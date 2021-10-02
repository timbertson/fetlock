use crate::lock;
use crate::lock_src::*;
use anyhow::*;
use getopts::Options;
use log::*;
use std::env;

#[derive(Debug, Clone)]
pub struct CliOpts {
	pub out_path: Option<String>,
	pub lock_src: LockSrc,
	pub src: Option<GithubSrc>,
	pub repo_freshness_days: u32,
	pub ocaml_version: Option<String>,
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
			"clone-freshness",
			"maximum age (in days) for cloned repos",
			"DAYS",
		);
		opts.optopt(
			"",
			"from",
			"create a lockfile directly from on a github repository (author/repo)",
			"AUTHOR/REPO",
		);
		opts.optopt(
			"",
			"src",
			"set src to a github repository (author/repo)",
			"AUTHOR/REPO",
		);

		opts.optopt("", "ocaml-version", "Required for opam", "VERSION");

		let matches = opts.parse(&argv[1..])?;
		if matches.opt_present("h") {
			return usage(&program, opts);
		}
		debug!("parsing opts: {:?}", &matches);

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
			"opam" => lock::Type::Opam,
			"yarn" => lock::Type::Yarn,
			"bundler" => lock::Type::Bundler,
			other => return Err(anyhow!("Unknown type: {}", other)),
		};
		let repo_freshness_days = matches
			.opt_str("clone-freshness")
			.map(|s| str::parse(&s))
			.transpose()?
			.unwrap_or(1);
		let lock_src = matches.opt_str("from");
		let src = matches.opt_str("src");
		let src = src.as_deref().map(GithubSrc::parse).transpose()?;
		let ocaml_version = matches.opt_str("ocaml-version");

		let lock_rel = matches.free.into_iter().next();
		let lock_src = LockSrc::parse(lock_type, lock_src.as_deref(), lock_rel)?;
		Ok(CliOpts {
			out_path,
			lock_src,
			src,
			repo_freshness_days,
			ocaml_version,
		})
	}
}
