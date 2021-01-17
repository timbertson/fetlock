use anyhow::*;
use crate::esy::opam_parser::*;
use crate::Key;

// public struct, containing only what we need for fetlock purposes
#[derive(Clone, Debug)]
pub struct Opam<'a> {
  build: Option<Value<'a>>,
  install: Option<Value<'a>>,
  depexts: Option<Value<'a>>,
}

pub struct NixCtx {
  lookup_opam: Box<dyn Fn(String) -> Option<String>>,
}

#[derive(Clone, Debug)]
pub enum Depext {
  Mandatory(String),
  IfPresent(String),
}

#[derive(Clone, Debug)]
pub struct Nix {
  build: Option<String>,
  install: Option<String>,
  depexts: Vec<Depext>,
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
            "depexts" => depexts = Some(b.value),
            _ => (),
          }
        },
        FileItem::Section(_) => (),
      }
    }
    Self { build, install, depexts }
  }
  
  pub fn to_nix<F>(&self, lookup_opam: F) -> Result<Nix>
  where F: Fn(&str) -> Option<Key> {
    Err(anyhow!("TODO: to_nix"))
  }
}