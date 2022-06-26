// esy.lock backend

use crate::esy::esy_manifest;
use crate::esy::esy_manifest::Manifest;
use crate::fetch;
use crate::opam::build::PkgType;
use crate::opam::eval::Pkg;
use crate::opam::opam2nix;
use crate::opam::{eval, opam_manifest};
use crate::stream_util::*;
use crate::string_util::*;
use crate::*;
use anyhow::*;
use async_trait::async_trait;
use log::*;
use serde::de::*;
use serde::Deserialize;
use std::borrow::Borrow;
use std::collections::{BTreeMap, HashMap};
use std::fmt;
use std::path::*;

#[derive(Clone, Debug)]
pub struct EsyLock {
	src: LocalSrc,
	lockfile: EsyLockFile,
}

#[derive(Clone, Debug)]
pub struct EsyLockFile {
	lock: Lock<EsySpec>,
}

struct InstalledPkgs {
	// TODO can these be refs?
	opam: HashMap<Name, Pkg>,
	esy: HashMap<Name, Pkg>,
}

impl EsyLock {
	fn partition_specs<'a>(&'a mut self) -> Result<InstalledPkgs> {
		let mut opam = HashMap::new();
		let mut esy = HashMap::new();
		let pkg = |name: Name, key: &Key| Pkg {
			name: name,
			key: key.clone(),
		};

		for (key, spec) in self.lockfile.lock.specs.iter_mut() {
			let name = Name(spec.spec.id.name.to_owned());
			match spec.meta.pkg_type()? {
				PkgType::Opam => {
					opam.insert(name.clone(), pkg(name, key));
				}
				PkgType::Esy => {
					esy.insert(name.clone(), pkg(name, key));
				}
			}
		}
		Ok(InstalledPkgs { esy, opam })
	}

	async fn manifest_contents<'a>(
		src: &LocalSrc,
		extract: &Option<fetch::ExtractSource<'a>>,
		manifest: &ManifestPath,
	) -> Result<String> {
		match manifest {
			ManifestPath::Remote(manifest_path) => {
				// TODO can a manifest ever point to somewhere other
				// than the src archive?
				extract
					.as_ref()
					.ok_or_else(|| anyhow!("remote manifest path given, but no source given"))?
					.file_contents(manifest_path)
					.await
			}
			ManifestPath::Local(manifest_path) => fetch::ExtractSource::from(&src.root)
				.await?
				.file_contents(manifest_path)
				.await
				.with_context(|| {
					format!("can't get manifest {} from {:?}", &manifest_path, &src.root)
				}),
		}
	}

	async fn extract<'a>(
		realised_src: Option<&'a PathBuf>,
		spec: &mut EsySpec,
	) -> Result<Option<fetch::ExtractSource<'a>>> {
		let result: Result<Option<fetch::ExtractSource>> = {
			if let Some(path_ref) = realised_src {
				let src = fetch::ExtractSource::from(path_ref).await?;
				// TODO this upgrade should happen somewhere centrally,
				// but it's wasteful to extract multiple times
				src.upgrade_gitmodules(&mut spec.spec).await?;
				Ok(Some(src))
			} else {
				Ok(None)
			}
		};
		result
	}

	async fn populate_manifest(
		src: &LocalSrc,
		realised_src: Option<&PathBuf>,
		esy_spec: &mut EsySpec,
	) -> Result<()> {
		let manifest = match esy_spec.meta.pkg_type()? {
			PkgType::Esy => {
				match Self::extract(realised_src, esy_spec).await? {
					Some(checkout) => {
						let contents =
							if let Some(manifest_path) = esy_spec.meta.manifest_path.as_ref() {
								Some(
									Self::manifest_contents(src, &Some(checkout), manifest_path)
										.await?,
								)
							} else {
								// TODO ManifestPath::Remote is an assumption
								if checkout.exists("esy.json").await {
									Some(checkout.file_contents("esy.json").await?)
								} else if checkout.exists("package.json").await {
									Some(checkout.file_contents("package.json").await?)
								} else {
									None
								}
							};
						contents.map(Manifest::Contents)
					}
					None => None,
				}
			}

			PkgType::Opam => {
				match esy_spec.meta.manifest_path.clone() {
					// all opams must have an explicit manifest
					None => {
						return Err(anyhow!(format!(
							"Opam package does not contain an explicit manifest: {:?}",
							&esy_spec
						)))
					}

					Some(manifest_path) => Some(match manifest_path {
						ManifestPath::Local(rel_path) => {
							let opam_path_rel = PathBuf::from(rel_path);
							let files_path_rel = opam_path_rel.with_file_name("files");
							let files_path_abs = src.root.join(&files_path_rel);
							debug!(
								"Checking files path {:?} for esy spec {:?}",
								files_path_abs, &esy_spec
							);
							if files_path_abs.exists() {
								debug!("Adding files path {:?}", files_path_abs);
								let hash = cache::nix_digest_of_path(files_path_abs).await?;
								esy_spec.spec.extra.insert(
									"files".to_owned(),
									cache::subtree_expr(
										Expr::Literal("final.rootAttrs.src".to_owned()),
										files_path_rel.to_string_lossy().to_string(),
										&hash,
									),
								);
							}
							Manifest::Path(
								src.root.join(opam_path_rel).to_string_lossy().to_string(),
							)
						}
						ManifestPath::Remote(_) => {
							let checkout = Self::extract(realised_src, esy_spec).await?;
							Manifest::Contents(
								Self::manifest_contents(src, &checkout, &manifest_path).await?,
							)
						}
					}),
				}
			}
		};
		esy_spec.meta.manifest = manifest;
		Ok(())
	}

	async fn finalize_spec(
		src: &LocalSrc,
		realised_src: Option<&PathBuf>,
		esy_spec: &mut EsySpec,
		opam_solution: &opam2nix::Solution,
		installed: &InstalledPkgs,
	) -> Result<()> {
		let start = std::time::Instant::now();
		let name = Name(esy_spec.spec.id.name.to_owned());
		match esy_spec.meta.pkg_type()? {
			PkgType::Opam => {
				let nix_ctx = eval::Ctx::from_map(PkgType::Opam, &name, &installed.opam);
				let selected_package = opam_solution.0.get::<str>(name.borrow()).ok_or(anyhow!(
					"opam implementation missing from opam2nix: {:?}",
					&name
				))?;
				let build = opam_manifest::OpamJson(selected_package)
					.build(&nix_ctx)
					.with_context(|| format!("evaluating opam package {:?}", &name))?;
				debug!(" -> as nix: {:?}", build);
				esy_spec.spec.extra.insert("build".to_owned(), build.expr());
			}
			PkgType::Esy => {
				// NOTE: some esy packages are just npm packages, depending on whether they have
				// an `esy` property in them
				match esy_spec.meta.manifest.as_ref() {
					None => (),
					Some(Manifest::Path(_)) => {
						return Err(anyhow!("Esy package has a local manifest path, this should have been resolved in populate_manifest"));
					}
					Some(Manifest::Contents(manifest)) => {
						let esy = esy_manifest::PackageJson::from_str(&manifest)
							.with_context(|| format!("deserializing manifest:\n\n{}", &manifest))?;
						debug!("esy manifest: {:?}", &esy);

						// Now that we have access to package.json, we can populate a better name/version
						// than we got from the lockfile.
						// If the name is e.g. @esy-ocaml/foo, just use "foo" as the name
						// (we don't replace `pname` since that's used to build the attrset,
						// but we pass it as `opamName` if it differs from `pname`)
						let opam_name = Name(
							esy.name
								.rsplit('/')
								.next()
								.expect("split is empty")
								.to_string(),
						);
						if let Some(version) = &esy.version {
							esy_spec.spec.id.version = version.clone();
						};

						let nix_ctx = eval::Ctx::from_map(PkgType::Esy, &opam_name, &installed.esy);
						esy_spec
							.spec
							.extra
							.insert("build".to_owned(), esy.build(&nix_ctx)?.expr());
						if esy_spec.spec.id.name != opam_name.0 {
							esy_spec
								.spec
								.extra
								.insert("opamName".to_owned(), Expr::str(opam_name.0));
						}
					}
				}
			}
		}
		let secs = start.elapsed().as_secs_f32();
		if secs > 0.5 {
			info!("[esy]: {} (in {:.1}s)", esy_spec.spec.id.name, secs);
		} else {
			info!("[esy]: {}", esy_spec.spec.id.name);
		}
		Ok(())
	}
}

