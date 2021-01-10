// common interface followed by all backends
use crate::lock::{Lock, Spec, Key};
use std::collections::hash_map;
use anyhow::*;

pub trait Backend: Sized {
	fn load(path: &str) -> Result<Self>;

	// access the underlying specs mutably (for populating sources)
	// TODO make this generic
	fn specs_mut(&mut self) -> hash_map::ValuesMut<Key, Spec>;

	// after sources have been resolved, some backends
	// perform additional mutation.
	// (e.g. adding build instructions or populating
	// information derived from the sources)
	fn finalize(self) -> Lock;
}
