use crate::string_util::*;
use crate::*;
use anyhow::*;
use log::*;
use std::path::*;

#[derive(Debug, Clone)]
pub enum LockRoot {
	Github(GithubSpec),
	Path(PathBuf),
}

#[derive(Debug, Clone)]
pub struct LockSrc {
	root: LockRoot,
	pub relative: Option<String>,
	pub lockfile: Option<String>,
}

#[derive(Debug, Clone)]
pub struct LockSrcOpts {
	pub repo: Option<String>,
	pub lock_root: Option<String>,
	pub lockfile: Option<String>,
}

impl LockSrc {
	pub async fn resolve(&self) -> Result<LocalSrc> {
		let relative = match (&self.relative, &self.lockfile) {
			(Some(rel), Some(lock)) => Some(format!("{}/{}", rel, lock)),
			(Some(rel), None) => Some(rel.clone()),
			(None, Some(lock)) => Some(lock.clone()),
			(None, None) => None,
		};
		match &self.root {
			LockRoot::Path(p) => Ok(LocalSrc::path(p.clone(), relative)),
			LockRoot::Github(gh) => {
				let src = gh.resolve().await?;
				LocalSrc::fetch_src(FetchSpec::Github(src), relative).await
			}
		}
	}
	
	pub fn root(&self) -> &LockRoot {
		&self.root
	}
}

#[derive(Debug, Clone)]
pub struct GithubSpec {
	repo: GithubRepo,
	git_ref: String,
}

impl GithubSpec {
	pub async fn resolve(&self) -> Result<Github> {
		let url = self.repo.git_url();
		let rev = resolve_git::resolve(&url, &self.git_ref).await?;
		Ok(self.repo.for_rev(rev))
	}

	pub fn parse(repo: &str) -> Result<GithubSpec> {
		let (path, git_ref) = split_one("#", &repo);
		let (owner, repo) = split_one_or_else("/", path, || anyhow!("invalid repo: {}", repo))?;
		Ok(GithubSpec {
			repo: GithubRepo {
				owner: owner.to_owned(),
				repo: repo.to_owned(),
			},
			git_ref: git_ref.unwrap_or("HEAD").to_owned(),
		})
	}
}

#[derive(Debug, Clone)]
pub struct LocalSrc {
	pub root: PathBuf,
	pub relative: Option<String>,
	pub fetch: Option<Fetch>,
}

impl LocalSrc {
	fn path(root: PathBuf, relative: Option<String>) -> Self {
		Self {
			root,
			relative,
			fetch: None
		}
	}

	async fn fetch_src(mut fetch_spec: FetchSpec, relative: Option<String>) -> Result<Self> {
		let digest = fetch::calculate_digest(&mut fetch_spec).await?;
		let fetch = Fetch::new(fetch_spec, digest);
		let root = fetch::realise_source(&fetch).await?;
		Ok(Self {
			root,
			relative,
			fetch: Some(fetch),
		})
	}

	pub fn lock_path(&self) -> PathBuf {
		// TODO cache once at construction
		if let Some(rel) = &self.relative {
			self.root.join(rel)
		} else {
			self.root.clone()
		}
	}
}

impl LockSrc {
	pub fn parse(opts: LockSrcOpts) -> Result<LockSrc> {
		debug!("parsing lock src:: {:?}", &opts);
		let LockSrcOpts { repo, lock_root, lockfile } = opts;
		let repo_root: Option<Result<LockRoot>> =
			repo.map(|repo| Ok(LockRoot::Github(GithubSpec::parse(repo.as_str())?)));
		let repo_root = repo_root.transpose()?;
		let (root, relative): (LockRoot, Option<String>) = match (repo_root, lock_root) {
			(None, None) => (LockRoot::Path(PathBuf::from(".")), None),
			(Some(root), relative) => (root, relative.map(|s| s.to_owned())),
			(None, Some(local_root)) => (LockRoot::Path(PathBuf::from(local_root)), None),
		};
		Ok(LockSrc {
			root,
			relative,
			lockfile: lockfile.map(|s| s.to_owned()),
		})
	}
}