#[async_trait(?Send)]
impl Backend for EsyLock {
	type Spec = EsySpec;

	async fn load(src_dir: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		let context = LockContext::new(lock::Type::Esy);

		// relative paths obtained from esy.lock contain the path to index.json,
		// so for convenience that's the internal path we use too, despite the fact that
		// fetlock uses the containing directory
		let LocalSrc { root, relative: relative_dir, fetch: _ } = src_dir;
		let relative_file = format!("{}/index.json",
			relative_dir.as_ref().ok_or_else(||anyhow!("lockfile path required"))?);
		let src_file = LocalSrc {
			root: root.clone(),
			relative: Some(relative_file),
			fetch: None,
		};

		let contents = crate::fs_util::read_to_string(src_file.lock_path())?;
		let lockfile: EsyLockFile = serde_json::from_str(&contents)?;
		Ok(EsyLock {
			src: src_file.clone(),
			lockfile,
		})
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.lockfile.lock
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		use opam2nix::{DirectSpec, OpamSource, Request};

		if let None = self
			.lockfile
			.lock
			.specs
			.iter()
			.find(|(key, esy_spec)| esy_spec.spec.id.name == "ocaml")
		{
			warn!("no `ocaml` implementation found, you will need to supply one at import time")
		}

		let realised_sources = fetch::realise_fetch_sources(
			self.lockfile
				.lock
				.specs
				.iter()
				.map(|(key, spec)| (key, &spec.spec))
			).await?;

		let installed = self.partition_specs()?;
		let installed_ref = &installed;

		let parallelism = 10;
		// TODO sorting and no parallelism makes ordering deterministic for testing
		// let parallelism = 1;
		// specs.sort_by(|a,b| a.id().cmp(&b.id()));

		// NOTE: we need two passes over packages to finalize.
		// On the first pass we fetch all remote manifests (JSON and opam).
		// Then we run opam2nix extract, and finally
		// `opam` file contents for all opam files. Then we can run `opam2nix
		// extract`, and the second pass can then construct the final build
		// commands for both esy and opam packages.
		let src_ref = &self.src;

		let specs = self.lockfile.lock.specs.iter_mut();
		let stream = futures::stream::iter(specs);
		foreach_unordered(parallelism, stream, |(key, esy_spec)| {
			let realised_src = realised_sources.get(key);
			async move {
				Self::populate_manifest(src_ref, realised_src, esy_spec)
					.await
					.with_context(|| format!("Populating opam manifest: {:?}", esy_spec))
			}
		})
		.await?;

		let opam_specs: Vec<DirectSpec> = self
			.lockfile
			.lock
			.specs
			.iter()
			.filter_map(|(id, esy_spec)| {
				let definition = if esy_spec.meta.pkg_type == Some(PkgType::Opam) {
					match &esy_spec.meta.manifest {
						None => None,
						Some(Manifest::Path(p)) => {
							Some(OpamSource::Path(PathBuf::from(p.to_owned())))
						}
						Some(Manifest::Contents(manifest)) => {
							Some(OpamSource::Contents(manifest.to_owned()))
						}
					}
				} else {
					None
				};
				let version = {
					let version = esy_spec.spec.id.version.as_str();
					if version.contains(':') || version.contains('/') {
						"dev"
					} else {
						version
					}
				}
				.to_owned();
				definition.map(|definition| DirectSpec {
					name: esy_spec.spec.id.name.to_string(),
					version: Some(version),
					definition,
				})
			})
			.collect();
		let opam_request = Request {
			ocaml_version: None,
			repositories: Vec::new(),
			selection: Some(opam_specs),
			spec: None,
		};

		let opam_solution = opam2nix::solve(&opam_request).await?;

		let specs = self.lockfile.lock.specs.iter_mut();
		let stream = futures::stream::iter(specs);
		let opam_solution_ref = &opam_solution;

		foreach_unordered(parallelism, stream, |(key, esy_spec)| {
			let realised_src = realised_sources.get(key);
			async move {
				debug!("starting... {:?}", &esy_spec.spec.id.name);
				Self::finalize_spec(
					src_ref,
					realised_src,
					esy_spec,
					opam_solution_ref,
					installed_ref,
				)
				.await
				.with_context(|| format!("Finalizing spec: {:?}", esy_spec))
			}
		})
		.await?;
		Ok(self.lockfile.lock)
	}
}

