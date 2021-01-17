use anyhow::*;
use crate::esy::opam_parser::*;
use crate::{Expr, Key};

// public struct, containing only what we need for fetlock purposes
#[derive(Clone, Debug)]
pub struct Opam<'a> {
  build: Option<Value<'a>>,
  install: Option<Value<'a>>,
  depexts: Vec<Value<'a>>,
}

pub struct NixCtx<'a> {
  pub name: &'a str,
  pub lookup_opam: &'a dyn Fn(&str) -> Option<Key>,
}

impl NixCtx<'_> {
  pub fn resolve(&self, ident: &str) -> Expr {
    match ident {
      "name" => Expr::Str(self.name.to_owned()),
      "jobs" => Expr::Str("$NIX_BUILD_CORES".to_owned()),
      _ => panic!(format!("TODO resolve {}", ident)),
    }
  }
}

#[derive(Clone, Debug)]
pub enum Depext {
  Mandatory(String),
  IfPresent(String),
}

#[derive(Clone, Debug)]
pub struct Nix {
  build: Option<Expr>,
  install: Option<Expr>,
  depexts: Vec<Expr>,
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
  
  pub fn into_nix(self, ctx: &NixCtx) -> Result<Nix> {
    let Self { build, install, depexts } = self;
    Ok(Nix {
      build: build.map_or(Ok(None), |x| x.into_nix(&ctx).map(Some))?,
      install: install.map_or(Ok(None), |x| x.into_nix(&ctx).map(Some))?,
      depexts: depexts.into_iter().map(|x| x.into_nix(&ctx)).collect::<Result<Vec<Expr>>>()?,
    })
  }
}