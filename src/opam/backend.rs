// opam backend. Note that opam doesn't have a builtin lock file,
// so we lean on `opam2nix extract` to solve
use crate::cache::CachedRepo;
use crate::nix_serialize::{WriteContext, Writeable};
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use log::*;
use std::borrow::{Borrow, BorrowMut};
use std::io::Write;
use tokio::process::Command;

#[derive(Clone, Debug)]
pub struct OpamSpec {
	spec: Spec,
}

// Structures used for communicating with opam2nix
pub mod opam2nix {
	use serde;
	use std::collections::HashMap;
	use std::path::PathBuf;

	// Input
	#[derive(Clone, Debug, serde::Serialize)]
	pub struct Repository {
		pub id: String,
		pub path: PathBuf,
	}

	#[derive(Clone, Debug, serde::Serialize)]
	pub struct DirectSpec {
		pub name: String,
		pub definition: PathBuf,
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

	#[derive(Clone, Debug, Default, serde::Deserialize)]
	pub struct Depexts {
		#[serde(default)]
		pub required: Vec<String>,

		#[serde(default)]
		pub optional: Vec<String>,
	}

	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct SelectedPackage {
		pub version: String,

		#[serde(default)]
		pub repository: Option<String>,

		pub src: Option<Src>,

		#[serde(default)]
		pub depends: Vec<String>,

		#[serde(default)]
		pub depexts: Depexts,

		pub build_commands: Vec<Command>,
		pub install_commands: Vec<Command>,
	}

	#[derive(Clone, Debug, serde::Deserialize)]
	pub struct Solution(pub HashMap<String, SelectedPackage>);
}

#[derive(Clone, Debug)]
pub struct OpamLock {
	lock: Lock<OpamSpec>,
}

#[async_trait(?Send)]
impl Backend for OpamLock {
	type Spec = OpamSpec;

	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self> {
		use opam2nix::{DirectSpec, Repository, Request, Solution};
		let context = LockContext::new(lock::Type::Opam);
		let opam_path = src.lock_path();

		let filename = opam_path
			.file_name()
			.ok_or(anyhow!("Filename required"))?
			.to_string_lossy();

		let package_name = filename
			.strip_suffix(".opam")
			.ok_or(anyhow!("not an .opam file: {}", filename))?;

		let package_name = Key::new(package_name.to_owned());

		let package_name_str = package_name.as_str();

		let opam_repo_git = GithubRepo {
			owner: "ocaml".to_owned(),
			repo: "opam-repository".to_owned(),
		};

		let opam_repo = CachedRepo::cache(&opts, &opam_repo_git).await?;

		let request = Request {
			repositories: vec![Repository {
				id: "opam".to_owned(),
				path: opam_repo.path.clone(),
			}],
			spec: vec![DirectSpec {
				name: package_name_str.to_owned(),
				definition: opam_path,
			}],
		};

		let serialized_request = serde_json::to_string(&request)?;

		info!("invoking opam solver");
		let contents = cmd::run_stdout(
			"opam2nix extract",
			Some(&serialized_request),
			Command::new("opam2nix").arg("extract"),
		)
		.await?;

		let mut solution: Solution = serde_json::from_str(&contents)?;

		let mut lock: Lock<OpamSpec> = Lock::<OpamSpec>::new(LockContext::new(lock::Type::Bundler));
		lock.set_root(Root::Package(package_name));
		for (name, selection) in solution.0.drain() {
			let mut spec = PartialSpec::empty();
			spec.set_src(match selection.src {
				Some(src) => Src::Archive(Url::new(src.url)),
				None => Src::None,
			});
			spec.id.set_name(name.clone());
			spec.id.set_version(selection.version);
			spec.add_deps(
				&mut selection
					.depends
					.iter()
					.map(|d| Key::new(d.clone()))
					.collect(),
			);

			for dep in selection.depexts.required {
				spec.add_build_input(Expr::Literal(format!("pkgs.{}", dep)));
			}

			for dep in selection.depexts.optional {
				spec.add_build_input(Expr::Literal(format!("pkgs.{} or null", dep)));
			}

			lock.add_impl(
				Key::new(name.clone()),
				OpamSpec {
					spec: spec.build()?,
				},
			);
		}
		Ok(OpamLock { lock })
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
