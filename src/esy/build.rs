// nix wrapper for build instructions extracted from a manifest,
// whether that be `esy`, `opam` or `npm`

use std::collections::HashMap;
use anyhow::*;
use std::fmt;
use std::borrow::Borrow;
use serde::Deserialize;
use serde::de::*;
use crate::Expr;

#[derive(Clone, Debug)]
pub enum Depext {
  Mandatory(String),
  IfPresent(String),
}

#[derive(Clone, Debug)]
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

#[derive(Debug, Clone)]
pub struct Command(String);

#[derive(Debug, Clone)]
pub struct Script(Vec<Command>);

impl Script {
  pub fn into_nix(self) -> Expr {
    let lines: Vec<Command> = self.0;
    Expr::Str(lines.join("\n"))
  }
}

impl<'de> Deserialize<'de> for Script {
  fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
  where
    D: Deserializer<'de>,
  {
    deserializer.deserialize_any(ScriptVisitor)
  }
}

struct ScriptVisitor;

// A script can be a single string,
// an array of strings (commands),
// or an array of arrays of strings (arguments)
impl<'de> Visitor<'de> for ScriptVisitor {
  type Value = Script;

  fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
    formatter.write_str("build script")
  }

  fn visit_str<E: serde::de::Error>(self, v: &str) -> std::result::Result<Self::Value, E> {
    Ok(Script(vec!(Command(v.to_owned()))))
  }

  fn visit_seq<A: SeqAccess<'de>>(self, mut seq: A) -> std::result::Result<Self::Value, A::Error> {
    let mut ret = Vec::new();
    while let Some(elem) = seq.next_element()? {
      ret.push(elem);
    }
    Ok(Script(ret))
  }
}

impl<'de> Deserialize<'de> for Command {
  fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
  where
    D: Deserializer<'de>,
  {
    deserializer.deserialize_any(CommandVisitor)
  }
}

struct CommandVisitor;

impl<'de> Visitor<'de> for CommandVisitor {
  type Value = Command;

  fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
    formatter.write_str("build command")
  }

  fn visit_str<E: serde::de::Error>(self, v: &str) -> std::result::Result<Self::Value, E> {
    Ok(Command(v.to_owned()))
  }

  fn visit_seq<A: SeqAccess<'de>>(self, mut seq: A) -> std::result::Result<Self::Value, A::Error> {
    let mut args = Vec::new();
    while let Some(elem) = seq.next_element::<String>()? {
      args.push(elem);
    }
    Ok(Command(args.join(" ")))
  }
}

impl Borrow<str> for Command {
  fn borrow(&self) -> &str {
    &self.0
  }
}