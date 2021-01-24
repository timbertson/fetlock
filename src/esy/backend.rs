// esy.lock backend

use crate::esy::{command, eval, opam};
use crate::fetch;
use crate::*;
use crate::nix_serialize::{Writeable, WriteContext};
use anyhow::*;
use async_trait::async_trait;
use log::*;
use serde::de::*;
use futures::StreamExt;
use std::borrow::{Borrow,BorrowMut};
use std::collections::HashMap;
use std::fmt;
use std::io::Write;

#[derive(Clone, Debug)]
pub struct EsyLock {
	lock: Lock<EsySpec>,
}

impl EsyLock {
	fn opam_specs(&mut self) -> (Vec<&mut EsySpec>, HashMap<opam::Name, opam::Pkg>) {
		let mut specs = Vec::new();
		let mut map = HashMap::new();
		for (key, spec) in self.lock.specs.iter_mut() {
			if let Some(name) = spec.meta.opam_name.as_ref() {
				let pkg = opam::Pkg {
					name: name.to_owned(),
					key: key.clone(),
				};
				map.insert(name.to_owned(), pkg);
				specs.push(spec);
			}
		}
		(specs, map)
	}
	
	async fn finalize_spec(esy_spec: &mut EsySpec, opam_map: &HashMap<opam::Name, opam::Pkg>) -> Result<()> {
		if let Some(path) = fetch::realise_source(&esy_spec.spec).await? {
			let name = esy_spec.meta.opam_name.as_ref().expect("opam name");
			let manifest = if let Some(manifest_path) = esy_spec.meta.manifest_path.as_ref() {
				let extract = fetch::ExtractSource::from(&path).await?;
				extract.file_contents(&manifest_path).await?
			} else {
				// TODO get your own checkout, stop hardcoding
				let repo_path = std::path::PathBuf::from("/Users/tcuthbertson/.cache/opam2nix/repos/opam-repository/");
				let repo = fetch::ExtractSource::from(&repo_path).await?;
				let version = &esy_spec.spec.id.version;
				let path = format!("packages/{}/{}.{}/opam", name.0, name.0, version);
				repo.file_contents(&path).await?
			};
			let nix_ctx = eval::Ctx::from_map(&name, &opam_map);
			let opam = opam::Opam::from_str(&manifest)
				.with_context(|| format!("parsing opam manifest:\n{}", &manifest))?;
			info!("parsed opam: {:?}", opam);
			let nix = opam.into_nix(&nix_ctx)
				.with_context(|| format!("evaluating opam:\n{:?}", &manifest))?;
			info!(" -> as nix: {:?}", nix);
			esy_spec.spec.extra.insert("opam".to_owned(), nix.expr());
		}
		Ok(())
	}
}

#[async_trait(?Send)]
impl Backend for EsyLock {
	type Spec = EsySpec;

	fn load(path: &str) -> Result<Self> {
		let context = LockContext::new(lock::Type::Esy);
		info!("loading {}", path);
		let contents = std::fs::read_to_string(path)?;
		let lock: EsyLock = serde_json::from_str(&contents)?;
		Ok(lock)
	}
	
	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lock
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		match self.lock.specs.iter().find(|(key, esy_spec)| esy_spec.spec.id.name == "ocaml") {
			Some((key, esy_spec)) => {
				self.lock.context.extra.insert(
					"ocaml".to_owned(),
					Expr::get_drv(key.to_string())
				);
			},
			None => warn!("no `ocaml` implementation found, you will need to supply one at import time"),
		}

		let (mut specs, opam_map) = self.opam_specs();
		let opam_map_ref = &opam_map;
		
		let parallelism = 10;
		// TODO sorting and no parallelism makes ordering deterministic for testing
		// let parallelism = 1;
		specs.sort_by(|a,b| a.spec.id.cmp(&b.spec.id));

		let mut stream = futures::stream::iter(specs)
			.map(|esy_spec| async move {
				Self::finalize_spec(esy_spec, opam_map_ref).await
					.with_context(|| format!("Finalizing spec: {:?}", &esy_spec))
			})
			.buffer_unordered(parallelism);

		// TODO surely there's some `drain` method?
		while let Some(response) = stream.next().await {
			response?;
		}
		drop(stream);

		Ok(self.lock)
	}
}

#[derive(Debug, Clone)]
struct EsyMeta {
	opam_name: Option<opam::Name>,
	manifest_path: Option<String>,
	manifest: Option<command::Manifest>,
}

impl EsyMeta {
	fn empty() -> Self {
		Self {
			opam_name: None,
			manifest_path: None,
			manifest: None,
		}
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
		let mut ret = EsyLock {
			lock: Lock::new(LockContext::new(lock::Type::Esy)),
		};
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"root" => {
					ret.lock.context.add_toplevel(map.next_value::<Key>()?);
				}
				"node" => {
					ret.lock.specs = map
						.next_value::<HashMap<Key, EsySpec>>()?
						.into_iter()
						.collect();
				}
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}
		Ok(ret)
	}
}

#[derive(Debug, Clone)]
pub struct EsySpec {
	spec: Spec,
	meta: EsyMeta,
}

impl Borrow<Spec> for EsySpec {
	fn borrow(&self) -> &Spec {
		&self.spec
	}
}

impl BorrowMut<Spec> for EsySpec {
	fn borrow_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}

// TODO seems like this should be possible as an implementation on Borrow<Spec>, but no luck
impl Writeable for EsySpec {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> std::io::Result<()> {
		self.spec.write_to(c)
	}
}

struct EsySpecVisitor;

impl<'de> Deserialize<'de> for EsySpec {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsySpecVisitor)
	}
}

impl<'de> Visitor<'de> for EsySpecVisitor {
	type Value = EsySpec;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy package")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
	where
		A: MapAccess<'de>,
	{
		let mut partial = PartialSpec::empty();
		let mut meta = EsyMeta::empty();
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"name" => {
					let name = map.next_value::<&str>()?;
					let name = if let Some(opam_name) = name.strip_prefix("@opam/") {
						meta.opam_name = Some(opam::Name(opam_name.to_owned()));
						opam_name.to_owned()
					} else {
						name.to_owned()
					};
					partial.id.set_name(name)
				}
				"version" => {
					let version = map.next_value::<&str>()?;
					let version = version.strip_prefix("opam:").unwrap_or(version).to_owned();
					partial.id.set_version(version);
				}
				"source" => {
					let EsySrc { src, manifest } = map.next_value::<EsySrc>()?;
					partial.set_src(src);
					if let Some(manifest) = manifest {
						meta.manifest_path = Some(manifest);
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
		err::into_serde(partial.build()).map(|spec| EsySpec { spec, meta })
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
