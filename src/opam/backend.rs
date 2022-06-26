// opam backend. Note that opam doesn't have a builtin lock file,
// so we lean on `opam2nix extract` to solve
use crate::cache;
use crate::hash::{NixHash, HashAlg};
use crate::cache::CachedRepo;
use crate::opam::build::PkgType;
use crate::opam::eval;
use crate::opam::opam2nix;
use crate::opam::opam_manifest::OpamJson;
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use futures::join;
use log::*;
use std::collections::{BTreeMap, HashMap};

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

	async fn load(src: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		use opam2nix::{OpamSource, Repository, Request, SelectedPackage, SolveSpec};
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

		let mut lock: Lock<OpamSpec> = Lock::<OpamSpec>::new(LockContext::new(lock::Type::Opam));

		lock.context.extra.insert(
			"ocamlPackages".to_owned(),
			Expr::Literal(match &opts.ocaml_version {
				None => "pkgs.ocaml-ng.ocamlPackages_latest".to_owned(),
				Some(version) => {
					let mut parts = version.split(".").into_iter();
					let (major, minor) = parts
						.next()
						.and_then(|major| parts.next().map(|minor| (major, minor)))
						.ok_or(anyhow!("Invalid ocaml version (expected major.minor*)"))?;
					format!("pkgs.ocaml-ng.ocamlPackages_{}_{}", major, minor)
				}
			}),
		);

		let opam_repo_git = GithubRepo {
			owner: "ocaml".to_owned(),
			repo: "opam-repository".to_owned(),
		};

		let opam_repo = CachedRepo::cache(&opts, &opam_repo_git).await?;

		let specs = vec![SolveSpec {
			name: package_name_str.to_owned(),
			constraints: None,
			definition: Some(OpamSource::Path(opam_path)),
		}];

		let request = Request {
			ocaml_version: opts.ocaml_version.clone(),
			repositories: vec![Repository {
				id: "opam".to_owned(),
				path: opam_repo.path.clone(),
			}],
			selection: None,
			spec: Some(specs),
		};

		let (solution, repo_digest) = join!(opam2nix::solve(&request), opam_repo.digest());
		let mut solution = solution?;
		let mut repositories = BTreeMap::new();
		repositories.insert(
			"opam".to_owned(),
			Fetch::new(
				FetchSpec::Github(Github {
					repo: opam_repo_git,
					git_ref: opam_repo.commit.clone(),
					fetch_submodules: false,
				}),
				repo_digest?
			).as_expr(),
		);

		lock.context
			.extra
			.insert("repositories".to_owned(), Expr::AttrSet(repositories));

		lock.set_root(Root::Package(package_name));

		let installed: HashMap<Name, eval::Pkg> = solution
			.0
			.iter()
			.map(|(name, selection)| {
				let key = Key::new(name.to_owned()); // opam keys are simply names
				let name = Name(name.to_owned());
				(name.clone(), eval::Pkg { name, key })
			})
			.collect();

		let mut repository_caches = HashMap::new();
		repository_caches.insert("opam".to_owned(), &opam_repo);

		for (name_str, selection) in solution.0.drain() {
			let mut spec = PartialSpec::empty();

			let name = Name(name_str.to_owned());
			let nix_ctx = eval::Ctx::from_map(PkgType::Opam, &name, &installed);
			let build = OpamJson(&selection)
				.build(&nix_ctx)
				.with_context(|| format!("evaluating opam package {:?}", &name))?;
			debug!(" -> as nix: {:?}", build);
			spec.extra.insert("build".to_owned(), build.expr());

			let SelectedPackage {
				version,
				repository,
				src,
				mut depends,
				depexts,
				build_commands: _,
				install_commands: _,
			} = selection;

			spec.id.set_name(name_str.clone());
			spec.id.set_version(version.clone());
			spec.set_any_src(match src {
				Some(src) => {
					let best_digest = src.digests.iter()
						.flat_map(|(alg_str, contents)|
							match HashAlg::parse(alg_str) {
								Err(e) => None,
								Ok(alg) => Some((alg, contents))
							}
						).max_by_key(|(alg,_)| *alg)
						.map(|(alg, contents)| NixHash::from_hex(alg, contents));
					let digest = match best_digest {
						None => { warn!("No useable opam digests found for {:?}", &src); None },
						Some(d) => Some(d?),
					};
					AnySrc::fetch(FetchSpec::Archive(Archive::new(src.url.clone())), digest)
				},
				None => AnySrc::Full(Src::None),
			});

			spec.add_deps(&mut depends);
			if let Some(repository) = repository {
				let cache = repository_caches
					.get(&repository)
					.ok_or(anyhow!("opam2nix returned unknown repository"))?;
				let files_rel = format!("packages/{}/{}.{}/files", &name_str, &name_str, &version);
				let local_path = cache.path.join(&files_rel);
				if local_path.exists() {
					debug!(
						"Adding files path {:?} from repository `{}`",
						&files_rel, repository
					);
					let hash = cache::nix_digest_of_path(local_path).await?;
					spec.extra.insert(
						"files".to_owned(),
						cache::subtree_expr(
							Expr::Literal(format!("final.repositories.{}", repository)),
							files_rel,
							&hash,
						),
					);
				}
			}

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
		// add `files` expression for all repo-based packages with an adjacent files directory
		Ok(self.lock)
	}
}

impl AsSpec for OpamSpec {
	fn wrap(spec: Spec) -> Self {
		todo!()
	}
	fn as_spec_ref(&self) -> &Spec {
		&self.spec
	}
	fn as_spec_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}
