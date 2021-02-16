use anyhow::*;
use crate::expr::{Expr, StringComponentOf};
use crate::esy::eval::{NixCtx, Eval};
use nom::{
  *,
  error::VerboseError,
  error::convert_error,
  error::context,
  bytes::complete::*,
  character::complete::*,
  branch::*,
  multi::*,
  combinator::*,
  sequence::*};

type Src<'a> = &'a str;
type SrcError<'a> = VerboseError<Src<'a>>;
type Res<'a, T> = IResult<Src<'a>, T, SrcError<'a>>;
trait SrcParser<'a, T>: Parser<Src<'a>, T, SrcError<'a>> {}
impl<'a, T, P> SrcParser<'a, T> for P where P: Parser<Src<'a>, T, SrcError<'a>> {
}

// <bool>          ::= true | false
fn bool_(s: Src) -> Res<bool> {
  let t = map(tag("true"), |_| true);
  let f = map(tag("false"), |_| false);
  alt((t,f))(s)
}

fn is_digit(c: char) -> bool {
  c.is_digit(10)
}

// <digit>         ::= "0".."9"
fn uint_(s: Src) -> Res<isize> {
  map_res(take_while(is_digit), |d| isize::from_str_radix(d, 10))(s)
}

fn dash(s: Src) -> Res<char> {
  char('-')(s)
}

// <int>           ::= [ "-" ] { <digit> }+
fn int(s: Src) -> Res<isize> {
  let neg = map(preceded(dash, uint_), |i| -i);
  alt((neg, uint_))(s)
}

// <letter>        ::= "a".."z" | "A".."Z"
fn letter(s: Src) -> Res<char> {
  satisfy(|ch| ch.is_alphabetic())(s)
}

fn underscore(s: Src) -> Res<char> {
  char('_')(s)
}

fn underscore_s(s: Src) -> Res<Src> {
  tag("_")(s)
}

fn plus(s: Src) -> Res<char> {
  char('+')(s)
}

// <identchar>     ::= <letter> | <digit>  | "_" | "-"
fn ident_char(s: Src) -> Res<char> {
  let alphanumeric = satisfy(|c| c.is_alphabetic() || is_digit(c));
  alt((alphanumeric, underscore, dash))(s)
}

// <ident>         ::= { <identchar> }* <letter> { <identchar> }*
fn ident(s: Src) -> Res<Src> {
  context("Ident", recognize(
    tuple((many_till(ident_char, letter), many0(ident_char)))
  ))(s)
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Varident<'a> {
  pub scope: Src<'a>,
  pub additional_scopes: Vec<Src<'a>>,
  pub ident: Src<'a>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Op {
  Eq,
  Neq,
  Lte,
  Gte,
  Lt,
  Gt,
  And,
  Or,
  Not,
  Question,
  // Used in esy
  Slash,
  Colon,
}
// <operator>      ::= { "!" | "=" | "<" | ">" | "|" | "&" }+ | [ ":" ] <operator> [ ":" ]
// TODO I don't understand the [":"] ... part. Does it mean optionally preceded and optionally followed?
// Note operator seems unused in practice, this is essentially relop from a package formula / version formula
// <relop>           ::= "=" | "!=" | "<" | "<=" | ">" | ">="
// <logop>           ::= "&" | "|"
fn basic_op(s: Src) -> Res<Op> {
  context("op", alt((
    map(tag("=="), |_| Op::Eq),
    map(tag("!="), |_| Op::Neq),
    map(tag("<="), |_| Op::Lte),
    map(tag(">="), |_| Op::Gte),
    map(tag("<"), |_| Op::Lt),
    map(tag(">"), |_| Op::Gt),
    map(tag("="), |_| Op::Eq),
    map(tag("!"), |_| Op::Not),
    map(tag("/"), |_| Op::Slash),
  )))(s)
}

fn logic_op(s: Src) -> Res<Op> {
  context("op", alt((
    map(tag("&"), |_| Op::And),
    map(tag("|"), |_| Op::Or),
  )))(s)
}

fn question(s: Src) -> Res<Op> {
  map(tag("?"), |_| Op::Question)(s)
}
fn colon(s: Src) -> Res<Op> {
  map(tag(":"), |_| Op::Colon)(s)
}

