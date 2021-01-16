use anyhow::*;
use log::*;

use nom::{
  *,
  error::VerboseError,
  error::convert_error,
  bytes::complete::*,
  character::complete::*,
  branch::*,
  multi::*,
  combinator::*,
  sequence::*};

type Res<'a, T> = IResult<&'a str, T, VerboseError<&'a str>>;

#[derive(Clone, Debug)]
pub struct Opam {
}

// <bool>          ::= true | false
fn bool_(s: &str) -> Res<bool> {
  let t = map(tag("true"), |_| true);
  let f = map(tag("false"), |_| false);
  alt((t,f))(s)
}

fn is_digit(c: char) -> bool {
  c.is_digit(10)
}

// <digit>         ::= "0".."9"
fn uint_(s: &str) -> Res<isize> {
  map_res(take_while(is_digit), |d| isize::from_str_radix(d, 10))(s)
}

fn dash(s: &str) -> Res<char> {
  char('-')(s)
}

// <int>           ::= [ "-" ] { <digit> }+
fn int(s: &str) -> Res<isize> {
  let neg = map(preceded(dash, uint_), |i| -i);
  alt((neg, uint_))(s)
}

// <letter>        ::= "a".."z" | "A".."Z"
fn letter(s: &str) -> Res<char> {
  satisfy(|ch| ch.is_alphabetic())(s)
}

fn underscore(s: &str) -> Res<char> {
  char('_')(s)
}

fn underscore_s(s: &str) -> Res<&str> {
  tag("_")(s)
}

fn plus(s: &str) -> Res<char> {
  char('+')(s)
}

// <identchar>     ::= <letter> | <digit>  | "_" | "-"
fn ident_char(s: &str) -> Res<char> {
  let alphanumeric = satisfy(|c| c.is_alphabetic() || is_digit(c));
  alt((alphanumeric, underscore, dash))(s)
}

// <ident>         ::= { <identchar> }* <letter> { <identchar> }*
fn ident(s: &str) -> Res<&str> {
  recognize(
    tuple((many0(ident_char), letter, many0(ident_char)))
  )(s)
}

// <varident>      ::= [ ( <ident> | "_" ) { "+" ( <ident> | "_" ) }* : ] <ident>
fn varident(s: &str) -> Res<&str> {
  recognize(
    tuple((
      alt((ident, underscore_s)),
      many0(tuple((plus, alt((ident, underscore_s)))))
    ))
  )(s)
}

// <operator>      ::= { "!" | "=" | "<" | ">" | "|" | "&" }+ | [ ":" ] <operator> [ ":" ]
// TODO I don't understand the [":"] ... part. Does it mean optionally preceded and optionally followed?
fn operator(s: &str) -> Res<&str> {
  alt((
    tag("!"),
    tag("="),
    tag("<"),
    tag(">"),
    tag("|"),
    tag("&"),
    tag("="),
    tag("="),
    tag("="),
    tag("=")
  ))(s)
}

fn string_char(s: &str) -> Res<char> {
  alt((
    satisfy(|ch| ch != '"'),
    preceded(char('\\'), alt((
      map(char('t'), |_| '\t'),
      map(char('n'), |_| '\n'),
      map(char('\n'), |_| '\n'), // TODO this should consume and return nothing, but it's unlikely to matter for fetlock
      map(char('r'), |_| '\r'),
      // map(char('b'), |_| '\b'), ???
      map(char('"'), |_| '"'),
      map(char('\\'), |_| '\\')
      // TODO:
      // * three-digit decimal / two-digit hexadecimal character codes (\NNN and \xNN)
    )))
  ))(s)
}

// <string>        ::= ( (") { <char> }* (") ) | ( (""") { <char> }* (""") )
// TODO: backtracking?
fn string(s: &str) -> Res<String> {
  map(alt((
    delimited(tag("\"\"\""), many0(alt((char('"'), string_char))), tag("\"\"\"")),
    delimited(char('"'), many0(string_char), char('"')),
  )), |v| v.into_iter().collect())(s)
}

