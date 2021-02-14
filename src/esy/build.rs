// nix wrapper for build instructions extracted from a manifest,
// whether that be `esy`, `opam` or `npm`

use std::collections::HashMap;
use std::fmt;
use log::*;
use anyhow::*;
use crate::{Expr,StringComponent};
use crate::esy::parser::Value;
use crate::esy::eval::{Eval, NixCtx};

#[derive(Clone, Debug, Copy, PartialEq, Eq)]
pub enum PkgType {
  Esy,
  Opam,
}

#[derive(Debug, Clone)]
pub enum Command<T: fmt::Debug + Clone> {
  Sh(T),
  Argv(Vec<T>),
}

impl<T: fmt::Debug + Clone> Command<T> {
  pub fn map_result<'a, F, R>(&'a self, f: F) -> Result<Command<R>>
    where F: Fn(&'a T) -> Result<R>, R: fmt::Debug + Clone {
    match self {
      Self::Sh(v) => Ok(Command::Sh(f(v)?)),
      Self::Argv(v) => {
        let v = v.into_iter().map(f).collect::<Result<Vec<R>>>();
        Ok(Command::Argv(v?))
      },
    }
  }
}

#[derive(Debug, Clone)]
pub struct Script<T: fmt::Debug+Clone>(pub Vec<Command<T>>);

impl<T: fmt::Debug+Clone> Script<T> {
  pub fn map_result<'a, F, R>(&'a self, f: F) -> Result<Script<R>>
    where F: Copy + Fn(&'a T) -> Result<R>, R: fmt::Debug + Clone {
    let cmds = self.0.iter()
      .map(|cmd| cmd.map_result(f))
      .collect::<Result<Vec<Command<R>>>>()?;
    Ok(Script(cmds))
  }
}

#[derive(Clone, Debug)]
pub struct NixBuild {
  pub mode: PkgType,
  pub build: Option<Expr>,
  pub install: Option<Expr>,
  pub depexts: Option<Expr>,
}

impl NixBuild {
  pub fn empty(mode: PkgType) -> Self {
    Self {
      mode,
      build: None,
      install: None,
      depexts: None,
    }
  }
  
  fn add_sep<T: Clone>(vec: &mut Vec<T>, first: &mut bool, sep: &T) {
    if *first {
      *first = false;
    } else {
      vec.push(sep.clone());
    }
  }

  pub fn coerce_script<'a>(pkg_type: PkgType, expr: Expr) -> Result<Expr> {
    let newline = StringComponent::Literal("\n".to_owned());
    let space = StringComponent::Literal(" ".to_owned());
    
    let add_cmd = |buf: &mut Vec<StringComponent>, args: Vec<Expr>| -> () {
      debug!("adding cmd: {:?}", args);
      let mut first_arg = true;
      for mut arg in args {
        Self::add_sep(buf, &mut first_arg, &space);
        let needs_quotes = arg.needs_bash_quotes();
        if needs_quotes {
          buf.push(StringComponent::Literal("\"".to_owned()));
          arg = arg.escape_for_bash();
        };
        match arg {
          Expr::Str(parts) => buf.extend(parts),
          other => buf.push(StringComponent::Expr(other)),
        };
        if needs_quotes {
          buf.push(StringComponent::Literal("\"".to_owned()));
        };
      }
    };

    let add_cmdline = |buf: &mut Vec<StringComponent>, cmdline: Expr| -> () {
      debug!("adding cmdline: {:?}", cmdline);
      // TODO encapsulate this [attern as `append_to(dest)`?
      match cmdline {
        Expr::Str(parts) => buf.extend(parts),
        other => buf.push(StringComponent::Expr(other)),
      }
    };

    let mut buf = Vec::new();

