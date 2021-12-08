use crate::expr::Expr;
use crate::hash::NixHash;
use anyhow::*;
use serde::de::{Deserialize, Deserializer};
use std::borrow::Borrow;
use std::collections::BTreeMap;
use std::fmt;
use std::fmt::Debug;
use std::iter::Iterator;

#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub enum Type {
	Esy,
	Opam,
	Yarn,
	Bundler,
	Cargo,
}

impl fmt::Display for Type {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		use Type::*;
		f.write_str(match self {
			Esy => "esy",
			Opam => "opam",
			Yarn => "yarn",
			Bundler => "bundler",
			Cargo => "cargo",
		})
	}
}

// newtype for a package key
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Key(String);

// newtype for a logical package name
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash, serde::Deserialize)]
pub struct Name(pub String);
impl Borrow<str> for Name {
	fn borrow(&self) -> &str {
		self.0.as_str()
	}
}

// newtype for a package version
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash, serde::Deserialize)]
pub struct Version(pub String);
impl Borrow<str> for Version {
	fn borrow(&self) -> &str {
		self.0.as_str()
	}
}

impl Key {
	pub fn new(raw: String) -> Key {
		Key(raw)
	}

	pub fn from_kv(name: &str, version: &str) -> Key {
		Self::new(format!("{}@{}", name, version))
	}

	pub fn from_id(id: &Id) -> Key {
		Self::from_kv(&id.name, &id.version)
	}

	pub fn as_str(&self) -> &str {
		&self.0
	}

	pub fn into_string(self) -> String {
		self.0
	}
}

impl From<&str> for Key {
	fn from(k: &str) -> Self {
		Self::new(k.to_owned())
	}
}

