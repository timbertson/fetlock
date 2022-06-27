// yarn.lock backend
use crate::*;
use log::*;
use anyhow::*;
use crate::stream_util::map_parallel;
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
		let contents = cmd::run_stdout(
			"convert.rb",
			None,
			Command::new("ruby")
				// .current_dir(base_dir)
				.arg("-e")
				.arg(include_str!("fetlock.rb"))
				.arg("lock")
				.arg(lock_path),
		)
		.await?;
		let lockfile: RawFile = serde_json::from_str(&contents)?;
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

	async fn update_lockfile<'a>(root: &'a PathBuf, rel: &'a Option<String>) -> Result<()> {
		cmd::exec(Command::new("bundle").arg("lock").arg("--update").current_dir(root)).await
	}
}

impl BundlerLock {
	async fn build_specs(raw: Vec<RawSpec>) -> Result<Vec<Spec>> {
		info!(
			"resolving {} package sources from online repository...",
			raw.len()
		);
		let stream = futures::stream::iter(raw.into_iter());
		map_parallel(10, stream, |raw| Self::build_spec(raw)).await
	}

	async fn build_spec(raw: RawSpec) -> Result<Spec> {
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

		let src: Result<Fetch> = (|| async move {
			// https://guides.rubygems.org/rubygems-org-api-v2/
			let url = format!("{}api/v2/rubygems/{}/versions/{}.json", &repository, &name, &version);
			let body = reqwest::get(&url)
				.await
				.with_context(|| format!("GET {}", &url))?
				.text()
				.await?;
			let listing: GemInfo = serde_json::from_str(&body)?;
			
			// The field is `sha`, but it's a sha256. Hope they don't change that.
			let digest = NixHash::from_hex(HashAlg::Sha256, &listing.sha)?;

			debug!("package listing for {:?}: {:?}", &name, listing);
			Ok(Fetch::new(FetchSpec::Archive(Archive::new(listing.gem_uri)), digest))
		})().await;
		spec.set_src(Src::Fetch(src.with_context(|| desc)?));
		spec.build()
	}
}
