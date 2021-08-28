use crate::string_util::*;
use crate::*;
use anyhow::*;
use log::*;
use std::path::*;

#[derive(Debug, Clone)]
pub enum LockRoot {
	Github(GithubSrc),
	Path(PathBuf),
}

#[derive(Debug, Clone)]
pub struct LockSrc {
	pub lock_type: lock::Type,
	pub root: LockRoot,
	pub relative: String,
}

impl LockSrc {
	pub async fn resolve(&self) -> Result<LocalSrc> {
		let relative = self.relative.clone();
		match &self.root {
			LockRoot::Path(p) => Ok(LocalSrc::path(p.clone(), relative)),
			LockRoot::Github(gh) => {
				let src = gh.resolve().await?;
				LocalSrc::fetch_src(src, relative).await
			}
		}
	}
}

#[derive(Debug, Clone)]
pub struct GithubSrc {
	repo: GithubRepo,
	git_ref: String,
}

impl GithubSrc {
	pub async fn resolve(&self) -> Result<Src> {
		let url = self.repo.git_url();
		let rev = resolve_git::resolve(&url, &self.git_ref).await?;
		Ok(self.repo.src_for_rev(rev))
	}

	pub fn parse(repo: &str) -> Result<GithubSrc> {
		let (path, git_ref) = split_one("#", &repo);
		let (owner, repo) = split_one_or_else("/", path, || anyhow!("invalid repo: {}", repo))?;
		Ok(GithubSrc {
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
	root: PathBuf,
	relative: String,
	pub src_digest: Option<(Src, Sha256)>,
}

impl LocalSrc {
	fn path(root: PathBuf, relative: String) -> Self {
		Self {
			root,
			relative,
			src_digest: None,
		}
	}

	async fn fetch_src(src: Src, relative: String) -> Result<Self> {
		let digest = fetch::calculate_digest(&src).await?;
		let root = fetch::realise_source(SrcDigest {
			src: &src,
			digest: &digest,
		})
		.await?;
		Ok(Self {
			root,
			relative,
			src_digest: Some((src, digest)),
		})
	}

	pub fn lock_path(&self) -> PathBuf {
		// TODO cache once at construction
		self.root.join(&self.relative)
	}
}

impl LockSrc {
	pub fn parse(
		lock_type: lock::Type,
		repo: Option<&str>,
		relative: Option<String>,
	) -> Result<LockSrc> {
		debug!("parsing lock src:: {:?} {:?}", &repo, &relative);
		let root: Option<Result<LockRoot>> =
			repo.map(|repo| Ok(LockRoot::Github(GithubSrc::parse(repo)?)));
		let root = root.transpose()?;
		let (root, relative): (LockRoot, String) = match (root, relative) {
			(_, None) => Err(anyhow!("path required")), // TODO guess relative from type
			(Some(root), Some(relative)) => Ok((root, relative)),
			(None, Some(relative)) => {
				// just a path, treat the parent directory as the repo
				let p = Path::new(&relative);
				Ok((
					LockRoot::Path(p.parent().unwrap_or(Path::new(".")).to_owned()),
					p.file_name()
						.ok_or(anyhow!("lock path must be a file"))?
						.to_str()
						.unwrap()
						.to_owned(),
				))
			}
		}?;
		Ok(LockSrc {
			lock_type,
			root,
			relative,
		})
	}
}
