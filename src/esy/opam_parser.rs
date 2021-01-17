use anyhow::*;
use crate::expr;
use crate::expr::Expr;
use crate::esy::opam::NixCtx;
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
type Res<'a, T> = IResult<Src<'a>, T, VerboseError<Src<'a>>>;

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

// <varident>      ::= [ ( <ident> | "_" ) { "+" ( <ident> | "_" ) }* : ] <ident>
fn varident(s: Src) -> Res<Src> {
  recognize(
    tuple((
      alt((ident, underscore_s)),
      many0(tuple((plus, alt((ident, underscore_s)))))
    ))
  )(s)
}

// <operator>      ::= { "!" | "=" | "<" | ">" | "|" | "&" }+ | [ ":" ] <operator> [ ":" ]
// TODO I don't understand the [":"] ... part. Does it mean optionally preceded and optionally followed?
// Note operator seems unused in practice, this is essentially relop from a package formula / version formula
// <relop>           ::= "=" | "!=" | "<" | "<=" | ">" | ">="
fn binary_op(s: Src) -> Res<Src> {
  context("binop", alt((
    tag("="),
    tag("!="),
    tag("<="),
    tag(">="),
    tag("<"),
    tag(">"),
  )))(s)
}

// <logop>           ::= "&" | "|"
fn logop(s: Src) -> Res<Src> {
  alt((tag("&"), tag("|")))(s)
}

// #[derive(Debug, Clone)]
// pub enum VersionFormula<'a> {
//   Not(Box<VersionFormula<'a>>),
//   Binop(Box<VersionFormula<'a>>, char, Box<VersionFormula<'a>>),
//   Op(Src<'a>, String),
// }
// // <version-formula> ::= <version-formula> <logop> <version-formula>
// //                       | "!" <version-formula>
// //                       | "(" <version-formula> ")"
// //                       | <relop> <version>
// // TODO: ws
// fn version_formula(s: Src) -> Res<VersionFormula> {
//   map(
//     tuple((
//       alt((
//         map(tuple((ws(relop), string)), |(relop, v)| VersionFormula::Op(relop, v)),
//         map(preceded(ws(tag("!")), version_formula), |v| VersionFormula::Not(Box::new(v))),
//         delimited(ws(char('(')), version_formula, ws(char(')'))),
//       )),
//       opt(tuple((ws(logop), version_formula)))
//     )),
//     |(a, op_and_b)| {
//       match op_and_b {
//         None => a,
//         Some((op, b)) => VersionFormula::Binop(Box::new(a), op, Box::new(b)),
//       }
//     }
//   )(s)
// }

fn string_char(s: Src) -> Res<char> {
  alt((
    none_of("\"\\"),
    preceded(char('\\'), alt((
      map(char('t'), |_| '\t'),
      map(char('n'), |_| '\n'),
      map(char('\n'), |_| '\n'), // TODO this should consume and return nothing, but it's unlikely to matter for fetlock
      map(char('r'), |_| '\r'),
      map(char('b'), |_| '\t'), // TODO what is \b for?
      map(char('"'), |_| '"'),
      map(char('\\'), |_| '\\')
      // TODO:
      // * three-digit decimal / two-digit hexadecimal character codes (\NNN and \xNN)
    )))
  ))(s)
}

// <string>        ::= ( (") { <char> }* (") ) | ( (""") { <char> }* (""") )
fn quote_string(s: Src) -> Res<Vec<StringComponent>> {
  delimited(char('"'), many0(string_component), char('"'))(s)
}
fn triplequote_string(s: Src) -> Res<Vec<StringComponent>> {
  map(preceded(tag("\"\"\""), many_till(string_component, tag("\"\"\""))),
    |(content, _delim)| content)(s)
}

#[derive(Clone, Debug)]
pub enum StringComponent<'a> {
  Literal(String),
  Expr(Value<'a>),
}

fn string_component(s: Src) -> Res<StringComponent> {
  alt((
    map(interpolation, StringComponent::Expr),
    map(many1(string_char), |v| StringComponent::Literal(v.into_iter().collect()))
  ))(s)
}

impl StringComponent<'_> {
  fn into_nix(self, c: &NixCtx) -> Result<expr::StringComponent> {
    use StringComponent::*;
    match self {
      Literal(s) => Ok(expr::StringComponent::Literal(s)),
      Expr(e) => Ok(expr::StringComponent::Expr(e.into_nix(c)?)),
    }
  }
}

fn interpolation(s: Src) -> Res<Value> {
  delimited(tag("%{"), ws(value), tag("}%"))(s)
}

fn string(s: Src) -> Res<Vec<StringComponent>> {
  context("string",
    alt((triplequote_string, quote_string)),
  )(s)
}

