// cargo backend
use crate::*;
use anyhow::*;
use log::*;
use std::collections::HashMap;
use async_trait::async_trait;
use cargo_metadata::{DependencyKind, MetadataCommand};

#[derive(Clone, Debug)]
pub struct CargoLock(Lock<Spec>);

impl CargoLock {
}

pub struct CrateMeta {
	features: Vec<String>,
}

#[async_trait(?Send)]
impl Backend for CargoLock {
	type Spec = Spec;

	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self> {
		let mut cmd = MetadataCommand::new();
		cmd.manifest_path(src.lock_path());
		let meta = cmd.exec()?;

		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Cargo));
		let resolve = meta.resolve.ok_or_else(||anyhow!("Cargo metadata did not include resolution information"))?;
		let root = resolve.root.ok_or_else(|| anyhow!("Cargo metadata has no root package"))?;
		lock.set_root(Root::Package(Key::from(&root.repr)));
		let mut nodes = HashMap::new();
		for node in resolve.nodes {
			// TODO I think these nodes could be references
			nodes.insert(Key::from(&node.id.repr), node.clone());
		}
		
		for package in meta.packages {
			let key = Key::from(&package.id.repr);
			let node = nodes.get(&key).ok_or_else(||
				anyhow!("Resolution metadata missing for package {:?}", &key))?;

			let mut partial = PartialSpec::empty();
			match package.source {
				None => partial.set_src(Src::None),
				Some(_) => partial.set_src(Src::Archive(Archive {
					name: Some("crate.tar.gz".to_owned()),
					url: Url::new(format!(
						"https://crates.io/api/v1/crates/{}/{}/download",
						&package.name, &package.version
					)),
				})),
			}
			partial.id.set_name(package.name);
			partial.id.set_version(package.version.to_string());
			partial.extra.insert("edition".to_owned(), Expr::str(package.edition.to_owned()));
			if !node.features.is_empty() {
				partial.extra.insert("features".to_owned(),
					Expr::List(node.features.iter().map(|f|
						Expr::str(f.to_owned())
					).collect())
				);
			}
			
			// note: package.dependencies is the spec, we can't tie it back to concrete pacakges.
			// we need to use the actual resolved deps for this package
			for dep in &node.deps {
				let required = dep.dep_kinds.iter().any(|k| {
					// TODO filter on k.target?
					match k.kind {
						DependencyKind::Normal => true,
						DependencyKind::Build => true,
						DependencyKind::Unknown => true,
						DependencyKind::Development => false,
					}
				});
				if !required {
					debug!("skipping development dependency {:?} -> {:?}", &key, &dep.pkg);
					continue;
				}
				let dep_key = Key::from(&dep.pkg.repr);
				partial.add_dep(dep_key);
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
