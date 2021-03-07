use anyhow::*;
use log::*;
use std::fmt;
use std::io::Write;
use std::io::stdout;
use std::writeln;

use fetlock::CliOpts;
use fetlock::fetch;
use fetlock::lock;
use fetlock::nix_serialize::{WriteContext, Writeable};
use fetlock::Backend;

async fn run() -> Result<()> {
	env_logger::from_env(env_logger::Env::default().default_filter_or("info"))
		.format(|buf, record| {
			let level = buf.default_styled_level(record.level());
			writeln!(buf, "{}: {}", level, record.args())
		})
		.init();
	let opts = CliOpts::from_argv()?;

	let out_path = opts.out_path.as_ref().map(|s| s.as_str());
	
	match opts.lock_type {
		lock::Type::Esy => process::<fetlock::esy::EsyLock>(&opts.lock_path, out_path).await,
		lock::Type::Yarn => process::<fetlock::yarn::YarnLock>(&opts.lock_path, out_path).await,
	}
}

async fn process<B: Backend + fmt::Debug>(path: &str, out_path: Option<&str>) -> Result<()> {
	let mut lock = B::load(path)?;
	debug!("{:?}", lock);
	fetch::populate_source_digests(lock.lock_mut()).await?;
	let lock = lock.finalize().await?;

	match out_path {
		None => {
			WriteContext::sink(stdout(), |mut c| lock.write_to(&mut c))
		},
		Some(path) => {
			info!("Writing {}", path);
			fetlock::fs::write_atomically(path, |out_file| {
				WriteContext::sink(out_file, |mut c| lock.write_to(&mut c))
			})
		},
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
