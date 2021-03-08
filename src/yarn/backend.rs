// yarn.lock backend
use crate::err::*;
use crate::nix_serialize::{WriteContext, Writeable};
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use serde::de::*;
use serde::Deserialize;
use std::borrow::{Borrow, BorrowMut};
use std::collections::{BTreeMap, HashMap};
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
		let mut lockfile: YarnLockFile = serde_json::from_str(&contents)?;
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
	resolution: Key,
	spec: Spec,
	find_keys: Vec<Key>,
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
		for (k, v) in self.0.specs.iter() {
			for secondary_key in v.find_keys.iter() {
				resolutions.insert(secondary_key.clone(), k.clone());
			}
		}

		// then replace all dependency_keys with their resolved versions
		for (k, v) in self.0.specs.iter_mut() {
			for dep_key in v.spec.dep_keys.iter_mut() {
				let resolved = resolutions
					.get(dep_key)
					.ok_or_else(|| anyhow!("canonical key not found for {:?}", dep_key))?;
				*dep_key = resolved.clone();
			}
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
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"__metadata" => {
					map.next_value::<IgnoredAny>()?;
				}
				key => {
					let find_keys = key
						.split(", ")
						.into_iter()
						.map(|s| Key::new(s.to_owned()))
						.collect();
					let mut spec = map.next_value::<YarnSpec>()?;
					spec.find_keys = find_keys;
					ret.0.add_impl(spec.resolution.clone(), spec);
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
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"version" => {
					spec.id.set_version(map.next_value::<String>()?);
				}
				"resolution" => {
					resolution = Some(map.next_value::<Key>()?);
				}
				"dependencies" => {
					let map = map.next_value::<BTreeMap<String, String>>()?;
					for (k, v) in map {
						spec.add_dep(Key::new(format!("{}@{}", k, v)));
					}
				}
				// TODO support checksum
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}
		Ok(YarnSpec {
			resolution: into_serde(resolution.ok_or_else(|| anyhow!("resolution not found")))?,
			spec: into_serde(spec.build())?,
			find_keys: vec![], // TODO this'll be overridden anyway, it's a bit pointless
		})
	}
}
