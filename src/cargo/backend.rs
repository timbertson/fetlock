// cargo backend
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use cargo_metadata::{MetadataCommand, DependencyKind};

#[derive(Clone, Debug)]
pub struct CargoLock(Lock<Spec>);

#[async_trait(?Send)]
impl Backend for CargoLock {
	type Spec = Spec;

	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self> {
		let mut cmd = MetadataCommand::new();
		cmd.manifest_path(src.lock_path());
		let meta = cmd.exec()?;

		// let crates_io_git = GithubRepo {
		// 	owner: "rust-lang".to_owned(),
		// 	repo: "crates.io-index".to_owned(),
		// };
		// let crates_repo = CachedRepo::cache(&opts, &crates_io_git).await?;
		// let index = crates_index::Index::new(&crates_repo.path);

		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Cargo));
		let root = meta.root_package().ok_or_else(||anyhow!("Cargo metadata has no root package"))?;
		lock.set_root(Root::Package(Key::new(root.name.to_owned())));
		
		for package in meta.packages {
			let mut partial = PartialSpec::empty();
			let key = Key::new(package.name.to_owned());
			match package.source {
				None => partial.set_src(Src::None),
				Some(_) => partial.set_src(Src::Archive(Archive {
					name: Some("crate.tar.gz".to_owned()),
					url: Url::new(format!("https://crates.io/api/v1/crates/{}/{}/download", &package.name, &package.version)),
				})),
			}
			partial.id.set_name(package.name);
			partial.id.set_version(package.version.to_string());
			for dep in package.dependencies {
				if dep.kind == DependencyKind::Development {
					continue
				}
				partial.add_dep(Key::new(dep.name.to_owned()));
			}
			
			let spec = partial.build()?;
			lock.add_impl(key, spec)
		}

		Ok(CargoLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}
}
