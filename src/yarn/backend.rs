// yarn.lock backend
use crate::err::*;
use crate::fetch::ExtractSource;
use crate::stream_util::*;
use crate::string_util::*;
use crate::*;
use tokio::process::Command;
use anyhow::*;
use async_trait::async_trait;
use log::*;
use serde::de;
use serde::de::*;
use serde::Deserialize;
use std::borrow::Cow;
use std::collections::{BTreeMap, HashMap, HashSet, BTreeSet};
use std::fmt;
use std::path::PathBuf;

#[derive(Clone, Debug)]
pub struct YarnLock {
	lockfile: YarnLockFile,
}

#[async_trait(?Send)]
impl Backend for YarnLock {
	type Spec = YarnSpec;

	fn virtual_root(spec: &mut PartialSpec) {
		spec.extra
			.insert("pkgname".to_owned(), Expr::str("virtual-root".to_owned()));
	}

	async fn load(src: &LockSrc, opts: &WriteOpts) -> Result<Self> {
		let lock_path = src.path();

		let mut package_json_path = lock_path.clone();
		package_json_path.set_file_name("package.json");
		let json_contents = fs_util::read_to_string(package_json_path)?;
		let package_json: PackageJSON = serde_json::from_str(&json_contents)?;

		let yaml_contents = fs_util::read_to_string(lock_path)?;
		let mut lockfile: YarnLockFile = serde_yaml::from_str(&yaml_contents)?;
		lockfile.fixup_keys()?;

		let root_key = lockfile.0.specs.iter().find_map(|(key, yarn_spec)|
			if yarn_spec.spec.id.name == package_json.name {
				Some(key)
			} else {
				None
			}
		).ok_or_else(|| anyhow!("Can't find lock entry for root package: {}", &package_json.name))?
		.to_owned();

		lockfile.mark_cyclic_dependencies(&root_key);

		let root_spec = lockfile.0.specs.get_mut(&root_key).unwrap();

		lockfile.0.context.root = Root::Package(root_key.clone());

		lockfile.populate_sources().await?;

		let mut sources = fetch::realise_fetch_sources(lockfile.0.specs.iter().map(|(k,v)| (k, &v.spec))).await?;
		sources.insert(root_key, src.root().to_owned());
		for (key, path) in sources {
			let spec = lockfile.0.specs.get_mut(&key).ok_or_else(||
				anyhow!("extracted source is not in specs: {:?}", key)
			)?;

			for err in spec.load_manifest(path).await.err().iter() {
				warn!("Failed to lock package.json from {}: {:?}", key, err)
			}
		}
		
		Ok(YarnLock { lockfile })
	}
	
	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lockfile.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.lockfile.0)
	}

	async fn update_lockfile<'a>(root: &'a PathBuf, rel: &'a str) -> Result<()> {
		cmd::exec(Command::new("yarn")
			.arg("install")
			.arg("--mode")
			.arg("update-lockfile")
			.current_dir(root)
		).await
	}
}

#[derive(Debug, Clone, Deserialize)]
struct PackageDist {
	tarball: String,
	shasum: Option<String>, // sha1
	integrity: Option<String>, // SRI hash
}

#[derive(Debug, Clone, Deserialize)]
struct PackageListing {
	dist: PackageDist,
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct PackageJSON {
	name: String,

	#[serde(default)]
	#[serde(deserialize_with = "deserialize_bin")]
	bin: BTreeMap<String, String>,
}

// bin can be "foo" which is a shorthand for { "foo": "foo" }
fn deserialize_bin<'de, D>(de: D) -> Result<BTreeMap<String, String>, D::Error> where D: Deserializer<'de> {
	struct BinVisitor;
	impl<'de> Visitor<'de> for BinVisitor {
			type Value = BTreeMap<String, String>;

			fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
				formatter.write_str("string or map[String, String]")
			}

			fn visit_str<E>(self, value: &str) -> Result<Self::Value, E>
			where E: de::Error,
			{
				let mut bin = BTreeMap::new();
				bin.insert(value.to_owned(), value.to_owned());
				Ok(bin)
			}

			fn visit_map<A>(self, mut map: A) -> Result<Self::Value, A::Error>
			where
				A: MapAccess<'de>,
			{
				let mut bin = BTreeMap::new();
				while let Some((key, value)) = map.next_entry::<Cow<'de, str>, Cow<'de, str>>()? {
					bin.insert(key.to_string(), value.to_string());
				}
				Ok(bin)
			}
	}
	de.deserialize_any(BinVisitor)
}

