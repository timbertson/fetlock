use crate::cache::{cache_hash, cache_root};
use crate::lock::*;
use crate::nix_serialize::*;
use anyhow::*;
use futures::StreamExt;
use futures::join;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use std::borrow::BorrowMut;
use std::fmt;
use std::collections::HashMap;
use std::io::{ErrorKind, Write};
use std::path::PathBuf;
use std::process::Stdio;
use std::str;
use tokio::fs;
use tokio::io::{AsyncReadExt, AsyncRead, AsyncWriteExt};
use tokio::process::Command;

pub async fn populate_source_digests<S: BorrowMut<Spec> + Writeable>(
	lock: &mut Lock<S>,
) -> Result<()> {
	let impls = lock.specs.values_mut().map(|x| x.borrow_mut());
	let mut stream = futures::stream::iter(impls)
		.map(|i| ensure_digest(i))
		.buffer_unordered(8);

	// TODO surely there's some `drain` method?
	while let Some(response) = stream.next().await {
		response?
	}
	Ok(())
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

struct FetchMany {
	expr: String,
}

impl FetchMany {
	fn digests<'a, Digests: Iterator<Item=&'a SrcDigest<'a>>>(src_digests: Digests) -> Result<FetchMany> {
		let mut expr = Vec::new();
		let mut out = WriteContext::initial(&mut expr);
		out.write_str("let pkgs = import <nixpkgs> {}; in ")?;
		out.write_str("rec { drvs = ")?;
		write_iter(src_digests, &mut out)?;
		out.write_str("; paths = pkgs.lib.map (d: d.outPath) drvs; }")?; // TODO
		Ok(FetchMany { expr: String::from_utf8(expr)? })
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
			// .arg("/tmp/foo")
			.arg("--attr")
			.arg("drvs")
			.kill_on_drop(true);
		command
	}

	async fn realise(&self) -> Result<Vec<String>> {
		let mut c = Command::new("bash");
		// c.arg("-euc").arg("sleep 0.5; echo FALSEY >&2; echo TRUEY; exit 1");
		// c.arg("-euc").arg("nix-build --no-out-link --show-trace --attr src --expr '(import <nixpkgs> {}).hello.drvAttrs'");
		// c.arg("-euc").arg("nix-build --no-out-link --show-trace --attr drvs -");
		c.arg("-euc").arg("nix-build --no-out-link --show-trace --attr drvs -");
		self.run_command("nix-build", c, Stdio::piped()).await?;
		todo!("ok yeah?");
		self.run_command("nix-build", self.build_command(), Stdio::piped()).await?;
	
		let mut expr_command = Command::new("nix-instantiate");
		expr_command
			.arg("--show-trace")
			.arg("-")
			.arg("--attr")
			.arg("paths")
			.arg("--eval")
			.arg("--strict")
			.arg("--json")
			.kill_on_drop(true);
		let json = self.check_stdout("nix-instantiate", expr_command).await?;
		let errmsg = format!("parsing JSON: {}", &json);
		Ok(serde_json::from_str::<Vec<String>>(&json).with_context(||errmsg)?)
	}

	async fn check_stdout(&self, desc: &'static str, command: Command) -> Result<String> {
		self.run_command(desc, command, Stdio::piped()).await.map(|stdout| stdout.expect("stdout is none"))
	}

	async fn run_command(&self, desc: &'static str, mut command: Command, stdout: Stdio) -> Result<Option<String>> {
		debug!("{:?}", command);
		command.stdout(stdout);
		command.stderr(Stdio::piped());
		command.stdin(Stdio::piped());
		command.kill_on_drop(true);
		let mut child = command.spawn()?;
		let mut stdin_pipe = child.stdin.take().expect("stdin is not a pipe");
		let mut stdout_pipe = child.stdout.take();
		let stderr_pipe = child.stderr.take().expect("stderr is not a pipe");
		let (wrote_stdin, stdout, consumed_stderr) = join!(
			// futures::future::ready(Ok::<(), Error>(())),
			(|| async {
				// debug!("Writing stdin: {}", self.expr);
				// let result = stdin_pipe.write(self.expr.as_bytes()).await;
				let result = stdin_pipe.write("{ drvs = [ (import <nixpkgs> {}).hello.drvAttrs.src ]; }".as_bytes()).await;
				drop(stdin_pipe);
				result
			})(),
			read_io_opt(&mut stdout_pipe),
			(|| async {
				use tokio::io::BufReader;
				use tokio::io::AsyncBufReadExt;
				let stderr_buf = BufReader::new(stderr_pipe);
				let mut lines = stderr_buf.lines();

				while let Some(line) = lines.next_line().await.transpose() {
					warn_output_line(desc, line.map_err(Error::from));
				}
				Ok::<(), Error>(())
			})(),
		);
		let status = command.status().await?;
		if status.success() {
			wrote_stdin.with_context(||"writing to stdin")?;
			stdout
		} else {
			consumed_stderr?;
			// warn_output(desc, &stderr);
			Err(anyhow!("Process failed (code={:?}): {:?}", status.code(), command))
		}
	}
}

