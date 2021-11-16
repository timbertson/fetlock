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
	// TODO make a better ADT which encapsulates modes
	pub update: bool,
	pub no_nix: bool,
}

fn usage<T>(program: &str, opts: Options) -> Result<T> {
	let brief = format!(
		"\
Usage: {} [OPTIONS] [project-path]

The default project-path is the current directory.
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
		opts.optopt(
			"l",
			"lockfile",
			"specify lockfile name (default: per-backend default)",
			"FILENAME",
		);
		opts.optopt("o", "out", "output file (default: stdout)", "PATH");

		opts.optopt(
			"",
			"clone-freshness",
			"maximum age (in days) for cloned repos",
			"DAYS",
		);
		opts.optopt(
			"g",
			"github",
			"load a lockfile directly from a github repository (author/repo)",
			"AUTHOR/REPO",
		);
		// TODO let user specify e.g. `../.` as a path
		opts.optopt(
			"",
			"src",
			"set root package src attribute to a github repository (author/repo), typically useful when using a local lockfile for an online project",
			"AUTHOR/REPO",
		);
		opts.optopt(
			"p",
			"path",
			"project path (directory containing lockfile)",
			"PATH",
		);

		opts.optopt("", "ocaml-version", "Required for opam", "VERSION");

		opts.optflag("", "update", "Update underlying lockfile from version specifications (using language-specific tooling)");
		opts.optflag("", "no-nix", "Don't generate a nix lock expression (useful with --update)");

		let matches = opts.parse(&argv[1..])?;
		if matches.opt_present("h") {
			return usage(&program, opts);
		}
		debug!("parsing opts: {:?}", &matches);

		if matches.free.len() > 1 {
			return Err(anyhow!(
				"Unexpected argument: {:?}",
				matches.free
			));
		}
		let out_path = matches.opt_str("out");
		let lock_type = if let Some(type_str) = matches.opt_str("type") {
			Some(match type_str.as_str() {
				"esy" => lock::Type::Esy,
				"opam" => lock::Type::Opam,
				"yarn" => lock::Type::Yarn,
				"bundler" => lock::Type::Bundler,
				"cargo" => lock::Type::Cargo,
				other => return Err(anyhow!("Unknown type: {}", other)),
			})
		} else {
			// autodetect
			None
		};
		let repo_freshness_days = matches
			.opt_str("clone-freshness")
			.map(|s| str::parse(&s))
			.transpose()?
			.unwrap_or(1);
		let remote_repo = matches.opt_str("github");
		let src = matches.opt_str("src");
		let src = src.as_deref().map(GithubSrc::parse).transpose()?;
		let ocaml_version = matches.opt_str("ocaml-version");
		let update = matches.opt_present("update");
		let no_nix = matches.opt_present("no-nix");
		let lock_filename = matches.opt_str("lockfile");
		let lock_root = matches.opt_str("path");

		let lock_src = LockSrc::parse(LockSrcOpts {
			lock_type,
			repo: remote_repo,
			lock_root,
			lockfile: lock_filename,
		})?;
		Ok(CliOpts {
			out_path,
			lock_src,
			src,
			repo_freshness_days,
			update,
			no_nix,
			ocaml_version,
		})
	}
}
