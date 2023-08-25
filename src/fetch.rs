use crate::cache::{cache_hash, cache_root};
use crate::{cmd, fetlock_env};
use crate::lock::*;
use crate::hash::*;
use crate::nix_serialize::*;
use crate::stream_util::*;
use anyhow::*;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use reqwest::{StatusCode, Client};
use std::collections::HashMap;
use std::{fmt, mem, io};
use std::io::{ErrorKind, Write};
use std::path::{Path, PathBuf};
use std::process::{ExitStatus, Stdio};
use std::str;
use tokio::fs;
use tokio::process::Command;

pub async fn populate_source_digests<S: AsSpec>(lock: &mut Lock<S>) -> Result<()> {
	let partial_sources = lock.specs.values()
		.filter_map(|x| x.as_spec_ref().src.partial())
		.count();
	if partial_sources > 0 {
		warn!("Backend didn't supply digests for {} sources", partial_sources);
	}
	let impls = lock.specs.values_mut().map(|x| x.as_spec_mut());
	let result = foreach_unordered(
		8,
		futures::stream::iter(impls),
		|i| ensure_digest_mut(&mut i.src)
	).await;
	result
}

pub async fn ensure_digest(src: AnySrc) -> Result<Src> {
	match src {
		AnySrc::Full(full) => Ok(full),
		AnySrc::Partial(mut fetch) => {
			let digest = calculate_digest(&mut fetch)
				.await
				.with_context(|| format!("fetching source: {:?}", &fetch))?;
			Ok(Src::Fetch(Fetch::new(fetch, digest)))
		},
	}
}

pub async fn ensure_digest_mut(src: &mut AnySrc) -> Result<()> {
	let mut tmp = AnySrc::Full(Src::None);
	mem::swap(&mut tmp, src);
	let full = ensure_digest(tmp).await?;
	*src = AnySrc::Full(full);
	Ok(())
}

fn get_cache_path(fetch_spec: &FetchSpec) -> Option<PathBuf> {
	let cache_filename = match fetch_spec {
		FetchSpec::Github(x) => cache_hash(x),
		FetchSpec::Archive(x) => cache_hash(x),
		FetchSpec::Custom(custom) => cache_hash(custom.cache_key.as_ref()?),
	};
	let cache_shard = &cache_filename[0..2];

	let mut cache_dir = cache_root();
	cache_dir.push("digests");
	cache_dir.push(cache_shard);

	Some(cache_dir.join(cache_filename))
}

// mut is required so that we can upgrade github repos based on whether they appear to be private.
// If this gets awkward, we should find a way to do it in a separate pass or via construction.
// It's convenient here since we can skip the test if we have a cache hit
pub async fn calculate_digest(fetch_spec: &mut FetchSpec) -> Result<NixHash> {
	// this could be recursive, but that's awkward with async functions so here's
	// a maximum two step repeat :facepalm:
	match calculate_digest_inner(fetch_spec).await? {
		Prefetch::Complete(hash) => Ok(hash),
		Prefetch::RetryModified => match calculate_digest_inner(fetch_spec).await? {
			Prefetch::Complete(hash) => Ok(hash),
			Prefetch::RetryModified => Err(anyhow!("calculate_digest requested too many retries"))
		}
	}
}

pub struct Fetchers;

impl Fetchers {
	pub fn write_fetcher_prelude<'a, W : io::Write>(out: &mut WriteContext<'a, W>) -> Result<()> {
		// we bind fetlock's fetchers as `final`, because custom fetch
		// expressions will use that name to access fetchers provided
		// in the fixpoint.
		out.write_str(r#"
			let
				pkgs = import <nixpkgs> {};
				final = import <fetlock/fetch.nix> { inherit pkgs; };
			in
		"#)?;
		Ok(())
	}
	
	pub fn add_fetlock_path(cmd: &mut Command) {
		cmd.arg("-I").arg(format!("fetlock={}", fetlock_env::nix()));
	}
}

enum Prefetch {
	Complete(NixHash),
	RetryModified
}

