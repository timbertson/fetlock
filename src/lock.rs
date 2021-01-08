use std::fmt::Debug;
use std::collections::HashMap;
use anyhow::*;
use serde::de::{Deserialize,Deserializer};
use crate::expr::Expr;

#[derive(Debug, Copy, Clone)]
pub enum Type {
	Esy
}

// newtype for a package key
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Key(String);

impl Key {
	pub fn new(raw: String) -> Key {
		Key(raw)
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
	lock_type: Type,
	toplevel: Vec<Key>,
	extra: HashMap<String, Expr>,
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
	pub repo: String,
	pub git_ref: String,
}

#[derive(Debug, Clone)]
pub struct Url(String);
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
pub struct Impl {
	pub dep_keys: Vec<Key>,
	pub src: Src,
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
				let id = id.build();
				let src = src.ok_or_else(||anyhow!("src required"))?;
				Ok(Impl { dep_keys, src, extra })
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