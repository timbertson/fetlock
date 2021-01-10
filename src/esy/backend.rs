// esy.lock backend

use crate::*;
use anyhow::{anyhow, Result};
use log::*;
use serde::de::*;
use std::collections::{HashMap,hash_map};
use std::fmt;

#[derive(Clone, Debug)]
pub struct EsyLock(Lock);
impl Backend for EsyLock {
	fn load(path: &str) -> Result<Self> {
		let context = LockContext::new(lock::Type::Esy);
		info!("loading {}", path);
		let contents = std::fs::read_to_string(path)?;
		let lock: EsyLock = serde_json::from_str(&contents)?;
		Ok(lock)
	}
	
	fn specs_mut(&mut self) -> hash_map::ValuesMut<Key, Impl> {
		self.0.specs.values_mut()
	}
	
	fn finalize(self) -> Lock {
		self.0
	}
}

struct EsyVisitor;

impl<'de> Deserialize<'de> for EsyLock {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
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
	where
		A: MapAccess<'de>,
	{
		let mut lock = Lock::new(LockContext::new(lock::Type::Esy));
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"root" => {
					lock.context.add_toplevel(map.next_value::<Key>()?);
				}
				"node" => {
					lock.specs = map
						.next_value::<HashMap<Key, EsyImpl>>()?
						.into_iter()
						.map(|(k, v)| (k, v.0))
						.collect();
				}
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}
		Ok(EsyLock(lock))
	}
}

pub struct EsyImpl(Impl);
struct EsyImplVisitor;

impl<'de> Deserialize<'de> for EsyImpl {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
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
	where
		A: MapAccess<'de>,
	{
		let mut partial = PartialImpl::empty();
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				// TODO strip @opam/?
				// TODO strip opam: from version
				// TODO populate opamName / opamVersion to enable substs
				"name" => partial.id.set_name(map.next_value::<String>()?),
				"version" => partial.id.set_version(map.next_value::<String>()?),
				"source" => {
					let EsySrc { src, manifest } = map.next_value::<EsySrc>()?;
					partial.set_src(src);
					if let Some(manifest) = manifest {
						partial
							.extra
							.insert("manifest".to_owned(), Expr::Str(manifest));
					}
				}
				"dependencies" => {
					let keys = map.next_value::<Vec<String>>()?.into_iter().map(Key::new);
					partial.add_deps(&mut keys.collect())
				}
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}
		err::into_serde(partial.build()).map(EsyImpl)
	}
}

#[derive(Debug, Clone)]
struct EsySrc {
	src: Src,
	manifest: Option<String>,
}

impl<'de> Deserialize<'de> for EsySrc {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsySrcVisitor)
	}
}

struct EsySrcVisitor;

impl EsySrcVisitor {
	fn split_one<'a>(sep: &'static str, spec: &'a str) -> (&'a str, Option<&'a str>) {
		let mut it = spec.splitn(2, sep);
		let start = it.next().expect("split returned no results");
		let end = it.next();
		(start, end)
	}

	fn parse(spec: &str) -> Result<EsySrc> {
		let (typ, src) = Self::split_one(":", spec);
		let src = src.ok_or_else(|| anyhow!("invalid spec"))?;
		match typ {
			"github" => {
				let (owner_repo_manifest, git_ref) = Self::split_one("#", src);
				let (owner_repo, manifest) = Self::split_one(":", owner_repo_manifest);

				let (owner, repo) = Self::split_one("/", owner_repo);
				let git_ref = git_ref.ok_or_else(|| anyhow!("ref missing"))?.to_owned();
				let owner = owner.to_owned();
				let repo = repo.ok_or_else(|| anyhow!("repo missing"))?.to_owned();
				let manifest = manifest.map(|m| m.to_owned());
				Ok(EsySrc {
					src: Src::Github(Github {
						owner,
						repo,
						git_ref,
					}),
					manifest,
				})
			}
			"archive" => {
				let mut it = src.splitn(2, "#");
				let url = it.next().unwrap().to_owned();
				// TODO handle (optional?) digest after hash
				// TODO handle (optional) manifest
				Ok(EsySrc {
					src: Src::Archive(Url::new(url)),
					manifest: None,
				})
			}
			"no-source" => Ok(EsySrc {
				src: Src::None,
				manifest: None,
			}),
			other => Err(anyhow!("Unknown archive type: {}", other)),
		}
	}

	fn extract(sources: Vec<String>) -> Result<EsySrc> {
		let mut parsed: Vec<EsySrc> = sources
			.iter()
			.map(|s| Self::parse(s))
			.collect::<Result<Vec<EsySrc>>>()?;

		// To aid filetype detection, we prefer sources with an extension
		parsed.sort_by_key(|v| v.src.extension().unwrap_or("").to_owned());
		parsed.reverse();

		let mut it = parsed.into_iter();

		if let Some(source) = it.next() {
			while let Some(extra) = it.next() {
				debug!("ignoring additional source: {:?}", extra);
			}
			Ok(source)
		} else {
			Err(anyhow!("Empty source array"))
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
	where
		A: MapAccess<'de>,
	{
		let mut src = None;
		let mut typ = None;
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				// source.source is an array of archives.
				// Multiple archives appear to be for redundancy, so we just pick one.
				"source" => {
					let archives = map.next_value::<Vec<String>>()?;
					src = Some(err::into_serde(Self::extract(archives))?);
				}
				"type" => {
					typ = Some(match map.next_value::<&str>()? {
						"install" => SrcType::Install,
						"link-dev" => SrcType::LinkDev,
						other => SrcType::Unknown(other.to_owned()),
					})
				}
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}
		err::into_serde(match typ {
			Some(SrcType::Install) => src.ok_or_else(|| anyhow!("Missing `source.source`")),
			Some(SrcType::LinkDev) => Ok(EsySrc {
				src: Src::None,
				manifest: None,
			}),
			Some(SrcType::Unknown(u)) => Err(anyhow!("Unknown source type: {}", u)),
			None => Err(anyhow!("Missing `source.type`")),
		})
	}
}
