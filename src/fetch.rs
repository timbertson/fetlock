use crate::lock::*;
use crate::nix_serialize::*;
use anyhow::*;
use futures::StreamExt;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use std::io::{ErrorKind, Write};
use std::path::PathBuf;
use std::str;
use tokio::fs;
use tokio::process::Command;

pub async fn populate_source_digests<'a, I: Iterator<Item=&'a mut Impl>>(impls: I) -> Result<()> {
	let mut stream = futures::stream::iter(impls)
		.map(|i| ensure_digest(i))
		.buffer_unordered(8);

	// TODO surely there's some `drain` method?
	while let Some(response) = stream.next().await {
		response?
	}
	Ok(())
}

async fn ensure_digest(implementation: &mut Impl) -> Result<()> {
	if implementation.src.requires_digest() && implementation.digest.is_none() {
		let fetched = fetch(&implementation.src)
			.await
			.with_context(|| format!("fetching source for {:?}", &implementation))?;
		implementation.digest = Some(fetched);
	}
	Ok(())
}

fn cache_filename(src: &Src) -> String {
	use sha2::{Digest, Sha256};
	let mut hasher = Sha256::new();
	// using Debug formatting is lazy, but easy :shrug:
	hasher.update(format!("{:?}", src));
	let mut hex = hex::encode(hasher.finalize());
	hex.truncate(24);
	hex
}

async fn fetch(src: &Src) -> Result<Sha256> {
	// let cache_dir = Path::new(&format!("{}/.cache/fetlock/digests", home));
	let cache_filename = cache_filename(src);
	let cache_shard = &cache_filename[0..2];

	let mut cache_dir = PathBuf::from(std::env::var("HOME").unwrap());
	cache_dir.push(".cache/fetlock/digests");
	cache_dir.push(cache_shard);

	let cache_path = cache_dir.join(cache_filename);
	debug!(
		"checking cached contents ({:?}) for src {:?}",
		&cache_path, src
	);
	match fs::read(&cache_path).await {
		Ok(bytes) => {
			debug!("bytes: {:?}", bytes);
			Ok(Sha256::new(String::from_utf8(bytes)?.trim_end().to_owned()))
		}
		Err(e) => {
			if e.kind() == ErrorKind::NotFound {
				info!("fetch: {:?}", src);
				fs::create_dir_all(&cache_dir).await?;
				let digest = do_fetch(src).await?;
				crate::fs::write_atomically(&cache_path, |mut f| Ok(write!(f, "{}\n", digest)?))?;
				Ok(digest)
			} else {
				Ok(Err(e).with_context(|| format!("reading {:?}", &cache_path))?)
			}
		}
	}
}

async fn do_fetch(src: &Src) -> Result<Sha256> {
	debug!("using prefetch to calculate digest for {:?}", src);
	let mut expr = Vec::new();
	write!(expr, "{}", "let pkgs = import <nixpkgs> {}; in ")?;
	let mut out = WriteContext::initial(&mut expr);
	let dummy = SrcDigest::new(src, Sha256::dummy());
	dummy.write_to(&mut out)?;
	let expr = str::from_utf8(&expr)?;

	let mut command = Command::new("nix-build");
	command
		.arg("--no-out-link")
		.arg("--show-trace")
		.arg("--expr")
		.arg(expr)
		.kill_on_drop(true);
	debug!("{:?}", command);
	let result = command.output().await?;

	lazy_static! {
	  // NOTE: this format works for nix 2.2+ only
	  static ref EXPECTED_SHA: Regex = Regex::new(&format!(r"got: +sha256:([a-z0-9]{{{}}})", Sha256::len())).unwrap();
	}

	let stderr = str::from_utf8(&result.stderr).unwrap_or("(non-utf8 output)");
	let stdout = str::from_utf8(&result.stdout).unwrap_or("(non-utf8 output)");
	if !stdout.is_empty() {
		for line in stderr.lines() {
			warn!("[nix-instantiate stdout]: {}", line);
		}
	}

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
