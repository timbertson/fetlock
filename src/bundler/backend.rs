// yarn.lock backend
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

struct PartialBundlerSpec {
	spec: PartialSpec,
	repository: String,
}

#[derive(Clone, Debug)]
pub struct BundlerLock(Lock<Spec>);

#[async_trait(?Send)]
impl Backend for BundlerLock {
	type Spec = Spec;

	async fn load(src: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		// TODO we need both the lockfile and the Gemfile,
		// the CLIopts include only the lockfile
		let lock_path = src.lock_path();
		let base_dir = lock_path
			.parent()
			.and_then(|p| p.to_str())
			.ok_or_else(|| anyhow!("can't get parent directory of lockfile"))?;
		let contents = cmd::run_stdout(
			"convert.rb",
			None,
			Command::new("ruby")
				.current_dir(base_dir)
				.arg("-e")
				.arg(include_str!("fetlock.rb"))
				.arg("lock"),
		)
		.await?;
		let lockfile: RawFile = serde_json::from_str(&contents)?;
		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Bundler));
		let RawFile { specs, toplevel } = lockfile;
		let roots: Vec<Key> = toplevel.into_iter().map(Key::new).collect();
		lock.set_root(Root::Virtual(roots));

		for spec in specs.into_iter() {
			let RawSpec {
				name,
				version,
				repository,
				mut dependencies,
			} = spec;
			let mut spec = PartialSpec::empty();
			let gem_url = format!("{}downloads/{}-{}.gem", &repository, &name, &version);
			spec.set_src(Src::Archive(Archive::new(gem_url)));
			spec.id.set_name(name.clone());
			spec.id.set_version(version);
			spec.add_deps(&mut dependencies);
			lock.add_impl(Key::new(name), spec.build()?);
		}

		Ok(BundlerLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}

	async fn update_lockfile<'a>(root: &'a PathBuf, rel: &'a Option<String>) -> Result<()> {
		cmd::exec(Command::new("bundle").arg("lock").arg("--update").current_dir(root)).await
	}
}