#[derive(Debug, Clone)]
enum ManifestPath {
	Local(String),
	Remote(String),
}

#[derive(Debug, Clone)]
struct EsyMeta {
	pkg_type: Option<PkgType>,

	// manifest_path is typically for opam files within a source repo.
	// I don't know whether it can also be used for nonstandard esy.json
	manifest_path: Option<ManifestPath>,

	manifest: Option<Manifest>,
}

impl EsyMeta {
	fn empty() -> Self {
		Self {
			pkg_type: None,
			manifest_path: None,
			manifest: None,
		}
	}

	fn pkg_type(&self) -> Result<PkgType> {
		self.pkg_type
			.ok_or_else(|| anyhow!("pkg_type not populated: {:?}", self))
	}
}

struct EsyVisitor;

impl<'de> Deserialize<'de> for EsyLockFile {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsyVisitor)
	}
}

impl<'de> Visitor<'de> for EsyVisitor {
	type Value = EsyLockFile;

	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy.lock")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
	where
		A: MapAccess<'de>,
	{
		let mut ret = EsyLockFile {
			lock: Lock::new(LockContext::new(lock::Type::Esy)),
		};
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"root" => {
					ret.lock.set_root(Root::Package(map.next_value::<Key>()?));
				}
				"node" => {
					ret.lock.specs = map
						.next_value::<BTreeMap<Key, EsySpec>>()?
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

impl AsSpec for EsySpec {
	fn wrap(spec: Spec) -> Self {
		EsySpec {
			spec,
			meta: EsyMeta::empty(),
		}
	}
	fn as_spec_ref(&self) -> &Spec {
		&self.spec
	}
	fn as_spec_mut(&mut self) -> &mut Spec {
		&mut self.spec
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
		// assume esy until told otherwise
		meta.pkg_type = Some(PkgType::Esy);
		let mut opam_src = None;
		while let Some(key) = map.next_key::<&str>()? {
			match key {
				"name" => {
					let name = map.next_value::<String>()?;
					// some opam packages don't have an "opam" property in their source spec,
					// so we can only tell via the @opam prefix :(
					let name = if let Some(opam_name) = name.strip_prefix("@opam/") {
						meta.pkg_type = Some(PkgType::Opam);
						opam_name.to_owned()
					} else {
						name
					};
					partial.id.set_name(name)
				}
				"version" => {
					let version = map.next_value::<&str>()?;
					let version = version.strip_prefix("opam:").unwrap_or(version).to_owned();
					partial.id.set_version(version);
				}
				"source" => {
					let EsySrcInfo {
						src,
						manifest,
						opam,
					} = map.next_value::<EsySrcInfo>()?;

					let remote_src = match src {
						AnySrc::Full(Src::Local(prefix)) => {
							if let Some(manifest) = manifest {
								let prefix_str = err::into_serde(path_util::to_str(&prefix.0))?;
								meta.manifest_path = Some(ManifestPath::Local(format!("{}/{}", prefix_str, manifest)));
							};
							AnySrc::Full(Src::None)
						},
						other => {
							if other.fetch_spec().is_some() {
								// it's some kind of remote source
								if let Some(manifest) = manifest {
									meta.manifest_path = Some(ManifestPath::Remote(manifest));
								}
							}
							other
						},
					};
					partial.set_any_src(remote_src);
					opam_src = opam;
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
		if let Some(EsySrcOpam {
			name,
			version,
			path,
		}) = opam_src
		{
			if let Some(path) = path {
				if meta.manifest_path.is_some() {
					return err::into_serde(Err(anyhow!(
						"package {:?} has both a manifest path (from a source archive) and an opam source (from the opam repository)",
						&name
					)));
				}
				// opam_src path is the directory, not the opam file itself
				meta.manifest_path = Some(ManifestPath::Local(format!("{}/opam", path)));
			}

			partial.id.set_version(version);
			partial.id.set_name(name);
			meta.pkg_type = Some(PkgType::Opam);
		}
		err::into_serde(partial.build()).map(|spec| EsySpec { spec, meta })
	}
}

#[derive(Debug, Clone)]
struct EsySrcInfo {
	src: AnySrc,
	manifest: Option<String>,
	opam: Option<EsySrcOpam>,
}

#[derive(Debug, Clone, Deserialize)]
struct EsySrcOpam {
	name: String,
	version: String,
	path: Option<String>, // relative to lockfile directory
}

impl<'de> Deserialize<'de> for EsySrcInfo {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		deserializer.deserialize_any(EsySrcInfoVisitor)
	}
}

struct EsySrcInfoVisitor;

impl EsySrcInfoVisitor {
	fn parse(spec: &str) -> Result<EsySrcInfo> {
		let (typ, src) = split_one(":", spec);
		let src = src.ok_or_else(|| anyhow!("invalid spec"))?;
		match typ {
			"github" => {
				let (owner_repo_manifest, git_ref) =
					split_one_or_else("#", src, || anyhow!("ref missing"))?;
				let (owner_repo, manifest) = split_one(":", owner_repo_manifest);
				let (owner, repo) = split_one_or_else("/", owner_repo, || anyhow!("repo missing"))?;
				let git_ref = git_ref.to_owned();
				let repo = repo.to_owned();
				let owner = owner.to_owned();
				let manifest = manifest.map(|m| m.to_owned());
				Ok(EsySrcInfo {
					src: AnySrc::Partial(FetchSpec::Github(Github {
						repo: GithubRepo { owner, repo },
						git_ref,
						fetch_submodules: false, // may be modified in fetch::upgrade_gitmodules
					})),
					manifest,
					opam: None,
				})
			}
			"archive" => {
				let mut it = src.split("#");
				let invalid = || anyhow!("invalid archive: {}", src);
				let url = it.next().ok_or_else(invalid)?.to_owned();
				let digest = match it.next() {
					None => None,
					Some(d) => {
						let mut parts = d.splitn(2, ':');
						let alg = HashAlg::parse(parts.next().ok_or_else(invalid)?)?;
						Some(NixHash::from_hex(alg, parts.next().ok_or_else(invalid)?)?)
					}
				};
				// TODO handle (optional) manifest
				Ok(EsySrcInfo {
					src: AnySrc::fetch(FetchSpec::Archive(Archive::new(url)), digest),
					manifest: None,
					opam: None,
				})
			}
			"no-source" => Ok(EsySrcInfo {
				src: AnySrc::Full(Src::None),
				manifest: None,
				opam: None,
			}),
			other => Err(anyhow!("Unknown archive type: {}", other)),
		}
	}

	fn extract(sources: Vec<String>) -> Result<EsySrcInfo> {
		let mut parsed: Vec<EsySrcInfo> = sources
			.iter()
			.map(|s| Self::parse(s))
			.collect::<Result<Vec<EsySrcInfo>>>()?;

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

#[derive(Debug, Clone)]
enum SrcType {
	Install,
	LinkDev,
	Unknown(String),
}

impl<'de> Visitor<'de> for EsySrcInfoVisitor {
	type Value = EsySrcInfo;
	fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
		formatter.write_str("esy source")
	}

	fn visit_map<A>(self, mut map: A) -> std::result::Result<Self::Value, A::Error>
	where
		A: MapAccess<'de>,
	{
		let mut src = None;
		let mut typ = None;
		let mut opam = None;
		let mut local_path = None;
		let mut local_manifest = None;
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
				"path" => {
					local_path = Some(map.next_value::<String>()?);
				}
				"manifest" => {
					local_manifest = Some(map.next_value::<String>()?);
				}
				"opam" => opam = Some(map.next_value()?),
				_ => {
					map.next_value::<IgnoredAny>()?;
				}
			}
		}

		err::into_serde(match typ {
			Some(SrcType::Install) => {
				if let Some(mut src) = src.as_mut() {
					src.opam = opam;
				}
				src.ok_or_else(|| anyhow!("Missing `source.source`"))
			}
			Some(SrcType::LinkDev) => Ok(EsySrcInfo {
				src: AnySrc::Full(local_path
					.map(|p| Src::Local(LocalPath::from_string(p)))
					.unwrap_or(Src::None)),
				manifest: local_manifest,
				opam,
			}),
			Some(SrcType::Unknown(u)) => Err(anyhow!("Unknown source type: {}", u)),
			None => Err(anyhow!("Missing `source.type`")),
		})
	}
}
