use anyhow::*;
use std::collections::HashMap;
use serde::Deserialize;
use crate::{Expr, StringComponent};
use crate::esy::build::*;
use crate::esy::eval::*;
use crate::esy::opam::{Name};

#[derive(Debug, Clone, Deserialize)]
pub struct PackageJson {
  pub esy: Option<EsySpec>,
}

impl PackageJson {
  pub fn from_str(contents: &str) -> Result<Self> {
    Ok(serde_json::from_str(&contents)?)
  }
  
  pub fn build(self) -> Result<NixBuild> {
    let mut nix_build = NixBuild::empty(PkgType::Esy);

    if let Some(EsySpec { build }) = self.esy {
      /*
      let name = Name("TODO".to_owned());
      // TODO hoist this out to caller
      // TODO: use a nix function to reduce the size / repetition in generated .nix expression
      let ctx_map = HashMap::new();
      let ctx = Ctx::from_map(&name, &ctx_map);
      let pkg_impl = PkgImpl {
        name: &name,
        path: Expr::Str("$out".to_owned()),
      };

      let expr_of_dir = |p: &str| -> Result<Expr> {
        let eval = Ctx::resolve_path(pkg_impl, p)?;
        Ok(eval.into_nix(&ctx)?)
      };
      */

      nix_build.build =
      Some(Expr::StrInterp(vec!(
        StringComponent::Literal("export cur__bin=$out/bin\n".to_owned()),
        // StringComponent::Expr(expr_of_dir("bin")?),
        // StringComponent::Literal("\n".to_owned()),
        StringComponent::Expr(build.into_nix()),
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
