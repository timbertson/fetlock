// yarn.lock backend
use crate::err::*;
use crate::stream_util::*;
use crate::string_util::*;
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use log::*;
use serde::de;
use serde::de::*;
use serde::Deserialize;
use std::borrow::Cow;
use std::collections::{BTreeMap, HashMap, HashSet};
use std::fmt;
use std::fs;
use std::path::PathBuf;

#[derive(Clone, Debug)]
pub struct YarnLock {
	lockfile: YarnLockFile,
	opts: CliOpts,
}

#[async_trait(?Send)]
impl Backend for YarnLock {
	type Spec = YarnSpec;

	fn virtual_root(spec: &mut PartialSpec) {
		spec.extra
			.insert("pkgname".to_owned(), Expr::str("virtual-root".to_owned()));
	}

	async fn load(src: &LocalSrc, opts: CliOpts) -> Result<Self> {
		let lock_path = src.lock_path();

		let mut package_json_path = lock_path.clone();
		package_json_path.set_file_name("package.json");
		let json_contents = fs::read_to_string(package_json_path)?;
		let package_json: PackageJSON = serde_json::from_str(&json_contents)?;

		let yaml_contents = fs::read_to_string(lock_path)?;
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

		let mut cyclic_deps = HashSet::new();
		lockfile.mark_cyclic_dependencies(&root_key, &mut cyclic_deps);
		let mut cyclic_deps_sorted: Vec<Key> = cyclic_deps.into_iter().collect();
		cyclic_deps_sorted.sort_unstable();

		let root_spec = lockfile.0.specs.get_mut(&root_key).unwrap();
		root_spec.spec.extra.insert(
			"nodePathDeps".to_owned(),
			Expr::List(cyclic_deps_sorted.into_iter().map(|k| Expr::str(k.to_string())).collect())
		);

		lockfile.0.context.root = Root::Package(root_key.clone());

		lockfile.populate_sources().await?;

		let mut sources = fetch::realise_sources(lockfile.0.specs.iter().map(|(k,v)| (k, &v.spec))).await?;
		sources.insert(root_key, src.root.clone());
		for (key, path) in sources {
			let spec = lockfile.0.specs.get_mut(&key).ok_or_else(||
				anyhow!("extracted source is not in specs: {:?}", key)
			)?;

			for err in spec.load_manifest(path).err().iter() {
				warn!("Failed to lock package.json from {}: {:?}", key, err)
			}
		}
		
		Ok(YarnLock { lockfile, opts })
	}
	
	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lockfile.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.lockfile.0)
	}
}

#[derive(Debug, Clone, Deserialize)]
struct PackageDist {
	tarball: String,
	// todo shaSum
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

			// TODO escaping with `url`?
			let url = format!("{}/{}/{}", root, self.spec.id.name, self.spec.id.version);
			let body = reqwest::get(&url)
				.await
				.with_context(|| format!("GET {}", &url))?
				.text()
				.await?;
			let listing: PackageListing = serde_json::from_str(&body)?;
			debug!("package listing for {:?}: {:?}", self.spec.id, listing);
			self.spec.src = Src::Archive(Archive::new(listing.dist.tarball));
			Ok(())
		})()
		.await;
		result.with_context(|| desc)
	}

	fn load_manifest(&mut self, extract: PathBuf) -> Result<()> {
		let json_path = extract.join("package.json");
		let json_contents = fs::read_to_string(&json_path)?;
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
		// We key implementations by their its actual resolution,
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
							// TODO why does yarn even write lockfiles with missing deps?
							Some(
								name_of_key(dep)
									.and_then(|name| {
										fallbacks
											.get(&name)
											.map(|key| {
												warn!(
													"{:?}: fallback to {:?} (for {})",
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

	fn mark_cyclic_dependencies(&mut self, root: &Key, cyclic_deps: &mut HashSet<Key>) {
		let mut seen = Vec::new();
		self.visit_cyclic_dependencies(&mut seen, cyclic_deps, root)
	}

	fn visit_cyclic_dependencies(&mut self, seen: &mut Vec<Key>, cyclic_deps: &mut HashSet<Key>, key: &Key) {
		// Yarn allows a -> b -> c -> a.
		// We can't represent this as nix `buildInputs` due to infinite recursion.
		// So we cut each at the first circular dependency we find (i.e. c -> a).
		// In order for c to be able to require(a), we add each dropped
		// dependency to the toplevel NODE_PATH (by using wrapProgram on everything
		// in bin/ of the root package).
		// This makes `a` globally available as a fallback, since NODE_PATH is
		// searched after checking node_modules.
		// Fingers crossed we never need two different versions of `a`.

		if let Some(yarn_spec) = self.0.specs.get_mut(key) {
			// First, drop cyclic deps (registering them at the toplevel)
			yarn_spec.spec.dep_keys.retain(|dep_key| {
				if seen.contains(dep_key) {
					cyclic_deps.insert(dep_key.to_owned());
					false
				} else {
					true
				}
			});

			let recurse_deps = yarn_spec.spec.dep_keys.clone();
			drop(yarn_spec);

			// In a second pass, recurse into dependencies. This must be done after
			// dropping `yarn_spec` because that's behind our mutable self reference
			for dep_key in recurse_deps.into_iter() {
				seen.push(dep_key.clone());
				self.visit_cyclic_dependencies(seen, cyclic_deps, &dep_key);
				seen.pop();
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

					// TODO: populate root from package.json
					// Or, look for the impl @`workspace:.`
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
			let key = Key::from_kv(k, v);
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
		let (name, rest) = split_name(s)?;
		let (registry, version) = match split_one(":", rest) {
			(registry, Some(version)) => (Some(registry), version),
			(version, None) => (None, version),
		};
		Ok(DepResolution {
			name: name.to_owned(),
			key: Key::new(format!("{}@{}", name, version)),
			registry: registry.map(|x| x.to_owned()),
		})
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
				registry: "npm".to_owned(),
			}
		);

		assert_eq!(
			DepResolution::parse("@org/pkg@npm:1.2.3").unwrap(),
			DepResolution {
				name: "@org/pkg".to_owned(),
				key: Key::new("@org/pkg@1.2.3".to_owned()),
				registry: "npm".to_owned(),
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