fn escaped_char(s: Src) -> Res<char> {
  preceded(char('\\'), alt((
    map(char('t'), |_| '\t'),
    map(char('n'), |_| '\n'),
    map(char('\n'), |_| '\n'), // TODO this should consume and return nothing, but it's unlikely to matter for fetlock
    map(char('r'), |_| '\r'),
    map(char('b'), |_| '\t'), // TODO what is \b for?
    map(char('"'), |_| '"'),
    map(char('\''), |_| '\''),
    map(char('\\'), |_| '\\'),
    // TODO:
    // * three-digit decimal / two-digit hexadecimal character codes (\NNN and \xNN)
  )))(s)
}


pub enum StringAtom<'a> {
  Char(char),
  Expr(Value<'a>),
}

struct CoalesceState<'a> {
  _result: Vec<OpamSC<'a>>,
  _pending: Option<String>,
}

// TODO can this be generalised so that we can also coalesce nix strings?
impl<'a> CoalesceState<'a> {
  pub fn drain_pending(&mut self) {
    if let Some(prev) = self._pending.take() {
      self._result.push(OpamSC::Literal(prev));
    }
  }

  pub fn push_expr(&mut self, v: Value<'a>) {
    self.drain_pending();
    self._result.push(OpamSC::Expr(v));
  }

  pub fn push_char(&mut self, c: char) {
    self._pending.get_or_insert_with(|| String::new()).push(c);
  }

  pub fn result(mut self) -> Vec<OpamSC<'a>> {
    self.drain_pending();
    self._result
  }
  
  pub fn new() -> Self {
    Self { _result: Vec::new(), _pending: None }
  }
}

impl<'a> StringAtom<'a> {
  fn coalesce(atoms: Vec<Self>) -> Vec<OpamSC<'a>> {
    let mut state = CoalesceState::new();
    for atom in atoms {
      match atom {
        StringAtom::Expr(e) => state.push_expr(e),
        StringAtom::Char(c) => state.push_char(c),
      }
    }
    state.result()
  }
}

pub type OpamSC<'a> = StringComponentOf<Value<'a>>;