async fn read_io_opt<Pipe: AsyncRead + Unpin>(pipe: &mut Option<Pipe>) -> Result<Option<String>> {
	if let Some(mut pipe) = pipe.take() {
		let mut buf = String::new();
		let _len: usize = pipe.read_to_string(&mut buf).await?;
		info!("read pipe -> {:?}", &buf);
		Ok(Some(buf))
	} else {
		Ok(None)
	}
}

fn warn_output_line(desc: &'static str, line: Result<String>) {
	match line {
		Ok(line) => {
			if !line.is_empty() {
				warn!("[{}]: {}", desc, line);
			}
		}
		Err(e) => {
			warn!("[{}]: can't read stderr: {:?}", desc, e);
		}
	}
}

fn warn_output(desc: &'static str, output: &Result<Option<String>>) {
	match output {
		Ok(None) => (),
		Ok(Some(output)) => {
			if !output.is_empty() {
				for line in output.lines() {
					warn!("[{}]: {}", desc, line);
				}
			}
		}
		Err(e) => {
			warn!("[{}]: can't read stderr: {:?}", desc, e);
		}
	}
}


async fn do_prefetch(src: &Src) -> Result<Sha256> {
	lazy_static! {
	  // NOTE: this format works for nix 2.2+ only
	  static ref EXPECTED_SHA: Regex = Regex::new(&format!(r"got: +sha256:([a-z0-9]{{{}}})", Sha256::len())).unwrap();
	}

	let dummy = SrcDigest::new(src, Sha256::dummy());
	let mut command = FetchMany::singleton(&dummy)?.build_command();
	let output = command.output().await?;
	let stdout = String::from_utf8(output.stdout).map(Some).map_err(Error::from);
	warn_output("nix stdout", &stdout);

	let stderr = str::from_utf8(&output.stderr).unwrap_or("(non-utf8 output)");
	let mut it = EXPECTED_SHA.captures_iter(stderr);
	let capture = it
		.next()
		.ok_or_else(|| anyhow!("Unable to extract expected sha from output:\n{}", stderr))
		.with_context(|| format!("{:?}", &command))?[1]
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

pub async fn realise_sources<'a, It: Iterator<Item=(&'a Key, &'a Spec)>>(specs: It) -> Result<HashMap<Key, PathBuf>> {
	let pairs = specs.filter_map(|(k, spec)| {
		spec.src_digest().map(|digest| (k, digest))
	}).collect::<Vec<(&Key, SrcDigest)>>();
	info!("realising: {} sources...", pairs.len());
	let paths = FetchMany::digests(pairs.iter().map(|(_key, digest)| digest))?.realise().await?;
	Ok(pairs.into_iter().zip(paths)
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
		let source_type = if fs::metadata(root).await?.is_dir() {
			SourceType::Directory
		} else {
			(|| async {
				let root_str = root.to_str().ok_or_else(|| anyhow!("non-utf8 root path"))?;
				let (mut cmd, archive_type) = if root_str.ends_with(".zip") {
					let mut cmd = Command::new("unzip");
					cmd.arg("-Z1").arg(root_str);
					(cmd, ArchiveType::Zip)
				} else {
					// assume it's some kind of tarball.
					let mut cmd = Command::new("tar");
					cmd.arg("tf").arg(root_str);
					(cmd, ArchiveType::Tar)
				};
				debug!("{:?}", cmd);
				// TODO use check_output?
				cmd.stdout(Stdio::piped()).kill_on_drop(true);
				let output = cmd.spawn()?.wait_with_output().await?;
				if !output.status.success() {
					Err(anyhow!("Process failed: {:?}", cmd))
				} else {
					let raw_listing = String::from_utf8(output.stdout)?;
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
					Ok(SourceType::Archive(ArchiveListing {
						archive_type,
						raw_listing,
						first_component,
					}))
				}
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
					gh.fetch_submodules = true;
					spec.digest = Some(do_prefetch(&spec.src).await?);
				}
			}
			_ => (),
		}
		Ok(())
	}

	pub async fn exists(&self, file: &str) -> bool {
		match &self.source_type {
			SourceType::Directory => fs::metadata(self.root.join(file)).await.is_ok(),
			SourceType::Archive(listing) => {
				let expected = format!("{}/{}", listing.first_component, file);
				listing.raw_listing.lines().any(|line| line == expected)
			}
		}
	}

	pub async fn file_contents(&self, file: &str) -> Result<String> {
		let bytes = (|| async move {
			match &self.source_type {
				SourceType::Directory => Ok(fs::read(self.root.join(file)).await?),
				SourceType::Archive(listing) => {
					let root_str = self
						.root
						.to_str()
						.ok_or_else(|| anyhow!("non-utf8 root path"))?;
					let archive_path = format!("{}/{}", listing.first_component, file);
					let mut cmd = Command::new("tar");
					cmd.arg("xf")
						.arg(root_str)
						.arg("--to-stdout")
						.arg("--extract")
						.arg(&archive_path)
						.stdout(Stdio::piped())
						.kill_on_drop(true);
					debug!("{:?}", cmd);
					let output = cmd.spawn()?.wait_with_output().await?;
					if !output.status.success() {
						Err(anyhow!(
							"Process `tar` failed to extract {} from {:?}",
							file,
							self
						))
					} else {
						Ok(output.stdout)
					}
				}
			}
		})()
		.await?;
		Ok(String::from_utf8(bytes)?)
	}
}
