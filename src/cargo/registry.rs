use crate::*;
use crate::cache::CachedRepo;
use anyhow::*;
use cargo_metadata::Package;
use cargo_util::registry::make_dep_path;
use serde::Deserialize;
use std::collections::HashMap;
use std::path::{PathBuf, Path};
use std::fmt::Write;

#[derive(Debug, Clone, Deserialize)]
struct RegistryConfig {
	dl: String,
}

#[derive(Debug, Clone, Deserialize)]
struct RegistryEntry {
	vers: String,
	cksum: String,
}

#[derive(Debug, Clone)]
pub struct LocalRegistry {
	root: PathBuf,
	config: RegistryConfig,
}

const CRATE_TEMPLATE: &str = "{crate}";
const VERSION_TEMPLATE: &str = "{version}";
const PREFIX_TEMPLATE: &str = "{prefix}";
const LOWER_PREFIX_TEMPLATE: &str = "{lowerprefix}";
const CHECKSUM_TEMPLATE: &str = "{sha256-checksum}";
// https://github.com/rust-lang/cargo/blob/c890be276d1943b0f2c9e4e48b90fcddc609b554/src/cargo/sources/registry/mod.rs#L52
impl LocalRegistry {
	pub async fn get_source(&self, pkg: &Package) -> Result<Src> {
		// https://github.com/rust-lang/cargo/blob/c890be276d1943b0f2c9e4e48b90fcddc609b554/src/cargo/sources/registry/mod.rs#L234-L247
		// https://github.com/rust-lang/cargo/blob/d405d73f0e37f949d8623dde025dad8246210600/src/cargo/sources/registry/remote.rs#L265-L281

		let version_string = pkg.version.to_string();
		let rel_path = make_dep_path(&pkg.name, true);
		let entry_path = Path::new(&self.root).join(rel_path).join(&pkg.name);
		let entry_file = fs_util::read_to_string(&entry_path)?;
		let entry = entry_file.lines()
			.filter(|l| !l.trim().is_empty())
			.map(serde_json::from_str::<RegistryEntry>)
			.find_map(|entry| entry.ok().filter(|e| e.vers == version_string))
			.ok_or_else(|| anyhow!("Couldn't find {} version {} in {:?}", pkg.name, pkg.version, &entry_path))?;
		
		let mut url = self.config.dl.clone();
		if !url.contains(CRATE_TEMPLATE)
			&& !url.contains(VERSION_TEMPLATE)
			&& !url.contains(PREFIX_TEMPLATE)
			&& !url.contains(LOWER_PREFIX_TEMPLATE)
			&& !url.contains(CHECKSUM_TEMPLATE)
		{
			write!(url, "/{}/{}/download", CRATE_TEMPLATE, VERSION_TEMPLATE).unwrap();
		}
		let prefix = make_dep_path(&pkg.name, true);
		let url = url
			.replace(CRATE_TEMPLATE, &pkg.name)
			.replace(VERSION_TEMPLATE, &version_string)
			.replace(PREFIX_TEMPLATE, &prefix)
			.replace(LOWER_PREFIX_TEMPLATE, &prefix.to_lowercase())
			.replace(CHECKSUM_TEMPLATE, &entry.cksum);
		
		let digest = NixHash::from_hex(HashAlg::Sha256, &entry.cksum)?;
		Ok(Src::Archive(Archive {
			name: Some("crate.tar.gz".to_owned()),
			url: Url::new(url),
			digest: Some(digest),
		}))
	}
	
	pub async fn load(opts: &WriteOpts, url: Url) -> Result<Self> {
		let root = CachedRepo::cache(opts, &GitRepo::new(url)).await?.path;
		let json_contents = fs_util::read_to_string(root.join("config.json"))?;
		let config: RegistryConfig = serde_json::from_str(&json_contents)?;
		Ok(Self { root, config })
	}
}

pub struct Registries<'a> {
	cache: HashMap<String, LocalRegistry>,
	opts: &'a WriteOpts,
}

impl<'a> Registries<'a> {
	pub fn new(opts: &'a WriteOpts) -> Self {
		Self { cache: HashMap::new(), opts }
	}

	pub async fn get(&mut self, source: &cargo_metadata::Source) -> Result<&LocalRegistry> {
		let url = source.repr.strip_prefix("registry+").ok_or_else(||anyhow!("Unknown registry spec: {}", source.repr))?;
		if !self.cache.contains_key(url) {
			let reg = LocalRegistry::load(&self.opts, Url::new(url.into())).await?;
			self.cache.insert(url.to_owned(), reg);
		}
		self.cache.get(url).ok_or_else(||anyhow!("Couldn't retrieve repo from hash"))
	}
}
