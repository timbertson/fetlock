use anyhow::*;
use log::*;
use tokio::process::Command;
use tokio::fs;
use std::str;
use std::path::PathBuf;
use std::io::{ErrorKind, Write};
use lazy_static::lazy_static;
use regex::Regex;
use crate::lock::*;
use crate::nix_serialize::*;

fn cache_filename(src: &Src) -> Result<String> {
  use sha2::{Sha256, Digest};

  let mut hasher = Sha256::new();
  // using Debug formatting is lazy, but easy :shrug:
  hasher.update(format!("{:?}", src));
  let result = hasher.finalize();

  Ok(String::from_utf8(result.to_vec())?)
}

async fn fetch(src: &Src) -> Result<Sha256> {
  let mut cache_dir = PathBuf::from(std::env::var("HOME").unwrap());
  cache_dir.push(".cache/fetlock/digests");
  // let cache_dir = Path::new(&format!("{}/.cache/fetlock/digests", home));
  let cache_path = cache_dir.join(cache_filename(src)?);
  debug!("checking cached contents ({:?}) for src {:?}", &cache_path, src);
  match fs::read(&cache_path).await {
    Ok(bytes) => {
      Ok(Sha256::new(String::from_utf8(bytes)?.trim_end().to_owned()))
    },
    Err(e) => {
      if e.kind() == ErrorKind::NotFound {
        fs::create_dir_all(&cache_dir).await?;
        let digest = do_fetch(src).await?;
        crate::fs::write_atomically(&cache_path,
          |mut f| Ok(write!(f, "{}\n", digest)?)
        )?;
        Ok(digest)
      } else {
        Ok(Err(e)?)
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

  let mut command = Command::new("nix-instantiate");
  command
    .arg("--expr")
    .arg(expr)
    .kill_on_drop(true)
    ;
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
  let capture = it.next().ok_or_else(||
    anyhow!("Unable to extract expected sha from output:\n{}", stderr)
  )?;
  if it.next().is_some() {
    return Err(anyhow!("Extracted multiple expected digests from output:\n{}", stderr));
  }
  Ok(Sha256::new(capture[1].to_owned()))
}
