use anyhow::*;
use lazy_static::lazy_static;
use serde::Deserialize;
use crate::{Expr,StringComponent};
use crate::esy::build::*;
use crate::esy::eval::*;
use crate::esy::parser;
use crate::esy::parser::Value;
use std::fmt;
use std::collections::BTreeMap;
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

  fn parse_str<'a>(s: &'a str) -> Result<Value<'a>> {
    parser::parse(parser::esy::entire_string, &s)
      .with_context(|| format!("Parsing esy string: {:?}", s))
  }

  fn parse<'a>(script: &'a Script<String>) -> Result<Value<'a>> {
    let script: Script<Value<'a>> = script.map_result(|arg| {
      Self::parse_str(&arg)
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
  
  fn evaluate_env<'c, C: NixCtx>(ctx: &C, key: String, value: &str) -> Result<Option<Expr>> {
    lazy_static! {
      static ref IGNORE_ENV: Vec<&'static str> = vec!(
        // ignore env vars that typical nix hooks take care of, since
        // the nix hooks are more likely to get it right
        "PATH",
        "LD_LIBRARY_PATH",
        "DYLD_LIBRARY_PATH",
        "PKG_CONFIG_PATH",
        "CAML_LD_LIBRARY_PATH",
        "OCAMLLIB",
        "OCAML_TOPLEVEL_PATH",
      );
    }

    if IGNORE_ENV.iter().any(|ignored| *ignored == key.as_str()) {
      Ok(None)
    } else {
      let eval = Self::parse_str(value)?;
      let value_expr = Eval::evaluate(eval, ctx)?.into_nix(ctx)?.canonicalize();
      let assignment = Expr::Str(vec!(
        StringComponent::Literal(key),
        StringComponent::Literal("=".to_owned()),
        StringComponent::Expr(value_expr)));
      Ok(Some(assignment))
    }
  }
  
  pub fn build<'c, C: NixCtx>(self, ctx: &C) -> Result<NixBuild> {
    let mut nix_build = NixBuild::empty(PkgType::Esy);
    if let Some(EsySpec { build, install, build_env, exported_env }) = self.esy {
      let parsed = Self::parse(&build.0)?;
      nix_build.build = Some(NixBuild::script(PkgType::Esy, ctx, parsed)?);
      if let Some(install) = install {
        let parsed = Self::parse(&install.0)?;
        nix_build.install = Some(NixBuild::script(PkgType::Esy, ctx, parsed)?);
      }

      let exported_env_list = exported_env.into_iter()
        .filter(|(k,export)| export.scope == "global")
        .filter_map(|(k,export)| Self::evaluate_env(ctx, k, &export.val).transpose())
        .collect::<Result<Vec<Expr>>>()?;
      if !exported_env_list.is_empty() {
        nix_build.extra.insert("exportedEnv".to_owned(), Expr::List(exported_env_list));
      }

      let build_env_list = build_env.into_iter()
        .filter_map(|(k,v)| Self::evaluate_env(ctx, k, &v).transpose())
        .collect::<Result<Vec<Expr>>>()?;
      if !build_env_list.is_empty() {
        nix_build.extra.insert("buildEnv".to_owned(), Expr::List(build_env_list));
      }
    }
    Ok(nix_build)
  }
}

#[derive(Debug, Clone)]
pub struct EsyScript(Script<String>);

#[derive(Debug, Clone)]
pub struct EsyCommand(Command<String>);

#[derive(Debug, Clone, Deserialize)]
pub struct ExportedEnv {
  pub val: String,
  pub scope: String,
}

// see:
// https://esy.sh/docs/en/configuration.html
// https://esy.sh/docs/en/environment.html#variable-substitution-syntax
#[derive(Debug, Clone, Deserialize)]
pub struct EsySpec {
  pub build: EsyScript,
  pub install: Option<EsyScript>,
  
  #[serde(rename = "exportedEnv")]
  #[serde(default)]
  pub exported_env: BTreeMap<String, ExportedEnv>,

  #[serde(rename = "buildEnv")]
  #[serde(default)]
  pub build_env: BTreeMap<String, String>,
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