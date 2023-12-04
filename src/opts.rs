use crate::lock;
use crate::lock_src::*;
use anyhow::*;
use log::*;
use std::collections::HashSet;
use std::path::PathBuf;
use clap::Parser;

mod raw {
	use clap::{Parser, AppSettings};

#[derive(Parser, Debug, Default, PartialEq, Eq)]
	pub struct CommonOpts {
		#[clap(short='t', long="type", help="specify lock type (default: autodetected)")]
		pub lock_type: Option<String>,

		#[clap(short='p', long, help="project path (directory containing lockfile; default is the current directory)")]
		pub path: Option<String>,
	}

#[derive(Parser, Debug, Default, PartialEq, Eq)]
	pub struct CommonWriteOpts {
		#[clap(short, long="out", help="Nix lock expression location (default nix/lock.nix)")]
		pub out_path: Option<String>,

		#[clap(short='l', long, help="lockfile name (default: per-backend)")]
		pub lockfile: Option<String>,

		#[clap(long, help="set root package src attribute to a local path (must begin with a dot) or github repository (author/repo)")]
		pub build_src: Option<String>,

		#[clap(long="clone-freshness", help="maximum age (in days) for cloned repos")]
		pub clone_freshness_days: Option<u32>,

		#[clap(long="ocaml-version", help="required for opam backend")]
		pub ocaml_version: Option<String>,

		#[clap(long="cargo-platform", help="override platform for cargo lockfiles")]
		pub cargo_platform: Option<String>,

		#[clap(long="cargo-features", help="features (comma-separated) for root crate")]
		pub cargo_features: Option<String>,
	}

#[derive(Parser, Debug, Default, PartialEq, Eq)]
	pub struct WriteOpts {
		#[clap(flatten)]
		pub common: CommonOpts,

		#[clap(flatten)]
		pub common_write: CommonWriteOpts,

		#[clap(long, help="load a lockfile directly from a github repository (author/repo[#ref])")]
		pub github: Option<String>,

		#[clap(long, help="load a lockfile from a nix epression literal")]
		pub from_nix: Option<String>,
	}

#[derive(Parser, Debug)]
	pub struct UpdateOpts {
		#[clap(flatten)]
		pub common: CommonOpts,

		#[clap(flatten)]
		pub common_write: CommonWriteOpts,

		#[clap(long="no-nix", help="Only update lockfile, don't generate a nix lock expression")]
		pub no_nix: bool,
	}

#[derive(Parser, Debug)]
	pub struct InitOpts {
		#[clap(flatten)]
		pub common: CommonOpts,

		#[clap(flatten)]
		pub common_write: CommonWriteOpts,

		#[clap(long, help="Overwrite existing boilerplate files")]
		pub force: bool,

		#[clap(short, long, help="Update (or generate) lock file based on package spec")]
		pub update: bool,
	}

#[derive(Parser, Debug)]
#[clap(setting = AppSettings::InferSubcommands, about="If no subcommand is given, `write` is assumed")]
	pub struct Opts {
		#[clap(subcommand)]
		pub cmd: Option<Command>,

		#[clap(flatten)]
		pub implicit_write_opts: WriteOpts,
		
		#[clap(short, long, parse(from_occurrences))]
		pub verbosity: i32,

		#[clap(short, long, parse(from_occurrences))]
		pub quietness: i32,
	}

#[derive(Parser, Debug)]
	pub enum Command {
		#[clap(about="Write a .nix lock expression from a (possibly-remote) lockfile")]
		Write(WriteOpts),

		#[clap(about="Run underlying package manager to update a local lockfile (and then write a new nix lock expression)")]
		Update(UpdateOpts),

		#[clap(about="Create boilerplate nix expressions for a local project")]
		Init(InitOpts),
	}
}

// Canonicalized / resolved version of raw opts
#[derive(Debug, Clone)]
pub struct CliOpts {
	pub lock_type: lock::Type,
	pub lock_src: LockSrc,
	pub cmd: Command,
}

#[derive(Debug, Clone)]
pub enum Command {
	Write(WriteOpts),
	Update(UpdateOpts),
	Init(InitOpts),
}