#[derive(Debug, Clone)]
pub struct YarnSpec {
	resolution: DepResolution,
	spec: Spec,
	find_keys: Vec<DepResolution>,
	optional_deps: HashSet<Key>,
}

impl YarnSpec {
	async fn populate_src(&mut self) -> Result<()> {
		let desc = format!("populating src for {:?}", &self.spec.id);
		let result: Result<()> = (|| async move {
			// https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md#getpackageversion
			let root = match self.resolution.registry.as_deref() {
				Some("npm") => "https://registry.npmjs.org/",
				None => {
					return Ok(());
				}
				Some(other) => {
					// TODO known repos:
					// - workspace (local files)
					// - patch (???)
					warn!(
						"Unsupported repo: {} (in package {:?})",
						other, self.spec.id
					);
					return Ok(());
				}
			};

			let url = format!("{}/{}/{}",
				root,
				url_util::encode(&self.spec.id.name),
				url_util::encode(&self.spec.id.version)
			);
			let body = http_client::get(&url)
				.await
				.with_context(|| format!("GET {}", &url))?
				.error_for_status()?
				.text()
				.await?;
			let listing: PackageListing = serde_json::from_str(&body)?;
			debug!("package listing for {:?}: {:?}", self.spec.id, listing);
			let digest = match &listing.dist.integrity {
				Some(sri) => Some(NixHash::parse_sri(sri)?),
				None => match &listing.dist.shasum {
					Some(sha1) => Some(NixHash::from_hex(HashAlg::Sha1, sha1)?),
					None => None,
				}
			};

			self.spec.src = AnySrc::fetch(FetchSpec::Archive(Archive::new(listing.dist.tarball)), digest);
			Ok(())
		})()
		.await;
		result.with_context(|| desc)
	}

	async fn load_manifest(&mut self, path: PathBuf) -> Result<()> {
		let extract = ExtractSource::from(&path).await?;
		let json_contents = extract.file_contents("package.json").await?;
		let package_json: PackageJSON = serde_json::from_str(&json_contents)?;
		if !package_json.bin.is_empty() {
			self.spec.extra.insert(
				"bin".to_owned(),
				Expr::AttrSet(
					package_json.bin
						.into_iter()
						.map(|(k,v)| (k, Expr::str(v)))
						.collect()
				)
			);
		}
		Ok(())
	}
	
	fn populate_cyclic_depkeys(&mut self, my_key: &Key, cycles: &HashSet<BTreeSet<Key>>) {
		// populate the cyclicDepKeys based on the union of all cycles this
		// package is present in, while also dropping any element of any cycle
		// from `dep_keys`
		let mut my_cyclic_deps = BTreeSet::new();
		
		for cycle in cycles.iter() {
			if cycle.contains(my_key) {
				// add all keys in this cycle that I'm in
				my_cyclic_deps.extend(cycle.iter().map(|k| k.to_owned()));

				for cycle_key in cycle.iter() {
					// drop all cycle participants from each other's dep_keys
					if let Some(idx) = self.spec.dep_keys.iter().position(|key| key == cycle_key) {
						self.spec.dep_keys.remove(idx);
					}
				}
			}
		}

		if !my_cyclic_deps.is_empty() {
			debug!("Package {:?} has cyclic deps: {:?}", &self.spec.id, &my_cyclic_deps);
			let exprs = my_cyclic_deps.into_iter().map(|k| Expr::str(k.into_string())).collect();
			self.spec.extra.insert("cyclicDepKeys".to_owned(), Expr::List(exprs));
		}
	}
}

