// cargo backend
use crate::*;
use anyhow::*;
use log::*;
use std::collections::HashMap;
use std::process::Command;
use std::env;
use std::path::Path;
use std::str::FromStr;
use platforms::platform;
use async_trait::async_trait;
use cargo_metadata::{DependencyKind, MetadataCommand, Package, Node};
use cargo_platform::Cfg;

#[derive(Clone, Debug)]
pub struct CargoLock(Lock<Spec>);

#[derive(Debug)]
struct Platform {
	platform: &'static platform::Platform,
	cfgs: Vec<Cfg>,
}

impl CargoLock {
	fn relative_to<'s, B: AsRef<Path>, S: 's + AsRef<Path>>(base: B, sub: &'s S) -> Result<&'s str> {
		Ok(sub.as_ref().strip_prefix(base.as_ref())?.to_str().ok_or_else(||anyhow!("invalid path"))?)
	}

	fn package_spec(package: &Package, nodes: &HashMap<Key, Node>, platform: &Platform) -> Result<(Key, Spec)> {
		// code / concepts cribbed from https://github.com/kolloch/crate2nix/blob/4ea73d6a96f9dcf5cab70e454e39b33ca0bbaccb/crate2nix/src/resolve.rs
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
		partial.id.set_name(package.name.to_string());
		partial.id.set_version(package.version.to_string());
		partial.extra.insert("edition".to_owned(), Expr::str(package.edition.to_owned()));

		// note: package.dependencies is the spec, we can't tie it back to concrete pacakges.
		// we need to use the actual resolved deps for this package
		let mut build_deps = Vec::new();
		for dep in &node.deps {
			let key = || Key::from(&dep.pkg.repr);
			for dep_kind in &dep.dep_kinds {
				if let Some(platform_filter) = &dep_kind.target {
					if !platform_filter.matches(platform.platform.target_triple, &platform.cfgs) {
						debug!("Ignoring dependency for target platform {:?} (current: {:?})", platform_filter, platform);
						continue
					}
				}
				match dep_kind.kind {
					DependencyKind::Normal => partial.add_dep(key()),
					DependencyKind::Build => build_deps.push(key()),
					DependencyKind::Unknown => partial.add_dep(key()),
					DependencyKind::Development => (),
				}
			}
		}

		let base_path = package.manifest_path.parent().ok_or_else(||anyhow!("empy path"))?;
		let mut proc_macro = false;
		let mut build_target = None;
		for target in &package.targets {
			// TODO how do we know what people actually depend on?
			// All of them?
			if target.kind.iter().any(|k| k == "lib") {
				// TODO is there a better way to get the base dir, or src_path relative to it?
				let src_rel = Self::relative_to(base_path, &target.src_path)?;
				if src_rel != "src/lib.rs" {
					partial.extra.insert("libPath".to_owned(), Expr::str(src_rel.to_string()));
				}
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
		if !build_deps.is_empty() {
			partial.extra.insert("buildDepKeys".to_owned(),
				Expr::List(build_deps.into_iter().map(|k|
					Expr::str(k.into_string())
				).collect())
			);
		}
		if let Some(build_target) = build_target {
			partial.extra.insert("buildSrc".to_owned(), Expr::str(Self::relative_to(base_path, &build_target.src_path)?.to_owned()));
		}
		if proc_macro {
			partial.extra.insert("procMacro".to_owned(), Expr::Bool(true));
		}

		let spec = partial.build()?;
		Ok((key, spec))
	}
	
	fn current_platform() -> Result<Platform> {
		let platform = platform::Platform::guess_current().ok_or_else(||anyhow!("Unknown platform"))?;
		let output = Command::new(env::var("RUSTC").as_ref().map(|s| &**s).unwrap_or("rustc"))
			.arg("--target")
			.arg(platform.target_triple)
			.args(&["--print", "cfg"])
			.output()?;

		if !output.status.success() {
			return Err(anyhow!("`rustc --print cfg` failed: {}", String::from_utf8(output.stderr)?));
		}

		let cfg_str = String::from_utf8(output.stdout)?;
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
		
		let platform = Self::current_platform()?;
		for package in meta.packages {
			let (key, spec) = Self::package_spec(&package, &nodes, &platform)
				.with_context(||format!("Processing package {:?}", &package))?;
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
