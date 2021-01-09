use anyhow::*;
use log::*;
use tokio::process::Command;
use std::str;
use lazy_static::lazy_static;
use regex::Regex;
use crate::lock::*;
use crate::nix_serialize::*;

pub async fn fetch(src: &Src) -> Result<Sha256> {
  use std::io::Write;
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
