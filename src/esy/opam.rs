use anyhow::*;
use std::collections::HashMap;
use std::borrow::Borrow;
use crate::esy::opam_parser::*;
use crate::esy::eval::*;
use crate::{Key, Expr};

// TODO: promote this outside of opam
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Name(pub String);

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct NameRef<'a>(pub &'a str);

// TODO should be impl Borrow<NameRef> when I can figure that out...
impl Borrow<str> for Name {
  fn borrow(&self) -> &str {
    self.0.as_str()
  }
}

// impl<'b> Borrow<NameRef<'b>> for Name {
//   fn borrow<'a>(&'a self) -> &'a NameRef<'b> {
//     // todo!()
//     let s: &'a String = &self.0;
//     let ret: &'a NameRef<'b> = &NameRef(s);
//     ret
//   }
// }

#[derive(Debug, Clone)]
pub struct Pkg {
  pub name: Name,
  pub key: Key,
}

// public struct, containing only what we need for fetlock purposes
#[derive(Clone, Debug)]
pub struct Opam<'a> {
  build: Option<Value<'a>>,
  install: Option<Value<'a>>,
  depexts: Vec<Value<'a>>,
}

#[derive(Clone, Debug)]
pub enum Depext {
  Mandatory(String),
  IfPresent(String),
}

impl<'a> Opam<'a> {
  pub fn from_str(contents: &'a str) -> Result<Opam> {
    parse(entire_file, contents).map(Self::filter)
  }
  
  fn filter(items: Vec<FileItem<'a>>) -> Opam<'a> {
    let mut build = None;
    let mut install = None;
    let mut depexts = None;
    for item in items {
      match item {
        FileItem::FieldBinding(b) => {
          match b.ident {
            "build" => build = Some(b.value),
            "install" => install = Some(b.value),
            "depexts" => {
              match b.value {
                Value::List(deps) => depexts = Some(deps),
                _ => todo!(),
              }
            }
            _ => (),
          }
        },
        FileItem::Section(_) => (),
      }
    }
    Self { build, install, depexts: depexts.unwrap_or_else(||Vec::new()) }
  }
  
  fn add_sep<T: Clone>(vec: &mut Vec<T>, first: &mut bool, sep: &T) {
    if *first {
      *first = false;
    } else {
      vec.push(sep.clone());
    }
  }

  fn bash_of_commands(cmds: Expr) -> Result<Expr> {
    // Takes an opam command spec [[make "..."]]
    // and returns a multi-line bash string.
    // TODO: add quotes / escapes where necessary
    use crate::StringComponent;
    
    let newline = StringComponent::Literal("\n".to_owned());
    let space = StringComponent::Literal(" ".to_owned());
    
    let add_cmd = |buf: &mut Vec<StringComponent>, args| -> Result<()> {
      let mut first_arg = true;
      for arg in args {
        Self::add_sep(buf, &mut first_arg, &space);
        match arg {
          Expr::Str(s) => buf.push(StringComponent::Literal(s)),
          Expr::StrInterp(s) => buf.extend(s),
          other => Err(anyhow!("Invalid command argument: {:?}", other))?,
        };
      }
      Ok(())
    };

    let mut buf = Vec::new();

    match cmds {
      Expr::List(cmds) => {
        if !cmds.iter().any(|cmd| cmd.is_list()) {
          // canonical form is a list (script) of lists (command args)
          // but if you only have one command you can just pass a single list of args
          add_cmd(&mut buf, cmds)?
        } else {
          let mut first_cmd = true;
          if cmds.len() > 1 {
            // always start a multiline string with a newline
            first_cmd = false;
          }

          for cmd in cmds {
            match cmd {
              Expr::List(args) => {
                Self::add_sep(&mut buf, &mut first_cmd, &newline);
                add_cmd(&mut buf, args)?;
              },
              expr => Err(anyhow!("TODO: interpret command argument: {:?}", expr))?,
            }
          }
        }
      },
      cmds => Err(anyhow!("TODO: interpret commands expression: {:?}", cmds))?,
    }
    Ok(Expr::StrInterp(buf))
  }

  pub fn into_nix<'c, Ctx: NixCtx<'c>>(self, ctx: &Ctx) -> Result<Nix> where 'a : 'c {
    let Self { build, install, depexts } = self;
    Ok(Nix {
      build: build.map_or(Ok(None), |x| x.into_nix(ctx).and_then(Self::bash_of_commands).map(Some))?,
      install: install.map_or(Ok(None), |x| x.into_nix(ctx).and_then(Self::bash_of_commands).map(Some))?,
      depexts: depexts.into_iter().map(|x| x.into_nix(ctx)).collect::<Result<Vec<Expr>>>()?,
    })
  }
}

#[derive(Clone, Debug)]
pub struct Nix {
  pub build: Option<Expr>,
  pub install: Option<Expr>,
  pub depexts: Vec<Expr>,
}

impl Nix {
  pub fn expr(self) -> Expr {
    let mut map = HashMap::new();
    let Self { build, install, depexts } = self;

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
  use Expr::*;
  type StringComponent = crate::StringComponent;
  
  fn bash(cmds: Expr) -> Expr {
    let cmds = cmds.canonicalize();
    match Opam::bash_of_commands(cmds.clone())
      .with_context(||format!("Processing commands: {:?}", cmds)) {
      Ok(expr) => expr.canonicalize(),
      Err(e) => panic!("{:?}", e),
    }
  }

  fn cmd(cmd: Vec<Expr>) -> Expr {
    bash(List(cmd))
  }

  #[test]
  fn test_bash_commands() {
    assert_eq!(
      cmd(vec!(
        StrInterp(vec!(
          StringComponent::Expr(Bool(false))
        )).canonicalize()
      )),
      Str("false".to_string())
    );
    
    assert_eq!(
      cmd(vec!(
        Expr::Str("ocaml".to_owned()),
        Expr::Str("pkg/pkg.ml".to_owned()),
        Expr::Str("build".to_owned()),
        Expr::Str("--with-js_of_ocaml".to_owned()),
        StrInterp(vec!(
          StringComponent::Expr(Bool(true))
        )).canonicalize()
      )),
      Str("ocaml pkg/pkg.ml build --with-js_of_ocaml true".to_owned())
    );
  }
}
