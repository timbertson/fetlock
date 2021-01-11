// common interface followed by all backends
use crate::lock::{Lock, Spec};
use crate::nix_serialize::Writeable;
use anyhow::*;
use async_trait::async_trait;
use std::borrow::BorrowMut;

// without the ?Send relaxation, implementation results in a confusing
// "one type is more general than the other" error:
// https://github.com/rust-lang/rust/issues/64650
#[async_trait(?Send)]
pub trait Backend: Sized {
	type Spec : BorrowMut<Spec> + Writeable;

	fn load(path: &str) -> Result<Self>;

	// access the underlying specs mutably (for populating sources)
	fn lock_mut<'a>(&'a mut self) -> &mut Lock<Self::Spec>;

	// Async to allow additional post-processing
	// (e.g. realising store paths and downloading
	// additional metadata from the internet)
	async fn finalize(self) -> Result<Lock<Self::Spec>>;
}
