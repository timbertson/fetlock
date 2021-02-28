use anyhow::*;
use getopts::Options;
use log::*;
use std::env;
use std::io::Write;
use std::writeln;

use fetlock::esy;
use fetlock::fetch;
use fetlock::nix_serialize::{WriteContext, Writeable};
use fetlock::Backend;

fn print_usage(program: &str, opts: Options) {
	let brief = format!(
		"\
Usage: {} LOCKFILE [options]
",
		program
	);
	print!("{}", opts.usage(&brief));
}

async fn run() -> Result<()> {
	env_logger::from_env(env_logger::Env::default().default_filter_or("info"))
		.format(|buf, record| {
			let level = buf.default_styled_level(record.level());
			writeln!(buf, "{}: {}", level, record.args())
		})
		.init();
	let argv: Vec<String> = env::args().collect();
	let program = argv[0].clone();

	let mut opts = Options::new();
	opts.optflag("h", "help", "print this help menu");

	let matches = opts.parse(&argv[1..])?;
	if matches.opt_present("h") {
		return Ok(print_usage(&program, opts));
	}

	let mut args = matches.free.iter().map(|x| x.as_ref());

	let lockfile_path = args.next().unwrap_or("sample/esy.json");
	let mut esy_lock = esy::EsyLock::load(lockfile_path)?;
	debug!("{:?}", esy_lock);
	fetch::populate_source_digests(esy_lock.lock_mut()).await?;
	let lock = esy_lock.finalize().await?;
	let out_path = "sample/esy.nix";
	info!("Writing {}", out_path);
	fetlock::fs::write_atomically(out_path, |mut out_file| {
		let mut out = WriteContext::initial(&mut out_file);
		lock.write_to(&mut out)?;
		Ok(())
	})?;
	info!("Wrote to {}", out_path);
	Ok(())
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
