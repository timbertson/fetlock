use crate::Archive;
use crate::Github;
use crate::cmd;
use crate::WriteOpts;
use crate::hash::*;
use crate::memoize::Memoize;
use crate::{Expr, GitUrl};
use anyhow::*;
use futures::future::FutureExt;
use log::*;
use std::borrow::Cow;
use std::collections::BTreeMap;
use std::fs;
use std::fs::*;
use std::path::*;
use std::rc::Rc;
use std::time::SystemTime;
use tokio::process::Command;
use tokio::sync::Mutex;

/*
 * Cache is useful for tracking a floating HEAD of tracked repositories
 * (used for global repositories like opam)
 * It can also compute the nix digest of any path, for constructing fixed-output derivations.
 */

const SECONDS_PER_DAY: u64 = 60 * 60 * 24;

pub trait CacheKey {
	fn cache_key<'a>(&'a self) -> Cow<'a, str>;
}

impl CacheKey for String {
	fn cache_key<'a>(&'a self) -> Cow<'a, str> {
		Cow::Borrowed(self)
	}
}

impl CacheKey for str {
	fn cache_key<'a>(&'a self) -> Cow<'a, str> {
		Cow::Borrowed(self)
	}
}

// Github and Archive are always cacheable,
// using Debug formatting (it's brittle but I'm lazy)
// Custom embeds its own (optional) cache_key

impl CacheKey for Github {
	fn cache_key<'a>(&'a self) -> std::borrow::Cow<'a, str> {
		Cow::Owned(format!("{:?}", self))
	}
}

impl CacheKey for Archive {
	// using Debug formatting is lazy, but easy :shrug:
	fn cache_key<'a>(&'a self) -> std::borrow::Cow<'a, str> {
		Cow::Owned(format!("{:?}", self))
	}
}

pub fn cache_root() -> PathBuf {
	let mut cache_dir = PathBuf::from(std::env::var("HOME").unwrap());
	cache_dir.push(".cache/fetlock");
	cache_dir
}

pub fn cache_hash<T: CacheKey>(key: &T) -> String {
	use data_encoding::BASE32_NOPAD;
	use sha2::{Digest, Sha256};
	let mut hasher = Sha256::new();
	hasher.update(key.cache_key().as_ref());
	BASE32_NOPAD.encode(&hasher.finalize())
}

pub struct CachedRepo {
	pub path: PathBuf,
	pub commit: String,
	digest: Rc<Mutex<Memoize<Option<NixHash>>>>,
}

