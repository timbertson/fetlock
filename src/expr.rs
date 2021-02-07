use anyhow::*;
use lazy_static::lazy_static;
use regex::Regex;
use std::collections::HashMap;
use std::fmt;

static S_TRUE: &str = "true";
static S_FALSE: &str = "false";

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FunCall {
	pub subject: Expr,
	pub args: Vec<Expr>,
}

impl FunCall {
	pub fn new(subject: Expr, args: Vec<Expr>) -> Box<FunCall> {
		Box::new(FunCall { subject, args })
	}
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct AttrPath {
	pub subject: Expr,
	pub attr_path: Vec<String>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum StringComponentOf<T: fmt::Debug + Clone + PartialEq + Eq> {
	Literal(String),
	Expr(T),
}

impl<T: fmt::Debug + Clone + Eq> StringComponentOf<T> {
	pub fn map_result<R, F>(self, f: F) -> Result<StringComponentOf<R>> 
		where F: Fn(T) -> Result<R>, R: fmt::Debug + Clone + Eq
	{
		match self {
			StringComponentOf::Literal(s) => Ok(StringComponentOf::Literal(s)),
			StringComponentOf::Expr(t) => Ok(StringComponentOf::Expr(f(t)?)),
		}
	}

	pub fn map<R, F>(self, f: F) -> StringComponentOf<R> 
		where F: Fn(T) -> R, R: fmt::Debug + Clone + Eq
	{
		match self {
			StringComponentOf::Literal(s) => StringComponentOf::Literal(s),
			StringComponentOf::Expr(t) => StringComponentOf::Expr(f(t)),
		}
	}
}

pub type StringComponent = StringComponentOf<Expr>;

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Expr {
	LitSeq(Vec<Expr>),
	Literal(String),
	Bool(bool),
	// TODO combine two string types
	Str(Vec<StringComponent>),
	Identifier(String),
	FunCall(Box<FunCall>),
	AttrPath(Box<AttrPath>),
	AttrSet(HashMap<String, Box<Expr>>),
	List(Vec<Expr>),
}

impl Expr {
	pub fn str(s: String) -> Expr {
		Expr::Str(vec!(StringComponent::Literal(s)))
	}

	pub fn is_list(&self) -> bool {
		match self {
			Expr::List(_) => true,
			_ => false,
		}
	}

	pub fn get_drv(key: String) -> Self {
		// TODO this is a bit lazy, we could just inline `final.pkgs."key"` but it needs another Expr type
		Expr::FunCall(Box::new(FunCall {
			subject: Expr::Literal("final.getDrv".to_owned()),
			args: vec!(Expr::str(key))
		}))
	}

	pub fn canonicalize(self) -> Self {
		use Expr::*;
		match self {
			Str(components) => {
				let coerced_to_string = components.into_iter().map(|part|
					part.map(|expr| match expr.canonicalize() {
						Expr::Bool(b) => Expr::str(format!("{}", b)),
						other => other,
					})
				).collect::<Vec<StringComponent>>();

				let as_plain_string: Result<Vec<&str>, ()> = coerced_to_string.iter().map(|part|
					match part {
						StringComponent::Literal(s) => Ok(s.as_str()),
						StringComponent::Expr(_) => Err(()),
					}
				).collect();
				match as_plain_string {
					Ok(parts) => Expr::str(parts.join("")),
					Err(()) => Str(coerced_to_string),
				}
			},
			other => other
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
		f.write_str(&UNSAFE_CHARS.replace_all(&self.0, "-").trim_matches('-'))
	}
}