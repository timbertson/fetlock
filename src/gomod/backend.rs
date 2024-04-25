use log::*;
use anyhow::*;
use async_trait::async_trait;
use std::{collections::BTreeMap, path::PathBuf};

use crate::*;

#[derive(Clone, Debug)]
pub struct GoLock {
	out_dir: PathBuf,
	root: LocalPath,
	lock: Lock<Spec>,
}

/*
Currently GoLock is a simple frontend to buildGoModule.
In the future we could consider something more like gomod2nix.
This still vendors everything for one big build, but individual
sources are cached independently and symlinked in, which
improves cache / download times for dependencies.

*/
impl GoLock {
	fn delete_vendor(attrs: &mut BTreeMap<String, Expr>, delete: bool) {
		if delete {
			attrs.insert("deleteVendor".to_owned(), Expr::Bool(true));
		}
	}

	fn vendor_src_for_expr(src: Expr, delete_vendor: bool, cache_key: Option<String>) -> CustomFetch {
		let mut attrs = BTreeMap::new();
		attrs.insert("src".to_owned(), src);
		Self::delete_vendor(&mut attrs, delete_vendor);
		CustomFetch {
			fn_name: "fetchGoModules",
			cache_key,
			attrs,
		}
	}

	fn vendor_src_for_fetch(src: &Fetch, delete_vendor: bool) -> CustomFetch {
		debug!("Fetching vendor src for fetch: {:?}", src);
		Self::vendor_src_for_expr(
			src.as_expr(), delete_vendor,
			Some(format!("{:?}", src))
		)
	}

	fn vendor_src_for_path(p: &LocalPath, delete_vendor: bool) -> Result<CustomFetch> {
		// we can use the nonportable expression because we're only ever evaluating this locally,
		// it doesn't make it into the lockfile
		debug!("Fetching vendor src for path: {:?}", p);
		Ok(Self::vendor_src_for_expr(p.abs_expr_nonportable()?, delete_vendor, None))
	}
}

#[async_trait(?Send)]
impl Backend for GoLock {
	type Spec = lock::Spec;

	async fn load(src: &LockSrc, opts: &WriteOpts) -> Result<Self> {
		let sum_path = src.path();

		let mut mod_path = sum_path.clone();
		mod_path.set_file_name("go.mod");
		let mod_file = fs_util::read_to_string(&mod_path)?;

		let full_name = mod_file
			.lines()
			.map(|l| l.trim())
			.flat_map(|l| {
				l.strip_prefix("module").map(|m| m.trim())
			})
			.next()
			.ok_or_else(|| anyhow!("Error: no `module` line found in {:?}", &mod_path))?;
		
		let name = full_name.rsplit('/').next().unwrap();

		let mut builder = PartialSpec::empty();
		builder.id.set_name(name.to_owned());
		builder.set_src(Src::None);
		let spec = builder.build()?;

		let key = Key::from_id(&spec.id);

		let ctx = LockContext::new(lock::Type::Gomod);
		let mut lock: Lock<Spec> = Lock::new(ctx);
		lock.context.root = lock::Root::Package(key.clone());

		lock.add_impl(key, spec);

		Ok(GoLock {
			out_dir: opts.out_dir(),
			root: LocalPath(src.root().clone()),
			lock,
		})
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lock
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		// fetlock populates `src`, but we need to also populate the vendor digest.
		for spec in self.lock.specs.values_mut() {
			let vendor_exists_in = |p: &PathBuf| p.join("vendor").exists();
			let delete_vendor = match &spec.src {
				AnySrc::Partial(p) => false,
				AnySrc::Full(src) => match src {
					Src::Fetch(src) => vendor_exists_in(&fetch::realise_source(src).await?),
					Src::Local(path) => vendor_exists_in(&path.0),
					Src::None => vendor_exists_in(&self.root.0),
				}
			};
			GoLock::delete_vendor(&mut spec.extra, delete_vendor);

			let mut mod_fetch = match &spec.src {
				AnySrc::Partial(p) => {
					return Err(anyhow!("Src digest not populated: {:?}", &p));
				},
				AnySrc::Full(src) => match src {
					Src::Fetch(fetch) =>
						FetchSpec::Custom(GoLock::vendor_src_for_fetch(fetch, delete_vendor)),

					Src::Local(path) => {
						// A local source path should be evaluated relative to the output
						// nix dir (e.g. nix/), not relative to the current dir
						let full_path = LocalPath(self.out_dir.join(&path.0));
						FetchSpec::Custom(GoLock::vendor_src_for_path(&full_path, delete_vendor)?)
					},

					Src::None => {
						debug!("using root src for sourceless package: {:?}", &spec.id);
						FetchSpec::Custom(GoLock::vendor_src_for_path(&self.root, delete_vendor)?)
					},
				}
			};

			let hash = fetch::calculate_digest(&mut mod_fetch).await?;
			// TODO how to pass in local src?
			spec.extra.insert("vendorHash".to_owned(), Expr::str(hash.sri_string()));
		}
		Ok(self.lock)
	}
}
