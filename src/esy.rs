// esy.lock backend

use std::fmt;
use std::collections::HashMap;
use anyhow::{Result, anyhow};
use serde::de::*;
use log::*;
use crate::*;

pub fn load(path: &str) -> Result<Lock> {
	let context = LockContext::new(lock::Type::Esy);
  info!("loading {}", path);
	let lock = Lock::new(context);
	Ok(lock)
}

struct EsyVisitor<'a> {
	lock: &'a mut Lock,
}

impl<'de: 'c, 'c> DeserializeSeed<'de> for EsyVisitor<'c> {
	type Value = Lock;

	fn deserialize<D>(self, deserializer: D) -> Result<Self::Value, D::Error>
	where D: Deserializer<'de>,
	{
		deserializer.deserialize_any(self)
	}
}

impl<'de: 'c, 'c> Visitor<'de> for EsyVisitor<'c> {
	type Value = Lock;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy.lock")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
		where A: MapAccess<'de> {
		while let Some(key) = map.next_key::<&str>()? {
			match key {
        "node" => {
          let impls = map.next_value::<HashMap<Key,EsyImpl>>()?;
          self.lock.implementations =
            impls.into_iter().map(|(k,v)| (k,v.0)).collect();
        }
        _ => { map.next_value::<IgnoredAny>()?; },
      }
		}
		Ok(self.lock.clone())
	}
}

struct EsyImpl(Impl);
struct EsyImplVisitor;

impl<'de> Deserialize<'de> for EsyImpl {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsyImplVisitor)
	}
}

impl<'de> Visitor<'de> for EsyImplVisitor {
	type Value = EsyImpl;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy package")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
		where A: MapAccess<'de> {
    let mut partial = PartialImpl::empty();
		while let Some(key) = map.next_key::<&str>()? {
			match key {
        "name" => partial.id.set_name(map.next_value::<String>()?),
        "version" => partial.id.set_version(map.next_value::<String>()?),
        "source" => partial.set_src(map.next_value_seed(EsySrc {})?),
        "dependencies" => {
          let keys = map.next_value::<Vec<String>>()?.into_iter().map(Key::new);
          partial.add_deps(&mut keys.collect())
        },
        _ => { map.next_value::<IgnoredAny>()?; },
      }
		}
		err::into_serde(partial.build()).map(EsyImpl)
	}
}

struct EsySrc {
}

impl EsySrc {
  fn parse(spec: &str) -> Result<Src> {
    let mut it = spec.splitn(2, ":");
    let typ = it.next().ok_or_else(||anyhow!("type missing"))?;
    let src = it.next().ok_or_else(||anyhow!("invalid spec"))?;
    match typ {
      "github" => {
        let mut it = src.splitn(2, "#");
        let repo = it.next().unwrap().to_owned();
        let git_ref = it.next().ok_or_else(||anyhow!("ref missing"))?.to_owned();
        Ok(Src::Github(Github { repo, git_ref }))
      },
      "archive" => {
        let mut it = src.splitn(2, "#");
        let url = it.next().unwrap().to_owned();
        // TODO handle (optional?) digest after hash
        Ok(Src::Archive(Url::new(url)))
      },
      other => Err(anyhow!("Unknown archive type: {}", other)),
    }
  }

  fn extract(sources: Vec<String>) -> Result<Src> {
    match sources.first().filter(|_| sources.len() == 1) {
      Some(source) => Self::parse(source),
      None => Err(anyhow!("Expected 1 source archive, got {}", sources.len())),
    }
  }
}

impl<'de> DeserializeSeed<'de> for EsySrc {
	type Value = Src;

	fn deserialize<D>(self, deserializer: D) -> Result<Self::Value, D::Error>
	where D: Deserializer<'de>,
	{
		deserializer.deserialize_any(self)
	}
}

impl<'de> Visitor<'de> for EsySrc {
	type Value = Src;
	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy source")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
		where A: MapAccess<'de> {
		let mut src = None;
		while let Some(key) = map.next_key::<&str>()? {
		  match key {
        // source.source is an array of archives.
        // In practice we only see one element, so this will fail on multiple
        "source" => {
          let archives = map.next_value::<Vec<String>>()?;
          src = Some(err::into_serde(Self::extract(archives))?);
        },
        _ => { map.next_value::<IgnoredAny>()?; },
      }
    }
    err::into_serde(src.ok_or_else(||anyhow!("Missing `src`")))
  }
}