    match expr {
      Expr::List(cmds) => {
        debug!("toplevel cmds: {:?}", cmds);
        if pkg_type == PkgType::Opam && !cmds.iter().any(|cmd| cmd.is_list()) {
          // opam [ foo bar baz ] means [[ foo bar baz ]],
          // but esy [ foo bar baz ] is [[foo] [bar] [baz]], so we also need to
          // handle cmds that are strings (below)
          add_cmd(&mut buf, cmds)
        } else {
          let mut first_cmd = true;
          if cmds.len() > 1 {
            // always start a multiline string with a newline
            first_cmd = false;
          }

          for cmd in cmds {
            Self::add_sep(&mut buf, &mut first_cmd, &newline);
            debug!("procesing cmd: {:?}", cmd);
            match cmd {
              Expr::List(args) => add_cmd(&mut buf, args),
              _ => add_cmdline(&mut buf, cmd),
            }
          }
        }
      },
      _ => add_cmdline(&mut buf, expr),
    }
    Ok(Expr::Str(buf))
  }

  pub fn script<'a, 'c: 'a, Ctx: NixCtx>(pkg_type: PkgType, ctx: &Ctx, value: Value<'a>) -> Result<Expr> {
    debug!("evaluating script: {:?}", value);
    let r: Result<Expr> = (|| {
      let nix = Eval::evaluate(value.clone(), ctx)?.into_nix(ctx)?.canonicalize();
      Ok(NixBuild::coerce_script(pkg_type, nix)?)
    })();
    r.with_context(|| format!("processing script expression: {:?}", value))
  }

  pub fn expr(self) -> Expr {
    let mut map = HashMap::new();
    let Self { mode, build, install, depexts } = self;
    let mode_str = match mode {
      PkgType::Esy => "esy",
      PkgType::Opam => "opam",
      // PkgType::Node => "node",
    };
    
    map.insert("mode".to_owned(), Box::new(Expr::str(mode_str.to_owned())));

    if let Some(build) = build {
      map.insert("buildPhase".to_owned(), Box::new(build));
    }
    if let Some(install) = install {
      map.insert("installPhase".to_owned(), Box::new(install));
    }
    if let Some(depexts) = depexts {
      map.insert("depexts".to_owned(), Box::new(depexts));
    }
    Expr::AttrSet(map)
  }
}

#[cfg(test)]
mod tests {
  use super::*;
  use Value::*;
  use crate::esy::eval::Ctx;
  use crate::esy::parser::OpamSC;
  type StringComponent = crate::StringComponent;
  
  fn bash(pkg_type: PkgType, cmds: Value) -> Expr {
    let ctx = Ctx::empty("testpkg");
    match NixBuild::script(pkg_type, &ctx, cmds.clone())
      .with_context(||format!("Processing commands: {:?}", cmds)) {
      Ok(expr) => expr.canonicalize(),
      Err(e) => panic!("{:?}", e),
    }
  }

  fn cmd(pkg_type: PkgType, cmd: Vec<Value>) -> Expr {
    bash(pkg_type, List(vec!(List(cmd))))
  }

  fn coerce_bash(pkg_type: PkgType, cmds: Expr) -> Expr {
    match NixBuild::coerce_script(pkg_type, cmds.clone())
      .with_context(||format!("Processing commands: {:?}", cmds)) {
      Ok(expr) => expr.canonicalize(),
      Err(e) => panic!("{:?}", e),
    }
  }

  fn coerce_cmd(pkg_type: PkgType, cmd: Vec<Expr>) -> Expr {
    coerce_bash(pkg_type, Expr::List(vec!(Expr::List(cmd))))
  }

  #[test]
  fn test_bash_commands() {
    assert_eq!(
      cmd(PkgType::Opam, vec!(
        String(vec!(
          OpamSC::Expr(Bool(false))
        ))
      )),
      Expr::str("false".to_string())
    );
    
    assert_eq!(
      cmd(PkgType::Opam, vec!(
        Value::literal("ocaml"),
        Value::literal("pkg/pkg.ml"),
        Value::literal("build"),
        Value::literal("--with-js_of_ocaml"),
        String(vec!(
          OpamSC::Expr(Bool(true))
        ))
      )),
      Expr::str("ocaml pkg/pkg.ml build --with-js_of_ocaml true".to_owned())
    );

    assert_eq!(
      coerce_cmd(PkgType::Opam, vec!(
        Expr::str("bash".to_owned()),
        Expr::str("-c".to_owned()),
        Expr::Literal("var".to_owned()),
      )),
      Expr::Str(vec!(
        StringComponent::Literal("bash -c \"".to_owned()),
        StringComponent::Expr(Expr::Literal("var".to_owned())),
        StringComponent::Literal("\"".to_owned()),
      ))
    );

    assert_eq!(
      bash(PkgType::Opam, List(vec!(
        Value::literal("ocaml"),
        Value::literal("build"),
      ))),
      Expr::str("ocaml build".to_owned())
    );

    assert_eq!(
      bash(PkgType::Esy, List(vec!(
        Value::literal("make"),
        Value::literal("./build"),
      ))),
      Expr::str("\nmake\n./build".to_owned())
    );

    assert_eq!(
      bash(PkgType::Esy, Value::literal("make")),
      Expr::str("make".to_owned())
    );
  }
}
