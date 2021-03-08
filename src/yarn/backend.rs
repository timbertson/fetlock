// yarn.lock backend
use crate::err::*;
use crate::nix_serialize::{WriteContext, Writeable};
use crate::string_util::*;
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use log::*;
use serde::de::*;
use serde::Deserialize;
use std::borrow::Cow;
use std::borrow::{Borrow, BorrowMut};
use std::collections::{BTreeMap, HashMap, HashSet};
use std::fmt;
use std::io::Write;

#[derive(Clone, Debug)]
pub struct YarnLock {
	lockfile: YarnLockFile,
	opts: CliOpts,
}

#[async_trait(?Send)]
impl Backend for YarnLock {
	type Spec = YarnSpec;

	fn load(opts: CliOpts) -> Result<Self> {
		let context = LockContext::new(lock::Type::Yarn);
		let contents = std::fs::read_to_string(&opts.lock_path)?;
		let mut lockfile: YarnLockFile = serde_yaml::from_str(&contents)?;
		lockfile.fixup_keys()?;
		Ok(YarnLock { lockfile, opts })
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lockfile.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.lockfile.0)
	}
}

#[derive(Debug, Clone)]
pub struct YarnSpec {
	resolution: DepResolution,
	spec: Spec,
	find_keys: Vec<DepResolution>,
	optional_deps: HashSet<Key>,
}

impl YarnSpec {
	fn fetch_src(&mut self) -> Result<()> {
		// TODO:
		// https://registry.npmjs.org/
		// https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md#getpackageversion
		// dist: an object containing a shasum and tarball url, usually in the form of https://registry.npmjs.org/<name>/-/<name>-<version>.tgz
		Err(anyhow!("TODO..."))
	}
}

// TODO get rid of this boilerplate?
impl Borrow<Spec> for YarnSpec {
	fn borrow(&self) -> &Spec {
		&self.spec
	}
}

impl BorrowMut<Spec> for YarnSpec {
	fn borrow_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}

impl Writeable for YarnSpec {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> std::io::Result<()> {
		self.spec.write_to(c)
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
						.map(|s| DepResolution::parse(s))
						.collect::<Result<Vec<DepResolution>>>();
					let mut spec = map.next_value::<YarnSpec>()?;
					spec.find_keys = into_serde(find_keys)?;
					// the first element in the map is the toplevel package
					if ret.0.context.toplevel.is_empty() {
						ret.0.context.toplevel.push(spec.resolution.key.clone());
					}
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
				.and_then(|res| DepResolution::parse(&res)),
		)?;
		spec.id.set_name(resolution.name.clone());

		let mut optional_deps = HashSet::new();
		for (k, v) in dependencies.unwrap_or_default().iter() {
			let key = Key::new(format!("{}@{}", k, v));
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

#[derive(Debug, Clone)]
struct DepResolution {
	name: String,
	key: Key,
	registry: String,
}

impl DepResolution {
	fn parse(s: &str) -> Result<DepResolution> {
		let (name, rest) = split_name(s)?;
		let (registry, version) =
			split_one_or_else(":", rest, || anyhow!("invalid spec: {:?}", s))?;
		Ok(DepResolution {
			name: name.to_owned(),
			key: Key::new(format!("{}@{}", name, version)),
			registry: registry.to_owned(),
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
	Ok(s.split_at(at_idx))
}
