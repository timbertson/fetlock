use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct FunCall {
	fun: Expr,
	args: Vec<Expr>,
}

#[derive(Debug, Clone)]
pub enum Expr {
	Literal(String),
	FunCall(Box<FunCall>),
	AttrSet(HashMap<String, Box<Expr>>),
	List(Vec<Box<Expr>>),
}
