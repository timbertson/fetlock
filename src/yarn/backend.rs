// yarn.lock backend
use crate::*;
use anyhow::*;
use log::*;
use std::io::Write;
use std::borrow::{Borrow, BorrowMut};
use async_trait::async_trait;
use crate::nix_serialize::{WriteContext, Writeable};
use crate::CliOpts;

#[derive(Clone, Debug)]
pub struct YarnLock {
	lock: Lock<YarnSpec>,
	opts: CliOpts,
}

#[async_trait(?Send)]
impl Backend for YarnLock {
	type Spec = YarnSpec;

	fn load(opts: CliOpts) -> Result<Self> {
		let context = LockContext::new(lock::Type::Yarn);
		info!("loading {}", &opts.lock_path);
		Err(anyhow!("TODO"))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lock
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.lock)
	}
}

#[derive(Debug, Clone)]
pub struct YarnSpec {
	spec: Spec,
}

// TODO get rid of this boilerplate?
impl Borrow<Spec> for YarnSpec {
	fn borrow(&self) -> &Spec {
		&self.spec
	}
}

impl BorrowMut<Spec> for YarnSpec {
	fn borrow_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}

impl Writeable for YarnSpec {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> std::io::Result<()> {
		self.spec.write_to(c)
	}
}