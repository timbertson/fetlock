use crate::cache::{cache_hash, cache_root};
use crate::cmd;
use crate::lock::*;
use crate::hash::*;
use crate::nix_serialize::*;
use crate::stream_util::*;
use anyhow::*;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use std::collections::HashMap;
use std::fmt;
use std::io::{ErrorKind, Write};
use std::path::{Path, PathBuf};
use std::process::{ExitStatus, Stdio};
use std::str;
use tokio::fs;
use tokio::process::Command;

pub async fn populate_source_digests<S: AsSpec>(lock: &mut Lock<S>) -> Result<()> {
	let impls = lock.specs.values_mut().map(|x| x.as_spec_mut());
	foreach_unordered(8, futures::stream::iter(impls), |i| ensure_digest(i)).await
}

async fn ensure_digest(implementation: &mut Spec) -> Result<()> {
	if implementation.src.requires_digest() && implementation.digest.is_none() {
		let digest = calculate_digest(&implementation.src)
			.await
			.with_context(|| format!("fetching source for {:?}", &implementation))?;
		implementation.digest = Some(digest);
	}
	Ok(())
}

fn get_cache_path(src: &Src) -> PathBuf {
	// using Debug formatting is lazy, but easy :shrug:
	let cache_filename = cache_hash(&format!("{:?}", src));
	let cache_shard = &cache_filename[0..2];

	let mut cache_dir = cache_root();
	cache_dir.push("digests");
	cache_dir.push(cache_shard);

	cache_dir.join(cache_filename)
}

pub async fn calculate_digest(src: &Src) -> Result<NixHash> {
	let cache_path = get_cache_path(src);
	debug!(
		"checking cached contents ({:?}) for src {:?}",
		&cache_path, src
	);
	let result: Result<NixHash> = (|| async {
		match fs::read(&cache_path).await {
			Ok(bytes) => {
				let s = String::from_utf8(bytes)?;
				NixHash::parse_sri(s.trim_end())
			},
			Err(e) => {
				if e.kind() == ErrorKind::NotFound {
					info!("fetch: {:?}", src);
					let cache_dir = cache_path.parent().ok_or_else(||anyhow!("empty cache path"))?;
					fs::create_dir_all(cache_dir).await?;
					let digest = do_prefetch(src).await?;
					crate::fs::write_atomically(&cache_path, |mut f| {
						Ok(write!(f, "{}\n", digest.sri())?)
					})?;
					Ok(digest)
				} else {
					Ok(Err(e).with_context(|| format!("reading {:?}", &cache_path))?)
				}
			}
		}
	})()
	.await;
	result.with_context(|| format!("fetching source {:?}", src))
}

#[derive(Debug)]
struct FetchMany {
	expr: String,
}

impl FetchMany {
	fn digests<'a, Digests: Iterator<Item = &'a SrcDigest<'a>>>(
		src_digests: Digests,
	) -> Result<FetchMany> {
		let mut expr = Vec::new();
		let mut out = WriteContext::initial(&mut expr);
		out.write_str("let pkgs = import <nixpkgs> {}; in ")?;
		out.write_str("rec { drvs = ")?;
		write_iter(src_digests, &mut out)?;
		out.write_str("; paths = builtins.map (d: d.outPath) drvs; }\n")?;
		let expr = String::from_utf8(expr)?;
		Ok(FetchMany { expr })
	}

	fn singleton(src_digest: &SrcDigest) -> Result<FetchMany> {
		let digests = Some(src_digest);
		Self::digests(digests.into_iter())
	}

	fn build_command(&self) -> Command {
		let mut command = Command::new("nix-build");
		command
			.arg("--no-out-link")
			.arg("--show-trace")
			.arg("-")
			.arg("--attr")
			.arg("drvs");
		command
	}

	async fn realise(&self) -> Result<Vec<PathBuf>> {
		self.run_command("nix-build", &mut self.build_command(), Stdio::piped())
			.await?;

		let json = self
			.check_stdout(
				"nix-instantiate",
				Command::new("nix-instantiate")
					.arg("--show-trace")
					.arg("-")
					.arg("--attr")
					.arg("paths")
					.arg("--eval")
					.arg("--strict")
					.arg("--json"),
			)
			.await?;
		let errmsg = format!("parsing JSON: {}", &json);
		Ok(serde_json::from_str::<Vec<PathBuf>>(&json).with_context(|| errmsg)?)
	}

	async fn check_stdout<'a, 'b>(
		&self,
		desc: &'a str,
		command: &'a mut Command,
	) -> Result<String> {
		cmd::run_stdout("desc", Some(self.expr.as_str()), command).await
	}

	async fn run_command(
		&self,
		desc: &str,
		command: &mut Command,
		stdout: Stdio,
	) -> Result<Option<String>> {
		cmd::run(desc, Some(self.expr.as_str()), stdout, command).await
	}

	async fn run_command_raw(
		&self,
		command: &mut Command,
		stdout: Stdio,
	) -> Result<(Option<String>, Option<String>, ExitStatus)> {
		cmd::run_raw(Some(self.expr.as_str()), stdout, command).await
	}
}

