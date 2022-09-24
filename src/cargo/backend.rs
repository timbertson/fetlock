// cargo backend
use crate::*;
use crate::cargo::registry::*;
use anyhow::*;
use futures::TryFutureExt;
use log::*;
use std::collections::HashMap;
use std::hash::Hash;
use tokio::process::Command;
use std::env;
use std::path::{Path, PathBuf};
use std::str::FromStr;
use platforms::platform;
use async_trait::async_trait;
use cargo_metadata::{DependencyKind, MetadataCommand, Package, Node, PackageId};
use cargo_platform::Cfg;

#[derive(Clone, Debug)]
pub struct CargoLock(Lock<Spec>);

pub struct CargoMeta<'a> {
	package: &'a Package,
	node: &'a Node,
}

// TODO derive from pkk.name and version, rather than parsing
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
struct CargoKey;
impl CargoKey {
	fn from(pkg: &Package) -> Key {
		Key::new(format!("{}-{}", &pkg.name, pkg.version.to_string()))
	}
}

#[derive(Debug)]
struct Platform {
	platform: &'static platform::Platform,
	cfgs: Vec<Cfg>,
}

impl CargoLock {
	fn relative_to<'s, B: AsRef<Path>, S: 's + AsRef<Path>>(base: B, sub: &'s S) -> Result<&'s str> {
		Ok(sub.as_ref().strip_prefix(base.as_ref())?.to_str().ok_or_else(||anyhow!("invalid path"))?)
	}

	async fn package_spec(registries: &mut Registries<'_>, meta: &CargoMeta<'_>, packages: &HashMap<PackageId, CargoMeta<'_>>, platform: &Platform) -> Result<Spec> {
		let CargoMeta { package, node } = meta;
		// code / concepts cribbed from https://github.com/kolloch/crate2nix/blob/4ea73d6a96f9dcf5cab70e454e39b33ca0bbaccb/crate2nix/src/resolve.rs
		let mut partial = PartialSpec::empty();
		match &package.source {
			None => partial.set_src(Src::None),
			Some(registry_spec) => {
				let src = registries.get(registry_spec).and_then(|registry|
					registry.get_source(&meta.package)
				).await.with_context(|| format!("Getting source for {:?}", &meta.package.id))?;
				partial.set_src(src);
			},
		}
		partial.id.set_name(package.name.to_string());
		partial.id.set_version(package.version.to_string());
		partial.extra.insert("edition".to_owned(), Expr::str(package.edition.to_owned()));

		let mut renames: HashMap<Name, HashMap<Version, Name>> = HashMap::new();

		// note: package.dependencies is the spec, we can't tie it back to concrete pacakges.
		// we need to use the actual resolved deps for this package
		let mut build_deps = Vec::new();
		for dep in &node.deps {
			let dep_meta = packages.get(&dep.pkg).ok_or_else(||
				anyhow!("Resolution package missing for dependency {:?}", &dep.pkg))?;

			// cargo renames dash -> underscore by default, any other
			// differences are explicit renames
			if dep_meta.package.name.replace('-', "_") != dep.name {
				let pkgname = Name(dep_meta.package.name.to_owned());
				let renamed = Name(dep.name.to_owned());
				let version = Version(dep_meta.package.version.to_string());
				let rename_map = renames.entry(pkgname).or_insert_with(|| HashMap::new());
				rename_map.insert(version, renamed);
			}
			let dep_key = CargoKey::from(&dep_meta.package);
			for dep_kind in &dep.dep_kinds {
				if let Some(platform_filter) = &dep_kind.target {
					if !platform_filter.matches(platform.platform.target_triple, &platform.cfgs) {
						debug!("Ignoring dependency for target platform {:?} (current: {:?})", platform_filter, platform);
						continue
					}
				}
				match dep_kind.kind {
					DependencyKind::Normal => partial.add_dep(dep_key.clone()),
					DependencyKind::Build => build_deps.push(dep_key.clone()),
					DependencyKind::Unknown => partial.add_dep(dep_key.clone()),
					DependencyKind::Development => (),
				}
			}
		}

		let base_path = package.manifest_path.parent().ok_or_else(||anyhow!("empy path"))?;
		let mut proc_macro = false;
		let mut build_target = None;
		let mut crate_bin = Vec::new();
		for target in &package.targets {

			// TODO is there a better way to get the base dir, or src_path relative to it?
			let src_rel = Self::relative_to(base_path, &target.src_path)?;

			if target.kind.iter().any(|k| k == "lib") {
				if src_rel != "src/lib.rs" {
					partial.extra.insert("libPath".to_owned(), Expr::str(src_rel.to_string()));
				}
			}

			if target.kind.iter().any(|k| k == "bin") {
				crate_bin.push(Expr::AttrSet(
					vec!(
						("name".to_owned(), Expr::str(target.name.to_owned())),
						("path".to_owned(), Expr::str(src_rel.to_string())),
					).into_iter().collect()
				))
			}

			if target.kind.iter().any(|k| k == "custom-build") {
				build_target = Some(target);
			}

			if target.kind.iter().any(|k| k == "proc-macro") {
				proc_macro = true
			}
		}

		if !node.features.is_empty() {
			partial.extra.insert("features".to_owned(),
				Expr::List(node.features.iter().map(|f|
					Expr::str(f.to_owned())
				).collect())
			);
		}
		if !crate_bin.is_empty() {
			partial.extra.insert("crateBin".to_owned(), Expr::List(crate_bin));
		}
		if !build_deps.is_empty() {
			partial.extra.insert("buildDepKeys".to_owned(),
				Expr::List(build_deps.into_iter().map(|k|
					Expr::str(k.into_string())
				).collect())
			);
		}
		if let Some(build_target) = build_target {
			partial.extra.insert("build".to_owned(), Expr::str(Self::relative_to(base_path, &build_target.src_path)?.to_owned()));
		}
		if proc_macro {
			partial.extra.insert("procMacro".to_owned(), Expr::Bool(true));
		}

		if !renames.is_empty() {
			partial.extra.insert("crateRenames".to_owned(), Expr::AttrSet(renames.into_iter().map(|(name, versions)| {
				let version_list = Expr::List(
					versions.into_iter().map(|(version, rename)|
						Expr::AttrSet(vec!(
							("version".to_owned(), Expr::str(version.0)),
							("rename".to_owned(), Expr::str(rename.0)),
						).into_iter().collect())
					).collect()
				);
				(name.0, version_list)
			}).collect()));
		}

		partial.build()
	}
	
	async fn get_platform(override_platform: Option<&str>) -> Result<Platform> {
		let platform = match override_platform {
			Some(p) => platforms::Platform::find(p).ok_or_else(||anyhow!("Unknown platform: {}", p))?,
			None => platform::Platform::guess_current().ok_or_else(||anyhow!("Unknown platform"))?,
		};
		let cfg_str = cmd::run_stdout("rustc --print cfg", None, Command::new(env::var("RUSTC").as_ref().map(|s| &**s).unwrap_or("rustc"))
			.arg("--target")
			.arg(platform.target_triple)
			.args(&["--print", "cfg"])
		).await?;

		let mut cfgs = vec!();
		for line in cfg_str.lines() {
			cfgs.push(Cfg::from_str(line)?);
		}

		Ok(Platform { cfgs, platform })
	}
}

#[async_trait(?Send)]
impl Backend for CargoLock {
	type Spec = Spec;

