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
	lockfile: Option<String>,
	resolved: Option<LocalSrc>,
}

#[derive(Debug, Clone)]
pub struct LockSrcOpts {
	pub repo: Option<String>,
	pub lock_root: Option<String>,
	pub lockfile: Option<String>,
}

impl LockSrc {
	pub async fn resolve(&mut self) -> Result<LocalSrc> {
		if let Some(resolved) = &self.resolved {
			return Ok(resolved.clone());
		}

		let relative = self.lockfile.clone();
		let resolved = match &self.root {
			LockRoot::Path(p) => Ok(LocalSrc::path(p.clone(), relative)),
			LockRoot::Github(gh) => {
				let src = gh.resolve().await?;
				LocalSrc::fetch_src(FetchSpec::Github(src), relative).await
			}
		}?;
		self.resolved = Some(resolved.clone());
		Ok(resolved)
	}
	
	pub fn lockfile(&self) -> Option<&str> {
		self.lockfile.as_deref()
	}
	
	pub fn root(&self) -> &LockRoot {
		&self.root
	}
	
	// When detecting a lockfile from a remote source, we have to resolve it
	// before we know the relative lockfile path. So if we've done that, we have to make sure
	// we also update the cached resolution.
	pub fn set_lockfile(&mut self, path: String) {
		if let Some(res) = &mut self.resolved {
			res.relative = Some(path.clone());
		}
		self.lockfile = Some(path);
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
			repo: GithubRepo::new(owner.to_owned(), repo.to_owned()),
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

		let root: LockRoot = match (repo_root, lock_root) {
			(None, None) => LockRoot::Path(PathBuf::from(".")),
			(Some(remote), None) => remote,
			(None, Some(local)) => LockRoot::Path(PathBuf::from(local)),
			(Some(root), Some(relative)) => {
				return Err(anyhow!("Can't specify both --path and --github"))
			},
		};
		Ok(LockSrc {
			root,
			lockfile: lockfile.map(|s| s.to_owned()),
			resolved: None
		})
	}
}
