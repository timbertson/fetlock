use crate::cache::{cache_hash, cache_root};
use crate::cmd;
use crate::lock::*;
use crate::nix_serialize::*;
use crate::stream_util::*;
use anyhow::*;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use std::borrow::BorrowMut;
use std::collections::HashMap;
use std::fmt;
use std::io::{ErrorKind, Write};
use std::path::PathBuf;
use std::process::{ExitStatus, Stdio};
use std::str;
use tokio::fs;
use tokio::process::Command;

pub async fn populate_source_digests<S: BorrowMut<Spec> + Writeable>(
	lock: &mut Lock<S>,
) -> Result<()> {
	let impls = lock.specs.values_mut().map(|x| x.borrow_mut());
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

async fn calculate_digest(src: &Src) -> Result<Sha256> {
	// using Debug formatting is lazy, but easy :shrug:
	let cache_filename = cache_hash(&format!("{:?}", src));
	let cache_shard = &cache_filename[0..2];

	let mut cache_dir = cache_root();
	cache_dir.push("digests");
	cache_dir.push(cache_shard);

	let cache_path = cache_dir.join(cache_filename);
	debug!(
		"checking cached contents ({:?}) for src {:?}",
		&cache_path, src
	);
	match fs::read(&cache_path).await {
		Ok(bytes) => Ok(Sha256::new(String::from_utf8(bytes)?.trim_end().to_owned())),
		Err(e) => {
			if e.kind() == ErrorKind::NotFound {
				info!("fetch: {:?}", src);
				fs::create_dir_all(&cache_dir).await?;
				let digest = do_prefetch(src).await?;
				crate::fs::write_atomically(&cache_path, |mut f| Ok(write!(f, "{}\n", digest)?))?;
				Ok(digest)
			} else {
				Ok(Err(e).with_context(|| format!("reading {:?}", &cache_path))?)
			}
		}
	}
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

	async fn realise(&self) -> Result<Vec<String>> {
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
		Ok(serde_json::from_str::<Vec<String>>(&json).with_context(|| errmsg)?)
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

async fn do_prefetch(src: &Src) -> Result<Sha256> {
	lazy_static! {
	  // NOTE: this format works for nix 2.2+ only
	  static ref EXPECTED_SHA: Regex = Regex::new(&format!(r"got: +sha256:([a-z0-9]{{{}}})", Sha256::default_len())).unwrap();
	}

	let dummy = SrcDigest::new(src, Sha256::dummy());
	debug!("prefetching {:?}", &dummy);
	let fetch = FetchMany::singleton(&dummy)?;
	let (stdout, stderr, status) = fetch
		.run_command_raw(&mut fetch.build_command(), Stdio::piped())
		.await?;
	cmd::warn_output("nix stdout", Ok(stdout));

	let stderr = stderr.ok_or_else(|| anyhow!("stderr not piped"))?;
	let mut it = EXPECTED_SHA.captures_iter(&stderr);
	let capture = it
		.next()
		.ok_or_else(|| anyhow!("Unable to extract expected sha from output:\n{}", stderr))
		.with_context(|| format!("{:?}", &fetch))?[1]
		.to_owned();
	debug!("first capture: {}", &capture);
	if it.next().is_some() {
		return Err(anyhow!(
			"Extracted multiple expected digests from output:\n{}",
			stderr
		));
	}
	Ok(Sha256::new(capture))
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
		.await?;
	Ok(pairs
		.into_iter()
		.zip(paths)
		.map(|((key, _), path)| (key.to_owned(), PathBuf::from(path)))
		.collect::<HashMap<Key, PathBuf>>())
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
	root: &'a PathBuf,
	source_type: SourceType,
}

impl ExtractSource<'_> {
	pub async fn from(root: &PathBuf) -> Result<ExtractSource<'_>> {
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