fn extract_expected_hash(stderr: &str) -> Result<NixHash> {
	lazy_static! {
	  // NOTE: this format works for nix 2.2+ only
	  static ref EXPECTED_SHA_2_2: Regex = Regex::new(&format!(r"(?m)^\s*got:\s+sha256:([a-z0-9]{{{}}})", NixHash::legacy_sha256_b32_len())).unwrap();
	  
		// 2.4 uses SRI format: https://github.com/NixOS/nix/commit/63c5c91cc053cbc1fcb8d3fe71c41142c9f51bfa
	  // https://github.com/NixOS/nix/commit/6024dc1d97212130c19d3ff5ce6b1d102837eee6#diff-6457959fc81a2b643a02948377299411961ae6027cf0b4da23928ec1d4d57ec8
	  static ref EXPECTED_SHA_2_4: Regex = Regex::new(r"(?m)^\s*got:\s+(sha[0-9]+-[^ \n\t]+$)").unwrap();
	}

	println!("{}", stderr);
	let mut it = EXPECTED_SHA_2_2.captures_iter(&stderr)
		.filter_map(|matches| matches.get(1))
		.map(|sha| NixHash::from_nix_b32(HashAlg::Sha256, sha.as_str()))
		.chain(EXPECTED_SHA_2_4.captures_iter(&stderr)
			.filter_map(|matches| matches.get(1))
			.map(|sri| NixHash::parse_sri(sri.as_str()))
		);
	let first = it.next()
		.ok_or_else(|| anyhow!("Unable to extract expected digest from output:\n{}", stderr))??;
	debug!("first capture: {:?}", &first);
	if it.next().is_some() {
		return Err(anyhow!(
			"Extracted multiple expected digests from output:\n{}",
			stderr
		));
	}
	Ok(first)
}

async fn do_prefetch(src: &Src) -> Result<NixHash> {
	let dummy = SrcDigest::new(src, NixHash::dummy());
	debug!("prefetching {:?}", &dummy);
	let fetch = FetchMany::singleton(&dummy)?;
	let (stdout, stderr, status) = fetch
		.run_command_raw(&mut fetch.build_command(), Stdio::piped())
		.await?;
	cmd::warn_output("nix stdout", Ok(stdout));

	let stderr = stderr.ok_or_else(|| anyhow!("stderr not piped"))?;
	extract_expected_hash(&stderr)
		.with_context(|| format!("{:?}", &fetch))
}

pub async fn realise_sources<'a, It: Iterator<Item = (&'a Key, &'a Spec)>>(
	specs: It,
) -> Result<HashMap<Key, PathBuf>> {
	let pairs = specs
		.filter_map(|(k, spec)| spec.src_digest().map(|digest| (k, digest)))
		.collect::<Vec<(&Key, SrcDigest)>>();
	info!("realising: {} sources...", pairs.len());
	let paths = FetchMany::digests(pairs.iter().map(|(_key, digest)| digest))?
		.realise()
		.await.with_context(|| {
			let mut lines = pairs.iter().map(|(key, src_digest)| {
				let SrcDigest { src, digest } = src_digest;
				format!("{} // {:?}", digest.sri(), get_cache_path(&src))
			}).collect::<Vec<String>>();
			lines.sort();
			format!("Failed realising sources:\n{}", lines.join("\n"))
		})?;
	Ok(pairs
		.into_iter()
		.zip(paths)
		.map(|((key, _), path)| (key.to_owned(), path))
		.collect::<HashMap<Key, PathBuf>>())
}

pub async fn realise_source<'a>(src_digest: SrcDigest<'a>) -> Result<PathBuf> {
	let paths = FetchMany::singleton(&src_digest)?.realise().await?;
	Ok(paths.into_iter().next().expect("empty iter"))
}

#[derive(Debug, Clone)]
enum ArchiveType {
	Tar,
	Zip,
}