impl AsSpec for YarnSpec {
	fn wrap(spec: Spec) -> Self {
		let name = spec.id.name.clone();
		YarnSpec {
			spec,
			resolution: DepResolution {
				name: name.clone(),
				key: Key::new(name),
				registry: None,
			},
			find_keys: Vec::new(),
			optional_deps: HashSet::new(),
		}
	}
	fn as_spec_ref(&self) -> &Spec {
		&self.spec
	}
	fn as_spec_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}

#[derive(Clone, Debug)]
pub struct YarnLockFile(Lock<YarnSpec>);

impl YarnLockFile {
	fn fixup_keys(&mut self) -> Result<()> {
		// Yarn lockfile's dependencies are keyed indirectly.
		// We key implementations by their actual resolution,
		// but yarn dependency maps still use _constraints_ as keys.

		// first, build a map with `find_key -> canonical_key`
		let mut resolutions = HashMap::new();
		let mut fallbacks = HashMap::new();
		for (k, v) in self.0.specs.iter() {
			for find_key in v.find_keys.iter() {
				resolutions.insert(find_key.key.clone(), k.clone());
			}
			fallbacks.insert(v.spec.id.name.clone(), k.clone());
		}
		debug!("resolutions: {:?}", resolutions);

		// then replace all dependency_keys with their resolved versions
		for (k, v) in self.0.specs.iter_mut() {
			v.spec.dep_keys = v
				.spec
				.dep_keys
				.iter()
				.filter_map(|dep| {
					let resolved = resolutions.get(dep);
					if let Some(resolved) = resolved {
						Some(Ok(resolved.clone()))
					} else {
						if v.optional_deps.contains(dep) {
							None
						} else {
							if log_enabled!(Level::Debug) {
								let mut all_keys: Vec<(&Key, &Key)> = resolutions.iter().collect();
								all_keys.sort();
								for (key, value) in all_keys {
									debug!("resolution: {} -> {}", key, value)
								}
							}
							// TODO why does yarn even write lockfiles with missing deps?
							Some(
								name_of_key(dep)
									.and_then(|name| {
										fallbacks
											.get(&name)
											.map(|key| {
												debug!(
													"Replacing unresolved {:?} with {:?} (dependency of {})",
													dep, key, &v.spec.id.name
												);
												key.clone()
											})
											.ok_or_else(|| {
												anyhow!("canonical key not found for {:?}", dep)
											})
									})
									.with_context(|| {
										format!("canonicalizing dependencies for {:?}", v.spec.id)
									}),
							)
						}
					}
				})
				.collect::<Result<Vec<Key>>>()?;
		}
		Ok(())
	}

	async fn populate_sources(&mut self) -> Result<()> {
		info!(
			"resolving {} package sources from online repository...",
			self.0.specs.len()
		);
		let stream = futures::stream::iter(self.0.specs.values_mut());
		foreach_unordered(10, stream, |spec| spec.populate_src()).await
	}

	fn mark_cyclic_dependencies(&mut self, root: &Key) {
		let mut stack = Vec::new();
		let mut cycles = HashSet::new();
		self.visit_cyclic_dependencies(&mut stack, &mut cycles, root);
		for cycle in cycles.iter() {
			debug!("Cycle: {:?}", cycle);
		}
		for (key, spec) in self.0.specs.iter_mut() {
			spec.populate_cyclic_depkeys(&key, &cycles);
		}
	}