#[derive(Debug, Clone)]
pub struct InitOpts {
	pub force: bool,
	pub update: bool,
	pub write: WriteOpts,
}

#[derive(Debug, Clone)]
pub struct UpdateOpts {
	pub common_write: WriteOpts,
	pub no_nix: bool,
}

#[derive(Debug, Clone)]
pub struct WriteOpts {
	pub out_path: Option<String>,
	pub build_src: Option<RootSpec>,
	pub clone_freshness_days: Option<u32>,
	pub ocaml_version: Option<String>,
	pub cargo_platform: Option<String>,
	pub cargo_features: Option<Vec<String>>,
}

impl WriteOpts {
	pub fn out_dir(&self) -> PathBuf {
		match &self.out_path {
			Some(out_path) => {
				let parent = PathBuf::from(out_path).parent().map(|p| p.to_owned());
				parent.unwrap_or_else(||PathBuf::from("."))
			},
			None => PathBuf::from("nix"),
		}
	}
}

impl CliOpts {
	pub fn from_argv() -> raw::Opts {
		let opts = raw::Opts::parse();
		debug!("parsed opts: {:?}", opts);
		opts
	}

	pub async fn resolve(raw: raw::Opts) -> Result<CliOpts> {
		let raw::Opts { cmd, implicit_write_opts, .. } = raw;
		let cmd = if let Some(cmd) = cmd {
			let default : raw::WriteOpts = Default::default();
			if implicit_write_opts != default {
				return Err(anyhow!("When specifying a command name, it must preceed all arguments"))
			}
			cmd
		} else {
			raw::Command::Write(implicit_write_opts)
		};
		
		let common = match &cmd {
			raw::Command::Init(c) => &c.common,
			raw::Command::Write(c) => &c.common,
			raw::Command::Update(c) => &c.common,
		};

		match cmd {
			raw::Command::Write(c) => {
				let (lock_type, lock_src, write_opts) = Self::resolve_write_opts(c).await?;
				Ok(CliOpts { lock_type, lock_src, cmd: Command::Write(write_opts) })
			},
			raw::Command::Update(c) => {
				let raw::UpdateOpts { common, common_write, no_nix } = c;
				let raw_write = raw::WriteOpts { common, common_write, github: None, from_nix: None };
				let (lock_type, lock_src, common_write) = Self::resolve_write_opts(raw_write).await?;
				Ok(CliOpts {
					lock_type,
					lock_src,
					cmd: Command::Update(UpdateOpts { common_write, no_nix }),
				})
			},
			raw::Command::Init(c) => {
				let raw::InitOpts { force, update, common, common_write } = c;
				let raw_write = raw::WriteOpts { common, common_write, github: None, from_nix: None };
				let (lock_type, lock_src, write) = Self::resolve_write_opts(raw_write).await?;
				Ok(CliOpts {
					lock_type,
					lock_src,
					cmd: Command::Init(InitOpts { force, update, write }),
				})
			},
		}
	}
	
	fn is_implicit_path(p: &str) -> bool {
		p.starts_with(".")
	}

	async fn resolve_write_opts(opts: raw::WriteOpts) -> Result<(lock::Type, LockSrc, WriteOpts)> {
		let raw::WriteOpts { common, common_write, github, from_nix } = opts;
		let raw::CommonOpts { lock_type, path } = common;
		let raw::CommonWriteOpts {
			out_path,
			lockfile,
			build_src,
			clone_freshness_days,
			ocaml_version,
			cargo_platform,
			cargo_features,
		} = common_write;
		
		// build src differs from lock src when you want to load a local lockfile but build from e.g. an online git repo
		let build_src = build_src.as_deref().map(|s| {
			if Self::is_implicit_path(s) {
				Ok(RootSpec::Path(PathBuf::from(s)))
			} else {
				GithubSpec::parse(s).map(RootSpec::Github)
			}
		}).transpose()?;

		let lock_root = LockRoot::resolve(LockRootOpts {
			repo: github,
			lock_root: path,
			nix_expr: from_nix,
		}).await?;

		let (lock_type, lockfile) = Self::resolve_type(&lock_root, lock_type, lockfile).await?;
		let lock_src = lock_root.src(lockfile);

		Ok((lock_type, lock_src, WriteOpts {
			out_path,
			build_src,
			clone_freshness_days,
			ocaml_version,
			cargo_platform,
			cargo_features: cargo_features.map(|s| s.split(',').map(|s| s.to_owned()).collect()),
		}))
	}
	
