use crate::expr::Expr;
use crate::nix_serialize::Writeable;
use anyhow::*;
use lazy_static::lazy_static;
use serde::de::{Deserialize, Deserializer};
use std::collections::BTreeMap;
use std::fmt;
use std::fmt::Debug;
use std::iter::Iterator;

#[derive(Debug, Copy, Clone)]
pub enum Type {
	Esy,
	Yarn,
}

impl fmt::Display for Type {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		use Type::*;
		f.write_str(match self {
			Esy => "esy",
			Yarn => "yarn",
		})
	}
}

// newtype for a package key
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Key(String);

// newtype for a logical package name
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Name(pub String);
impl std::borrow::Borrow<str> for Name {
	fn borrow(&self) -> &str {
		self.0.as_str()
	}
}

impl Key {
	pub fn new(raw: String) -> Key {
		Key(raw)
	}

	pub fn as_str(&self) -> &str {
		&self.0
	}
}

impl fmt::Display for Key {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		fmt::Display::fmt(&self.0, f)
	}
}

impl<'de> Deserialize<'de> for Key {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where
		D: Deserializer<'de>,
	{
		// TODO remove hash part of key, it's unnecessary
		Ok(Key(String::deserialize(deserializer)?))
	}
}

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord)]
pub struct Id {
	pub name: String,
	pub version: String,
}

impl Id {
	pub fn version(v: Option<String>) -> String {
		v.unwrap_or_else(|| "development".to_owned())
	}

	pub fn new(name: String, version: Option<String>) -> Id {
		Id {
			name,
			version: Self::version(version),
		}
	}
}

#[derive(Debug, Clone)]
pub struct PartialId {
	name: Option<String>,
	version: Option<String>,
}

impl PartialId {
	pub fn empty() -> Self {
		Self {
			name: None,
			version: None,
		}
	}

	pub fn build(self) -> Result<Id> {
		match self {
			Self { name, version } => {
				let name = name.ok_or_else(|| anyhow!("name required"))?;
				Ok(Id {
					name,
					version: Id::version(version),
				})
			}
		}
	}

	pub fn set_name(&mut self, v: String) {
		self.name = Some(v);
	}

	pub fn set_version(&mut self, v: String) {
		self.version = Some(v);
	}
}

#[derive(Debug, Clone)]
pub struct LockContext {
	pub lock_type: Type,
	pub toplevel: Vec<Key>,
	pub extra: BTreeMap<String, Expr>,
}

impl LockContext {
	pub fn version() -> &'static str {
		"1"
	}

	pub fn new(lock_type: Type) -> LockContext {
		LockContext {
			lock_type,
			toplevel: vec![],
			extra: BTreeMap::new(),
		}
	}

	pub fn add_toplevel(&mut self, key: Key) {
		self.toplevel.push(key)
	}
}

pub trait GitUrl {
	fn git_url(&self) -> String;
	fn src_for_rev(&self, rev: String) -> Src;
}

#[derive(Debug, Clone)]
pub struct GithubRepo {
	pub owner: String,
	pub repo: String,
}

impl GitUrl for GithubRepo {
	fn git_url(&self) -> String {
		format!("https://github.com/{}/{}.git", &self.owner, &self.repo)
	}

	fn src_for_rev(&self, rev: String) -> Src {
		Src::Github(Github {
			repo: self.clone(),
			git_ref: rev,
			fetch_submodules: false,
		})
	}
}

#[derive(Debug, Clone)]
pub struct GitRepo {
	url: String,
}

// TODO when anyone needs it
// impl GitUrl for GitRepo { ... }

#[derive(Debug, Clone)]
pub struct Github {
	pub repo: GithubRepo,
	pub git_ref: String,
	pub fetch_submodules: bool,
}

#[derive(Debug, Clone)]
pub struct Url(pub String);
impl Url {
	pub fn new(s: String) -> Url {
		Url(s)
	}
}

#[derive(Debug, Clone)]
pub enum Src {
	Github(Github),
	Archive(Url),
	None,
}

impl Src {
	pub fn requires_digest(&self) -> bool {
		match self {
			Src::None => false,
			_ => true,
		}
	}

