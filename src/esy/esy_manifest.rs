use anyhow::*;
use serde::Deserialize;
use crate::esy::build::*;
use crate::esy::eval::*;
use crate::esy::parser;
use crate::esy::parser::Value;
use std::fmt;
use serde::de::*;

#[derive(Debug, Clone, Deserialize)]
pub struct PackageJson {
  pub name: String,
  pub version: Option<String>,
  pub esy: Option<EsySpec>,
}

impl PackageJson {
  pub fn from_str(contents: &str) -> Result<Self> {
    Ok(serde_json::from_str(&contents)?)
  }

  fn parse<'a>(script: &'a Script<String>) -> Result<Value<'a>> {
    let script: Script<Value<'a>> = script.map_result(|arg| {
      parser::parse(parser::esy::entire_string, &arg)
        .with_context(|| format!("Parsing esy command: {:?}", arg))
    })?;
    let mut cmds = Vec::new();
    for cmd in script.0 {
      match cmd {
        Command::Sh(s) => cmds.push(s),
        Command::Argv(v) => cmds.push(Value::List(v)),
      }
    }
    Ok(Value::List(cmds))
  }
  
  pub fn build<'c, C: NixCtx>(self, ctx: &C) -> Result<NixBuild> {
    let mut nix_build = NixBuild::empty(PkgType::Esy);

    if let Some(EsySpec { build }) = self.esy {
      let parsed = Self::parse(&build.0)?;
      nix_build.build = Some(NixBuild::script(PkgType::Esy, ctx, parsed)?);
    }
    Ok(nix_build)
  }
}

#[derive(Debug, Clone)]
pub struct EsyScript(Script<String>);

#[derive(Debug, Clone)]
pub struct EsyCommand(Command<String>);

// see:
// https://esy.sh/docs/en/configuration.html
// https://esy.sh/docs/en/environment.html#variable-substitution-syntax
#[derive(Debug, Clone, Deserialize)]
pub struct EsySpec {
  pub build: EsyScript
}

impl<'de> Deserialize<'de> for EsyScript {
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
  type Value = EsyScript;

  fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
    formatter.write_str("build script")
  }

  fn visit_str<E: serde::de::Error>(self, v: &str) -> std::result::Result<Self::Value, E> {
    Ok(EsyScript(Script(vec!(Command::Sh(v.to_owned())))))
  }

  fn visit_seq<A: SeqAccess<'de>>(self, mut seq: A) -> std::result::Result<Self::Value, A::Error> {
    let mut ret = Vec::new();
    while let Some(elem) = seq.next_element::<EsyCommand>()? {
      ret.push(elem.0);
    }
    Ok(EsyScript(Script(ret)))
  }
}

impl<'de> Deserialize<'de> for EsyCommand {
  fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
  where
    D: Deserializer<'de>,
  {
    deserializer.deserialize_any(CommandVisitor)
  }
}

struct CommandVisitor;

impl<'de> Visitor<'de> for CommandVisitor {
  type Value = EsyCommand;

  fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
    formatter.write_str("build command")
  }

  fn visit_str<E: serde::de::Error>(self, v: &str) -> std::result::Result<Self::Value, E> {
    Ok(EsyCommand(Command::Sh(v.to_owned())))
  }

  fn visit_seq<A: SeqAccess<'de>>(self, mut seq: A) -> std::result::Result<Self::Value, A::Error> {
    let mut args = Vec::new();
    while let Some(elem) = seq.next_element::<String>()? {
      args.push(elem);
    }
    Ok(EsyCommand(Command::Argv(args)))
  }
}