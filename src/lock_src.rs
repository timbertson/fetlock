use crate::string_util::*;
use crate::*;
use anyhow::*;
use log::*;
use std::path::*;

#[derive(Debug, Clone)]
pub enum RootSpec {
	Github(GithubSpec),
	Path(PathBuf),
}

// A temporary state between LockRoot and a full LockSrc
// so we can resolve locally and autodetect lockfile etc
#[derive(Debug, Clone)]
pub struct LockRoot {
	pub spec: RootSpec,
	pub path: PathBuf,
	fetch: Option<Fetch>,
}

impl LockRoot {
	pub async fn resolve(opts: LockRootOpts) -> Result<Self> {
		let spec = Self::parse(opts)?;
		let (fetch, path) = match &spec {
			RootSpec::Path(p) => (None, p.clone()),
			RootSpec::Github(gh) => {
				let src = gh.resolve().await?;
				let fetch = Self::fetch(FetchSpec::Github(src)).await?;
				let root = fetch::realise_source(&fetch).await?;
				(Some(fetch), root)
			}
		};
		Ok(Self { spec, path, fetch})
	}

	fn parse(opts: LockRootOpts) -> Result<RootSpec> {
		debug!("parsing lock src:: {:?}", &opts);
		let LockRootOpts { repo, lock_root } = opts;
		let repo_root: Option<Result<RootSpec>> =
			repo.map(|repo| Ok(RootSpec::Github(GithubSpec::parse(repo.as_str())?)));
		let repo_root = repo_root.transpose()?;

		let spec: RootSpec = match (repo_root, lock_root) {
			(None, None) => RootSpec::Path(PathBuf::from(".")),
			(Some(remote), None) => remote,
			(None, Some(local)) => RootSpec::Path(PathBuf::from(local)),
			(Some(root), Some(relative)) => {
				return Err(anyhow!("Can't specify both --path and --github"))
			},
		};
		Ok(spec)
	}

	async fn fetch(mut fetch_spec: FetchSpec) -> Result<Fetch> {
		let digest = fetch::calculate_digest(&mut fetch_spec).await?;
		Ok(Fetch::new(fetch_spec, digest))
	}

	pub fn src(self, lockfile: String) -> LockSrc {
		let full = self.path.join(&lockfile);
		LockSrc {
			root: self,
			full,
			lockfile
		}
	}
}

#[derive(Debug, Clone)]
pub struct LockRootOpts {
	pub repo: Option<String>,
	pub lock_root: Option<String>,
}


#[derive(Debug, Clone)]
pub struct LockSrc {
	root: LockRoot,
	full: PathBuf,
	lockfile: String,
}

impl LockSrc {
	pub fn path(&self) -> &PathBuf {
		&self.full
	}
	
	pub fn lockfile(&self) -> &str {
		&self.lockfile
	}

	pub fn root(&self) -> &PathBuf {
		&self.root.path
	}

	pub fn fetch(&self) -> Option<&Fetch> {
		self.root.fetch.as_ref()
	}
	
	pub fn lock_root(&self) -> &LockRoot {
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
			repo: GithubRepo::new(owner.to_owned(), repo.to_owned()),
			git_ref: git_ref.unwrap_or("HEAD").to_owned(),
		})
	}
}
