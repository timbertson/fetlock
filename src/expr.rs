use std::collections::HashMap;

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
pub enum Expr {
	Literal(String),
	Str(String),
	Identifier(String),
	FunCall(Box<FunCall>),
	AttrPath(Box<AttrPath>),
	AttrSet(HashMap<String, Box<Expr>>),
	List(Vec<Box<Expr>>),
}

pub struct DrvName(String); // any string used for a drvname

/*
let unsafe_drvname_chars = Str.regexp "[^-_.0-9a-zA-Z]"
let envvar_of_ident name =	let drvname_safe str =
var_prefix ^ (Str.global_replace unsafe_envvar_chars "_" name)		(Str.global_replace unsafe_drvname_chars "-" str)
*/
