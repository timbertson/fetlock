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
		lock::Type::Yarn => process::<crate::yarn::YarnLock>(opts).await,
		lock::Type::Bundler => process::<crate::bundler::BundlerLock>(opts).await,
	}
}

async fn process<B: Backend + fmt::Debug>(opts: CliOpts) -> Result<()> {
	info!("loading {:?}", &opts.lock_src);
	let src = opts.lock_src.resolve().await?;
	let mut lock = B::load(&src, opts.clone())
		.await
		.with_context(|| format!("loading {:?}", &opts.lock_src))?;
	debug!("{:?}", lock);

	// ensure there is a root package, using a virtual one if necessary
	let lock_mut = lock.lock_mut();
	let root_key = match &mut lock_mut.context.root {
		Root::Package(key) => key.clone(),
		Root::Virtual(keys) => {
			let key = Key::new("_virtual_root".to_owned());
			let pseudo_root = Root::Package(key.clone());
			let mut spec = PartialSpec::empty();
			spec.add_deps(keys);
			let spec = spec.build()?;
			lock_mut.add_impl(key.clone(), B::Spec::wrap(spec));
			key
		}
	};

	let root_spec: &mut B::Spec = lock_mut
		.specs
		.get_mut(&root_key)
		.ok_or_else(|| anyhow!("root spec ({}) is not defined", root_key))?;

	if let Some((src, digest)) = src.src_digest {
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
