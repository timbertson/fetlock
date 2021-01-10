// common interface followed by all backends
use crate::lock::Lock;
use anyhow::*;

pub trait Backend: Sized {
	fn load(path: &str) -> Result<Self>;

	// access the underlying lock held by Self
	fn lock_mut(&mut self) -> &mut Lock;

	// after sources have been resolved, some backends
	// perform additional mutation.
	// (e.g. adding build instructions or populating
	// information derived from the sources)
	fn finalize(self) -> Lock;
}
