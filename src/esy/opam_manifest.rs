use anyhow::*;
use crate::esy::parser::*;
use crate::esy::parser::opam::*;
use crate::esy::eval::*;
use crate::esy::build::*;
use crate::Expr;

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

    let mut depexts = Some(Value::List(depexts).into_nix(ctx)?.flatten());
    // suppress empty depexts
    if let Some(Expr::List(l)) = &depexts {
      if l.len() == 0 {
        depexts = None;
      }
    }
    
    Ok(NixBuild {
      mode,
      depexts,
      build: build.map_or(Ok(None), |x| NixBuild::script(mode, ctx, x).map(Some))?,
      install: install.map_or(Ok(None), |x| NixBuild::script(mode, ctx, x).map(Some))?,
    })
  }
}