	fn visit_cyclic_dependencies(&mut self, stack: &mut Vec<Key>, cycles: &mut HashSet<BTreeSet<Key>>, key: &Key) {
		// Yarn allows a -> b -> c -> a.
		// We can't represent this as nix `buildInputs` due to infinite recursion.
		// So we find cycles, and for each derivation present in the cycle we add a
		// passthru property `cyclicDepKeys`. We don't include these in `depKeys`.
		//
		// When installing dependencies into node_modules, if a direct dependency has
		// this property we copy it instead of symlinking, _and_ we copy all the other
		// cyclicDepKeys even if they're not direct dependencies.
		//
		// The result is that everything is symlinked, except when depending on a, b or c
		// also contains a (shallow) copy of node_modules/{a,b,c}

		if let Some(yarn_spec) = self.0.specs.get_mut(key) {
			// first, collect cycles that are triggered by a direct dependency
			for dep_key in yarn_spec.spec.dep_keys.iter() {
				if let Some(idx) = stack.iter().position(|key| key == dep_key) {
					let cycle_keys: BTreeSet<Key> = stack[idx..].to_owned().into_iter().collect();
					debug!("cycle found in dependency {}: {:?}", &key, &cycle_keys);
					cycles.insert(cycle_keys);
				}
			}
			
			// clone to release the borrow of yarn_spec (behind &self)
			let recurse_into_deps = yarn_spec.spec.dep_keys.clone();

			for dep_key in recurse_into_deps.into_iter() {
				// skip if dep is present in any cycle
				if !cycles.iter().any(|cycle_keys| cycle_keys.contains(&dep_key)) {
					stack.push(dep_key.clone());
					self.visit_cyclic_dependencies(stack, cycles, &dep_key);
					stack.pop();
				}
			}
		}
	}
}

impl<'de> Deserialize<'de> for YarnLockFile {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		deserializer.deserialize_any(YarnVisitor)
	}
}

struct YarnVisitor;

impl<'de> Visitor<'de> for YarnVisitor {
	type Value = YarnLockFile;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("yarn lock")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
	where
		A: MapAccess<'de>,
	{
		let mut ret = YarnLockFile(Lock::new(LockContext::new(lock::Type::Yarn)));
		while let Some(key) = map.next_key::<Cow<'de, str>>()? {
			match key.as_ref() {
				"__metadata" => {
					map.next_value::<IgnoredAny>()?;
				}
				key => {
					let find_keys = key
						.split(", ")
						.into_iter()
						.map(|s| DepResolution::parse(s).with_context(|| "toplevel yarn key"))
						.collect::<Result<Vec<DepResolution>>>();
					let mut spec = map.next_value::<YarnSpec>()?;
					spec.find_keys = into_serde(find_keys)?;
					ret.0.add_impl(spec.resolution.key.clone(), spec);
				}
			}
		}
		Ok(ret)
	}
}

struct YarnSpecVisitor;

impl<'de> Deserialize<'de> for YarnSpec {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		deserializer.deserialize_any(YarnSpecVisitor)
	}
}

impl<'de> Visitor<'de> for YarnSpecVisitor {
	type Value = YarnSpec;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("yarn spec")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
	where
		A: MapAccess<'de>,
	{
		let mut spec = PartialSpec::empty();
		let mut resolution = None;
		let mut dependencies = None;
		let mut dependencies_meta = BTreeMap::new();
		while let Some(key) = map.next_key::<Cow<'de, str>>()? {
			match key.as_ref() {
				"version" => {
					spec.id.set_version(map.next_value::<String>()?);
				}
				"resolution" => {
					resolution = Some(map.next_value::<String>()?);
				}
				"dependencies" => {
					dependencies = Some(map.next_value::<BTreeMap<String, String>>()?);
				}
				"dependenciesMeta" => {
					dependencies_meta = map.next_value::<BTreeMap<String, YarnDependencyMeta>>()?;
				}
				// TODO support checksum
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}

		let resolution = into_serde(
			resolution
				.ok_or_else(|| anyhow!("resolution not found"))
				.and_then(|res| DepResolution::parse(&res).with_context(|| "resolution field")),
		)?;
		spec.id.set_name(resolution.name.clone());
		spec.extra
			.insert("pkgname".to_owned(), Expr::str(resolution.name.clone()));

		let mut optional_deps = HashSet::new();
		for (k, v) in dependencies.unwrap_or_default().iter() {
			// resolution may be either a straight name or (more unusually)
			// a renamed dep. ie. `my-lodash-alias: npm:lodash^1.2.3`
			let resolution = DepResolution::parse_dependency_spec(&k, &v);
			let key = resolution.key;
			if dependencies_meta.get(k).and_then(|m| m.optional) == Some(true) {
				optional_deps.insert(key.clone());
			}
			spec.add_dep(key);
		}

		spec.set_src(Src::None); // will be populated later
		Ok(YarnSpec {
			resolution,
			spec: into_serde(spec.build())?,
			find_keys: vec![], // TODO this'll be overridden anyway, it's a bit pointless
			optional_deps,
		})
	}
}

