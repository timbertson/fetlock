use anyhow::*;
use std::collections::HashMap;
use crate::esy::opam_parser::*;
use crate::esy::opam::{Name, NameRef, Pkg};
use crate::{Expr, FunCall, StringComponent};

pub trait NixCtx<'a> {
  fn name(&self) -> &'a Name;
  fn get<'b>(&self, name: NameRef<'b>) -> Option<&'a Pkg>;
  //fn get<K: Hash + Eq>(&self, name: &'a K) -> Option<&'a Pkg>
  //  where Name: Borrow<K>;
}

pub struct NixCtxMap<'a> {
  name: &'a Name,
  map: &'a HashMap<Name, Pkg>
}

impl<'a> NixCtx<'a> for NixCtxMap<'a> {
  fn name(&self) -> &'a Name { self.name }
  //fn get<K: Hash + Eq>(&self, name: &K) -> Option<&'a Pkg> where Name: Borrow<K> {
  //  self.map.get(name)
  //}
  fn get<'b>(&self, name: NameRef<'b>) -> Option<&'a Pkg> {
    self.map.get(name.0)
  }
}

#[derive(Debug, Clone)]
pub enum VarScope<'a> {
  Unknown,
  SelfScope,
  Package(Option<&'a Pkg>),
}

pub struct Ctx;
impl Ctx {
  pub fn from_map<'a>(name: &'a Name, map: &'a HashMap<Name, Pkg>) -> NixCtxMap<'a> {
    NixCtxMap { name, map }
  }

  pub fn resolve<'a, 'expr: 'a, Ctx: NixCtx<'a>>(ctx: &Ctx, scope: VarScope<'a>, ident: &'expr str) -> Result<Eval<'a>> {
    let resolved = match scope {
      VarScope::Unknown => match ident {
        "jobs" => Ok(Eval::Str("$NIX_BUILD_CORES".to_owned())),
        ident if ident == ctx.name().0 => Ok(Eval::Str("$out".to_owned())),
        
        // is it a package variable implicitly on `self`?
        ident => Self::resolve(ctx, VarScope::SelfScope, ident).or_else(|_| {
          // otherwise try looking it up as a package name
          match ctx.get(NameRef(ident)) {
            Some(pkg) => Self::resolve(ctx, VarScope::Package(Some(pkg)), "path"),
            
            // otherwise it might either be an uninstalled package,
            // an unknown global or possibly a dynamic var, which we don't support
            // TODO quietly return undefined once this is more mature
            None => Err(anyhow!("TODO unknown global: {:?}", ident)),
          }
        })
      },
      VarScope::SelfScope => match ident {
        "name" => Ok(Eval::Str(ctx.name().0.to_owned())),
        "version" => Err(anyhow!("TODO: version")),
        ident => Self::resolve_against(Expr::Str("$out".to_owned()), ident),
      },
      VarScope::Package(key) => match ident {
        "installed" => Ok(Eval::Bool(key.is_some())),
        "enable" => {
          let s = if key.is_some() { "enable" } else { "disable" };
          Ok(Eval::Str(s.to_owned()))
        },
        ident => match key {
          None => Err(anyhow!("TODO: need to suppress entire surrounding expression for: ({:?})", ident)),
          Some(pkg) => {
            let drv = Expr::FunCall(Box::new(FunCall {
              subject: Expr::Literal("getDrv".to_owned()),
              args: vec!(Expr::Str(pkg.key.as_str().to_owned()))
            }));
            Self::resolve_against(drv, ident)
          },
        }
      },
    };
    resolved.with_context(|| format!("resolving {:?} in scope {:?}", ident, &scope))
  }
  
  fn resolve_against(path: Expr, ident: &str) -> Result<Eval> {
    match ident {
      "pinned" // TODO do we ever want to pretend to be pinned?
      | "with-test"
      | "with-doc"
        => Ok(Eval::Bool(false)),
 
      "path" => Ok(Eval::Nix(path)),
      "share" => Ok(Eval::Nix(Expr::StrInterp(vec!(
        StringComponent::Expr(path),
        StringComponent::Literal("TODO:OPAM_NAME".to_owned())
      )))),

      // depends: resolved direct dependencies of the package
      // enable: takes the value "enable" or "disable" depending on whether the package is installed
      // bin, sbin, lib, man, doc, share, etc: the corresponding directories for this package (similar to <pkgname>.install)
      // build: directory where the package was built
      // hash: hash of the package archive
      // dev: true if this is a development package, i.e. it was not built from a release archive
      // build-id: a hash identifying the precise package version and metadata, and that of all its dependencies
      // opamfile: if the package is installed, path of its opam file, from opam internals, otherwise not defined
      ident => Err(anyhow!("TODO unknown package[{:?}] var: {:?}", path, ident)),
    }
  }

  fn scope<'a, 'expr : 'a, Ctx: NixCtx<'a>>(ctx: &Ctx, scope: &'expr str) -> VarScope<'a> {
    match scope {
      "_" => VarScope::SelfScope,
      name if name == ctx.name().0 => VarScope::SelfScope,
      scope => VarScope::Package(ctx.get(NameRef(scope)))
    }
  }

  pub fn resolve_ident<'a, Ctx: NixCtx<'a>>(ctx: &Ctx, ident: &'a str) -> Result<Eval<'a>> {
    Self::resolve(ctx, VarScope::Unknown, ident)
  }

  pub fn resolve_varident<'a, Ctx: NixCtx<'a>>(ctx: &Ctx, ident: &Varident<'a>) -> Result<Eval<'a>> {
    if ident.additional_scopes.len() > 0 {
      todo!("support additional scopes");
    }
    let scope = match ident.scope {
      "_" => VarScope::SelfScope,
      name => Self::scope(ctx, name),
    };
    Self::resolve(ctx, scope, ident.ident)
  }
}