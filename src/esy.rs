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
  let contents = std::fs::read_to_string(path)?;
  let lock: EsyLock = serde_json::from_str(&contents)?;
  Ok(lock.0)
}

struct EsyLock(Lock);
struct EsyVisitor;

impl<'de> Deserialize<'de> for EsyLock {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsyVisitor)
	}
}

impl<'de> Visitor<'de> for EsyVisitor {
	type Value = EsyLock;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy.lock")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
		where A: MapAccess<'de> {
    let mut lock = Lock::new(LockContext::new(lock::Type::Esy));
		while let Some(key) = map.next_key::<&str>()? {
			match key {
        "root" => {
          lock.context.add_toplevel(map.next_value::<Key>()?);
        }
        "node" => {
          lock.implementations = map
            .next_value::<HashMap<Key,EsyImpl>>()?
            .into_iter()
            .map(|(k,v)| (k,v.0))
            .collect();
        }
        _ => { map.next_value::<IgnoredAny>()?; },
      }
		}
		Ok(EsyLock(lock))
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
        "source" => partial.set_src(map.next_value::<EsySrc>()?.0),
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

struct EsySrc(Src);

impl<'de> Deserialize<'de> for EsySrc {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsySrcVisitor)
	}
}

struct EsySrcVisitor;

impl EsySrcVisitor {
  fn parse(spec: &str) -> Result<Src> {
    let mut it = spec.splitn(2, ":");
    let typ = it.next().ok_or_else(||anyhow!("type missing"))?;
    let src = it.next().ok_or_else(||anyhow!("invalid spec"))?;
    match typ {
      "github" => {
        let mut it = src.splitn(2, "#");
        let owner_repo = it.next().unwrap().to_owned();
        let git_ref = it.next().ok_or_else(||anyhow!("ref missing"))?.to_owned();

        let mut it = owner_repo.splitn(2, "/");
        let owner = it.next().unwrap().to_owned();
        let repo = it.next().ok_or_else(||anyhow!("repo missing"))?.to_owned();
        Ok(Src::Github(Github { owner, repo, git_ref }))
      },
      "archive" => {
        let mut it = src.splitn(2, "#");
        let url = it.next().unwrap().to_owned();
        // TODO handle (optional?) digest after hash
        Ok(Src::Archive(Url::new(url)))
      },
      "no-source" => Ok(Src::None),
      other => Err(anyhow!("Unknown archive type: {}", other)),
    }
  }

  fn extract(sources: Vec<String>) -> Result<Src> {
    match sources.first() {
      Some(source) => {
        if sources.len() > 1 {
          debug!("using only first source of array: {:?}", sources);
        }
        Self::parse(source)
      },
      None => Err(anyhow!("Empty source array")),
    }
  }
}

enum SrcType {
  Install,
  LinkDev,
  Unknown(String),
}

impl<'de> Visitor<'de> for EsySrcVisitor {
	type Value = EsySrc;
	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy source")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
		where A: MapAccess<'de> {
		let mut src = None;
		let mut typ = None;
		while let Some(key) = map.next_key::<&str>()? {
		  match key {
        // source.source is an array of archives.
        // Multiple archives appear to be for redundancy, so we just take the first
        // (and warn until I confirm this behaviour is correct)
        "source" => {
          let archives = map.next_value::<Vec<String>>()?;
          src = Some(err::into_serde(Self::extract(archives))?);
        },
        "type" => {
          typ = Some(match map.next_value::<&str>()? {
            "install" => SrcType::Install,
            "link-dev" => SrcType::LinkDev,
            other => SrcType::Unknown(other.to_owned()),
          })
        },
        _ => { map.next_value::<IgnoredAny>()?; },
      }
    }
    err::into_serde(match typ {
      Some(SrcType::Install) => src.ok_or_else(||anyhow!("Missing `source.source`")),
      Some(SrcType::LinkDev) => Ok(Src::None),
      Some(SrcType::Unknown(u)) => Err(anyhow!("Unknown source type: {}", u)),
      None => Err(anyhow!("Missing `source.type`")),
    }).map(EsySrc)
  }
}