#[derive(Debug, Clone)]
pub enum Value<'a> {
  String(String),
  Bool(bool),
  Int(isize),
  Ident(&'a str),
  Varident(&'a str),
  Op(&'a str),
  List(Vec<Value<'a>>),
  Option(Box<OptionValue<'a>>),
}

/// A combinator that takes a parser `inner` and produces a parser that also consumes both leading and 
/// trailing whitespace, returning the output of `inner`.
fn ws<'a, F: 'a, O>(inner: F) -> impl FnMut(&'a str) -> Res<O>
  where F: FnMut(&'a str) -> Res<O>,
{
  delimited(filler, inner, filler)
}

/// We discard comments anywhere whitespace is allowed
fn filler(s: &str) -> Res<()> {
  discard(delimited(multispace0, comment, multispace0))(s)
}

fn discard<'a, F: 'a, O>(inner: F) -> impl FnMut(&'a str) -> Res<()>
  where
  F: FnMut(&'a str) -> Res<O>,
{
  map(inner, |_| ())
}

// <value>         ::= <bool> | <int> | <string> | <ident> | <varident>
//                   | <operator> | <list> | <option> | "(" <value> ")"
fn value(s: &str) -> Res<Value> {
  alt((
    map(string, Value::String),
    map(bool_, Value::Bool),
    map(int, Value::Int),
    map(ident, Value::Ident),
    map(varident, Value::Varident),
    map(operator, Value::Op),
    map(list, Value::List),
    delimited(ws(char('(')), value, ws(char(')'))),
    map(option, |opt| Value::Option(Box::new(opt))),
  ))(s)
}

#[derive(Debug, Clone)]
pub struct OptionValue<'a> {
  head: Value<'a>,
  tail: Vec<Value<'a>>,
}
// <option>        ::= <value> "{" { <value> }* "}"
fn option(s: &str) -> Res<OptionValue> {
  map(
    tuple((value, delimited(ws(char('{')), many0(ws(value)), ws(char('}'))))),
    |(head, tail)| OptionValue { head, tail }
  ) (s)
}


// <list>          ::= "[" { <value> }* "]"
fn list(s: &str) -> Res<Vec<Value>> {
  delimited(ws(char('[')), many0(ws(value)), ws(char(']')))(s)
}

#[derive(Clone, Debug)]
pub struct FieldBinding<'a> {
  ident: &'a str,
  value: Value<'a>,
}

// <field-binding> ::= <ident> : <value>
fn field_binding(s: &str) -> Res<FieldBinding> {
  map(
    separated_pair(ident, ws(char(':')), ws(value)),
    |(ident, value)| FieldBinding { ident, value }
  )(s)
}

// <comment>       ::= ( "(*" { <char> }* "*)" ) | ( "#" { <char\newline> }* <newline> )
// TODO backtrack
fn ocaml_comment(s: &str) -> Res<()> {
  discard(tuple((
    tag("(*"),
    many_till(anychar, tag("*)")),
  )))(s)
}

fn line_comment(s: &str) -> Res<()> {
  discard(tuple((
    char('#'),
    satisfy(|ch| ch != '\n'),
    char('\n')
  )))(s)
}
fn comment(s: &str) -> Res<()> {
  alt((ocaml_comment, line_comment))(s)
}

#[derive(Clone, Debug)]
pub enum FileItem<'a> {
  Section(Section<'a>),
  FieldBinding(FieldBinding<'a>),
}

#[derive(Clone, Debug)]
pub struct Section<'a> {
  ident: &'a str,
  string: Option<String>,
  contents: Vec<FileItem<'a>>,
}
// <section>       ::= <ident> [ <string> ] "{" <file-contents> "}"
fn section(s: &str) -> Res<Section> {
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
fn file_contents(s: &str) -> Res<Vec<FileItem>> {
  many0(alt((
    map(field_binding, FileItem::FieldBinding),
    map(section, FileItem::Section))))(s)
}

#[derive(Clone, Debug)]
pub enum Term<'a> {
  String(String),
  Varident(&'a str)
}
// <term>          ::= <string> | <varident>
fn term(s: &str) -> Res<Term> {
  alt((
    map(string, Term::String),
    map(varident, Term::Varident),
  ))(s)
}

fn entire_file(s: &str) -> Res<Vec<FileItem>> {
  all_consuming(file_contents)(s)
}

// public struct
impl Opam {
  pub fn from_str(contents: &str) -> Result<Vec<FileItem>> {
    let (_, opam) = entire_file(contents).map_err(|e| {
      match e {
        Err::Incomplete(_) => { panic!() },
        Err::Error(e) | Err::Failure(e) => {
          error!(
            "Parse error - trace:\n{}",
            convert_error(contents, e)
          );
        }
      }
      anyhow!("opam parse failed")
    })?;
    Ok(opam)
  }
}