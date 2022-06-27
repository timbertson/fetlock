use std::collections::BTreeMap;

use anyhow::*;
use async_trait::async_trait;

use crate::*;


#[derive(Clone, Debug)]
pub struct GoLock(Lock<Spec>);

/*

Currently GoLock is a simple frontend to buildGoModule.
In the future we could consider something more like gomod2nix.
This still vendors everything for one big build, but individual
sources are cached independently and symlinked in, which
improves cache / download times for dependencies.

*/
impl GoLock {
	fn vendor_src_for_expr(src: Expr, cache_key: Option<String>) -> CustomFetch {
		let mut attrs = BTreeMap::new();
		attrs.insert("src".to_owned(), src);
		CustomFetch {
			fn_name: "fetchGoModules",
			cache_key,
			attrs,
		}
	}

	fn vendor_src_for_fetch(src: &Fetch) -> CustomFetch {
		Self::vendor_src_for_expr(
			src.as_expr(),
			Some(format!("{:?}", src))
		)
	}

	fn vendor_src_for_path(p: &LocalPath) -> Result<CustomFetch> {
		// we can use the nonportable expression because we're only ever evaluating this locally,
		// it doesn't make it into the lockfile
		Ok(Self::vendor_src_for_expr(p.abs_expr_nonportable()?, None))
	}
}

#[async_trait(?Send)]
impl Backend for GoLock {
	type Spec = lock::Spec;

	async fn load(src: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		let sum_path = src.lock_path();

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

		let ctx = LockContext::new(lock::Type::Go);
		let mut lock: Lock<Spec> = Lock::new(ctx);
		lock.context.root = lock::Root::Package(key.clone());

		lock.add_impl(key, spec);

		Ok(GoLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		// fetlock populates `src`, but we need to also populate the vendor digest.
		for spec in self.0.specs.values_mut() {
			let mut mod_fetch = match &spec.src {
				AnySrc::Partial(p) => {
					return Err(anyhow!("Src digest not populated: {:?}", &p));
				},
				AnySrc::Full(src) => match src {
					Src::Fetch(fetch) => {
						FetchSpec::Custom(GoLock::vendor_src_for_fetch(fetch))
					},
					Src::Local(path) => {
						FetchSpec::Custom(GoLock::vendor_src_for_path(path)?)
					},
					Src::None => {
						return Err(anyhow!("root package src is None: {:?}", &spec));
					},
				}
			};

			let hash = fetch::calculate_digest(&mut mod_fetch).await?;
			// TODO how to pass in local src?
			spec.extra.insert("vendorSha256".to_owned(), Expr::str(hash.sri_string()));
		}
		Ok(self.0)
	}
}
