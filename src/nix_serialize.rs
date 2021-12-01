// writes Expr objects to a stream

use crate::expr::*;
use crate::lock::*;
use crate::hash::NixHash;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use std::collections::BTreeMap;
use std::fmt;
use std::fmt::Debug;
use std::io::{Result, Write};
use std::ops::Deref;

pub struct WriteContext<'a, W: Write> {
	file: &'a mut W,
	indent: usize,
	empty_line: bool, // after `nl`, no indent or content written
}

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
enum StringMode {
	DoubleQuote,
	Multiline,
}

impl StringMode {
	pub fn preferred(s: &str) -> StringMode {
		if s.contains('\n') {
			StringMode::Multiline
		} else {
			StringMode::DoubleQuote
		}
	}

	pub fn preferred_v(s: &Vec<StringComponent>) -> StringMode {
		let mut preferred = s.iter().map(|part| match part {
			StringComponent::Literal(s) => Self::preferred(s),
			StringComponent::Expr(_) => StringMode::DoubleQuote,
		});
		if preferred.any(|p| p == StringMode::Multiline) {
			StringMode::Multiline
		} else {
			StringMode::DoubleQuote
		}
	}
}

impl WriteContext<'_, Vec<u8>> {
	pub fn string<F: FnOnce(&mut WriteContext<Vec<u8>>) -> Result<()>>(
		f: F,
	) -> anyhow::Result<String> {
		let mut expr = Vec::new();
		let mut out = WriteContext::<Vec<u8>>::initial(&mut expr);
		f(&mut out)?;
		Ok(String::from_utf8(expr)?)
	}

	pub fn sink<W: Write, F: FnOnce(&mut WriteContext<W>) -> Result<()>>(
		mut w: W,
		f: F,
	) -> anyhow::Result<()> {
		let mut out = WriteContext::initial(&mut w);
		f(&mut out)?;
		Ok(())
	}
}

