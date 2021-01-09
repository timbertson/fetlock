// writes Expr objects to a stream

use std::io::{Result,Write};
use std::fmt;
use std::ops::Deref;
use std::collections::HashMap;
use regex::Regex;
use lazy_static::lazy_static;
use crate::lock::*;
use crate::expr::*;

pub struct WriteContext<W: Write> {
	file: W,
  indent: usize,
  empty_line: bool, // after `nl`, no indent or content written
}

impl<W: Write> WriteContext<W> {
  pub fn initial(file: W) -> Self {
    Self {
      file, indent: 0, empty_line: true
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

  fn attrs_start(&mut self) -> Result<()> {
    self.write_str("{")?;
    self.indent += 1;
    Ok(())
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

  fn attrs_end(&mut self) -> Result<()> {
    self.indent -= 1;
    self.nl()?;
    self.write_str("}")
  }

  fn attrs<K: fmt::Display, V: Writeable>(&mut self, attrs: &HashMap<K,V>) -> Result<()> {
    self.attrs_start()?;
    for (k,v) in attrs.iter() {
      self.attr(k, v)?;
    }
    self.attrs_end()
  }

  fn list<V: Writeable>(&mut self, attrs: &Vec<V>) -> Result<()> {
    self.write_str("[")?;
    self.indent += 1;
    for v in attrs.iter() {
      self.nl()?;
      // TODO only bracket complex expressions
      self.write_str("(")?;
      v.write_to(self)?;
      self.write_str(")")?;
    }
    self.indent -= 1;
    self.nl()?;
    self.write_str("]")?;
    Ok(())
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
      },
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
      },
      Expr::List(l) => l.write_to(c),
    }
  }
}

impl Writeable for LockContext {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    let LockContext { lock_type, toplevel, extra } = self;
    c.attrs_start()?;
    c.attr(&"type", lock_type)?;
    c.attr(&"version", &Self::version())?;
    c.attr(&"toplevel", toplevel)?;
    for (k,v) in extra.iter() {
      c.attr(k, v)?;
    }
    c.attrs_end()
  }
}

impl Writeable for Impl {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    let Impl { dep_keys, extra, src } = self;
    c.attrs_start()?;
    c.attr(&"depKeys", dep_keys)?;
    c.attr(&"src", src)?;
    for (k,v) in extra.iter() {
      c.attr(k, v)?;
    }
    c.attrs_end()
  }
}

impl Writeable for Src {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    // TODO a bit inefficient
    let expr = match self {
      Src::Github(github) => {
        let Github { repo, git_ref } = github;
        let mut attrs = HashMap::new();
        // TODO break into owner/repo
        attrs.insert("repo".to_owned(), Box::new(Expr::Str(repo.to_string())));
        attrs.insert("rev".to_owned(), Box::new(Expr::Str(git_ref.to_string())));
        Expr::FunCall(FunCall::new(
          Expr::Literal("pkgs.fetchFromGitHub".to_owned()),
          vec!(Expr::AttrSet(attrs)))
        )
      },
      Src::Archive(url) => {
        let mut attrs = HashMap::new();
        attrs.insert("url".to_owned(), Box::new(Expr::Str(url.0.clone())));
        Expr::FunCall(FunCall::new(
          Expr::Literal("pkgs.fetchUrl".to_owned()),
          vec!(Expr::AttrSet(attrs)))
        )
      },
      Src::None => Expr::Literal("null".to_owned()), // TODO better error reporting, assert?
    };
    expr.write_to(c)
  }
}


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

impl Writeable for &str {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    c.write_nix_string(self)
  }
}

impl<V: Writeable> Writeable for Vec<V> {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    c.list(self)
  }
}

impl<V: Writeable> Writeable for Box<V> {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    self.deref().write_to(c)
  }
}

impl<K: fmt::Display, V: Writeable> Writeable for HashMap<K, V> {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    c.attrs(self)
  }
}

impl Writeable for Lock {
  fn write_to<W: Write>(&self, c: &mut WriteContext<W>) -> Result<()> {
    let Lock { context, implementations } = self;
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

    c.attrs_start()?;
    c.attr(&"context", context)?;
    c.attr(&"implementations", implementations)?;
    c.attrs_end()
  }
}
