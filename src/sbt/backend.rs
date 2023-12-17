// SBT backend
// Note: SBT / java doesn't have any concept of a lockfile, so you
// do need to evaluate a project (and download its deps) via SBT
// every time you generate a lock.nix
use crate::*;
use log::*;
use anyhow::*;
use async_trait::async_trait;
use serde::Deserialize;
use std::collections::BTreeMap;
use std::collections::btree_map::Entry;
use std::io::{Read, Seek};
use std::os::unix;
use std::fs;
use std::path::PathBuf;
use std::process::Stdio;
use tokio::process::Command;

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawDependency {
	key: Key,
	name: String,
	version: String,
	artifacts: Vec<RawArtifact>
}

struct Artifact {
	cache_path: String,
	file: Fetch,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawArtifact {
	url: String,
	cache_path: String, // relative to root cache_path
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawFile {
	cache_root: String,
	repository_config: Option<String>,
	dependencies: Vec<RawDependency>,
}

#[derive(Clone, Debug)]
pub struct SbtLock(Lock<Spec>);

#[async_trait(?Send)]
impl Backend for SbtLock {
	type Spec = Spec;

	async fn load(src: &LockSrc, opts: &WriteOpts) -> Result<Self> {
		let tmp_dir = tempfile::TempDir::with_prefix("fetlock-src-")?;
		let project_dir = tmp_dir.path().join("src");
		cmd::exec(
			Command::new("cp")
				.arg("-a")
				.arg(src.root())
				.arg(&project_dir)
		).await?;

		// make writeable, in case we copied this from the nix store
		cmd::exec(
			Command::new("chmod")
				.arg("-R")
				.arg("u+rwX")
				.arg(&tmp_dir.path())
		).await?;
		
		let inject_files = vec!(
			(format!("{}/inject/Fetlock.scala", fetlock_env::nix()), project_dir.join("project/Fetlock.scala")),
			(format!("{}/inject/fetlockDeps.sbt", fetlock_env::nix()), project_dir.join("project/fetlockDeps.sbt")),

			// TODO this seems hacky; and how far down should we go?
			(format!("{}/inject/Fetlock.scala", fetlock_env::nix()), project_dir.join("project/project/Fetlock.scala")),
			(format!("{}/inject/fetlockDeps.sbt", fetlock_env::nix()), project_dir.join("project/project/fetlockDeps.sbt")),
		);
		
		for (src, dest) in inject_files {
			if dest.exists() {
				fs::remove_file(&dest)?;
			}
			// TODO inject via env, not symlink?
			unix::fs::symlink(&src, &dest)
				.with_context(|| format!("symlinking {} -> {}", &src, dest.display()))?;
		}

		// sbt doesn't know that stderr is a thing apparently, so
		// we need to treat stdout as stderr and create a tempfile for the _actual_ output
		let mut fetlock_output = tempfile::NamedTempFile::with_prefix("sbt-")?;
		cmd::run(
			"sbt",
			Some(""), // disable interactivity
			Stdio::inherit(), // error output
			Command::new("sbt")
				.arg("fetlockGenerate")
				.current_dir(&project_dir)
				.env("FETLOCK_OUTPUT", fetlock_output.path()),
		)
		.await?;
		let mut contents = String::new();
		fetlock_output.read_to_string(&mut contents)?;

		// sbt doesn't know that stderr is a thing apparently, so
		// we need to treat stdout as stderr and create a tempfile for the _actual_ output
		cmd::run(
			"sbt",
			Some(""), // disable interactivity
			Stdio::inherit(), // error output
			Command::new("sbt")
				.arg("fetlockGenerate")
				.current_dir(&project_dir.join("project"))
				.env("FETLOCK_OUTPUT", fetlock_output.path()),
		)
		.await?;
		let mut meta_contents = String::new();
		fetlock_output.rewind()?;
		fetlock_output.read_to_string(&mut meta_contents)?;

		drop(fetlock_output);
		tmp_dir.close()?;

		let lockfile: RawFile = serde_json::from_str(&contents)
			.with_context(|| format!("{}\n\n^^parsing JSON output from Fetlock.scala", &contents))?;

		let meta_lockfile: RawFile = serde_json::from_str(&meta_contents)
			.with_context(|| format!("{}\n\n^^parsing JSON output from Fetlock.scala", &contents))?;

		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Sbt));
		let RawFile { dependencies, repository_config, cache_root } = lockfile;
		// let roots: Vec<Key> = toplevel.into_iter().map(Key::new).collect();
		lock.set_root(Root::Virtual(vec!())); // TODO


		let mut map = BTreeMap::new();

		let all_deps =
			SbtLock::build_deps(
				&PathBuf::from(meta_lockfile.cache_root.clone()),
				meta_lockfile.dependencies
			).await?.into_iter().chain(

			SbtLock::build_deps(
				&PathBuf::from(cache_root),
				dependencies
			).await?.into_iter()
		);

		// SBT can have multiple paths to the same depencency, and different
		// artifacts in each. It's safe to merge them all since we're building up
		// one big cache.
		for (key, spec) in all_deps {
			match map.entry(key) {
				Entry::Vacant(slot) => { slot.insert(spec); },
				Entry::Occupied(mut slot) => {
					slot.get_mut().merge_from(spec)?;
				}
			}
		}
		
		// now insert into lock
		for (key, spec) in map {
			lock.add_impl(key, spec.into_spec()?);
		}

		let repo_config_expr = repository_config.map(|c| Expr::str(c)).unwrap_or(Expr::Null);
		lock.context.extra.insert("repositoryConfig".to_owned(), repo_config_expr);

		Ok(SbtLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}

	async fn update_lockfile<'a>(root: &'a PathBuf, rel: &'a str) -> Result<()> {
		todo!()
		// cmd::exec(Command::new("bundle").arg("lock").arg("--update").current_dir(root)).await
	}
}