async fn calculate_digest_inner(fetch_spec: &mut FetchSpec) -> Result<Prefetch> {
	let cache_path = get_cache_path(fetch_spec);
	if cache_path.is_some() {
		debug!(
			"checking cached contents ({:?}) for src {:?}",
			&cache_path, fetch_spec
		);
	}
	let result: Result<Prefetch> = (|| async {
		let cached: Option<NixHash> = match &cache_path {
			None => None,
			Some(cache_path) => {
				match fs::read(cache_path).await {
					Ok(bytes) => {
						let s = String::from_utf8(bytes)?;
						Some(NixHash::parse_sri(s.trim_end())?)
					},
					Err(e) => {
						if e.kind() == ErrorKind::NotFound {
							None
						} else {
							return Err(e).with_context(|| format!("reading {:?}", &cache_path));
						}
					}
				}
			}
		};

		match cached {
			Some(hash) => Ok(Prefetch::Complete(hash)),
			None => {
				if let FetchSpec::Github(github) = fetch_spec {
					if github.repo.private == false {
						let url = github.repo.git_url();
						debug!("Testing if public repo is reachable: {}", url);

						let status = Client::builder().build()?
							.head(&url).send().await
							.with_context(|| format!("HEAD {}", &url))?
							.status();
						if status == StatusCode::NOT_FOUND {
							info!("Assuming private repo: {:?}", github.repo);
							github.repo.private = true;
							return Ok(Prefetch::RetryModified);
						}
					}
				}

				info!("fetch: {:?}", fetch_spec);
				let digest = do_prefetch(fetch_spec).await?;
				if let Some(cache_path) = cache_path {
					let cache_dir = cache_path.parent().ok_or_else(||anyhow!("empty cache path"))?;
					fs::create_dir_all(cache_dir).await?;
					crate::fs::write_atomically(&cache_path, |mut f| {
						Ok(write!(f, "{}\n", digest.sri())?)
					})?;
				}
				Ok(Prefetch::Complete(digest))
			}
		}

	})()
	.await;
	result.with_context(|| format!("fetching source {:?}", fetch_spec))
}

#[derive(Debug)]
struct FetchMany {
	expr: String,
}

impl FetchMany {
	fn digests<'a, Digests: Iterator<Item = FetchSpecRef<'a>>>(
		fetch_specs: Digests,
	) -> Result<FetchMany> {
		let mut expr = Vec::new();
		let mut out = WriteContext::initial(&mut expr);
		Fetchers::write_fetcher_prelude(&mut out)?;
		out.write_str("rec { drvs = ")?;
		write_iter(fetch_specs, &mut out)?;
		out.write_str("; paths = builtins.map (d: d.outPath) drvs; }\n")?;
		let expr = String::from_utf8(expr)?;
		Ok(FetchMany { expr })
	}

	fn singleton(src_digest: FetchSpecRef) -> Result<FetchMany> {
		let digests = Some(src_digest);
		Self::digests(digests.into_iter())
	}
	
	fn build_command(&self) -> Command {
		let mut command = Command::new("nix-build");
		Fetchers::add_fetlock_path(&mut command);
		command
			.arg("--no-out-link")
			.arg("--show-trace")
			.arg("--attr")
			.arg("drvs")
			.arg("-");
		command
	}

