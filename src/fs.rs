use anyhow::*;
use std::fs::File;
use std::fs;

pub fn write_atomically<T>(p: &str, f: impl Fn(File) -> Result<T>) -> Result<T> {
	let tmp = format!("{}.tmp", p);
  let ret = f(File::create(&tmp)?)?;
  fs::rename(tmp, p)?;
  Ok(ret)
}
