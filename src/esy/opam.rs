use anyhow::*;
use std::borrow::Borrow;
use crate::esy::parser::*;
use crate::esy::parser::opam::*;
use crate::esy::eval::*;
use crate::esy::build::*;
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
  
  pub fn into_nix<'c: 'a, Ctx: NixCtx>(self, ctx: &'c Ctx) -> Result<NixBuild> {
    let Self { build, install, depexts } = self;
    let mode = PkgType::Opam;
    Ok(NixBuild {
      mode,
      build: build.map_or(Ok(None), |x| NixBuild::script(mode, ctx, x).map(Some))?,
      install: install.map_or(Ok(None), |x| NixBuild::script(mode, ctx, x).map(Some))?,
      depexts: depexts.into_iter().map(|x| x.into_nix(ctx)).collect::<Result<Vec<Expr>>>()?,
    })
  }
}

