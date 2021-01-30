// nix wrapper for build instructions extracted from a manifest,
// whether that be `esy`, `opam` or `npm`

use std::collections::HashMap;
use anyhow::*;
use crate::Expr;
use crate::esy::opam_parser::{Value, OpamSC};
use crate::esy::eval::{Eval, NixCtx};

#[derive(Clone, Debug)]
pub enum Depext {
  Mandatory(String),
  IfPresent(String),
}

#[derive(Clone, Debug, Copy, PartialEq, Eq)]
pub enum PkgType {
  Esy,
  Opam,
  Node,
}

#[derive(Clone, Debug)]
pub struct NixBuild {
  pub mode: PkgType,
  pub build: Option<Expr>,
  pub install: Option<Expr>,
  pub depexts: Vec<Expr>,
}

impl NixBuild {
  pub fn empty(mode: PkgType) -> Self {
    Self {
      mode,
      build: None,
      install: None,
      depexts: Vec::new(),
    }
  }
  
  fn add_sep<T: Clone>(vec: &mut Vec<T>, first: &mut bool, sep: &T) {
    if *first {
      *first = false;
    } else {
      vec.push(sep.clone());
    }
  }

  fn coerce_script<'a>(pkg_type: PkgType, value: Value<'a>) -> Result<Value<'a>> {
    let newline = OpamSC::Literal("\n".to_owned());
    let space = OpamSC::Literal(" ".to_owned());
    
    let add_cmd = |buf: &mut Vec<OpamSC<'a>>, args| -> Result<()> {
      let mut first_arg = true;
      for arg in args {
        Self::add_sep(buf, &mut first_arg, &space);
        match arg {
          Value::String(parts) => buf.extend(parts),
          other => buf.push(OpamSC::Expr(other)),
        };
      }
      Ok(())
    };

    let mut buf = Vec::new();

    match value {
      Value::List(cmds) => {
        if pkg_type == PkgType::Opam && !cmds.iter().any(|cmd| cmd.is_list()) {
          // opam [ foo bar baz ] means [[ foo bar baz ]],
          // but esy [ foo bar baz ] is [[foo] [bar] [baz]], so we also need to
          // handle cmds that are strings (below)
          add_cmd(&mut buf, cmds)?
        } else {
          let mut first_cmd = true;
          if cmds.len() > 1 {
            // always start a multiline string with a newline
            first_cmd = false;
          }

          for cmd in cmds {
            Self::add_sep(&mut buf, &mut first_cmd, &newline);
            match cmd {
              Value::List(args) => add_cmd(&mut buf, args)?,
              _ => add_cmd(&mut buf, vec!(cmd))?,
            }
          }
        }
      },
      _ => add_cmd(&mut buf, vec!(value))?,
    }
    Ok(Value::String(buf))
  }

  pub fn script<'a, 'c: 'a, Ctx: NixCtx>(pkg_type: PkgType, ctx: &Ctx, value: Value<'a>) -> Result<Expr> {
    let r: Result<Expr> = (|| {
      let value = NixBuild::coerce_script(pkg_type, value.clone())?;
      let eval = Eval::evaluate(value, ctx)?;
      Ok(eval.into_nix(ctx)?.canonicalize())
    })();
    r.with_context(|| format!("processing script expression: {:?}", value))
  }

  pub fn expr(self) -> Expr {
    let mut map = HashMap::new();
    let Self { mode, build, install, depexts } = self;
    let mode_str = match mode {
      PkgType::Esy => "esy",
      PkgType::Opam => "opam",
      PkgType::Node => "node",
    };
    
    map.insert("mode".to_owned(), Box::new(Expr::Str(mode_str.to_owned())));

    if let Some(build) = build {
      map.insert("buildPhase".to_owned(), Box::new(build));
    }
    if let Some(install) = install {
      map.insert("installPhase".to_owned(), Box::new(install));
    }

    map.insert("depexts".to_owned(), Box::new(Expr::List(depexts)));
    Expr::AttrSet(map)
  }
}

#[cfg(test)]
mod tests {
  use super::*;
  use Value::*;
  use crate::esy::eval::Ctx;
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
    bash(pkg_type, List(cmd))
  }

  #[test]
  fn test_bash_commands() {
    assert_eq!(
      cmd(PkgType::Opam, vec!(
        String(vec!(
          OpamSC::Expr(Bool(false))
        ))
      )),
      Expr::Str("false".to_string())
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
      Expr::Str("ocaml pkg/pkg.ml build --with-js_of_ocaml true".to_owned())
    );

    assert_eq!(
      bash(PkgType::Opam, List(vec!(
        Value::literal("ocaml"),
        Value::literal("build"),
      ))),
      Expr::Str("ocaml build".to_owned())
    );

    assert_eq!(
      bash(PkgType::Esy, List(vec!(
        Value::literal("make"),
        Value::literal("./build"),
      ))),
      Expr::Str("\nmake\n./build".to_owned())
    );

    assert_eq!(
      bash(PkgType::Esy, Value::literal("make")),
      Expr::Str("make".to_owned())
    );
  }
}
