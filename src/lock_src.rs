use crate::*;
use std::path::PathBuf;

pub enum LockSrc {
	Src(Src),
	Path(PathBuf),
}