	pub fn extension(&self) -> Option<&str> {
		match self {
			Src::Archive(url) => {
				let mut it = url.0.rsplit("/").next().expect("empty split").rsplit(".");
				let ext_or_filename = it.next();
				if let Some(filename) = it.next() {
					ext_or_filename
				} else {
					None
				}
			}
			_ => None,
		}
	}
}

#[derive(Debug, Clone)]
pub struct Sha256(String);

impl Sha256 {
	pub fn new(s: String) -> Sha256 {
		Sha256(s)
	}

	pub fn default_len() -> usize {
		52
	}

	pub fn into_string(self) -> String {
		self.0
	}

	pub fn dummy() -> &'static Self {
		lazy_static! {
			static ref DUMMY: Sha256 = Sha256::new(
				std::iter::repeat("0")
					.take(Sha256::default_len())
					.collect::<String>()
			);
		}
		&DUMMY
	}
}

impl fmt::Display for Sha256 {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		fmt::Display::fmt(&self.0, f)
	}
}

#[derive(Debug, Clone)]
pub struct SrcDigest<'a> {
	pub src: &'a Src,
	pub digest: &'a Sha256,
}

impl SrcDigest<'_> {
	pub fn new<'a>(src: &'a Src, digest: &'a Sha256) -> SrcDigest<'a> {
		SrcDigest { src, digest }
	}
}

#[derive(Debug, Clone)]
pub struct Spec {
	pub id: Id,
	pub dep_keys: Vec<Key>,
	build_inputs: Vec<Expr>,
	pub src: Src,
	pub digest: Option<Sha256>,
	pub extra: BTreeMap<String, Expr>,
}

impl Spec {
	pub fn src_digest(&self) -> Option<SrcDigest> {
		self.digest.as_ref().map(|digest| SrcDigest {
			src: &self.src,
			digest,
		})
	}

	pub fn build_inputs(&self) -> Vec<Expr> {
		let mut ret = self.build_inputs.clone();
		if self.src.extension().map_or(false, |ext| ext == "zip") {
			ret.push(Expr::Literal("pkgs.unzip".to_owned()));
		}
		ret
	}

	pub fn add_build_input(&mut self, dep: Expr) {
		self.build_inputs.push(dep)
	}
}

#[derive(Debug, Clone)]
pub struct PartialSpec {
	pub id: PartialId,
	pub dep_keys: Vec<Key>,
	pub src: Option<Src>,
	pub extra: BTreeMap<String, Expr>,
}

impl PartialSpec {
	pub fn empty() -> Self {
		Self {
			id: PartialId::empty(),
			dep_keys: Vec::new(),
			src: None,
			extra: BTreeMap::new(),
		}
	}

	pub fn build(self) -> Result<Spec> {
		match self {
			Self {
				id,
				dep_keys,
				src,
				extra,
			} => {
				let id = id.build()?;
				let src = src.ok_or_else(|| anyhow!("src required"))?;
				Ok(Spec {
					id,
					dep_keys,
					build_inputs: Vec::new(),
					src,
					extra,
					digest: None,
				})
			}
		}
	}

	pub fn add_dep(&mut self, dep_key: Key) {
		self.dep_keys.push(dep_key);
	}

	pub fn add_deps(&mut self, dep_keys: &mut Vec<Key>) {
		self.dep_keys.append(dep_keys);
	}

	pub fn set_src(&mut self, src: Src) {
		self.src = Some(src);
	}
}

#[derive(Debug, Clone)]
pub struct Lock<Spec: Writeable> {
	pub context: LockContext,
	pub specs: BTreeMap<Key, Spec>,
	pub vars: BTreeMap<&'static str, Expr>,
}

impl<Spec: Writeable> Lock<Spec> {
	pub fn new(context: LockContext) -> Lock<Spec> {
		Lock {
			context,
			specs: BTreeMap::new(),
			vars: BTreeMap::new(),
		}
	}

	pub fn add_impl(&mut self, k: Key, v: Spec) {
		self.specs.insert(k, v);
	}
}
