use std::fmt::Debug;
use std::fmt;
use std::collections::HashMap;
use anyhow::*;
use serde::de::{Deserialize,Deserializer};
use lazy_static::lazy_static;
use crate::expr::Expr;

#[derive(Debug, Copy, Clone)]
pub enum Type {
	Esy
}

impl fmt::Display for Type {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		use Type::*;
		f.write_str(match self {
			Esy => "esy"
		})
	}
}

// newtype for a package key
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Key(String);

impl Key {
	pub fn new(raw: String) -> Key {
		Key(raw)
	}
}

impl fmt::Display for Key {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		fmt::Display::fmt(&self.0, f)
	}
}

impl<'de> Deserialize<'de> for Key {
	fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
	where D: Deserializer<'de>,
	{
		Ok(Key(String::deserialize(deserializer)?))
	}
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Id {
	pub name: String,
	pub version: String,
}

impl Id {
	pub fn version(v: Option<String>) -> String {
		v.unwrap_or_else(||"development".to_owned())
	}

	pub fn new(name: String, version: Option<String>) -> Id {
		Id { name, version: Self::version(version) }
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
				let name = name.ok_or_else(||anyhow!("name required"))?;
				Ok(Id { name, version: Id::version(version) })
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
	pub extra: HashMap<String, Expr>,
}

impl LockContext {
	pub fn version() -> &'static str {
		"1"
	}

	pub fn new(lock_type: Type) -> LockContext {
		LockContext {
			lock_type,
			toplevel: vec!(),
			extra: HashMap::new(),
		}
	}
	
	pub fn add_toplevel(&mut self, key: Key) {
		self.toplevel.push(key)
	}
}

#[derive(Debug, Clone)]
pub struct Github {
	pub owner: String,
	pub repo: String,
	pub git_ref: String,
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

#[derive(Debug, Clone)]
pub struct Sha256(String);

impl Sha256 {
	pub fn new(s: String) -> Sha256 {
		Sha256(s)
	}

	pub fn len() -> usize { 52 }

	pub fn dummy() -> &'static Self {
    lazy_static! {
      static ref DUMMY: Sha256 =
      	Sha256::new(std::iter::repeat("0").take(Sha256::len()).collect::<String>());
    }
    &DUMMY
	}
}

impl fmt::Display for Sha256 {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		fmt::Display::fmt(&self.0, f)
	}
}

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
pub struct Impl {
	pub id: Id,
	pub dep_keys: Vec<Key>,
	pub src: Src,
	pub digest: Option<Sha256>,
	pub extra: HashMap<String, Expr>,
}

#[derive(Debug, Clone)]
pub struct PartialImpl {
	pub id: PartialId,
	pub dep_keys: Vec<Key>,
	pub src: Option<Src>,
	pub extra: HashMap<String, Expr>,
}

impl PartialImpl {
	pub fn empty() -> Self {
		Self {
			id: PartialId::empty(),
			dep_keys: Vec::new(),
			src: None,
			extra: HashMap::new(),
		}
	}

	pub fn build(self) -> Result<Impl> {
		match self {
			Self { id, dep_keys, src, extra } => {
				let id = id.build()?;
				let src = src.ok_or_else(||anyhow!("src required"))?;
				Ok(Impl { id, dep_keys, src, extra, digest: None })
			}
		}
	}
	
	pub fn add_deps(&mut self, dep_keys: &mut Vec<Key>) {
		self.dep_keys.append(dep_keys);
	}

	pub fn set_src(&mut self, src: Src) {
		self.src = Some(src);
	}
}

#[derive(Debug, Clone)]
pub struct Lock {
	pub context: LockContext,
	pub implementations: HashMap<Key, Impl>,
}

impl Lock {
	pub fn new(context: LockContext) -> Lock {
		Lock { context, implementations: HashMap::new() }
	}
	
	pub fn add_impl(&mut self, k: Key, v: Impl) {
		self.implementations.insert(k, v);
	}
}