/// A combinator that takes a parser `inner` and produces a parser that also consumes both leading and 
/// trailing whitespace, returning the output of `inner`.
fn ws<'a, F: 'a, O>(inner: F) -> impl FnMut(Src<'a>) -> Res<O>
  where F: SrcParser<'a, O>
{
  delimited(filler, inner, filler)
}

// <comment>       ::= ( "(*" { <char> }* "*)" ) | ( "#" { <char\newline> }* <newline> )
fn ocaml_comment(s: Src) -> Res<()> {
  discard(tuple((
    tag("(*"),
    many_till(anychar, tag("*)")),
  )))(s)
}

fn newline_or_eof(s: Src) -> Res<()> {
  discard(alt((tag("\n"), eof)))(s)
}

fn line_comment(s: Src) -> Res<()> {
  discard(tuple((
    char('#'),
    many0(satisfy(|ch| ch != '\n')),
    newline_or_eof,
  )))(s)
}
fn comment(s: Src) -> Res<()> {
  alt((ocaml_comment, line_comment))(s)
}


/// We discard comments anywhere whitespace is allowed
fn filler(s: Src) -> Res<()> {
  discard(many0(alt((discard(space1), discard(newline), comment))))(s)
}

fn discard<'a, F: 'a, O>(inner: F) -> impl FnMut(Src<'a>) -> Res<()>
  where
  F: FnMut(Src<'a>) -> Res<O>,
{
  map(inner, |_| ())
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Binop<'a> {
  pub a: Value<'a>,
  pub op: Op,
  pub b: Value<'a>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Ternop<'a> {
  pub test: Value<'a>,
  pub iftrue: Value<'a>,
  pub iffalse: Value<'a>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ValueWithOption<'a> {
  pub value: Value<'a>,
  pub option: Value<'a>
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Value<'a> {
  String(Vec<OpamSC<'a>>),
  Bool(bool),
  Int(isize),
  Ident(Src<'a>),
  Varident(Varident<'a>),
  List(Vec<Value<'a>>),
  // Composite(Box<Value<'a>>, Vec<ValueSuffix<'a>>),
  UnaryOp(Op, Box<Value<'a>>),
  Binop(Box<Binop<'a>>),
  Ternop(Box<Ternop<'a>>),
  Option(Box<ValueWithOption<'a>>),
}

impl<'a> Value<'a> {
  pub fn literal(s: &str) -> Value {
    // used in tests
    Value::String(vec!(OpamSC::Literal(s.to_owned())))
  }

  pub fn into_nix<'c: 'a, C: NixCtx>(self, c: &'c C) -> Result<Expr> {
    Ok(Eval::evaluate(self, c)?.into_nix(c)?.canonicalize())
  }

	pub fn is_list(&self) -> bool {
		match self {
			Value::List(_) => true,
			_ => false,
		}
	}
}

#[derive(Debug, Clone)]
pub struct Dialect<I,O,E> {
  base: fn(I) -> IResult<I,O,E>
}

type SrcDialect<'a> = Dialect<Src<'a>, Value<'a>, SrcError<'a>>;


// A dialect parser is any parser that depends on a dialect
// (but `fn` must be a static function pointer, not a closure)
#[derive(Debug, Clone)]
pub struct DialectParser<I,O1,O2,E>
{
  dialect: Dialect<I,O1,E>,
  f: fn(Dialect<I,O1,E>, I) -> IResult<I,O2,E>,
}

// explicit impl required to relax default `Copy` condition on generic params to `Clone`
impl <I: Clone,O: Clone,E: Clone> Copy for Dialect<I,O,E> {}
impl <I: Clone,O1: Clone,O2: Clone,E: Clone> Copy for DialectParser<I,O1,O2,E> {}

impl<I: Clone, O1: Clone, O2: Clone, E: Clone> Parser<I,O2,E> for DialectParser<I,O1,O2,E> {
  fn parse(&mut self, input: I) -> IResult<I,O2,E> {
    (self.f)(self.dialect, input)
  }
}

mod dialect {
  use super::*;

  pub fn parser<'a, I,O1, O2, E>(
    dialect: Dialect<I,O1,E>, f: fn(Dialect<I,O1,E>, I) -> IResult<I,O2,E>)
    -> DialectParser<I,O1,O2,E> {
    DialectParser { dialect, f }
  }

  // #[derive(Debug, Clone, PartialEq, Eq)]
  // pub enum ValueSuffix<'a> {
  //   Logop(Src<'a>, Value<'a>),
  //   Option(Vec<Value<'a>>),
  // }
  // <option>        ::= <value> "{" { <value> }* "}"
  // We implement this as "value optionally followed by value_suffix", otherwise
  // the value parse is ambiguous
  fn value_option<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    let value = parser(d, value);
    delimited(ws(char('{')), value, ws(char('}')))(s)
  }

  pub fn list<'a>(d: Dialect<Src<'a>, Value<'a>, SrcError<'a>>, s: Src<'a>) -> Res<'a, Vec<Value<'a>>> {
    let value = parser(d, value);
    context("list",
      delimited(ws(char('[')),
      many0(ws(value)),
      ws(char(']')))
    )(s)
  }

  // lvl0 is plain values, without operators
  pub fn value_lvl0<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    let value_lvl0 = parser(d, value_lvl0);
    let value = parser(d, value);
    let value_option = parser(d, value_option);
    let list = parser(d, list);
    map(
      tuple((
        alt((
          map(bool_, Value::Bool),
          map(int, Value::Int),
          d.base,
          map(ident, Value::Ident),
          map(list, Value::List),
          delimited(ws(char('(')), value, ws(char(')'))),
        )),
        opt(value_option),
      ))
      , |(mut value, option)| {
        if let Some(option) = option {
          value = Value::Option(Box::new(ValueWithOption {
            value, option
          }))
        }
        value
      }
    )(s)
  }

  pub fn value_lvl1<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    // lvl0 or unary op
    let value_lvl0 = parser(d, value_lvl0);
    let value = parser(d, value);
    alt((
      map(
        tuple((basic_op, ws(value))),
        |(op, value)| Value::UnaryOp(op, Box::new(value))
      ),
      value_lvl0
    ))(s)
  }

  pub fn value_lvl2<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    // lvl1 or comparison binop
    let lvl1 = parser(d, value_lvl1);
    let lvl2 = parser(d, value_lvl2);
    alt((
      map(
        tuple((lvl1, ws(basic_op), lvl2)),
        |(a, op, b)| Value::Binop(Box::new(Binop { a, op, b }))
      ),
      lvl1
    ))(s)
  }

  pub fn value_lvl3<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    // lvl2 or logic binop
    let lvl2 = parser(d, value_lvl2);
    let lvl3 = parser(d, value_lvl3);
    alt((
      map(
        tuple((lvl2, ws(logic_op), lvl3)),
        |(a, op, b)| Value::Binop(Box::new(Binop { a, op, b }))
      ),
      lvl2
    ))(s)
  }

  pub fn value_lvl4<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    // lvl3 or ternop
    let lvl3 = parser(d, value_lvl3);
    let lvl4 = parser(d, value_lvl4);
    alt((
      map(
        tuple((
          lvl3,
          preceded(ws(question), lvl4),
          preceded(ws(colon), lvl4),
        )),
        |(test, iftrue, iffalse)| Value::Ternop(Box::new(Ternop { test, iftrue, iffalse }))
      ),
      lvl3
    ))(s)
  }

  pub fn value_lvl5<'a>(d: SrcDialect<'a>, s: Src<'a>) -> Res<'a, Value<'a>> {
    // lvl4 or colon binop (note: only valid for esy, hopefully doesn't affect opam parsing)
    let lvl4 = parser(d, value_lvl4);
    let lvl5 = parser(d, value_lvl5);
    alt((
      map(
        tuple(( lvl4, ws(colon), lvl5)),
        |(a, op, b)| Value::Binop(Box::new(Binop { a, op, b }))
      ),
      lvl4
    ))(s)
  }

  pub fn value<'a>(d: Dialect<Src<'a>, Value<'a>, SrcError<'a>>, s: Src<'a>) -> Res<'a, Value<'a>> {
    value_lvl5(d, s)
  }
}


pub mod opam {
  use super::*;

  // <value>         ::= <bool> | <int> | <string> | <ident> | <varident>
  //                   | <operator> | <list> | <option> | "(" <value> ")"
  // For convenience, value is also used to express filters & dependency filters:
  //
  // <filter> ::= <filter> <logop> <filter>
  //            | "!" <filter>
  //            | "?" <filter>
  //            | ( <filter> )
  //            | <filter> <relop> <filter>
  //            | <varident>
  //            | <string>
  //            | <int>
  //            | <bool>
  // 
  // <filtered-package-formula> ::= <filtered-package-formula> <logop> <filtered-package-formula>
  //                              | ( <filtered-package-formula> )
  //                              | <pkgname> { { <filtered-version-formula> }* }
  // 
  // <filtered-version-formula> ::= <filtered-version-formula> <logop> <filtered-version-formula>
  //                              | "!" <filtered-version-formula>
  //                              | "?" <filtered-version-formula>
  //                              | "(" <filtered-version-formula> ")"
  //                              | <relop> <version>
  //                              | <filter>
  //                              | <relop> <filter>
  //
  pub fn base(s: Src) -> Res<Value> {
    alt((
      map(string, Value::String),
      map(varident, Value::Varident),
    ))(s)
  }

  pub fn value(s: Src) -> Res<Value> {
    let d = Dialect { base };
    dialect::parser(d, dialect::value).parse(s)
  }

  pub fn list(s: Src) -> Res<Vec<Value>> {
    let d = Dialect { base };
    dialect::parser(d, dialect::list).parse(s)
  }

  // #[derive(Debug, Clone, PartialEq, Eq)]
  // pub enum ValueSuffix<'a> {
  //   Logop(Src<'a>, Value<'a>),
  //   Option(Vec<Value<'a>>),
  // }
  // <option>        ::= <value> "{" { <value> }* "}"
  // We implement this as "value optionally followed by value_suffix", otherwise
  // the value parse is ambiguous
  pub fn value_option(s: Src) -> Res<Value> {
    delimited(ws(char('{')), value, ws(char('}')))(s)
  }

  pub fn interpolation(s: Src) -> Res<Value> {
    delimited(tag("%{"), ws(value), tag("}%"))(s)
  }

  pub fn string(s: Src) -> Res<Vec<OpamSC>> {
    context("string",
      alt((triplequote_string, quote_string)),
    )(s)
  }

  #[derive(Clone, Debug, PartialEq, Eq)]
  pub struct FieldBinding<'a> {
    pub ident: Src<'a>,
    pub value: Value<'a>,
  }

  // <field-binding> ::= <ident> : <value>
  pub fn field_binding(s: Src) -> Res<FieldBinding> {
    context("field_binding", map(
      separated_pair(ident, context("colon", ws(char(':'))), ws(value)),
      |(ident, value)| FieldBinding { ident, value }
    ))(s)
  }

  #[derive(Clone, Debug, PartialEq, Eq)]
  pub enum FileItem<'a> {
    Section(Section<'a>),
    FieldBinding(FieldBinding<'a>),
  }

  #[derive(Clone, Debug, PartialEq, Eq)]
  pub struct Section<'a> {
    pub ident: Src<'a>,
    pub string: Option<Vec<OpamSC<'a>>>,
    pub contents: Vec<FileItem<'a>>,
  }
  // <section>       ::= <ident> [ <string> ] "{" <file-contents> "}"
  fn section(s: Src) -> Res<Section> {
    map(tuple((
      ident,
      ws(opt(string)),
      delimited(
        ws(char('{')),
        file_contents,
        ws(char('}'))
      )
    )),
    |(ident, string, contents)| Section { ident, string, contents })(s)
  }

  // <file-contents> ::= { <file-item> }*
  // <file-item>     ::= <field-binding> | <section>
  fn file_contents(s: Src) -> Res<Vec<FileItem>> {
    many0(alt((
      map(field_binding, FileItem::FieldBinding),
      map(section, FileItem::Section))))(s)
  }

  #[derive(Clone, Debug, PartialEq, Eq)]
  pub enum Term<'a> {
    String(Vec<OpamSC<'a>>),
    Varident(Varident<'a>)
  }
  // <term>          ::= <string> | <varident>
  fn term(s: Src) -> Res<Term> {
    alt((
      map(string, Term::String),
      map(varident, Term::Varident),
    ))(s)
  }

  pub fn entire_file(s: Src) -> Res<Vec<FileItem>> {
    all_consuming(ws(file_contents))(s)
  }

  fn string_char(s: Src) -> Res<char> {
    alt((
      none_of("\"\\"),
      escaped_char,
    ))(s)
  }

  // <string>        ::= ( (") { <char> }* (") ) | ( (""") { <char> }* (""") )
  pub fn quote_string(s: Src) -> Res<Vec<OpamSC>> {
    delimited(char('"'), map(many0(string_atom), StringAtom::coalesce), char('"'))(s)
  }

  pub fn triplequote_string(s: Src) -> Res<Vec<OpamSC>> {
    map(
      preceded(tag("\"\"\""), many_till(triplequote_string_atom, tag("\"\"\""))),
      |(content, _delim)| StringAtom::coalesce(content)
    )(s)
  }
  fn triplequote_string_atom(s: Src) -> Res<StringAtom> {
    alt((
      map(char('"'), StringAtom::Char),
      string_atom
    ))(s)
  }

  fn string_atom(s: Src) -> Res<StringAtom> {
    alt((
      map(interpolation, StringAtom::Expr),
      map(string_char, StringAtom::Char),
    ))(s)
  }

  // <varident>      ::= [ ( <ident> | "_" ) { "+" ( <ident> | "_" ) }* : ] <ident>
  // TODO treat a+b+c:d as a:d & b:d & c:d
  pub fn varident(s: Src) -> Res<Varident> {
    map(
      tuple((
        alt((ident, underscore_s)),
        many0(preceded(plus, alt((ident, underscore_s)))),
        char(':'),
        ident
      )),
      |(scope, additional_scopes, _, ident)| Varident { scope, additional_scopes, ident }
    )(s)
  }

}

pub mod esy {
  use super::*;

  fn base(s: Src) -> Res<Value> {
    alt((
      map(string, Value::String),
      map(varident, Value::Varident),
      map(envvar, Value::Varident),
    ))(s)
  }

  pub fn value(s: Src) -> Res<Value> {
    let d = Dialect { base };
    dialect::parser(d, dialect::value).parse(s)
  }

  pub fn interpolation(s: Src) -> Res<Value> {
    delimited(tag("#{"), ws(value), tag("}"))(s)
  }

  fn varident(s: Src) -> Res<Varident> {
    map(
      tuple((
        ident,
        char('.'),
        ident
      )),
      |(scope, _, ident)| Varident { scope, additional_scopes: Vec::new(), ident }
    )(s)
  }

  fn envvar(s: Src) -> Res<Varident> {
    map(
      preceded(char('$'), ident),
      |ident| Varident { scope:"$", additional_scopes: Vec::new(), ident }
    )(s)
  }

  pub fn string_inner(s: Src) -> Res<Vec<OpamSC>> {
    map(many0(string_atom), StringAtom::coalesce)(s)
  }

  fn single_string_char(s: Src) -> Res<char> {
    alt((
      none_of("'\\"),
      escaped_char,
    ))(s)
  }

  pub fn string(s: Src) -> Res<Vec<OpamSC>> {
    delimited(char('\''), string_inner, char('\''))(s)
  }

  fn string_atom(s: Src) -> Res<StringAtom> {
    alt((
      map(interpolation, StringAtom::Expr),
      map(single_string_char, StringAtom::Char),
    ))(s)
  }

  pub fn entire_string(s: Src) -> Res<Value> {
    all_consuming(map(esy::string_inner, Value::String))(s)
  }
}

pub fn parse<'a, T, F>(mut p: F, contents: &'a str) -> Result<T>
  where F: FnMut(Src<'a>) -> Res<T> {
  let (_, ret) = p(contents).map_err(|e| {
    let msg: String = match e {
      Err::Incomplete(_) => { panic!() },
      Err::Error(e) | Err::Failure(e) => {
        format!(
          "Parse error - trace:\n{}",
          convert_error(contents, e)
        )
      }
    };
    anyhow!(msg)
  })?;
  Ok(ret)
}

#[cfg(test)]
mod tests {
  use super::*;
  use log::*;
  
  fn valid<'a, T, F>(p: F, contents: &'a str) -> ()
    where F: FnMut(Src<'a>) -> Res<T>, T: std::fmt::Debug {
      match parse(all_consuming(p), contents) {
        Ok(result) => info!("{:?}", result),
        Err(p) => panic!(format!("{}", p)),
      }
  }

  fn p<'a, T, F>(p: F, contents: &'a str) -> T
    where F: FnMut(Src<'a>) -> Res<T>, T: std::fmt::Debug {
      match parse(all_consuming(p), contents) {
        Ok(result) => {
          info!("{:?}", result);
          result
        },
        Err(p) => panic!(format!("{}", p)),
      }
  }

  #[test]
  fn test_string_subparsers() {
    use opam::*;
    valid(quote_string, r#""hello""#);
    valid(triplequote_string, r#""""hello""""#);
    valid(interpolation, "%{1}%");
    valid(interpolation, "%{id}%");
    valid(varident, "lwt:installed");
    valid(interpolation, "%{lwt:installed}%");
    valid(interpolation, "%{conf-m4:installed}%");
  }

  #[test]
  fn test_string() {
    use opam::*;
    valid(string, r#""""hello""""#);
    valid(string, r#""hello""#);
    use StringComponentOf::*;
    assert_eq!(
      p(string, "\"%{1}%\""),
      vec!(Expr(Value::Int(1)))
    );
    assert_eq!(
      p(string, "\"hi %{there}%\""),
      vec!(Literal("hi ".to_owned()), Expr(Value::Ident("there")))
    );
  }

  #[test]
  fn test_field_binding() {
    use opam::*;
    valid(field_binding, r#"foo: """hello""""#);
    valid(field_binding, r#"foo: "hello""#);
    valid(field_binding, r#"foo: true"#);
  }

  #[test]
  fn test_list() {
    use opam::*;
    valid(list, "[1]");
    valid(list, "[1 2 3]");
    valid(list, "[]");
    valid(list, "[ 1 true \"foo\" ]");
  }

  #[test]
  fn test_comment() {
    valid(ocaml_comment, "(* ocaml comment *)");
    valid(comment, "(* hi *)");
    valid(comment, "# hi");
    valid(ws(bool_), "true # hi");
    valid(ws(bool_), r#"#initial
      (* pre-comment *)
      # another comment
      true
      (* more comments *)
      "#);
  }

  #[test]
  fn test_options() {
    use opam::*;
    valid(value_option, "{ foo }");
    valid(value_option, "{ foo & bar }");
    valid(value_option, "{ foo & >= bar }");
  }

  #[test]
  fn test_esy() {
    use esy::*;
    valid(string, "'foo'");
    valid(value, "os == 1");
    valid(interpolation, "#{ os = 'linux'}");
    valid(interpolation, "#{ true ? 1 : 2 }");
    valid(value, "self.bin / 'makeinfo'");
    valid(value, "self.install / 'include' / 'harfbuzz'");
    valid(value, "$PKG_CONFIG_PATH");
    valid(value, "self.lib / 'pkgconfig' : $PKG_CONFIG_PATH");
    valid(entire_string, "ln #{self.bin / 'makeinfo'}");
    assert_eq!(
      p(value, "true == true ? 1 : 2"),
      Value::Ternop(Box::new(Ternop {
        test: Value::Binop(Box::new(Binop {
          a: Value::Bool(true),
          op: Op::Eq,
          b: Value::Bool(true),
        })),
        iftrue: Value::Int(1),
        iffalse: Value::Int(2),
      })),
    );

    valid(interpolation, "#{ os == 'linux' ? 'linux' : 'nope' }");
    valid(string_inner, "#{ os == 'linux' ? 'yeah' : 'nah' }");
  }

  #[test]
  fn test_value() {
    use opam::*;
    valid(value, r#""cppo" {build & >= "1.1.0"}"#);
    valid(many0(ws(value)), r#">= "4.08.0""#);
    valid(value, r#""ocaml" {>= "4.08.0"}"#);
    valid(value, "1 | 2");
    valid(value, r#""1" | "2""#);
    valid(value, r#""pkga" | "pkgb""#);
    valid(value, r#""pkga" {>= "4.10.0"} | "pkgb""#);
    valid(value, r#""ocaml" {>= "4.10.0"} | "ocaml-syntax-shims""#);
    valid(value, r#"arch != "ppc64""#);
    valid(value, r#"[
      "cppo" {build & >= "1.1.0"}
      "dune" {>= "1.8.0"}
      "dune-configurator"
      "mmap" {>= "1.1.0"}
      "ocaml" {>= "4.02.0"}
      ("ocaml" {>= "4.08.0"} | "ocaml-syntax-shims")
      "ocplib-endian"
      "result"
      "seq"
      "ocamlfind" {dev & >= "1.7.3-1"}
    ]"#);
  }

  #[test]
  fn test_entire_file() {
    use opam::*;
    valid(entire_file, r#"foo: """hello""""#);
    valid(entire_file, r#"foo: true"#);
    valid(entire_file, r#"description: """desc""""#);
    valid(entire_file, r#"
      build: [ "dune" "runtest" "-p" name ] {with-test & ocaml:version >= "4.07.0"}
    "#);
    valid(entire_file, r#"
      depends: [
        "mdx" {with-test & >= "1.4" & < "1.6" }
      ]
    "#);
    valid(entire_file, r#"
#leading comment
opam-version: "2.0"
synopsis: "Promises and event-driven I/O"
description: """\
A promise is a value that may become determined in the future.

Lwt provides typed, composable promises. Promises that are resolved by I/O are
resolved by Lwt in parallel.

Meanwhile, OCaml code, including code creating and waiting on promises, runs in
a single thread by default. This reduces the need for locks or other
synchronization primitives. Code can be run in parallel on an opt-in basis."""
maintainer: [
  "Raphaël Proust <code@bnwr.net>" "Anton Bachin <antonbachin@yahoo.com>"
]
authors: ["Jérôme Vouillon" "Jérémie Dimino"]
license: "MIT"
homepage: "https://github.com/ocsigen/lwt"
doc: "https://ocsigen.org/lwt"
bug-reports: "https://github.com/ocsigen/lwt/issues"
depends: [
  "cppo" {build & >= "1.1.0"}
  "dune" {>= "1.8.0"}
  "dune-configurator"
  "mmap" {>= "1.1.0"}
  "ocaml" {>= "4.02.0"}
  ("ocaml" {>= "4.08.0"} | "ocaml-syntax-shims")
  "ocplib-endian"
  "result"
  "seq"
  "ocamlfind" {dev & >= "1.7.3-1"}
]
depopts: ["base-threads" "base-unix" "conf-libev"]
conflicts: [
  "ocaml-variants" {= "4.02.1+BER"}
]
build: [
  [
    "dune"
    "exec"
    "-p"
    name
    "src/unix/config/discover.exe"
    "--"
    "--save"
    "--use-libev"
    "%{conf-libev:installed}%"
  ]
  ["dune" "build" "-p" name "-j" jobs]
]
dev-repo: "git+https://github.com/ocsigen/lwt.git"
url {
  src: "https://github.com/ocsigen/lwt/archive/5.4.0.zip"
  checksum: [
    "md5=fc4721bdb1a01225b96e3a2debde95fa"
    "sha512=e427f08223b77f9af696c9e6f90ff68e27e02e446910ef90d3da542e7b00bf23dd191ac77c1871288faa2289f8d28fc2f44efc3d3fe9165fe1c7a6be88ee49ff"
  ]
}
    "#.trim());
  }
}