#[derive(Clone)]
struct ArchiveListing {
	archive_type: ArchiveType,
	first_component: String,
	raw_listing: String,
}

impl fmt::Debug for ArchiveListing {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> std::fmt::Result {
		fmt::Debug::fmt(&self.first_component, f)
	}
}

#[derive(Debug, Clone)]
enum SourceType {
	Archive(ArchiveListing),
	Directory,
}

#[derive(Debug, Clone)]
pub struct ExtractSource<'a> {
	root: &'a Path,
	source_type: SourceType,
}

impl ExtractSource<'_> {
	pub async fn from<P: AsRef<Path>>(root: &P) -> Result<ExtractSource<'_>> {
		let root = root.as_ref();
		debug!("ExtractSource::from({:?})", root);
		let source_type = if fs::metadata(root).await?.is_dir() {
			SourceType::Directory
		} else {
			(|| async {
				let root_str = root.to_str().ok_or_else(|| anyhow!("non-utf8 root path"))?;
				let (desc, mut cmd, archive_type) = if root_str.ends_with(".zip") {
					let mut cmd = Command::new("unzip");
					cmd.arg("-Z1").arg(root_str);
					("unzip", cmd, ArchiveType::Zip)
				} else {
					// assume it's some kind of tarball.
					let mut cmd = Command::new("tar");
					cmd.arg("tf").arg(root_str);
					("tar", cmd, ArchiveType::Tar)
				};
				let raw_listing = cmd::run_stdout(desc, None, &mut cmd).await?;
				// first grab the root directory
				let first_line = raw_listing
					.lines()
					.next()
					.ok_or_else(|| anyhow!("no output received from `tar`"))?;
				let first_component = first_line
					.split("/")
					.next()
					.expect("empty split")
					.to_owned();
				Ok::<SourceType, Error>(SourceType::Archive(ArchiveListing {
					archive_type,
					raw_listing,
					first_component,
				}))
			})()
			.await
			.with_context(|| format!("getting archive root for {:?}", root))?
		};
		Ok(ExtractSource { root, source_type })
	}

	pub async fn upgrade_gitmodules(&self, spec: &mut Spec) -> Result<()> {
		// note we don't actually switch the extracted source, we assume that any
		// files we need to inspect as part of fetlock aren't behind a submodule
		match &mut spec.src {
			Src::Github(gh) => {
				if (!gh.fetch_submodules) && self.exists(".gitmodules").await {
					debug!("found .gitmodules file, upgrading fetch expression");
					gh.fetch_submodules = true;
					spec.digest = Some(calculate_digest(&spec.src).await?);
				}
			}
			_ => (),
		}
		Ok(())
	}

	pub async fn exists(&self, file: &str) -> bool {
		debug!("exists({:?}, {:?}", self, file);
		match &self.source_type {
			SourceType::Directory => fs::metadata(self.root.join(file)).await.is_ok(),
			SourceType::Archive(listing) => {
				let expected = format!("{}/{}", listing.first_component, file);
				listing.raw_listing.lines().any(|line| line == expected)
			}
		}
	}

	pub async fn file_contents(&self, file: &str) -> Result<String> {
		debug!("file_contents({:?}, {:?})", self, file);
		match &self.source_type {
			SourceType::Directory => Ok(String::from_utf8(fs::read(self.root.join(file)).await?)?),
			SourceType::Archive(listing) => {
				let root_str = self
					.root
					.to_str()
					.ok_or_else(|| anyhow!("non-utf8 root path"))?;
				let archive_path = format!("{}/{}", listing.first_component, file);
				cmd::run_stdout(
					"tar",
					None,
					Command::new("tar")
						.arg("xf")
						.arg(root_str)
						.arg("--to-stdout")
						.arg("--extract")
						.arg(&archive_path),
				)
				.await
			}
		}
	}
}


#[cfg(test)]
mod tests {
	use super::*;
	#[test]
	fn test_sri_extract() {
		let output = "
error: hash mismatch in fixed-output derivation '/nix/store/di8z942yxvackqffrzjv53y2f4gkv5gp-archive.tar.gz.drv':
specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
   got:    sha256-uwehbMgcghqFcnaTyrlF5KI7QvLTdUMERuAopgTdm7A=
		";
		assert_eq!(
			extract_expected_hash(output).ok(),
			Some(NixHash::SRI(SRIHashOld::new("sha256-uwehbMgcghqFcnaTyrlF5KI7QvLTdUMERuAopgTdm7A=".to_string()))),
		);
	}
}