impl CachedRepo {
	pub async fn cache<G: GitUrl>(opts: &WriteOpts, src: &G) -> Result<CachedRepo> {
		use fs2::FileExt;
		let mut path = cache_root();
		path.push("git");
		let url = src.git_url();
		path.push(cache_hash(&url));
		debug!("cache for {} is: {:?}", &url, &path);
		fs::create_dir_all(&path)?;
		let lock_path = path.clone().join("lock");
		let lock = OpenOptions::new()
			.read(true)
			.write(true)
			.create(true)
			.open(&lock_path)?;
		lock.lock_exclusive()?;
		let repo_path = path.clone().join("repo");
		if !repo_path.exists() {
			let repo_tmp = path.clone().join("repo.tmp");
			if repo_tmp.exists() {
				fs::remove_dir_all(&repo_tmp)?;
			}
			info!("cloning {:?}", &url);
			cmd::exec(
				Command::new("git")
					.arg("clone")
					.arg("--depth=1")
					.arg(&url)
					.arg(&repo_tmp),
			)
			.await?;
			fs::rename(&repo_tmp, &repo_path)?;
		} else {
			debug!("checking staleness of {:?}", &repo_path);
			let mtime = lock.metadata()?.modified()?;
			let now = SystemTime::now();
			let age = now
				.duration_since(mtime)
				.or_else(|_| now.duration_since(SystemTime::UNIX_EPOCH))?;
			let fetch_ref = "fetlock-fetched";
			let age_in_days = age.as_secs() / SECONDS_PER_DAY;
			let clone_freshness_days = opts.clone_freshness_days.unwrap_or(1);
			if age.as_secs() > (u64::from(clone_freshness_days) * SECONDS_PER_DAY) {
				info!("updating {} (age={} days)", &url, age_in_days);
				cmd::exec(
					Command::new("git")
						.arg("-C")
						.arg(&repo_path)
						.arg("fetch")
						.arg("--force")
						.arg(&url)
						.arg(format!("HEAD:refs/heads/{}", fetch_ref)),
				)
				.await?;

				cmd::exec(
					Command::new("git")
						.arg("-C")
						.arg(&repo_path)
						.arg("reset")
						.arg("--hard")
						.arg(fetch_ref),
				)
				.await?;
				lock.set_len(0)?; // cause mtime to be updated
			} else {
				debug!("not updating {}, it's only {} days old", &url, age_in_days);
			}
		}
		let head_rev = cmd::run_stdout(
			"git",
			None,
			Command::new("git")
				.arg("-C")
				.arg(&repo_path)
				.arg("rev-parse")
				.arg("HEAD"),
		)
		.await?;
		let lazy_digest = {
			let repo_path = repo_path.clone();
			let rev = head_rev.clone();
			nix_digest_of_git_repo(repo_path, rev).map(|result| match result {
				Ok(sha) => Some(sha),
				Err(err) => {
					// have to log this instead of returning because Anyhow::Result
					// is not `Clone`.
					error!("{:?}", err);
					None
				}
			})
		};
		Ok(CachedRepo {
			commit: head_rev.to_owned(),
			path: repo_path,
			digest: Rc::new(Mutex::new(Memoize::new(Box::pin(lazy_digest)))),
		})
	}

	pub async fn digest(&self) -> Result<NixHash> {
		use std::ops::DerefMut;
		debug!("acquiring mutex...");
		let mut guard = self.digest.lock().await; //.unwrap();
		guard
			.deref_mut()
			.await
			.ok_or_else(|| anyhow!("failed to extract digest"))
	}
}

pub async fn nix_digest_of_path<P: AsRef<Path>>(path: P) -> Result<NixHash> {
	let output = cmd::run_stdout(
		"nix-hash",
		None,
		Command::new("bash")
			.arg("-euo")
			.arg("pipefail")
			.arg("-c")
			.arg("nix-store --dump \"$DIR\" | nix-hash --type sha256 --flat /dev/stdin")
			.env("DIR", path.as_ref()),
	)
	.await?;
	NixHash::from_hex(HashAlg::Sha256, &output)
}

// rev could be a reference, but it makes the actual usage awkward
pub async fn nix_digest_of_git_repo<P: AsRef<Path>>(path: P, rev: String) -> Result<NixHash> {
	info!("exporting {:?} revision {}", path.as_ref(), rev);
	let tmp_dir = tempdir::TempDir::new("fetlock-export")?;
	cmd::exec(
		Command::new("bash")
			.arg("-euc")
			.arg("git -C \"$REPO\" archive \"$REV\" | tar x -C \"$EXTRACT\"")
			.env("REPO", path.as_ref())
			.env("REV", rev)
			.env("EXTRACT", tmp_dir.path()),
	)
	.await?;
	nix_digest_of_path(tmp_dir.path()).await
}

pub fn subtree_expr(base: Expr, rel_path: String, hash: &NixHash) -> Expr {
	Expr::fun_call(
		Expr::Literal("final.subtree".to_owned()),
		vec![Expr::AttrSet(
			vec![
				("base".to_owned(), base),
				("path".to_owned(), Expr::str(rel_path)),
				("hash".to_owned(), Expr::str(hash.sri_string())),
			]
			.into_iter()
			.collect::<BTreeMap<String, Expr>>(),
		)],
	)
}
