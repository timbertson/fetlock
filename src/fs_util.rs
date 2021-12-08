use anyhow::*;
use std::fs;
use std::path::Path;

pub fn read_to_string<P: AsRef<Path>>(path: P) -> Result<String> {
	fs::read_to_string(path.as_ref()).with_context(|| format!("reading {:?}", path.as_ref()))
}
