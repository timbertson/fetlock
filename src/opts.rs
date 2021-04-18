use crate::lock;
use anyhow::*;
use getopts::Options;
use std::env;

#[derive(Debug, Clone)]
pub struct CliOpts {
	pub out_path: Option<String>,
	pub lock_type: lock::Type,
	pub lock_path: String,
	pub repo_freshness_days: u32,
}

fn usage<T>(program: &str, opts: Options) -> Result<T> {
	let brief = format!(
		"\
Usage: {} LOCKFILE [options]
",
		program
	);
	Err(anyhow!("{}", opts.usage(&brief)))
}

impl CliOpts {
	pub fn from_argv() -> Result<CliOpts> {
		let argv: Vec<String> = env::args().collect();
		let program = argv[0].clone();

		let mut opts = Options::new();
		opts.optflag("h", "help", "print this help menu");
		opts.optopt(
			"t",
			"type",
			"specify lock type (default: autodetected)",
			"TYPE",
		);
		opts.optopt("o", "out", "output file (default: stdout)", "PATH");
		opts.optopt(
			"",
			"repo-freshness",
			"maximum age (in days) for cached repos",
			"DAYS",
		);

		let matches = opts.parse(&argv[1..])?;
		if matches.opt_present("h") {
			return usage(&program, opts);
		}

		if matches.free.len() != 1 {
			return Err(anyhow!(
				"Expected exactly one argument, got: {:?}",
				matches.free
			));
		}
		let out_path = matches.opt_str("out");
		let lock_type = match matches
			.opt_str("type")
			.unwrap_or_else(|| "AUTODETECT_NOT_IMPLEMENTED".to_owned())
			.as_str()
		{
			"esy" => lock::Type::Esy,
			"yarn" => lock::Type::Yarn,
			"bundler" => lock::Type::Bundler,
			other => return Err(anyhow!("Unknown type: {}", other)),
		};
		let repo_freshness_days = matches
			.opt_str("repo-freshness")
			.map(|s| str::parse(&s))
			.transpose()?
			.unwrap_or(1);
		let lock_path = matches.free.into_iter().next().unwrap();
		Ok(CliOpts {
			out_path,
			lock_type,
			lock_path,
			repo_freshness_days,
		})
	}
}