/// A combinator that takes a parser `inner` and produces a parser that also consumes both leading and 
/// trailing whitespace, returning the output of `inner`.
fn ws<'a, F: 'a, O>(inner: F) -> impl FnMut(Src<'a>) -> Res<O>
  where F: FnMut(Src<'a>) -> Res<O>,
{
  delimited(filler, inner, filler)
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

#[derive(Debug, Clone)]
pub struct Logop<'a> {
  pub a: Value<'a>,
  pub op: Src<'a>,
  pub b: Value<'a>,
}

#[derive(Debug, Clone)]
pub struct ValueWithOption<'a> {
  pub value: Value<'a>,
  pub options: Vec<Value<'a>>
}

#[derive(Debug, Clone)]
pub enum Value<'a> {
  String(Vec<StringComponent<'a>>),
  Bool(bool),
  Int(isize),
  Ident(Src<'a>),
  Varident(Src<'a>),
  Op(Src<'a>),
  List(Vec<Value<'a>>),
  // Composite(Box<Value<'a>>, Vec<ValueSuffix<'a>>),
  Logop(Box<Logop<'a>>),
  Option(Box<ValueWithOption<'a>>),
}

impl<'a> Value<'a> {
  pub fn into_nix(self, c: &NixCtx) -> Result<Expr> {
    use Value::*;
    Ok(match self {
      // TODO coalesce interpolated values which collapse to a concrete string value
      String(x) => {
        let parts = x.into_iter()
          .map(|x| x.into_nix(c))
          .collect::<Result<Vec<expr::StringComponent>>>()?;
        Expr::StrInterp(parts)
      },
      Bool(x) => Expr::Literal(format!("{}", x)),
      Int(x) => Expr::Literal(format!("{}", x)),
      Ident(x) => c.resolve(x),
      Varident(x) => todo!(), // lookup in ctx
      Op(x) => todo!(), // unsupported
      Logop(x) => todo!(), // unsupported
      Option(x) => todo!(), // unsupported
      List(x) => {
        let exprs = x.into_iter().map(|x| x.into_nix(c)).collect::<Result<Vec<Expr>>>()?;
        Expr::List(exprs)
      }
    })
  }
}



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
fn unary_op(s: Src) -> Res<Src> {
  alt((tag("!"), tag("?")))(s)
}
fn value(s: Src) -> Res<Value> {
  map(
    tuple((
      alt((
        map(string, Value::String),
        map(bool_, Value::Bool),
        map(int, Value::Int),
        map(ident, Value::Ident),
        map(varident, Value::Varident),
        map(binary_op, Value::Op),
        map(unary_op, Value::Op),
        // map(logop, Value::Op),
        map(list, Value::List),
        // map(version_formula, Value::VersionFormula),
        delimited(ws(char('(')), value, ws(char(')'))),
      )),
      opt(ws(value_options)),
      opt(tuple((ws(logop), value))),
    )),
    |(mut value, options, logop)| {
      match options {
        Some(options) => value = Value::Option(Box::new(ValueWithOption {
          value, options
        })),
        None => (),
      }
      match logop {
        Some((op, value2)) => Value::Logop(Box::new(Logop {
          a: value,
          op,
          b: value2,
        })),
        None => value,
      }
    }
  )(s)
}

// #[derive(Debug, Clone)]
// pub enum ValueSuffix<'a> {
//   Logop(Src<'a>, Value<'a>),
//   Option(Vec<Value<'a>>),
// }
// <option>        ::= <value> "{" { <value> }* "}"
// We implement this as "value optionally followed by value_suffix", otherwise
// the value parse is ambiguous
fn value_options(s: Src) -> Res<Vec<Value>> {
  delimited(ws(char('{')), many0(ws(value)), ws(char('}')))(s)
}

// <list>          ::= "[" { <value> }* "]"
fn list(s: Src) -> Res<Vec<Value>> {
  context("list",
    delimited(ws(char('[')),
    many0(ws(value)),
    // many0(ws(map(int, Value::Int))),
    ws(char(']')))
  )(s)
}

#[derive(Clone, Debug)]
pub struct FieldBinding<'a> {
  pub ident: Src<'a>,
  pub value: Value<'a>,
}

// <field-binding> ::= <ident> : <value>
fn field_binding(s: Src) -> Res<FieldBinding> {
  context("field_binding", map(
    separated_pair(ident, context("colon", ws(char(':'))), ws(value)),
    |(ident, value)| FieldBinding { ident, value }
  ))(s)
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

#[derive(Clone, Debug)]
pub enum FileItem<'a> {
  Section(Section<'a>),
  FieldBinding(FieldBinding<'a>),
}

#[derive(Clone, Debug)]
pub struct Section<'a> {
  pub ident: Src<'a>,
  pub string: Option<Vec<StringComponent<'a>>>,
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

#[derive(Clone, Debug)]
pub enum Term<'a> {
  String(Vec<StringComponent<'a>>),
  Varident(Src<'a>)
}
// <term>          ::= <string> | <varident>
fn term(s: Src) -> Res<Term> {
  alt((
    map(string, Term::String),
    map(varident, Term::Varident),
  ))(s)
}

pub fn entire_file(s: Src) -> Res<Vec<FileItem>> {
  all_consuming(file_contents)(s)
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

  #[test]
  fn test_string_subparsers() {
    valid(quote_string, r#""hello""#);
    valid(triplequote_string, r#""""hello""""#);
  }

  #[test]
  fn test_string() {
    valid(string, r#""""hello""""#);
    valid(string, r#""hello""#);
  }

  #[test]
  fn test_field_binding() {
    valid(field_binding, r#"foo: """hello""""#);
    valid(field_binding, r#"foo: "hello""#);
    valid(field_binding, r#"foo: true"#);
  }

  #[test]
  fn test_list() {
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
  fn test_value() {
    valid(value, r#""cppo" {build & >= "1.1.0"}"#);
    valid(binary_op, ">=");
    valid(value, r#">="#);
    valid(many0(ws(value)), r#">= "4.08.0""#);
    valid(value, r#""ocaml" {>= "4.08.0"}"#);
    valid(value, "1 | 2");
    valid(value, r#""1" | "2""#);
    valid(value, r#""pkga" | "pkgb""#);
    valid(value, r#""pkga" {>= "4.10.0"} | "pkgb""#);
    valid(value, r#""ocaml" {>= "4.10.0"} | "ocaml-syntax-shims""#);
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
    valid(entire_file, r#"foo: """hello""""#);
    valid(entire_file, r#"foo: true"#);
    valid(entire_file, r#"description: """desc""""#);
    valid(entire_file, r#"
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