	async fn load(src: &LockSrc, opts: &WriteOpts) -> Result<Self> {
		let mut cmd = MetadataCommand::new();
		
		// we have a lockfile but cargo_metadata expects Cargo.toml, which should be a sibling
		let mut lock_path = src.path().to_owned();
		lock_path.set_file_name("Cargo.toml");
		cmd.manifest_path(lock_path);
		let meta = cmd.exec()?;

		let mut lock: Lock<Spec> = Lock::<Spec>::new(LockContext::new(lock::Type::Cargo));
		let resolve = meta.resolve.ok_or_else(||anyhow!("Cargo metadata did not include resolution information"))?;
		let nodes: HashMap<PackageId, &Node> = resolve.nodes.iter().map(|node| (node.id.clone(), node)).collect();
		let metas = {
			let mut map: HashMap<PackageId, CargoMeta<'_>> = HashMap::new();
			for package in meta.packages.iter() {
				let key = &package.id;
				let node = nodes.get(key).ok_or_else(|| anyhow!("Resolution node missing for package {:?}", &key))?;
				map.insert(key.clone(), CargoMeta { package, node });
			}
			map
		};

		if let Some(root) = resolve.root {
			let root_meta = metas.get(&root).ok_or_else(||anyhow!("Meta missing for root package ({})", root))?;
			lock.set_root(Root::Package(CargoKey::from(&root_meta.package)));
		} else {
			// create a virtual package depending on all workspace members (TODO: and their direct deps?)
			// TODO: for workspace members, use the correct `src`? Currently it uses the root which is the parent dir.
			let workspace_members = meta.workspace_members;
			let package_keys: Vec<Key> = workspace_members.iter()
				.flat_map(|pkgid| metas.get(pkgid))
				.map(|meta| meta.package)
				.map(|key| CargoKey::from(key))
				.collect()
				;
			lock.set_root(Root::Virtual(package_keys));
		}

		let platform = Self::get_platform(opts.cargo_platform.as_deref()).await?;
		let mut registries = Registries::new(opts);
		for meta in metas.values() {
			let key = CargoKey::from(&meta.package);
			let spec = Self::package_spec(&mut registries, &meta, &metas, &platform).await
				.with_context(||format!("Processing package {:?}", &meta.package))?;
			lock.add_impl(key, spec);
		}

		Ok(CargoLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}
	
	async fn update_lockfile<'a>(root: &'a PathBuf, rel: &'a str) -> Result<()> {
		cmd::exec(Command::new("cargo").arg("generate-lockfile").current_dir(root)).await
	}
}
