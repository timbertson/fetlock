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
	let args: Vec<String> = env::args().collect();
	let program = args[0].clone();

	let mut opts = Options::new();
	opts.optflag("h", "help", "print this help menu");
	let matches = opts.parse(&args[1..])?;
	if matches.opt_present("h") {
		return Ok(print_usage(&program, opts));
	}


	let opam_contents = std::fs::read_to_string("sample/lwt.opam")?;
	let opam = esy::opam::Opam::from_str(&opam_contents)?;
	info!("sample opam: {:?}", opam);
	fn lookup_opam(name: &str) -> Option<fetlock::Key> {
		match name {
			"lwt" => Some(fetlock::Key::new("@opam/lwt@opam:4.5.0@542100aa".to_owned())),
			_ => None,
		}
	}
	let nix_ctx = esy::opam::NixCtx {
		name: "lwt",
		lookup_opam: &lookup_opam,
	};
	let nix = opam.into_nix(&nix_ctx)?;
	info!(" -> as nix: {:?}", nix);
	let mut out_buf = Vec::new();
	let mut out = WriteContext::initial(&mut out_buf);
	nix.expr().write_to(&mut out)?;
	info!("Nix:\n{}", String::from_utf8(out_buf)?);


	Err(anyhow!("TODO: continue fetlock#main"))?;

	let mut esy_lock = esy::EsyLock::load("sample/esy.json")?;
	debug!("{:?}", esy_lock);
	fetch::populate_source_digests(esy_lock.lock_mut()).await?;
	let lock = esy_lock.finalize().await?;
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
