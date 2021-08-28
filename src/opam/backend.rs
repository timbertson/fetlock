// opam backend. Note that opam doesn't have a builtin lock file,
// so we lean on `opam2nix extract` to solve
use crate::nix_serialize::{WriteContext, Writeable};
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use std::borrow::{Borrow, BorrowMut};
use std::io::Write;

#[derive(Clone, Debug)]
pub struct OpamSpec {
	spec: Spec,
}

// Structures used for communicating with opam2nix
pub mod opam2nix {
	use crate::lock::Name;
	use std::collections::HashMap;
	use serde;

	// Input
	#[derive(Clone, Debug, serde::Serialize)]
	pub struct Repository {
		pub id: String,
		pub path: String,
	}

	#[derive(Clone, Debug, serde::Serialize)]
	pub struct DirectSpec {
		pub definition: String,
	}

	#[derive(Clone, Debug, serde::Serialize)]
	pub struct Request {
		pub repositories: Vec<Repository>,
		pub spec: Vec<DirectSpec>,
	}
	
	// Output
	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct Src {
		pub url: String,
	}

	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct Command(Vec<String>);

	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct Depexts {
		pub required: Vec<String>,
		pub optional: Vec<String>,
	}

	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct SelectedPackage {
		pub version: String,
		pub repository: Option<String>,
		pub src: Option<Src>,
		pub depends: Vec<String>,
		pub depexts: Depexts,
		pub build_commands: Vec<Command>,
		pub install_commands: Vec<Command>,
	}

	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct Solution(HashMap<Name, SelectedPackage>);
}

#[derive(Clone, Debug)]
pub struct OpamLock {
	solution: opam2nix::Solution,
	lock: Lock<OpamSpec>,
}

#[async_trait(?Send)]
impl Backend for OpamLock {
	type Spec = OpamSpec;

	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self> {
		let context = LockContext::new(lock::Type::Opam);
		
		/*
		TODO actually invoke opam2nix
		*/
		let contents = "TODO";
		let solution: opam2nix::Solution = serde_json::from_str(&contents)?;
		Ok(OpamLock { solution, lock: todo!() })
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lock
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.lock)
	}
}

// TODO get rid of this boilerplate?
impl Borrow<Spec> for OpamSpec {
	fn borrow(&self) -> &Spec {
		&self.spec
	}
}

impl BorrowMut<Spec> for OpamSpec {
	fn borrow_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}

impl Writeable for OpamSpec {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> std::io::Result<()> {
		self.spec.write_to(c)
	}
}

impl AsSpec for OpamSpec {
	fn wrap(spec: Spec) -> Self {
		todo!()
	}
}