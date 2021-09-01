// opam backend. Note that opam doesn't have a builtin lock file,
// so we lean on `opam2nix extract` to solve
use log::*;
use std::collections::HashMap;
use crate::opam::build::PkgType;
use crate::opam::eval;
use crate::opam::opam2nix;
use crate::cache::CachedRepo;
use crate::nix_serialize::{WriteContext, Writeable};
use crate::opam::opam_manifest::OpamJson;
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use std::borrow::{Borrow, BorrowMut};
use std::io::Write;

#[derive(Clone, Debug)]
pub struct OpamSpec {
	spec: Spec,
}

#[derive(Clone, Debug)]
pub struct OpamLock {
	lock: Lock<OpamSpec>,
}

#[async_trait(?Send)]
impl Backend for OpamLock {
	type Spec = OpamSpec;

	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self> {
		use opam2nix::{SolveSpec, OpamSource, Repository, Request};
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
			selection: None,
			spec: Some(vec![SolveSpec {
				name: package_name_str.to_owned(),
				definition: OpamSource::Path(opam_path),
			}]),
		};

		let mut solution = opam2nix::solve(&request).await?;

		let mut lock: Lock<OpamSpec> = Lock::<OpamSpec>::new(LockContext::new(lock::Type::Opam));
		lock.set_root(Root::Package(package_name));

		let installed: HashMap<Name, eval::Pkg> = solution.0.iter().map(|(name, selection)| {
			let key = Key::new(name.to_owned()); // opam keys are simply names
			let name = Name(name.to_owned());
			(name.clone(), eval::Pkg { name, key })
		}).collect();
			
		for (name_str, selection) in solution.0.drain() {
			let mut spec = PartialSpec::empty();
			spec.set_src(match &selection.src {
				Some(src) => Src::Archive(Url::new(src.url.clone())),
				None => Src::None,
			});
			spec.id.set_name(name_str.clone());
			spec.id.set_version(selection.version.clone());

			let name = Name(name_str.to_owned());
			let nix_ctx = eval::Ctx::from_map(PkgType::Opam, &name, &installed);
			let build = OpamJson(&selection)
				.build(&nix_ctx)
				.with_context(|| format!("evaluating opam package {:?}", &name))?;
			debug!(" -> as nix: {:?}", build);
			spec.extra.insert("build".to_owned(), build.expr());

			lock.add_impl(
				Key::new(name_str.clone()),
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