impl SbtLock {
	async fn build_deps(cache_root: &PathBuf, raw: Vec<RawDependency>) -> Result<Vec<(Key, MidSpec)>> {
		let num_artifacts: usize = raw.iter().map(|dep| dep.artifacts.len()).sum();
		info!("Calculating {} artifact hashes ...", num_artifacts);
		let stream = futures::stream::iter(raw);
		Ok(stream_util::map_parallel(30, stream, |raw| Self::build_dep(cache_root, raw)).await?.into_iter().collect())
	}

	async fn build_dep(cache_root: &PathBuf, raw: RawDependency) -> Result<(Key, MidSpec)> {
		let RawDependency {
			key,
			name,
			version,
			artifacts: raw_artifacts,
		} = raw;
		let desc = format!("populating src for {:?}", &name);

		let mut spec = PartialSpec::empty();
		spec.id.set_name(name.clone());
		spec.id.set_version(version.clone());
		
		// we don't set src, that's used for building SBT modules.
		// Instead we set artifacts to signal it's precompiled
		spec.set_src(Src::None);

		let mut artifacts = Vec::with_capacity(raw_artifacts.len());
		for artifact in raw_artifacts.into_iter() {
			let RawArtifact { cache_path, url } = artifact;
			let local_path = cache_root.join(&cache_path);
			let name = string_util::str_of_os(local_path.file_name().ok_or_else(||anyhow!("No filename in path: {}", &cache_path))?)?;
			let digest = cache::nix_digest_of_file(&local_path).await?;
			let fetch_spec = FetchSpec::Archive(Archive { name: Some(name.to_owned()), url: Url::new(url) });
			let file = Fetch::new(fetch_spec, digest);
			artifacts.push(Artifact { cache_path, file });
		}
		Ok((key, MidSpec {
			name, version, artifacts,
		}))
	}
}

// between RawSpec and Spec
struct MidSpec {
	name: String,
	version: String,
	artifacts: Vec<Artifact>,
}

impl MidSpec {
	fn merge_from(&mut self, other: Self) -> Result<()> {
		let Self { name, version, mut artifacts } = other;
		if name != self.name {
			return Err(anyhow!("Can't merge specs with id {:?} and {:?}", &name, &self.name))
		}
		if version != self.version {
			return Err(anyhow!("Can't merge specs with src {:?} and {:?}", &version, &self.version))
		}

		// dedup artifacts on cache_path
		artifacts.retain(|to_add| {
			!self.artifacts.iter().any(|existing| existing.same_cache_path(to_add))
		});
		self.artifacts.extend(artifacts);
		Ok(())
	}

	fn into_spec(self) -> Result<Spec> {
		let Self {
			name,
			version,
			artifacts,
		} = self;

		let mut spec = PartialSpec::empty();
		spec.id.set_name(name.clone());
		spec.id.set_version(version.clone());
		
		// we don't set src, that's used for building SBT modules.
		// Instead we set artifacts to signal it's precompiled
		spec.set_src(Src::None);

		let mut artifact_exprs = Vec::with_capacity(artifacts.len());
		for artifact in artifacts.into_iter() {
			let Artifact { cache_path, file } = artifact;
			artifact_exprs.push(Expr::attr_set(vec!(
				("cache_path", Expr::str(cache_path)),
				("file", file.as_expr()),
			)));
		}
		spec.extra.insert("artifacts".to_owned(), Expr::List(artifact_exprs));
		Ok(spec.build()?)
	}
}

impl Artifact {
	fn same_cache_path(&self, other: &Self) -> bool {
		return self.cache_path == other.cache_path
	}
}
