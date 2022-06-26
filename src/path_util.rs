use std::path::Path;

use anyhow::*;

pub fn to_str<P: AsRef<Path>>(p: &P) -> Result<&str> {
	let path = p.as_ref();
	path.to_str().ok_or_else(|| anyhow!("Invalid path: {:?}", path))
}
