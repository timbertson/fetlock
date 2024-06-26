use crate::expr::{Expr, FunCall};
use crate::hash::NixHash;
use crate::{path_util, url_util};
use anyhow::*;
use serde::de::{Deserialize, Deserializer};
use std::borrow::Borrow;
use std::collections::BTreeMap;
use std::fmt;
use std::fmt::Debug;
use std::iter::Iterator;
use std::path::PathBuf;

#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub enum Type {
	Esy,
	Opam,
	Yarn,
	Bundler,
	Cargo,
	Gomod,
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
			Gomod => "gomod",
		})
	}
}

// newtype for a package key
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Key(String);
impl Borrow<str> for Key {
	fn borrow(&self) -> &str {
		self.0.as_str()
	}
}

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

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
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

impl From<Id> for PartialId {
	fn from(id: Id) -> Self {
		let Id { name, version } = id;
		PartialId { name: Some(name), version: Some(version) }
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
}

#[derive(Debug, Clone)]
pub struct GithubRepo {
	pub owner: String,
	pub repo: String,
	pub private: bool,
}

impl GithubRepo {
	pub fn new(owner: String, repo: String) -> Self {
		Self { owner, repo, private: false }
	}

	pub fn for_rev(&self, rev: String) -> Github {
		Github {
			repo: self.clone(),
			git_ref: rev,
			fetch_submodules: false,
		}
	}
}

impl GitUrl for GithubRepo {
	fn git_url(&self) -> String {
		let owner = url_util::encode(&self.owner);
		let repo = url_util::encode(&self.repo);
		if self.private {
			format!("git+ssh://git@github.com/{}/{}", owner, repo)
		} else {
			format!("https://github.com/{}/{}.git", owner, repo)
		}
	}
}

#[derive(Debug, Clone)]
pub struct GitRepo {
	url: Url,
}

impl GitRepo {
	pub fn new(url: Url) -> Self {
		Self { url }
	}
}

impl GitUrl for GitRepo {
	fn git_url(&self) -> String {
		self.url.0.clone()
	}
}

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
}

impl Archive {
	pub fn new(s: String) -> Self {
		Self {
			name: None,
			url: Url::new(s),
		}
	}
}

// A buildable src. Only accepts Fetch not FetchSpec,
// ensuring all fetched sources have a nix hash
#[derive(Debug, Clone)]
pub enum Src {
	Fetch(Fetch),

	// Local paths are rendered as relative to the root
	// derivation's src when rendered to a nix expression.
	// At nix generation time, this is relative to the working
	// directory.
	Local(LocalPath),

	None
}

impl Src {
	pub fn fetch(&self) -> Option<&Fetch> {
		match self {
			Self::Fetch(f) => Some(f),
			_ => None
		}
	}
}

struct LocalPathRender<'a> {
	is_abs: bool,
	is_dir: bool,
	path: &'a PathBuf,
}

#[derive(Debug, Clone)]
pub struct LocalPath(pub PathBuf);
impl LocalPath {
	pub fn from_string(s: String) -> Self {
		LocalPath(PathBuf::from(s))
	}

	pub fn relative(self) -> Option<Self> {
		if self.0.is_relative() {
			Some(self)
		} else {
			None
		}
	}
	
	pub fn abs_expr_nonportable(&self) -> Result<Expr> {
		Self::expr_raw(LocalPathRender {
			is_abs: true,
			is_dir: self.0.is_dir(),
			path: &std::fs::canonicalize(&self.0)?
		})
	}

	fn expr_raw(render: LocalPathRender) -> Result<Expr> {
		let s = path_util::to_str(render.path)?;
		let prefix = if render.is_abs || s.starts_with('.') { "" } else { "./" };
		let suffix = if render.is_dir { "/." } else { "" };
		let nix_path = format!("{}{}{}", prefix, s, suffix);
		Ok(Expr::FunCall(FunCall::new(
			Expr::Literal("final.pathSrc".to_owned()),
			vec!(Expr::Literal(nix_path))
		)))
	}

	pub fn as_expr(&self) -> Result<Expr> {
		if self.0.is_absolute() {
			return Err(anyhow!("Attempted to use absolute path in nix expression {:?}", &self.0));
		}
		Self::expr_raw(LocalPathRender {
			is_abs: false,
			is_dir: self.0.is_dir(),
			path: &self.0
		})
	}
}

// A fixed-output src (including hash)
#[derive(Debug, Clone)]
pub struct Fetch {
	pub spec: FetchSpec,
	pub hash: NixHash,
}

impl Fetch {
	pub fn new(spec: FetchSpec, hash: NixHash) -> Self {
		Fetch { spec, hash }
	}

	pub fn as_ref(&self) -> FetchSpecRef {
		FetchSpecRef { spec: &self.spec, hash: &self.hash }
	}

	pub fn as_expr(&self) -> Expr {
		self.as_ref().as_expr()
	}
}