impl<W: Write> WriteContext<'_, W> {
	pub fn initial<'a>(file: &'a mut W) -> WriteContext<'a, W> {
		WriteContext {
			file,
			indent: 0,
			empty_line: true,
		}
	}

	fn write<'a>(&mut self, args: fmt::Arguments<'a>) -> Result<()> {
		if self.empty_line {
			for _ in 0..self.indent {
				write!(self.file, "  ")?;
			}
			self.empty_line = false;
		}
		self.file.write_fmt(args)
	}

	pub fn write_str(&mut self, s: &str) -> Result<()> {
		self.write(format_args!("{}", s))
	}

	fn write_char(&mut self, c: char) -> Result<()> {
		self.write(format_args!("{}", c))
	}

	fn space(&mut self) -> Result<()> {
		if !self.empty_line {
			write!(self.file, " ")?
		}
		Ok(())
	}

	fn nl(&mut self) -> Result<()> {
		self.empty_line = true;
		write!(self.file, "\n")
	}

	fn write_nix_string_inner<V: fmt::Display>(&mut self, mode: StringMode, v: &V) -> Result<()> {
		let s = format!("{}", v);
		match mode {
			StringMode::DoubleQuote => {
				/*
				The special characters " and \ and the character sequence ${ must be escaped by prefixing them with a backslash (\).
				Newlines, carriage returns and tabs can be written as \n, \r and \t, respectively.
				*/
				let mut chars = s.chars();
				while let Some(ch) = chars.next() {
					match ch {
						'\n' => write!(self.file, "\\n")?,
						'\r' => write!(self.file, "\\r")?,
						'\t' => write!(self.file, "\\t")?,
						'"' | '\\' => {
							write!(self.file, "\\")?;
							write!(self.file, "{}", ch)?;
						}
						'$' => {
							let next = chars.next();
							if next == Some('{') {
								write!(self.file, "{}", "\\${")?;
							} else {
								write!(self.file, "{}", ch)?;
								if let Some(n) = next {
									write!(self.file, "{}", n)?;
								}
							}
						}
						other => write!(self.file, "{}", ch)?,
					}
				}
				Ok(())
			}
			StringMode::Multiline => {
				/* TODO
				$ can be escaped by prefixing it with '' (that is, two single quotes), i.e., ''$.
				'' can be escaped by prefixing it with ', i.e., '''.
				$ removes any special meaning from the following  (i.e. $$).
				Linefeed, carriage-return and tab characters can be written as ''\n, ''\r, ''\t, and ''\ escapes any other character.
				*/
				let mut chars = s.chars();
				while let Some(ch) = chars.next() {
					match ch {
						'\n' => {
							self.nl()?;
						}
						'$' => {
							let next = chars.next();
							if next == Some('{') {
								self.write_str("''${")?;
							} else {
								self.write_char(ch)?;
								if let Some(n) = next {
									self.write_char(n)?;
								}
							}
						}
						'\'' => {
							let next = chars.next();
							if next == Some('\'') {
								self.write_str("'''")?;
							} else {
								self.write_char(ch)?;
								if let Some(n) = next {
									self.write_char(n)?;
								}
							}
						}
						other => self.write_char(ch)?,
					}
				}
				Ok(())
			}
		}
	}

	fn write_nix_string<V: fmt::Display>(&mut self, v: &V) -> Result<()> {
		let mode = StringMode::DoubleQuote;
		self.wrap_nix_string(mode, |c| c.write_nix_string_inner(mode, v))
	}

	fn wrap_nix_string(
		&mut self,
		mode: StringMode,
		f: impl Fn(&mut WriteContext<W>) -> Result<()>,
	) -> Result<()> {
		match mode {
			StringMode::DoubleQuote => self.bracketed_with(false, "\"", "\"", f),
			StringMode::Multiline => self.bracketed_with(true, "''", "''", f),
		}
	}

	fn bracketed_with(
		&mut self,
		indent: bool,
		open: &str,
		close: &str,
		f: impl FnOnce(&mut WriteContext<W>) -> Result<()>,
	) -> Result<()> {
		self.write_str(open)?;
		if indent {
			self.indent += 1;
		}
		f(self)?;
		if indent {
			self.indent -= 1;
			self.nl()?;
		}
		self.write_str(close)
	}

	fn bracket(&mut self, f: impl FnOnce(&mut WriteContext<W>) -> Result<()>) -> Result<()> {
		self.bracketed_with(false, "(", ")", f)
	}

	fn bracket_attrs(&mut self, f: impl FnOnce(&mut WriteContext<W>) -> Result<()>) -> Result<()> {
		self.bracketed_with(true, "{", "}", f)
	}

	fn bracket_list(&mut self, f: impl FnOnce(&mut WriteContext<W>) -> Result<()>) -> Result<()> {
		self.bracketed_with(true, "[", "]", f)
	}

	fn bracket_attr<K: fmt::Display>(
		&mut self,
		k: &K,
		f: impl FnOnce(&mut WriteContext<W>) -> Result<()>,
	) -> Result<()> {
		lazy_static! {
			static ref VALID_IDENTIFIER: Regex = Regex::new(r"^[a-zA-Z_][-a-zA-Z_0-9]*$").unwrap();
		}
		self.nl()?;
		let repr = format!("{}", k);
		if VALID_IDENTIFIER.is_match(&repr) {
			self.write_str(&repr)?;
		} else {
			self.write_nix_string(k)?;
		}
		self.bracketed_with(false, " = ", ";", f)
	}

	fn attr<K: fmt::Display, V: Writeable>(&mut self, k: &K, v: &V) -> Result<()> {
		self.bracket_attr(k, |c| v.write_to(c))
	}

	fn list_item<V: Writeable>(&mut self, v: &V) -> Result<()> {
		self.nl()?;
		// TODO only bracket complex expressions
		self.bracket(|c| v.write_to(c))
	}

	fn fn_arg<V: Writeable>(&mut self, v: &V) -> Result<()> {
		self.space()?;
		// TODO only bracket complex expressions
		self.bracket(|c| v.write_to(c))
	}

	fn path_component(&mut self, p: &str) -> Result<()> {
		self.write(format_args!(".{}", p))
	}
}

pub trait Writeable: Debug {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()>;
}

impl Writeable for Expr {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		match self {
			Expr::Literal(s) => c.write_str(s),
			Expr::LitSeq(parts) => {
				let mut first = true;
				for part in parts {
					if first {
						first = false;
					} else {
						c.write_char(' ')?;
					}
					part.write_to(c)?;
				}
				Ok(())
			}
			Expr::Null => c.write_str("null"),
			Expr::Bool(b) => c.write(format_args!("{}", b)),
			Expr::Str(s) => {
				let mode = StringMode::preferred_v(&s);
				c.wrap_nix_string(mode, |c| {
					for part in s {
						match part {
							StringComponent::Literal(s) => c.write_nix_string_inner(mode, s)?,
							StringComponent::Expr(e) => {
								c.write_str("${")?;
								e.write_to(c)?;
								c.write_str("}")?;
							}
						}
					}
					Ok(())
				})
			}
			Expr::Identifier(s) => c.write_str(s),
			Expr::AttrSet(h) => h.write_to(c),
			Expr::FunCall(fc) => {
				let FunCall { subject, args } = &(fc.deref());
				c.write_str("(")?;
				subject.write_to(c)?;
				for a in args.iter() {
					c.write_str(" ")?;
					a.write_to(c)?;
				}
				c.write_str(")")?;
				Ok(())
			}
			Expr::AttrPath(p) => {
				let AttrPath { subject, attr_path } = &(p.deref());
				c.write_str("(")?;
				subject.write_to(c)?;
				for p in attr_path.iter() {
					c.write_str(".")?;
					c.write_str(p)?;
				}
				c.write_str(")")?;
				Ok(())
			}
			Expr::List(l) => l.write_to(c),
		}
	}
}

