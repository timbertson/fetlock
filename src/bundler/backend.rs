// Gemfile.lock backend
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use serde::Deserialize;
use std::path::PathBuf;
use tokio::process::Command;

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawSpec {
	name: String,
	version: String,
	repository: String,
	dependencies: Vec<Key>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct RawFile {
	toplevel: Vec<String>,
	specs: Vec<RawSpec>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
pub struct GemInfo {
	gem_uri: String,
	sha: String,
}

#[derive(Clone, Debug)]
pub struct BundlerLock(Lock<Spec>);

#[async_trait(?Send)]
impl Backend for BundlerLock {
	type Spec = Spec;

	async fn load(src: &LockSrc, opts: &WriteOpts) -> Result<Self> {
		// TODO we need both the lockfile and the Gemfile,
		// the CLIopts include only the lockfile
		let lock_path = src.path();
		let contents = cmd::run_stdout(
			"convert.rb",
			None,
			Command::new("ruby")
				.arg(format!("{}/inject/fetlock.rb", fetlock_env::nix()))
				.arg("lock")
				.arg(lock_path),
		)
		.await?;
		let lockfile: RawFile = serde_json::from_str(&contents)
			.with_context(|| format!("{}\n\n^^parsing JSON output from fetlock.rb", &contents))?;
		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Bundler));
		let RawFile { specs, toplevel } = lockfile;
		let roots: Vec<Key> = toplevel.into_iter().map(Key::new).collect();
		lock.set_root(Root::Virtual(roots));

		let specs = BundlerLock::build_specs(specs).await?;
		for spec in specs {
			lock.add_impl(Key::new(spec.id.name.clone()), spec);
		}

		Ok(BundlerLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}

	async fn update_lockfile<'a>(root: &'a PathBuf, rel: &'a str) -> Result<()> {
		cmd::exec(Command::new("bundle").arg("lock").arg("--update").current_dir(root)).await
	}
}

impl BundlerLock {
	async fn build_specs(raw: Vec<RawSpec>) -> Result<Vec<Spec>> {
		raw.into_iter().map(Self::build_spec).collect()
	}

	fn build_spec(raw: RawSpec) -> Result<Spec> {
		let RawSpec {
			name,
			version,
			repository,
			mut dependencies,
		} = raw;
		let desc = format!("populating src for {:?}", &name);

		let mut spec = PartialSpec::empty();
		spec.id.set_name(name.clone());
		spec.id.set_version(version.clone());
		spec.add_deps(&mut dependencies);

		let filename = format!("{}-{}.gem", &name, &version);
		let url = format!("{}gems/{}", &repository, &filename);
		let archive = Archive { url: lock::Url(url), name: Some(filename) };
		spec.set_fetch_src(FetchSpec::Archive(archive));
		spec.build()
	}
}
