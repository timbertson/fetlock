use std::fmt::*;
use std::collections::HashMap;
use crate::expr::Expr;

#[derive(Debug, Copy, Clone)]
pub enum Type {
	Esy
}

#[derive(Debug, Clone)]
pub struct Id {
	name: String,
	version: String,
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
pub struct Context {
	version: String,
	lock_type: Type,
	toplevel: Vec<Id>,
	extra: HashMap<String, Expr>,
}
impl Context {
	pub fn new(lock_type: Type) -> Context {
		Context {
			lock_type,
			version: "TODO".to_owned(),
			toplevel: vec!(),
			extra: HashMap::new(),
		}
	}
}

#[derive(Debug, Clone)]
pub struct Lock {
	context: Context,
	implementations: HashMap<String, Expr>,
}

impl Lock {
	pub fn new(context: Context) -> Lock {
		Lock { context, implementations: HashMap::new() }
	}
}