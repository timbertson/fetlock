use anyhow::*;
use log::*;
use std::fmt;
use std::io::stdout;
use std::io::Write;
use std::writeln;

use fetlock::fetch;
use fetlock::lock;
use fetlock::nix_serialize::{WriteContext, Writeable};
use fetlock::Backend;
use fetlock::CliOpts;

async fn run() -> Result<()> {
	env_logger::from_env(env_logger::Env::default().default_filter_or("info"))
		.format(|buf, record| {
			let level = buf.default_styled_level(record.level());
			writeln!(buf, "{}: {}", level, record.args())
		})
		.init();
	let opts = CliOpts::from_argv()?;
	debug!("parsed options: {:?}", opts);

	match opts.lock_type {
		lock::Type::Esy => process::<fetlock::esy::EsyLock>(opts).await,
		lock::Type::Yarn => process::<fetlock::yarn::YarnLock>(opts).await,
	}
}

async fn process<B: Backend + fmt::Debug>(opts: CliOpts) -> Result<()> {
	info!("loading {}", &opts.lock_path);
	let mut lock = B::load(opts.clone())?;
	debug!("{:?}", lock);
	fetch::populate_source_digests(lock.lock_mut()).await?;
	let lock = lock.finalize().await?;

	match opts.out_path {
		None => WriteContext::sink(stdout(), |mut c| lock.write_to(&mut c)),
		Some(path) => {
			info!("Writing {}", path);
			fetlock::fs::write_atomically(path, |out_file| {
				WriteContext::sink(out_file, |mut c| lock.write_to(&mut c))
			})
		}
	}
}

#[tokio::main]
async fn main() {
	match run().await {
		Ok(()) => (),
		Err(e) => {
			error!("{:?}", e);
			std::process::exit(1)
		}
	}
}
