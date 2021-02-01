use anyhow::*;
use serde::Deserialize;
use crate::{Expr, StringComponent};
use crate::esy::build::*;
use crate::esy::eval::*;
use crate::esy::parser;
use crate::esy::parser::Value;
use std::fmt;
use serde::de::*;

#[derive(Debug, Clone, Deserialize)]
pub struct PackageJson {
  pub esy: Option<EsySpec>,
}

impl PackageJson {
  pub fn from_str(contents: &str) -> Result<Self> {
    Ok(serde_json::from_str(&contents)?)
  }
  
  pub fn build<'c, C: NixCtx>(self, ctx: &C) -> Result<NixBuild> {
    let mut nix_build = NixBuild::empty(PkgType::Esy);

    if let Some(EsySpec { build }) = self.esy {
      let parsed = build.parse()?;
      nix_build.build = Some(Expr::StrInterp(vec!(
        StringComponent::Literal("\nexport cur__bin=$out/bin\n".to_owned()),
        StringComponent::Expr(NixBuild::script(PkgType::Esy, ctx, parsed)?),
      )));
    }
    Ok(nix_build)
  }
}

// see:
// https://esy.sh/docs/en/configuration.html
// https://esy.sh/docs/en/environment.html#variable-substitution-syntax
#[derive(Debug, Clone, Deserialize)]
pub struct EsySpec {
  pub build: Script
}

#[derive(Debug, Clone)]
pub struct Command(String);

#[derive(Debug, Clone)]
pub struct Script(Vec<Command>);

impl Script {
  fn parse(&self) -> Result<Value> {
    let cmds = self.0.iter()
      .map(|cmd| parser::parse(parser::esy::entire_string, &cmd.0)
        .with_context(|| format!("Parsing esy command: {:?}", cmd)))
      .collect::<Result<Vec<Value>>>()?;
    Ok(Value::List(cmds))
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