impl From<&String> for Key {
	fn from(k: &String) -> Self {
		Self::new(k.to_owned())
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
	// TODO use Name and Version types
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
pub enum Root {
	Package(Key),
	Virtual(Vec<Key>),
}

impl Root {
	pub fn key(&self) -> Key {
		match self {
			Root::Package(key) => key.clone(),
			Root::Virtual(keys) => Key::new("_virtual_root".to_owned()),
		}
	}
}

#[derive(Debug, Clone)]
pub struct LockContext {
	pub lock_type: Type,
	pub root: Root,
	pub extra: BTreeMap<String, Expr>,
}

impl LockContext {
	pub fn version() -> &'static str {
		"1"
	}

	pub fn new(lock_type: Type) -> LockContext {
		LockContext {
			lock_type,
			root: Root::Package(Key::new("root-pkg-unset".to_owned())),
			extra: BTreeMap::new(),
		}
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
	url: Url,
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
pub struct Archive {
	pub name: Option<String>,
	pub url: Url,
	pub digest: Option<NixHash>,
}

impl Archive {
	pub fn new(s: String, digest: Option<NixHash>) -> Self {
		Self {
			name: None,
			url: Url::new(s),
			digest
		}
	}
}

#[derive(Debug, Clone)]
pub enum Src {
	Github(Github),
	Archive(Archive),
	RelativePath(String),
	None,
}

impl Src {
	pub fn requires_digest(&self) -> bool {
		match self {
			Src::Github(_) => true,
			Src::Archive(_) => true,
			Src::RelativePath(_) => false,
			Src::None => false,
		}
	}

	pub fn supplied_digest(&self) -> Option<Option<&NixHash>> {
		match self {
			Src::Github(_) => None,
			Src::Archive(a) => Some(a.digest.as_ref()),
			Src::RelativePath(_) => None,
			Src::None => None,
		}
	}

	pub fn extension(&self) -> Option<&str> {
		match self {
			Src::Archive(archive) => {
				let mut it = archive
					.url
					.0
					.rsplit("/")
					.next()
					.expect("empty split")
					.rsplit(".");
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
pub struct SrcDigest<'a> {
	pub src: &'a Src,
	pub digest: &'a NixHash,
}

impl SrcDigest<'_> {
	pub fn new<'a>(src: &'a Src, digest: &'a NixHash) -> SrcDigest<'a> {
		SrcDigest { src, digest }
	}

	pub fn as_expr(&self) -> Expr {
		let SrcDigest { src, digest } = self;
		match src {
			Src::Github(github) => {
				let Github {
					repo: GithubRepo { owner, repo },
					git_ref,
					fetch_submodules,
				} = github;
				let mut attrs = vec![
					("owner", Expr::str(owner.to_owned())),
					("repo", Expr::str(repo.to_owned())),
					("rev", Expr::str(git_ref.to_owned())),
					("hash", Expr::str(digest.sri_string())),
				];
				if *fetch_submodules {
					attrs.push(("fetchSubmodules", Expr::Bool(true)));
				}

				Expr::fun_call(
					Expr::Literal("pkgs.fetchFromGitHub".to_owned()),
					vec![Expr::attr_set(attrs)],
				)
			}
			Src::Archive(archive) => {
				let Archive { url, name, digest: _ } = archive;
				let mut attrs = vec![
					("url", Expr::str(url.0.to_owned())),
					("hash", Expr::str(digest.sri_string())),
				];
				if let Some(name) = name {
					attrs.push(("name", Expr::str(name.to_owned())));
				}

				Expr::fun_call(
					Expr::Literal("pkgs.fetchurl".to_owned()),
					vec![Expr::attr_set(attrs)],
				)
			}

			// TODO better error reporting, assert?
			Src::RelativePath(_) => Expr::Null,
			Src::None => Expr::Null,
		}
	}
}

pub trait AsSpec: Debug + Clone {
	fn wrap(spec: Spec) -> Self;

	// These could be type constraints `AsRef<Spec> + AsMut<Spec>`,
	// but it makes for tedious boulerplate
	fn as_spec_ref(&self) -> &Spec;
	fn as_spec_mut(&mut self) -> &mut Spec;
}

#[derive(Debug, Clone)]
pub struct Spec {
	pub id: Id,
	pub dep_keys: Vec<Key>,
	build_inputs: Vec<Expr>,
	pub src: Src,
	pub digest: Option<NixHash>,
	pub extra: BTreeMap<String, Expr>,
}

impl Spec {
	pub fn src_digest(&self) -> Option<SrcDigest> {
		self.digest.as_ref().map(|digest| SrcDigest {
			src: &self.src,
			digest,
		})
	}

	pub fn set_src_digest(&mut self, src: Src, digest: NixHash) {
		self.src = src;
		self.digest = Some(digest);
	}

	pub fn set_src_path(&mut self, src: String) {
		self.src = Src::RelativePath(src);
		self.digest = None;
	}

	pub fn build_inputs(&self) -> Vec<Expr> {
		let mut ret = self.build_inputs.clone();
		if self.src.extension().map_or(false, |ext| ext == "zip") {
			ret.push(Expr::Literal("pkgs.unzip".to_owned()));
		}
		ret
	}
}

impl AsSpec for Spec {
	fn wrap(spec: Spec) -> Self {
		spec
	}
	fn as_spec_ref(&self) -> &Spec {
		self
	}
	fn as_spec_mut(&mut self) -> &mut Spec {
		self
	}
}

#[derive(Debug, Clone)]
pub struct PartialSpec {
	pub id: PartialId,
	pub dep_keys: Vec<Key>,
	pub src: Option<Src>,
	pub build_inputs: Vec<Expr>,
	pub extra: BTreeMap<String, Expr>,
}

impl PartialSpec {
	pub fn empty() -> Self {
		Self {
			id: PartialId::empty(),
			dep_keys: Vec::new(),
			build_inputs: Vec::new(),
			src: None,
			extra: BTreeMap::new(),
		}
	}

	pub fn build(self) -> Result<Spec> {
		let error_desc = format!("building {:?}", &self); // TODO make this lazy
		match self {
			Self {
				id,
				dep_keys,
				build_inputs,
				src,
				extra,
			} => {
				let built: Result<Spec> = (|| {
					let id = id.build()?;
					let src = src.ok_or_else(|| anyhow!("src required"))?;
					Ok(Spec {
						id,
						dep_keys,
						build_inputs,
						src,
						extra,
						digest: None,
					})
				})();
				built.with_context(|| error_desc)
			}
		}
	}

	pub fn add_dep(&mut self, dep_key: Key) {
		self.dep_keys.push(dep_key);
	}

	pub fn add_deps(&mut self, dep_keys: &mut Vec<Key>) {
		self.dep_keys.append(dep_keys);
	}

	pub fn add_build_input(&mut self, dep: Expr) {
		self.build_inputs.push(dep)
	}

	pub fn set_src(&mut self, src: Src) {
		self.src = Some(src);
	}
}

#[derive(Debug, Clone)]
pub struct Lock<S: AsSpec> {
	pub context: LockContext,
	pub specs: BTreeMap<Key, S>,
	pub vars: BTreeMap<&'static str, Expr>,
}

impl<S: AsSpec> Lock<S> {
	pub fn new(context: LockContext) -> Lock<S> {
		Lock {
			context,
			specs: BTreeMap::new(),
			vars: BTreeMap::new(),
		}
	}

	pub fn add_impl(&mut self, k: Key, v: S) {
		self.specs.insert(k, v);
	}

	pub fn set_root(&mut self, root: Root) {
		self.context.root = root;
	}
}
