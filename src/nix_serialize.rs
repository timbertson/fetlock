// writes Expr objects to a stream

use crate::expr::*;
use crate::lock::*;
use lazy_static::lazy_static;
use log::*;
use regex::Regex;
use std::collections::HashMap;
use std::fmt;
use std::fmt::Debug;
use std::borrow::Borrow;
use std::io::{Result, Write};
use std::ops::Deref;

pub struct WriteContext<'a, W: Write> {
	file: &'a mut W,
	indent: usize,
	empty_line: bool, // after `nl`, no indent or content written
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

	fn write_str(&mut self, s: &str) -> Result<()> {
		self.write(format_args!("{}", s))
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

	fn write_nix_string<V: fmt::Display>(&mut self, v: &V) -> Result<()> {
		// TODO escape special chars
		self.write_str("\"")?;
		self.write(format_args!("{}", v))?;
		self.write_str("\"")
	}

	fn bracketed_with(
		&mut self,
		indent: bool,
		open: &str,
		close: &str,
		f: impl Fn(&mut WriteContext<W>) -> Result<()>,
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

	fn bracket(&mut self, f: impl Fn(&mut WriteContext<W>) -> Result<()>) -> Result<()> {
		self.bracketed_with(false, "(", ")", f)
	}

	fn bracket_attrs(&mut self, f: impl Fn(&mut WriteContext<W>) -> Result<()>) -> Result<()> {
		self.bracketed_with(true, "{", "}", f)
	}

	fn bracket_list(&mut self, f: impl Fn(&mut WriteContext<W>) -> Result<()>) -> Result<()> {
		self.bracketed_with(true, "[", "]", f)
	}

	fn attr<K: fmt::Display, V: Writeable>(&mut self, k: &K, v: &V) -> Result<()> {
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
		self.write_str(" = ")?;
		v.write_to(self)?;
		self.write_str(";")
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

pub trait Writeable {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()>;
}

impl Writeable for Expr {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		match self {
			Expr::Literal(s) => c.write_str(s),
			Expr::Str(s) => c.write_nix_string(s),
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
			toplevel,
			extra,
		} = self;
		c.bracket_attrs(|c| {
			c.attr(&"type", lock_type)?;
			c.attr(&"version", &Self::version())?;
			c.attr(&"toplevel", toplevel)?;
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
		} = self;
		let Id { name, version } = id;
		c.bracket_attrs(|c| {
			c.attr(&"pname", &DrvName::new(name))?;
			c.attr(&"version", &DrvName::new(version))?;
			c.attr(&"depKeys", dep_keys)?;

			if let Some(digest) = digest.as_ref() {
				c.attr(&"src", &SrcDigest::new(src, digest))?;
			} else {
				if src.requires_digest() {
					warn!("digest missing for source: {:?}", src);
				}
			}

			for (k, v) in extra.iter() {
				c.attr(k, v)?;
			}
			Ok(())
		})
	}
}

impl Writeable for SrcDigest<'_> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		let SrcDigest { src, digest } = self;
		match src {
			Src::Github(github) => {
				let Github {
					owner,
					repo,
					git_ref,
				} = github;
				c.write_str("pkgs.fetchFromGitHub ")?;
				c.bracket_attrs(|c| {
					c.attr(&"owner", &owner)?;
					c.attr(&"repo", &repo)?;
					c.attr(&"rev", &git_ref)?;
					c.attr(&"sha256", digest)
				})
			}
			Src::Archive(url) => {
				c.write_str("pkgs.fetchurl ")?;
				c.bracket_attrs(|c| {
					c.attr(&"url", &url.0)?;
					c.attr(&"sha256", digest)
				})
			}
			Src::None => c.write_str("null"), // TODO better error reporting, assert?
		}
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

impl<T: Writeable> Writeable for dyn Borrow<T> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		self.borrow().write_to(c)
	}
}

impl Writeable for Sha256 {
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

impl<V: Writeable> Writeable for Vec<V> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		c.bracket_list(|c| {
			for v in self.iter() {
				c.list_item(v)?;
			}
			Ok(())
		})
	}
}

impl<V: Writeable> Writeable for Box<V> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		self.deref().write_to(c)
	}
}

impl<K: fmt::Display, V: Writeable> Writeable for HashMap<K, V> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		// TODO: sort keys
		c.bracket_attrs(|c| {
			for (k, v) in self.iter() {
				c.attr(k, v)?;
			}
			Ok(())
		})
	}
}

impl<Spec: Writeable + Debug + Clone> Writeable for Lock<Spec> {
	fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
		let Lock { context, specs } = self;
		c.write_str("final: prev:")?;
		c.nl()?;
		c.write_str("let")?;
		c.nl()?;
		c.indent += 1;
		c.write_str("pkgs = final.pkgs;")?;
		c.indent -= 1;
		c.nl()?;
		c.write_str("in")?;
		c.nl()?;

		c.bracket_attrs(|c| {
			c.attr(&"context", context)?;
			c.attr(&"specs", specs)?;
			Ok(())
		})
	}
}
