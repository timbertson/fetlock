use crate::string_util::*;
use crate::*;
use anyhow::*;
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
}

#[derive(Debug, Clone)]
pub struct LocalSrc {
	root: PathBuf,
	relative: String,
}

impl LocalSrc {
	pub fn new(root: PathBuf, relative: String) -> Self {
		Self { root, relative }
	}

	pub fn lock_path(&self) -> PathBuf {
		// TODO cache once at construction
		self.root.join(&self.relative)
	}
}

impl LockSrc {
	pub fn parse(
		lock_type: lock::Type,
		repo: Option<String>,
		relative: Option<String>,
	) -> Result<LockSrc> {
		let root: Option<Result<LockRoot>> = repo.map(|repo| {
			let (path, git_ref) = split_one("#", &repo);
			let (owner, repo) = split_one_or_else("/", path, || anyhow!("invalid repo: {}", repo))?;
			Ok(LockRoot::Github(GithubSrc {
				repo: GithubRepo {
					owner: owner.to_owned(),
					repo: repo.to_owned(),
				},
				git_ref: git_ref.unwrap_or("HEAD").to_owned(),
			}))
		});
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
