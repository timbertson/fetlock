use anyhow::*;
use log::*;
use std::fmt;
use std::fs;
use std::path::PathBuf;
use std::io::Write;
use std::writeln;

use crate::nix_serialize::{WriteContext, Writeable};
use crate::*;

pub async fn main() -> Result<()> {
	let raw_opts = CliOpts::from_argv();
	let log_level = match raw_opts.quietness {
		0 => match raw_opts.verbosity {
			0 => "info",
			_ => "debug",
		},
		1 => "warn",
		_ => "error",
	};
	env_logger::from_env(env_logger::Env::default().default_filter_or(log_level))
		.format(|buf, record| {
			let level = buf.default_styled_level(record.level());
			writeln!(buf, "{}: {}", level, record.args())
		})
		.init();
	
	let opts = CliOpts::resolve(raw_opts).await?;
	match opts.lock_type {
		lock::Type::Esy => process::<crate::esy::EsyLock>(opts).await,
		lock::Type::Opam => process::<crate::opam::OpamLock>(opts).await,
		lock::Type::Yarn => process::<crate::yarn::YarnLock>(opts).await,
		lock::Type::Bundler => process::<crate::bundler::BundlerLock>(opts).await,
		lock::Type::Cargo => process::<crate::cargo::CargoLock>(opts).await,
		lock::Type::Go => process::<crate::gomod::GoLock>(opts).await,
	}
}

async fn process<B: Backend + fmt::Debug>(opts: CliOpts) -> Result<()> {
	match &opts.cmd {
		opts::Command::Init(init_opts) => init::<B>(&opts, &init_opts).await,
		opts::Command::Update(update_opts) => update::<B>(&opts, update_opts).await,
		opts::Command::Write(write_opts) => write::<B>(&opts, &write_opts).await,
	}
}

async fn write<B: Backend + fmt::Debug>(opts: &CliOpts, write_opts: &WriteOpts) -> Result<()> {
	info!("loading {:?}", &opts.lock_src);
	let lock_src = opts.lock_src.resolve().await?;
	let mut lock = B::load(&lock_src, write_opts)
		.await
		.with_context(|| format!("loading {:?}", &lock_src))?;
	debug!("{:?}", lock);

	// ensure there is a root package, using a virtual one if necessary
	let lock_mut = lock.lock_mut();
	let root_key = lock_mut.context.root.key();
	match &mut lock_mut.context.root {
		Root::Package(key) => (),
		Root::Virtual(keys) => {
			let pseudo_root = Root::Package(root_key.clone());
			let mut spec = PartialSpec::empty();
			spec.id.set_name("fetlock-virtual-root".to_owned());
			spec.id.set_version("dev".to_owned());
			spec.set_src(Src::None);
			// TODO deps empty for yarn example?
			spec.add_deps(keys);
			// let the backend add any mandatory properties
			B::virtual_root(&mut spec);
			let spec = spec.build().with_context(|| "virtual root spec")?;
			lock_mut.add_impl(root_key.clone(), B::Spec::wrap(spec));
		}
	};

	let root_spec: &mut B::Spec = lock_mut
		.specs
		.get_mut(&root_key)
		.ok_or_else(|| anyhow!("root spec ({}) is not defined", root_key))?;

	// src comes from an explicit `src`, or `lock_src`.
	let src = match &write_opts.src {
		Some(LockRoot::Github(gh)) => {
			let mut resolved = FetchSpec::Github(gh.resolve().await?);
			let digest = fetch::calculate_digest(&mut resolved).await?;
			Src::Fetch(Fetch::new(resolved, digest))
		},
		Some(LockRoot::Path(p)) => Src::Local(LocalPath(p.to_owned())),
		
		// If there's no explicit source and no remote source, use `../`.
		// This works well for the default path of nix/lock.nix, but is a bit odd otherwise.
		None => {
			lock_src.fetch.map(Src::Fetch)
				.unwrap_or_else(|| Src::Local(LocalPath(PathBuf::from("..".to_owned()))))
		},
	};

	debug!("setting src {:?}, on root {:?}", src, lock_mut.context.root);
	root_spec.as_spec_mut().set_src(src);

	fetch::populate_source_digests(lock_mut).await?;
	let lock = lock.finalize().await?;

	let out_path = match &write_opts.out_path {
		Some(out_path) => PathBuf::from(out_path),
		None => {
			// special case: when file path not provided, we will autocreate `project/nix` and write `lock.nix` within it
			let dir = if let LockRoot::Path(p) = opts.lock_src.root() {
				p.join("nix")
			} else {
				PathBuf::from("nix")
			};
			fs::create_dir_all(&dir)?;
			dir.join("lock.nix")
		},
	};
	info!("Writing {:?}", out_path);
	crate::fs::write_atomically(out_path, |out_file| {
		WriteContext::sink(out_file, |mut c| lock.write_to(&mut c))
	})
}