	async fn resolve_type(lock_root: &LockRoot, type_str: Option<String>, lockfile: Option<String>)
	-> Result<(lock::Type, String)> {
		if let Some(type_str) = type_str {
			let lock_type = match type_str.as_str() {
				"esy" => lock::Type::Esy,
				"opam" => lock::Type::Opam,
				"yarn" => lock::Type::Yarn,
				"bundler" => lock::Type::Bundler,
				"cargo" => lock::Type::Cargo,
				"gomod" => lock::Type::Gomod,
				"sbt" => lock::Type::Sbt,
				other => return Err(anyhow!("Unknown type: {}", other)),
			};
			let lockfile = Self::default_filename(lock_type)
				.ok_or_else(|| anyhow!("No default lockfile name for {:?}, use --lockfile", lock_type))?;
			Ok((lock_type, lockfile.to_owned()))
		} else {
			Self::detect_type(lock_root, lockfile).await
		}
	}

	fn default_filename(lock_type: lock::Type) -> Option<&'static str> {
		match lock_type {
			lock::Type::Yarn => Some("yarn.lock"),
			lock::Type::Cargo => Some("Cargo.lock"),
			lock::Type::Bundler => Some("Gemfile.lock"),
			lock::Type::Gomod => Some("go.sum"),
			lock::Type::Opam => Some("opam"),
			lock::Type::Esy => None,
			lock::Type::Sbt => Some("build.sbt"),
		}
	}

	fn type_from(filename: &str) -> Option<(lock::Type, &str)> {
		// Note that we can infer a lock file which may not exist (yet),
		// based on a spec file
		if filename == "package.json" || filename == "yarn.lock" {
			Some((lock::Type::Yarn, "yarn.lock"))
		} else if filename == "Cargo.toml" || filename == "Cargo.lock" {
			Some((lock::Type::Cargo, "Cargo.lock"))
		} else if filename == "Gemfile" || filename == "Gemfile.lock" {
			Some((lock::Type::Bundler, "Gemfile.lock"))
		} else if filename == "go.mod" || filename == "go.sum" {
			Some((lock::Type::Gomod, "go.sum"))
		} else if filename.ends_with(".opam") || filename == "opam" {
			Some((lock::Type::Opam, filename))
		} else if filename.ends_with("esy.lock") {
			// TODO is there a default name?
			Some((lock::Type::Esy, filename))
		} else if filename.ends_with(".sbt") {
			Some((lock::Type::Sbt, filename))
		} else {
			None
		}
	}

	async fn detect_type(root: &LockRoot, lockfile: Option<String>) -> Result<(lock::Type, String)> {
		if let Some(lockfile) = lockfile {
			debug!("detecting based on lockfile name: {:?}", lockfile);
			let lock_type = Self::type_from(&lockfile).map(|(t, _)| t)
				.ok_or_else(|| anyhow!("Couldn't determine lock type from lock file name, you'll have to also specify --type/-t"))?;
			Ok((lock_type, lockfile))
		} else {
			// detect based on file presence
			let root_path = &root.path;
			debug!("detecting based on contents of path {:?}", root_path);
			
			let types: HashSet<(lock::Type, String)> = root_path.read_dir()?.flat_map(|ent|
				ent.ok().and_then(|ent| ent.file_name().to_str().and_then(|f|
					Self::type_from(f).map(|(t, f)| (t, f.to_owned()))
				))
			).collect();

			if types.len() > 1 {
				return Err(anyhow!("Ambiguous lock type found ({:?})\nYou must specify `--lockfile` or `--type`", &types));
			}
			let detected = if let Some((t, lockfile)) = types.into_iter().next() {
				info!("Detected lock type: {}", t);
				debug!("Detected Based on lockfile: {:?}", &lockfile);
				Some((t, lockfile))
			} else {
				None
			};

			detected.ok_or_else(|| anyhow!("Couldn't autodetect lock type, use --type/-t"))
		}
	}
}