#[derive(Debug, Clone, PartialEq, Eq)]
struct DepResolution {
	name: String,
	key: Key,
	registry: Option<String>,
}

impl DepResolution {
	fn parse(s: &str) -> Result<DepResolution> {
		let result: Result<DepResolution> = (|| {
			let (name, rest) = split_name(s)?;
			let (registry, version) = Self::split_registry(rest);
			Ok(DepResolution {
				name: name.to_owned(),
				key: Key::new(format!("{}@{}", &name, version)),
				registry: registry.map(|x| x.to_owned()),
			})
		})();
		result.with_context(|| format!("Parsing {}", s))
	}

	fn parse_dependency_spec(name: &str, version_spec: &str) -> DepResolution {
		// dependency specs are either version spec like `npm:^1.2.3`
		// or they can be renames, e.g:
		// string-width-cjs: "npm:string-width@^4.2.0"
		
		let (registry, version_spec) = Self::split_registry(version_spec);

		// use the name from version_spec if present
		let (name, version_spec) = split_name(version_spec).unwrap_or((name, version_spec));

		// Note in the case of renames all we currently do is
		// to use the real dep key, ignoring the rename.
		
		// The right approach would eventually let `depKeys` specify
		// the package name under which the dependency
		// should be installed, rather than taking it from the package.
		Self::from_name_version_registry(name, version_spec, registry)
	}

	fn from_name_version_registry(name: &str, version: &str, registry: Option<&str>) -> Self {
		DepResolution {
			name: name.to_owned(),
			key: Key::from_kv(name, version),
			registry: registry.map(|x| x.to_owned()),
		}
	}
	
	fn split_registry(s: &str) -> (Option<&str>, &str) {
		// s.split_once(':').map(|(a,b)| (Some(a), b)).unwrap_or((None, s))
		match split_one(":", s) {
			(registry, Some(rest)) => (Some(registry), rest),
			(rest, None) => (None, rest),
		}
	}
	
}

#[derive(Debug, Clone, Deserialize)]
struct YarnDependencyMeta {
	optional: Option<bool>,
}

fn name_of_key(key: &Key) -> Result<String> {
	let (name, _) = split_name(key.as_str())?;
	Ok(name.to_owned())
}

fn split_name(s: &str) -> Result<(&str, &str)> {
	let at_idx = if let Some(remainder) = s.strip_prefix("@") {
		remainder
			.find('@')
			.ok_or_else(|| anyhow!("invalid spec: {:?}", s))?
			+ 1
	} else {
		s.find('@')
			.ok_or_else(|| anyhow!("invalid spec: {:?}", s))?
	};
	let (name, remainder) = s.split_at(at_idx);
	let remainder = remainder
		.strip_prefix("@")
		.ok_or_else(|| anyhow!("remainder doesn't start with `@`"))?;
	Ok((name, remainder))
}

#[cfg(test)]
mod tests {
	use super::*;
	#[test]
	fn test_resolution() {
		assert_eq!(
			DepResolution::parse("foo@npm:1.2.3").unwrap(),
			DepResolution {
				name: "foo".to_owned(),
				key: Key::new("foo@1.2.3".to_owned()),
				registry: Some("npm".to_owned()),
			}
		);

		assert_eq!(
			DepResolution::parse("@org/pkg@npm:1.2.3").unwrap(),
			DepResolution {
				name: "@org/pkg".to_owned(),
				key: Key::new("@org/pkg@1.2.3".to_owned()),
				registry: Some("npm".to_owned()),
			}
		);

		assert_eq!(
			DepResolution::parse("foo@^1.2.3").unwrap(),
			DepResolution {
				name: "foo".to_owned(),
				key: Key::new("foo@^1.2.3".to_owned()),
				registry: None,
			}
		);
	}
}
