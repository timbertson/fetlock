use anyhow::*;
use getopts::Options;
use log::*;
use std::env;
use std::io::Write;
use std::writeln;

use fetlock::esy;
use fetlock::fetch;
use fetlock::nix_serialize::{WriteContext, Writeable};

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
	let args: Vec<String> = env::args().collect();
	let program = args[0].clone();

	let mut opts = Options::new();
	opts.optflag("h", "help", "print this help menu");
	opts.optflag("", "full", "reload all track metadata, ignoring `mtime`");
	opts.optflagopt(
		"",
		"export-limit",
		"per-playlist export limit, in GB (not applied to entire export)",
		"SIZE",
	);
	opts.optflagopt(
		"",
		"min-tracks",
		"minimum track filter for artist subcommand",
		"NUM",
	);
	let matches = opts.parse(&args[1..])?;
	if matches.opt_present("h") {
		return Ok(print_usage(&program, opts));
	}
	let mut lock = esy::load("sample/esy.json")?;
	debug!("{:?}", lock);
	fetch::populate_source_digests(&mut lock).await?;
	let out_path = "sample/esy.nix";
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
