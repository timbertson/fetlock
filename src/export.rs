use crate::expr::Expr;

enum Type {
	Esy
}

struct Id {
	name: String,
	version: String,
}

impl Id {
	fn version(v: Option<String>) -> String = v.unwrap_or_else(||"development".to_owned())
}

struct Context {
	version: String,
	lockType: Type,
	toplevel: Vec<Id>,
	extra: HashMap<String, Expr>,
}

struct Impl {
	id: Id,
	src: Expr,
	deps: Vec<Id>,
	extra: HashMap<String, Impl>,
}

struct Lock {
	version: String,
	context: Context,
	implementations: HashMap<String, Impl>,
}