#[derive(Debug, Clone, Copy)]
pub struct FetchSpecRef<'a> {
	pub spec: &'a FetchSpec,
	pub hash: &'a NixHash,
}

impl<'a> FetchSpecRef<'a> {
	pub fn as_expr(self) -> Expr {
		match &self.spec {
			FetchSpec::Github(github) => {
				let Github {
					repo,
					git_ref,
					fetch_submodules,
				} = github;
				let mut attrs = vec![
					("rev", Expr::str(git_ref.to_owned())),
					("hash", Expr::str(self.hash.sri_string())),
				];

				if *fetch_submodules {
					attrs.push(("fetchSubmodules", Expr::Bool(true)));
				}

				if repo.private {
					attrs.push(("url", Expr::str(repo.git_url())));
					Expr::fun_call(
						Expr::Literal("final.fetchGitBuiltin".to_owned()),
						vec![Expr::attr_set(attrs)],
					)
				} else {
					let GithubRepo { owner, repo, private: _ } = repo;
					attrs.push(("owner", Expr::str(owner.to_owned())));
					attrs.push(("repo", Expr::str(repo.to_owned())));
					Expr::fun_call(
						Expr::Literal("pkgs.fetchFromGitHub".to_owned()),
						vec![Expr::attr_set(attrs)],
					)
				}

			},

			FetchSpec::Archive(archive) => {
				let Archive { url, name } = archive;
				let mut attrs = vec![
					("url", Expr::str(url.0.to_owned())),
					("hash", Expr::str(self.hash.sri_string())),
				];
				if let Some(name) = name {
					attrs.push(("name", Expr::str(name.to_owned())));
				}

				Expr::fun_call(
					Expr::Literal("pkgs.fetchurl".to_owned()),
					vec![Expr::attr_set(attrs)],
				)
			},

			FetchSpec::Custom(c) => {
				let mut attrs = c.attrs.clone();
				attrs.insert("hash".to_owned(), Expr::str(self.hash.sri_string()));
				Expr::FunCall(Box::new(FunCall {
					subject: Expr::Literal(format!("final.{}", &c.fn_name)),
					args: vec!(Expr::AttrSet(attrs))
				}))
			},
		}
	}
}

#[derive(Debug, Clone)]
pub enum FetchSpec {
	Github(Github),
	Archive(Archive),
	Custom(CustomFetch),
}

#[derive(Debug, Clone)]
pub enum AnySrc {
	Full(Src),
	Partial(FetchSpec),
}

impl AnySrc {
	pub fn fetch(fetch: FetchSpec, hash: Option<NixHash>) -> Self {
		match hash {
			None => Self::Partial(fetch),
			Some(hash) => Self::Full(Src::Fetch(Fetch::new(fetch, hash))),
		}
	}

	pub fn require_full(&self) -> Result<&Src> {
		match self {
			Self::Full(f) => Ok(f),
			Self::Partial(partial) => Err(anyhow!("Nix digest not populated, this is a bug in fetlock: {:?}", partial)),
		}
	}

	pub fn partial(&self) -> Option<&FetchSpec> {
		match self {
			Self::Full(_) => None,
			Self::Partial(f) => Some(f),
		}
	}

	pub fn fetch_spec(&self) -> Option<&FetchSpec> {
		match self {
			Self::Partial(f) => Some(f),
			Self::Full(Src::Fetch(f)) => Some(&f.spec),
			Self::Full(Src::None) => None,
			Self::Full(Src::Local(_)) => None,
		}
	}

	pub fn extension(&self) -> Option<&str> {
		match self.fetch_spec() {
			Some(FetchSpec::Archive(archive)) => {
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
	
	pub fn as_expr(&self) -> Result<Expr> {
		match self {
			AnySrc::Full(src) => match src {
				Src::None => Ok(Expr::Null),
				Src::Local(local) => local.as_expr(),
				Src::Fetch(fetch) => Ok(fetch.as_expr()),
			},
			AnySrc::Partial(p) => {
				Err(anyhow!("Attempted to serialize src without digest: {:?}", self))
			},
		}
	}
}

#[derive(Clone)]
pub struct CustomFetch {
	pub fn_name: &'static str,
	pub cache_key: Option<String>,
	pub attrs: BTreeMap<String, Expr>,
}

impl Debug for CustomFetch {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		f.write_fmt(format_args!("CustomFetch({}, {})",
			&self.fn_name,
			self.cache_key.as_deref().unwrap_or("[uncacheable]")
		))
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
	pub src: AnySrc,
	pub extra: BTreeMap<String, Expr>,
}

impl Spec {
	pub fn set_src(&mut self, src: Src) {
		self.src = AnySrc::Full(src);
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
	pub src: Option<AnySrc>,
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

	pub fn set_fetch_src(&mut self, src: FetchSpec) {
		self.src = Some(AnySrc::Partial(src));
	}

	pub fn set_src(&mut self, src: Src) {
		self.src = Some(AnySrc::Full(src));
	}

	pub fn set_any_src(&mut self, src: AnySrc) {
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
