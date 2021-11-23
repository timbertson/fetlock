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
		#[clap(short='t', long="type", about="specify lock type (default: autodetected)")]
		pub lock_type: Option<String>,

		#[clap(short='p', long, about="project path (directory containing lockfile; default is the current directory)")]
		pub path: Option<String>,
	}

#[derive(Parser, Debug, Default, PartialEq, Eq)]
	pub struct CommonWriteOpts {
		#[clap(short, long="out", about="Nix lock expression location (default nix/lock.nix)")]
		pub out_path: Option<String>,

		#[clap(short='l', long, about="lockfile name (default: per-backend default)")]
		pub lockfile: Option<String>,

		#[clap(long, about="set root package src attribute to a local path (must begin with a dot) or github repository (author/repo)")]
		pub src: Option<String>,

		#[clap(long="clone-freshness", about="maximum age (in days) for cloned repos")]
		pub clone_freshness_days: Option<u32>,

		#[clap(long="ocaml-version", about="required for opam backend")]
		pub ocaml_version: Option<String>,
	}

#[derive(Parser, Debug, Default, PartialEq, Eq)]
	pub struct WriteOpts {
		#[clap(flatten)]
		pub common: CommonOpts,

		#[clap(flatten)]
		pub common_write: CommonWriteOpts,

		#[clap(long, about="load a lockfile directly from a github repository (author/repo)")]
		pub github: Option<String>,
	}

#[derive(Parser, Debug)]
	pub struct UpdateOpts {
		#[clap(flatten)]
		pub common: CommonOpts,

		#[clap(flatten)]
		pub common_write: CommonWriteOpts,

		#[clap(long="no-nix", about="Only update lockfile, don't generate a nix lock expression")]
		pub no_nix: bool,
	}

#[derive(Parser, Debug)]
	pub struct InitOpts {
		#[clap(flatten)]
		pub common: CommonOpts,

		#[clap(flatten)]
		pub common_write: CommonWriteOpts,

		#[clap(long, about="Overwrite existing boilerplate files")]
		pub force: bool,

		#[clap(short, long, about="Update (or generate) lock file based on package spec")]
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

		#[clap(about="Update local lockfile based on package specification (and write nix expression)")]
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
	pub src: Option<LockRoot>,
	pub clone_freshness_days: Option<u32>,
	pub ocaml_version: Option<String>,
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
				let raw_write = raw::WriteOpts { common, common_write, github: None };
				let (lock_type, lock_src, common_write) = Self::resolve_write_opts(raw_write).await?;
				Ok(CliOpts {
					lock_type,
					lock_src,
					cmd: Command::Update(UpdateOpts { common_write, no_nix }),
				})
			},
			raw::Command::Init(c) => {
				let raw::InitOpts { force, update, common, common_write } = c;
				let raw_write = raw::WriteOpts { common, common_write, github: None };
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
		let raw::WriteOpts { common, common_write, github } = opts;
		let raw::CommonOpts { lock_type, path } = common;
		let raw::CommonWriteOpts { out_path, lockfile, src, clone_freshness_days, ocaml_version } = common_write;

		// if path is implicit, also use it for `src`:
		let implicit_path = path.as_deref().filter(|p| Self::is_implicit_path(p));
		let src = src.as_deref().or(implicit_path).map(|s| {
			if Self::is_implicit_path(s) {
				Ok(LockRoot::Path(PathBuf::from(s)))
			} else {
				GithubSrc::parse(s).map(LockRoot::Github)
			}
		}).transpose()?;
		let mut lock_src = LockSrc::parse(LockSrcOpts {
			repo: github,
			lock_root: path,
			lockfile: lockfile,
		})?;
		let lock_type = Self::resolve_type(&mut lock_src, lock_type.as_ref()).await?;
		Ok((lock_type, lock_src, WriteOpts {
			out_path,
			src,
			clone_freshness_days,
			ocaml_version
		}))
	}
	
	async fn resolve_type(lock_src: &mut LockSrc, type_str: Option<&String>) -> Result<lock::Type> {
		if let Some(type_str) = type_str {
			Ok(match type_str.as_str() {
				"esy" => lock::Type::Esy,
				"opam" => lock::Type::Opam,
				"yarn" => lock::Type::Yarn,
				"bundler" => lock::Type::Bundler,
				"cargo" => lock::Type::Cargo,
				other => return Err(anyhow!("Unknown type: {}", other)),
			})
		} else {
			Self::detect_type(lock_src).await
		}
	}

	fn type_from(filename: &str) -> Option<(lock::Type, &str)> {
		// Note that we can infer a lock file which may not exist (yet),
		// based on a spec file
		if filename == "package.json" {
			Some((lock::Type::Yarn, "yarn.lock"))
		} else if filename == "Cargo.toml" || filename == "Cargo.lock" {
			Some((lock::Type::Cargo, "Cargo.lock"))
		} else if filename == "Gemfile" || filename == "Gemfile.lock" {
			Some((lock::Type::Bundler, "Gemfile.lock"))
		} else if filename.ends_with(".opam") || filename == "opam" {
			Some((lock::Type::Opam, filename))
		} else if filename.ends_with("esy.lock") {
			// TODO is there a default name?
			Some((lock::Type::Esy, filename))
		} else {
			None
		}
	}

	async fn detect_type(src: &mut LockSrc) -> Result<lock::Type> {
		let detected = if let Some(lockfile) = src.lockfile.as_ref() {
			debug!("detecting based on lockfile name: {:?}", lockfile);
			Self::type_from(lockfile).map(|(t, _)| t)
		} else {
			// detect based on file presence
			let local_src = src.resolve().await?;
			let root = local_src.lock_path();
			debug!("detecting based on contents of path {:?}", &root);
			
			let types: HashSet<(lock::Type, String)> = root.read_dir()?.flat_map(|ent|
				ent.ok().and_then(|ent| ent.file_name().to_str().and_then(|f|
					Self::type_from(f).map(|(t, f)| (t, f.to_owned()))
				))
			).collect();

			if types.len() > 1 {
				return Err(anyhow!("Ambiguous lock type found ({:?})\nYou must specify `--lockfile` or `--type`", &types));
			}
			if let Some((t, lockfile)) = types.into_iter().next() {
				src.lockfile = Some(lockfile);
				info!("Detected lock type: {}", t);
				Some(t)
			} else {
				None
			}
		};

		detected.ok_or_else(|| anyhow!("Couldn't autodetect lock type, use --type/-t"))
	}
}

