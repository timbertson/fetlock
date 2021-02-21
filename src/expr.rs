use anyhow::*;
use lazy_static::lazy_static;
use regex::Regex;
use std::collections::BTreeMap;
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

pub trait StringMerge: fmt::Debug + Clone + PartialEq + Eq {
	fn into_string_components(self) -> Result<Vec<StringComponentOf<Self>>, Self>;
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum StringComponentOf<T: fmt::Debug + Clone + PartialEq + Eq> {
	Literal(String),
	Expr(T),
}

impl<X: fmt::Debug + Clone + PartialEq + Eq> StringComponentOf<X> {
	fn push_literal<T: StringMerge>(dest: &mut Vec<StringComponentOf<T>>, s: String) -> () {
		match dest.last_mut() {
			Some(StringComponentOf::Literal(dest)) => dest.push_str(&s),
			_ => dest.push(StringComponentOf::Literal(s)),
		}
	}

	pub fn append<T: StringMerge>(
		dest: &mut Vec<StringComponentOf<T>>,
		v: StringComponentOf<T>,
	) -> () {
		match v {
			StringComponentOf::Literal(s) => Self::push_literal(dest, s),
			StringComponentOf::Expr(e) => match e.into_string_components() {
				Ok(components) => components
					.into_iter()
					.for_each(|part| Self::append(dest, part)),
				Err(e) => dest.push(StringComponentOf::Expr(e)),
			},
		}
	}

	pub fn as_static_string(parts: &Vec<StringComponentOf<X>>) -> Result<String, ()> {
		let mut literals = Vec::new();
		for v in parts {
			match v {
				StringComponentOf::Literal(l) => literals.push(l.as_str()),
				StringComponentOf::Expr(_) => return Err(()),
			}
		}
		Ok(literals.join(""))
	}
}

impl<T: fmt::Debug + Clone + Eq> StringComponentOf<T> {
	pub fn map_result<R, F>(self, f: F) -> Result<StringComponentOf<R>>
	where
		F: Fn(T) -> Result<R>,
		R: fmt::Debug + Clone + Eq,
	{
		match self {
			StringComponentOf::Literal(s) => Ok(StringComponentOf::Literal(s)),
			StringComponentOf::Expr(t) => Ok(StringComponentOf::Expr(f(t)?)),
		}
	}

	pub fn map<R, F>(self, f: F) -> StringComponentOf<R>
	where
		F: Fn(T) -> R,
		R: fmt::Debug + Clone + Eq,
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
	Str(Vec<StringComponent>),
	Identifier(String),
	FunCall(Box<FunCall>),
	AttrPath(Box<AttrPath>),
	AttrSet(BTreeMap<String, Box<Expr>>),
	List(Vec<Expr>),
}

impl Expr {
	pub fn str(s: String) -> Expr {
		Expr::Str(vec![StringComponent::Literal(s)])
	}

	pub fn is_list(&self) -> bool {
		match self {
			Expr::List(_) => true,
			_ => false,
		}
	}

	pub fn flatten(self) -> Expr {
		match self {
			Expr::List(_) => {
				let mut dest = Vec::new();
				self.flatten_into(&mut dest);
				Expr::List(dest)
			}
			other => other,
		}
	}

	pub fn flatten_into(self, dest: &mut Vec<Expr>) -> () {
		match self {
			Expr::List(l) => {
				for item in l {
					item.flatten_into(dest);
				}
			}
			other => {
				dest.push(other);
			}
		}
	}

	pub fn needs_bash_quotes(&self) -> bool {
		match self {
			Expr::Str(parts) => parts.iter().any(|part| {
				match part {
					// weak test for now, can be improved
					StringComponent::Literal(s) => s.contains(|ch| ch == ' ' || ch == '"'),
					StringComponent::Expr(e) => e.needs_bash_quotes(),
				}
			}),
			Expr::Bool(_) => false,
			_ => true,
		}
	}

	pub fn escape_for_bash(self) -> Self {
		match self {
			Expr::Str(parts) => Expr::Str(
				parts
					.into_iter()
					.map(|part| match part {
						StringComponent::Literal(s) => {
							StringComponent::Literal(s.replace('\\', r#"\\"#).replace('"', r#"\""#))
						}
						StringComponent::Expr(e) => StringComponent::Expr(e.escape_for_bash()),
					})
					.collect(),
			),

			Expr::List(v) => Expr::List(v.into_iter().map(|v| v.escape_for_bash()).collect()),
			Expr::LitSeq(v) => Expr::LitSeq(v.into_iter().map(|v| v.escape_for_bash()).collect()),

			Expr::Bool(_)
			| Expr::Identifier(_)
			| Expr::Literal(_)
			| Expr::AttrPath(_)
			| Expr::FunCall(_)
			| Expr::AttrSet(_) => self,
		}
	}

	pub fn get_drv(key: String) -> Self {
		// TODO this is a bit lazy, we could just inline `final.pkgs."key"` but it needs another Expr type
		Expr::FunCall(Box::new(FunCall {
			subject: Expr::Literal("final.getDrv".to_owned()),
			args: vec![Expr::str(key)],
		}))
	}

	pub fn canonicalize(self) -> Self {
		use Expr::*;
		match self {
			Str(components) => {
				let mut dest = Vec::new();
				for v in components {
					StringComponent::append(&mut dest, v);
				}
				Str(dest)
			}
			other => other,
		}
	}
}

impl StringMerge for Expr {
	fn into_string_components(self) -> Result<Vec<StringComponent>, Self> {
		match self {
			Self::Str(components) => Ok(components),
			Self::Bool(b) => Ok(vec![StringComponent::Literal(format!("{}", b))]),
			expr => Err(expr),
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
