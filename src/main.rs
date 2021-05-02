use anyhow::*;
use log::*;
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
use crate::{LocalSrc, LockRoot};

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
	let relative = opts.lock_src.relative.clone();
	let src = match &opts.lock_src.root {
		LockRoot::Path(p) => LocalSrc::new(p.clone(), relative),
		LockRoot::Github(gh) => {
			let src = gh.resolve().await?;
			let digest = fetch::calculate_digest(&src).await?;
			LocalSrc::new(
				fetch::realise_source(SrcDigest {
					src: &src,
					digest: &digest,
				})
				.await?,
				relative,
			)
		}
	};
	let mut lock = B::load(src, opts.clone())
		.await
		.with_context(|| format!("loading {:?}", &opts.lock_src))?;
	debug!("{:?}", lock);
	fetch::populate_source_digests(lock.lock_mut()).await?;
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
