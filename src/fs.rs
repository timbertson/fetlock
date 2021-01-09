use anyhow::*;
use std::fs::File;
use std::fs;
use std::path::Path;

pub fn write_atomically<T>(p: impl AsRef<Path>, f: impl Fn(File) -> Result<T>) -> Result<T> {
	let p = p.as_ref();
	let existing_filename = p.file_name()
	  .and_then(|n| n.to_str())
	  .ok_or_else(||anyhow!("not a file path: {:?}", p))?;
	let mut tmp = p.to_path_buf();
  tmp.set_file_name(format!("{}.tmp", existing_filename));
  let ret = f(File::create(&tmp)?)?;
  fs::rename(tmp, p)?;
  Ok(ret)
}
