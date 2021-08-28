use anyhow::*;
use log::*;
use std::borrow::BorrowMut;
use std::fmt;
use std::io::stdout;
use std::io::Write;
use std::writeln;

use crate::fetch;
use crate::lock;
use crate::nix_serialize::{WriteContext, Writeable};
use crate::Backend;
use crate::CliOpts;
use crate::*;

pub async fn main() -> Result<()> {
	env_logger::from_env(env_logger::Env::default().default_filter_or("info"))
		.format(|buf, record| {
			let level = buf.default_styled_level(record.level());
			writeln!(buf, "{}: {}", level, record.args())
		})
		.init();
	let opts = CliOpts::from_argv()?;
	debug!("parsed options: {:?}", opts);

	match opts.lock_src.lock_type {
		lock::Type::Esy => process::<crate::esy::EsyLock>(opts).await,
		lock::Type::Opam => process::<crate::opam::OpamLock>(opts).await,
		lock::Type::Yarn => process::<crate::yarn::YarnLock>(opts).await,
		lock::Type::Bundler => process::<crate::bundler::BundlerLock>(opts).await,
	}
}

async fn process<B: Backend + fmt::Debug>(opts: CliOpts) -> Result<()> {
	info!("loading {:?}", &opts.lock_src);
	let lock_src = opts.lock_src.resolve().await?;
	let mut lock = B::load(&lock_src, opts.clone())
		.await
		.with_context(|| format!("loading {:?}", &lock_src))?;
	debug!("{:?}", lock);

	// ensure there is a root package, using a virtual one if necessary
	let lock_mut = lock.lock_mut();
	let root_key = lock_mut.context.root.key();
	match &mut lock_mut.context.root {
		Root::Package(key) => (),
		Root::Virtual(keys) => {
			let pseudo_root = Root::Package(root_key.clone());
			let mut spec = PartialSpec::empty();
			spec.id.set_name("fetlock-virtual-root".to_owned());
			spec.id.set_version("dev".to_owned());
			spec.set_src(Src::None);
			// TODO deps empty for yarn example?
			spec.add_deps(keys);
			// let the backend add any mandatory properties
			B::virtual_root(&mut spec);
			let spec = spec.build()
				.with_context(||"virtual root spec")?;
			lock_mut.add_impl(root_key.clone(), B::Spec::wrap(spec));
		}
	};

	let root_spec: &mut B::Spec = lock_mut
		.specs
		.get_mut(&root_key)
		.ok_or_else(|| anyhow!("root spec ({}) is not defined", root_key))?;

	// src comes from an explicit `src`, or `lock_src` if it's remote
	let src_digest = if let Some(gh) = opts.src {
		let src = gh.resolve().await?;
		let digest = fetch::calculate_digest(&src).await?;
		Some((src, digest))
	} else {
		lock_src.src_digest
	};
	if let Some((src, digest)) = src_digest {
		debug!("setting src {:?}, on root {:?}", src, lock_mut.context.root);
		let spec_ref: &mut Spec = root_spec.borrow_mut();
		spec_ref.set_src_digest(src, digest);
	}

	fetch::populate_source_digests(lock_mut).await?;
	let lock = lock.finalize().await?;

	match opts.out_path {
		None => WriteContext::sink(stdout(), |mut c| lock.write_to(&mut c)),
		Some(path) => {
			info!("Writing {}", path);
			crate::fs::write_atomically(path, |out_file| {
				WriteContext::sink(out_file, |mut c| lock.write_to(&mut c))
			})
		}
	}
}
