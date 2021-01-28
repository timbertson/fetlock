use anyhow::*;
use std::collections::HashMap;
use std::fmt;
use std::borrow::Borrow;
use serde::Deserialize;
use serde::de::*;
use crate::Expr;

#[derive(Debug, Clone, Deserialize)]
pub struct PackageJson {
  pub esy: Option<EsySpec>,
}

impl PackageJson {
  pub fn from_str(contents: &str) -> Result<Self> {
    Ok(serde_json::from_str(&contents)?)
  }
  
  pub fn expr(self) -> Expr {
    let mut map = HashMap::new();
    if let Some(EsySpec { build }) = self.esy {
      let lines: Vec<Command> = build.0;
      let build_expr = Expr::Str(lines.join("\n"));
      map.insert("buildPhase".to_owned(), Box::new(build_expr));
    }
    Expr::AttrSet(map)
  }
}

#[derive(Debug, Clone)]
pub struct Script(Vec<Command>);

// see:
// https://esy.sh/docs/en/configuration.html
// https://esy.sh/docs/en/environment.html#variable-substitution-syntax
#[derive(Debug, Clone, Deserialize)]
pub struct EsySpec {
  pub build: Script
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

#[derive(Debug, Clone)]
pub struct Command(String);

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