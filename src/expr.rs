use lazy_static::lazy_static;
use regex::Regex;
use std::collections::HashMap;
use std::fmt;

#[derive(Debug, Clone)]
pub struct FunCall {
	pub subject: Expr,
	pub args: Vec<Expr>,
}

impl FunCall {
	pub fn new(subject: Expr, args: Vec<Expr>) -> Box<FunCall> {
		Box::new(FunCall { subject, args })
	}
}

#[derive(Debug, Clone)]
pub struct AttrPath {
	pub subject: Expr,
	pub attr_path: Vec<String>,
}

#[derive(Debug, Clone)]
pub enum StringComponent {
	Literal(String),
	Expr(Expr),
}

#[derive(Debug, Clone)]
pub enum Expr {
	Literal(String),
	Bool(bool),
	// TODO combine two string types
	Str(String),
	StrInterp(Vec<StringComponent>),
	Identifier(String),
	FunCall(Box<FunCall>),
	AttrPath(Box<AttrPath>),
	AttrSet(HashMap<String, Box<Expr>>),
	List(Vec<Expr>),
}

impl Expr {
	pub fn canonicalize(self) -> Self {
		use Expr::*;
		match self {
			StrInterp(components) => {
				let as_plain_string: Result<Vec<&str>, ()> = components.iter().map(|part|
					match part {
						StringComponent::Literal(s) => Ok(s.as_str()),
						StringComponent::Expr(Expr::Str(s)) => Ok(s.as_str()),
						StringComponent::Expr(_) => Err(()),
					}
				).collect();
				match as_plain_string {
					Ok(parts) => Expr::Str(parts.join("")),
					Err(()) => StrInterp(components),
				}
			},
			other => other
		}
	}
	
	pub fn is_list(&self) -> bool {
		match self {
			Expr::List(_) => true,
			_ => false,
		}
	}
}

#[derive(Debug, Clone)]
pub struct DrvName<'a>(&'a str); // any string used as part of a drvname

impl DrvName<'_> {
	pub fn new<'a>(s: &str) -> DrvName {
		DrvName(s)
	}
}

impl fmt::Display for DrvName<'_> {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		lazy_static! {
			static ref UNSAFE_CHARS: Regex = Regex::new(r"[^-_.0-9a-zA-Z]").unwrap();
		}
		f.write_str(&UNSAFE_CHARS.replace_all(&self.0, "-"))
	}
}