async fn update<B: Backend + fmt::Debug>(opts: &CliOpts, update_opts: &opts::UpdateOpts) -> Result<()> {
	debug!("Updating lockfile {:?}", &opts.lock_src);
	let local_src = require_local_src(opts).await?;
	B::update_lockfile(&local_src.root, &local_src.relative).await?;
	
	if update_opts.no_nix {
		debug!("--no-nix; exiting");
		Ok(())
	} else {
		write::<B>(opts, &update_opts.common_write).await
	}
}

async fn init<B: Backend + fmt::Debug>(opts: &CliOpts, init_opts: &opts::InitOpts) -> Result<()> {
	debug!("Initializing {:?}", &opts.lock_src);
	
	let root = match opts.lock_src.root() {
		LockRoot::Path(p) => {
			let base = PathBuf::from(p);
			match &opts.lock_src.relative {
				Some(rel) => base.join(rel),
				None => base,
			}
		},
		_ => PathBuf::from("."),
	};
	
	write_init_file(&init_opts, &root, "nix/default.nix", |mut f| {
		writeln!(f, "\
{{ pkgs ? import <nixpkgs> {{}} }}:
with pkgs;
let
  fetlock = callPackage (builtins.fetchTarball \"https://github.com/timbertson/fetlock/archive/master.tar.gz\") {{}};
  selection = fetlock.{}.load ./lock.nix {{}};
in selection",
			opts.lock_type
		)?;
		Ok(())
	})?;

	write_init_file(&init_opts, &root, "default.nix", |mut f| {
		writeln!(f, "(import ./nix {{}}).root")?;
		Ok(())
	})?;

	write_init_file(&init_opts, &root, "shell.nix", |mut f| {
		writeln!(f, "(import ./nix {{}}).shell")?;
		Ok(())
	})?;

	if init_opts.update {
		info!("Initialization complete, updating lockfile ...");
		let update_opts = opts::UpdateOpts {
			common_write: init_opts.write.clone(),
			no_nix: false,
		};
		update::<B>(opts, &update_opts).await
	} else {
		info!("Initialization complete, writing lock expression ...");
		write::<B>(opts, &init_opts.write).await
	}
}

fn write_init_file<F: FnOnce(fs::File) -> Result<()>>(
	opts: &opts::InitOpts,
	root: &PathBuf,
	rel: &str,
	block: F) -> Result<()> {
	let p = root.join(rel);
	if opts.force || (!p.exists()) {
		if let Some(parent) = p.parent() {
			fs::create_dir_all(parent)?;
		}
		let output = fs::File::create(&p)?;
		info!("Writing: {:?}", &p);
		block(output)
	} else {
		warn!("Skipping initialization of {:?} (pass --force to overwrite it)", &p);
		Ok(())
	}
}

async fn require_local_src(opts: &CliOpts) -> Result<LocalSrc> {
	if let LockRoot::Path(p) = opts.lock_src.root() {
		opts.lock_src.resolve().await
	} else {
		Err(anyhow!("local path required"))
	}
}
