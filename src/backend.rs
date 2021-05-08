// common interface followed by all backends
use crate::lock::{AsSpec, Lock};
use crate::lock_src::LocalSrc;
use crate::CliOpts;
use anyhow::*;
use async_trait::async_trait;

// without the ?Send relaxation, implementation results in a confusing
// "one type is more general than the other" error:
// https://github.com/rust-lang/rust/issues/64650
#[async_trait(?Send)]
pub trait Backend: Sized + std::fmt::Debug {
	type Spec: AsSpec;

	// Parse file, populate a lock structure
	// async because some implementations will need
	// to download metadata from a registry
	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self>;

	// access the underlying specs mutably (for populating source digests)
	fn lock_mut<'a>(&'a mut self) -> &mut Lock<Self::Spec>;

	// Additional post-processing, after source digests are populated.
	// (e.g. realising store paths and downloading
	// additional metadata from the internet)
	async fn finalize(self) -> Result<Lock<Self::Spec>>;
}
