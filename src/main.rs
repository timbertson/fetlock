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
	}
}

async fn process<B: Backend + fmt::Debug>(opts: CliOpts) -> Result<()> {
	match &opts.cmd {
		opts::Command::Init(init_opts) => todo!(),
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
	let src_digest = if let Some(gh) = &write_opts.src {
		let src = gh.resolve().await?;
		let digest = fetch::calculate_digest(&src).await?;
		Some((src, digest))
	} else {
		lock_src.src_digest
	};
	if let Some((src, digest)) = src_digest {
		debug!("setting src {:?}, on root {:?}", src, lock_mut.context.root);
		let spec_ref: &mut Spec = root_spec.as_spec_mut();
		spec_ref.set_src_digest(src, digest);
	}

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
	if let LockRoot::Path(p) = opts.lock_src.root() {
		let local_src = opts.lock_src.resolve().await?;
		B::update_lockfile(&local_src.root, &local_src.relative).await?;
	} else {
		return Err(anyhow!("--update requires a local lock path"));
	}
	
	if update_opts.no_nix {
		debug!("--no-nix; exiting");
		Ok(())
	} else {
		write::<B>(opts, &update_opts.common_write).await
	}
}
