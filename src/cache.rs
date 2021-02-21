use crate::GitUrl;
use anyhow::*;
use log::*;
use std::fs;
use std::fs::*;
use std::io::Write;
use std::path::*;
use std::time::SystemTime;
use tokio::process::Command;

// 1 day
const SECONDS_PER_DAY: u64 = 60 * 60 * 24;
const TTL_SECONDS: u64 = SECONDS_PER_DAY;

pub fn cache_root() -> PathBuf {
	let mut cache_dir = PathBuf::from(std::env::var("HOME").unwrap());
	cache_dir.push(".cache/fetlock");
	cache_dir
}

pub fn cache_hash(src: &str) -> String {
	use sha2::{Digest, Sha256};
	let mut hasher = Sha256::new();
	hasher.update(src);
	let mut hex = hex::encode(hasher.finalize());
	hex.truncate(24);
	hex
}

async fn exec_command(command: &mut Command) -> Result<()> {
	debug!("{:?}", command);
	command.kill_on_drop(true);
	let status = command.spawn()?.wait().await?;
	debug!("Command {:?} status: {:?}", command, status);
	if status.success() {
		Ok(())
	} else {
		Err(anyhow!("Process failed: {:?}", command))
	}
}

pub async fn cached_repo<G: GitUrl>(src: &G) -> Result<PathBuf> {
	// TODO this should probably be async
	use fs2::FileExt;
	let mut path = cache_root();
	path.push("git");
	let url = src.git_url();
	path.push(cache_hash(&url));
	debug!("cache for {} is: {:?}", &url, &path);
	fs::create_dir_all(&path)?;
	let lock_path = path.clone().join("lock");
	let mut lock = OpenOptions::new()
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
		exec_command(
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
		if age.as_secs() > TTL_SECONDS {
			info!("updating {} (age={} days)", &url, age_in_days);
			exec_command(
				Command::new("git")
					.arg("-C")
					.arg(&repo_path)
					.arg("fetch")
					.arg("--force")
					.arg(&url)
					.arg(format!("HEAD:refs/heads/{}", fetch_ref)),
			)
			.await?;

			exec_command(
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
	Ok(repo_path)
}
