use log::*;
use anyhow::*;
use std::fs;
use std::fs::File;
use std::path::Path;

pub fn write_atomically<T>(p: impl AsRef<Path>, f: impl Fn(File) -> Result<T>) -> Result<T> {
	let p = p.as_ref();
	let existing_filename = p
		.file_name()
		.and_then(|n| n.to_str())
		.ok_or_else(|| anyhow!("not a file path: {:?}", p))?;
	let mut tmp = p.to_path_buf();
	tmp.set_file_name(format!("{}.tmp", existing_filename));
	if let Ok(tmpfile) = File::create(&tmp) {
		let ret = f(tmpfile)?;
		fs::rename(tmp, p)?;
		Ok(ret)
	} else {
		debug!("Can't create tempfile, writing to source directly");
		f(File::create(p)?)
	}
}