impl Writeable for LockContext {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		let LockContext {
			lock_type,
			root,
			extra,
		} = self;
		c.bracket_attrs(|c| {
			c.attr(&"type", lock_type)?;
			c.attr(&"version", &Self::version())?;
			c.attr(&"root", &root.key())?;
			for (k, v) in extra.iter() {
				c.attr(k, v)?;
			}
			Ok(())
		})
	}
}

impl Writeable for Spec {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		let Spec {
			id,
			dep_keys,
			extra,
			src,
			digest,
			..
		} = self;
		let Id { name, version } = id;
		c.bracket_attrs(|c| {
			c.attr(&"pname", &DrvName::new(name))?;
			c.attr(&"version", &DrvName::new(version))?;
			c.attr(&"depKeys", dep_keys)?;

			let build_inputs = self.build_inputs();
			if build_inputs.len() > 0 {
				c.attr(&"buildInputs", &Expr::List(build_inputs))?;
			}

			match src {
				Src::None => (),
				Src::RelativePath(p) => {
					let nix_path = format!("{}/.", p.strip_suffix('/').unwrap_or(p));
					c.attr(&"src", &Expr::FunCall(FunCall::new(
						Expr::Literal("final.pathSrc".to_owned()),
						vec!(Expr::Literal(nix_path))
					)))?;
				},
				_ => {
					if let Some(digest) = digest.as_ref() {
						c.attr(&"src", &SrcDigest::new(src, digest))?;
					} else {
						warn!("digest missing for source: {:?}", src);
					}
				}
			};

			for (k, v) in extra.iter() {
				c.attr(k, v)?;
			}
			Ok(())
		})
	}
}

impl Writeable for SrcDigest<'_> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		// This could be more efficient if written directly, but we need the
		// Expr implementation in order to store sources in hashmaps etc
		self.as_expr().write_to(c)
	}
}

/* Simple delegating implementations for various string-like types and wrappers.
 * We could achieve this by an impl for Display, but we're not allowed to
 */
impl Writeable for Type {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.write_nix_string(self)
	}
}

impl Writeable for Key {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.write_nix_string(self)
	}
}

impl<T: Writeable> Writeable for &T {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		self.deref().write_to(c)
	}
}

impl Writeable for NixHash {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.write_nix_string(self)
	}
}

impl Writeable for &str {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.write_nix_string(self)
	}
}

impl Writeable for String {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.write_nix_string(self)
	}
}

impl Writeable for DrvName<'_> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.write_nix_string(self)
	}
}

pub fn write_iter<V: Writeable, I: Iterator<Item = V>, W: Write>(
	it: I,
	c: &mut WriteContext<W>,
) -> Result<()> {
	c.bracket_list(move |c| {
		for v in it {
			c.list_item(&v)?;
		}
		Ok(())
	})
}

impl<V: Writeable> Writeable for Vec<V> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		write_iter(self.iter(), c)
	}
}

impl<V: Writeable> Writeable for Box<V> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		self.deref().write_to(c)
	}
}

impl<K: fmt::Display + Debug + Clone, V: Writeable> Writeable for BTreeMap<K, V> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.bracket_attrs(|c| {
			for (k, v) in self.iter() {
				c.attr(k, v)?;
			}
			Ok(())
		})
	}
}

impl<S: AsSpec> Writeable for Lock<S> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		let Lock {
			context,
			vars,
			specs,
		} = self;
		c.write_str("final:")?;
		c.nl()?;
		c.write_str("let")?;
		c.indent += 1;
		c.nl()?;
		c.write_str("pkgs = final.pkgs;")?;
		for (k, v) in vars {
			c.nl()?;
			c.write(format_args!("{} = ", k))?;
			v.write_to(c)?;
			c.write_char(';')?;
		}
		c.indent -= 1;
		c.nl()?;
		c.write_str("in")?;
		c.nl()?;

		c.bracket_attrs(|c| {
			c.attr(&"context", context)?;
			// Ideally we could implement Writeable<S: AsSpec> and then use the BTreeMap impl,
			// but rust won't let us
			c.bracket_attr(&"specs", |c| {
				c.bracket_attrs(|c| {
					for (name, spec) in specs {
						c.attr(name, spec.as_spec_ref())?;
					}
					Ok(())
				})
			})
		})
	}
}
