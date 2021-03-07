use anyhow::*;
use getopts::Options;
use log::*;
use std::env;
use std::fmt;
use std::io::Write;
use std::io::stdout;
use std::writeln;

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
	opts.optopt("t", "type", "specify lock type (default: autodetected)", "TYPE");
	opts.optopt("o", "out", "output file (default: stdout)", "PATH");

	let matches = opts.parse(&argv[1..])?;
	if matches.opt_present("h") {
		return Ok(print_usage(&program, opts));
	}

	if matches.free.len() != 1 {
		return Err(anyhow!("Expected exactly one argument, got: {:?}", matches.free))
	}
	let lockfile_path = matches.free.iter().map(|x| x.as_ref()).next().unwrap();
	let out_path_owned = matches.opt_str("out");
	let out_path = out_path_owned.as_ref().map(|s| s.as_str());
	
	match matches.opt_str("type").unwrap_or_else(||"AUTODETECT_NOT_IMPLEMENTED".to_owned()).as_str() {
		"esy" => process::<fetlock::esy::EsyLock>(lockfile_path, out_path).await,
		"yarn" => process::<fetlock::yarn::YarnLock>(lockfile_path, out_path).await,
		other => { return Err(anyhow!("Unknown type: {}", other)) },
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