	async fn realise(&self) -> Result<Vec<PathBuf>> {
		self.run_command("nix-build", &mut self.build_command(), Stdio::piped())
			.await?;

		let mut json_command = Command::new("nix-instantiate");
		Fetchers::add_fetlock_path(&mut json_command);

		let json = self
			.check_stdout(
				"nix-instantiate",
					json_command
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
		cmd::run_stdout("fetch", Some(self.expr.as_str()), command).await
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
	  static ref EXPECTED_SHA_2_2: Regex = Regex::new(r"(?m)^\s*got:\s+sha256:([a-z0-9]{52})").unwrap();
	  
		// 2.4 uses SRI format: https://github.com/NixOS/nix/commit/63c5c91cc053cbc1fcb8d3fe71c41142c9f51bfa
	  // https://github.com/NixOS/nix/commit/6024dc1d97212130c19d3ff5ce6b1d102837eee6#diff-6457959fc81a2b643a02948377299411961ae6027cf0b4da23928ec1d4d57ec8
	  static ref EXPECTED_SHA_2_4: Regex = Regex::new(r"(?m)^\s*got:\s+(sha[0-9]+-[^ \n\t]+$)").unwrap();
	}

	let mut it = EXPECTED_SHA_2_2.captures_iter(&stderr)
		.filter_map(|matches| matches.get(1))
		.map(|sha| NixHash::from_nix_b32(HashAlg::Sha256, sha.as_str().to_owned()))
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

async fn do_prefetch(spec: &FetchSpec) -> Result<NixHash> {
	let dummy = FetchSpecRef { spec, hash: NixHash::dummy() };
	debug!("prefetching {:?}", &dummy);
	let fetch = FetchMany::singleton(dummy)?;
	let (stdout, stderr, status) = fetch
		.run_command_raw(&mut fetch.build_command(), Stdio::piped())
		.await?;
	cmd::log_output(Level::Warn, "nix stdout", Ok(stdout));

	let stderr = stderr.ok_or_else(|| anyhow!("stderr not piped"))?;
	extract_expected_hash(&stderr)
		.with_context(|| format!("{:?}", &fetch))
}

pub async fn realise_fetch_sources<'a, It: Iterator<Item = (&'a Key, &'a Spec)>>
	(specs: It) -> Result<HashMap<Key, PathBuf>>
{
	let src_pairs = specs
		.filter_map(|(key, spec)| {
			match spec.src.require_full() {
				Err(e) => Some(Err(e)),
				Ok(full) => full.fetch().map(|fetch| {
					Ok((key, fetch))
				})
			}
		}).collect::<Result<Vec<(&Key, &Fetch)>>>()?;

	if src_pairs.is_empty() {
		return Ok(HashMap::new())
	}
	info!("realising: {} sources...", src_pairs.len());
	let paths = FetchMany::digests(src_pairs.iter().map(|(_key, fetch)| fetch.as_ref()))?
		.realise()
		.await.with_context(|| {
			let mut lines = src_pairs.iter().map(|(key, fetch)| {
				format!("{:?} from {:?}", fetch, get_cache_path(&fetch.spec))
			}).collect::<Vec<String>>();
			lines.sort();
			format!("Failed realising sources:\n{}", lines.join("\n"))
		})?;
	Ok(src_pairs
		.into_iter()
		.zip(paths)
		.map(|((key, _), path)| (key.to_owned(), path))
		.collect::<HashMap<Key, PathBuf>>())
}

pub async fn realise_source<'a>(fetch: &Fetch) -> Result<PathBuf> {
	let paths = FetchMany::singleton(fetch.as_ref())?.realise().await?;
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
		let new_src = match &mut spec.src.fetch_spec() {
			Some(FetchSpec::Github(gh)) => {
				if (!gh.fetch_submodules) && self.exists(".gitmodules").await {
					debug!("found .gitmodules file, upgrading fetch expression");

					let mut new_gh = gh.clone();
					new_gh.fetch_submodules = true;
					let mut new_spec = FetchSpec::Github(new_gh);
					let digest = calculate_digest(&mut new_spec).await?;
					Some(Src::Fetch(Fetch::new(new_spec, digest)))
				} else {
					None
				}
			},
			_ => None,
		};
		if let Some(src) = new_src {
			spec.set_src(src);
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
			extract_expected_hash(output).unwrap(),
			NixHash::parse_sri("sha256-uwehbMgcghqFcnaTyrlF5KI7QvLTdUMERuAopgTdm7A=").unwrap(),
		);
	}

	#[test]
	fn test_sha256_extract() {
		let output = "
unpacking source archive /private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-source.drv-0/fcbf81e89df989206bdad4a92327e593078525b2.tar.gz
hash mismatch in fixed-output derivation '/nix/store/n3b8iy0yjbckydapcj2lyjzcxyblis6x-source':
  wanted: sha256:0000000000000000000000000000000000000000000000000000
  got:    sha256:1mzs82grpwigji3a0gcs2g4s7i1lfd5qdwpnvczh6p3rrsfwsawc
error: build of '/nix/store/3ckw1sz0ipki3wxx79pfwpbssh5cmv3j-source.drv' failed
		";
		assert_eq!(
			extract_expected_hash(output).unwrap(),
			NixHash::from_nix_b32(HashAlg::Sha256, "1mzs82grpwigji3a0gcs2g4s7i1lfd5qdwpnvczh6p3rrsfwsawc".to_owned()).unwrap(),
		);
	}
}
