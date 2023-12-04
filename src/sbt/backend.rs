// SBT backend
// Note: SBT / java doesn't have any concept of a lockfile, so you
// do need to evaluate a project (and download its deps) via SBT
// every time you generate a lock.nix
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use serde::Deserialize;
use std::collections::BTreeMap;
use std::io::Read;
use std::os::unix;
use std::fs;
use std::path::PathBuf;
use std::process::Stdio;
use tokio::process::Command;

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawDependency {
	name: String,
	version: String,
	artifacts: Vec<RawArtifact>
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawArtifact {
	url: String,
	cache_path: String, // relative to root cache_path
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawFile {
	cache_root: String,
	dependencies: BTreeMap<Key, RawDependency>,
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
		
		let plugin_file = format!("{}/inject/Fetlock.scala", fetlock_env::nix());
		let plugin_link = project_dir.join("project/Fetlock.scala");

		// log::warn!("waiting...");
		// let mut buffer = String::new();
		// let stdin = std::io::stdin(); // We get `Stdin` here.
		// stdin.read_line(&mut buffer)?;


		// TODO clean this up
		if plugin_link.exists() {
			fs::remove_file(&plugin_link)?;
		}

		// TODO inject via env, not symlink
		unix::fs::symlink(&plugin_file, &plugin_link)
			.with_context(|| format!("symlinking {} -> {}", &plugin_file, plugin_link.display()))?;

		// sbt doesn't know that stderr is a thing apparently, so
		// we need to treat stdout as stderr and create a tempfile for the _actual_ output
		let mut fetlock_output = tempfile::NamedTempFile::with_prefix("sbt-")?;
		cmd::run(
			"sbt",
			Some(""), // disable interactivity
			Stdio::inherit(), // error output
			Command::new("sbt")
				.arg("generateFetlockOutput")
				.current_dir(&project_dir)
				.env("FETLOCK_OUTPUT", fetlock_output.path()),
		)
		.await?;
		let mut contents = String::new();
		fetlock_output.read_to_string(&mut contents)?;

		drop(fetlock_output);
		tmp_dir.close()?;

		let lockfile: RawFile = serde_json::from_str(&contents)
			.with_context(|| format!("{}\n\n^^parsing JSON output from Fetlock.scala", &contents))?;

		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Sbt));
		let RawFile { dependencies, cache_root } = lockfile;
		// let roots: Vec<Key> = toplevel.into_iter().map(Key::new).collect();
		lock.set_root(Root::Virtual(vec!())); // TODO

		let deps = SbtLock::build_deps(&PathBuf::from(cache_root), dependencies).await?;
		for (key, dep) in deps.into_iter() {
			lock.add_impl(key, dep);
		}

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
	async fn build_deps(cache_root: &PathBuf, raw: BTreeMap<Key, RawDependency>) -> Result<BTreeMap<Key, Spec>> {
		let stream = futures::stream::iter(raw);
		Ok(stream_util::map_parallel(10, stream, |raw| Self::build_dep(cache_root, raw)).await?.into_iter().collect())
	}

	async fn build_dep(cache_root: &PathBuf, pair: (Key, RawDependency)) -> Result<(Key, Spec)> {
		let (key, raw) = pair;
		let RawDependency {
			name,
			version,
			artifacts,
		} = raw;
		let desc = format!("populating src for {:?}", &name);

		let mut spec = PartialSpec::empty();
		spec.id.set_name(name.clone());
		spec.id.set_version(version.clone());
		
		// we don't set src, that's used for building SBT modules.
		// Instead we set artifacts to signal it's precompiled
		spec.set_src(Src::None);

		let mut artifact_exprs = Vec::with_capacity(artifacts.len());
		for artifact in artifacts.into_iter() {
			let RawArtifact { cache_path, url } = artifact;
			let local_path = cache_root.join(&cache_path);
			let name = string_util::str_of_os(local_path.file_name().ok_or_else(||anyhow!("No filename in path: {}", &cache_path))?)?;
			let digest = cache::nix_digest_of_file(&local_path).await?;
			let fetch_spec = FetchSpec::Archive(Archive { name: Some(name.to_owned()), url: Url::new(url) });
			artifact_exprs.push(Expr::attr_set(vec!(
				("cache_path", Expr::str(cache_path)),
				("file", Fetch::new(fetch_spec, digest).as_expr()),
			)));
		}
		spec.extra.insert("artifacts".to_owned(), Expr::List(artifact_exprs));
		Ok((key, spec.build()?))
	}
}
