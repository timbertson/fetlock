use anyhow::*;
use log::*;
use std::collections::HashMap;
use crate::expr;
use crate::esy::opam_parser::*;
use crate::esy::opam_parser;
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
pub struct PkgImpl<'a> {
  name: &'a Name,
  path: Expr,
}

#[derive(Debug, Clone)]
pub enum VarScope<'a> {
  Unknown,
  SelfScope,
  Package(Option<&'a Pkg>),
}

#[derive(Debug, Clone)]
enum PathScope {
  Named,
  Root,
}

#[derive(Debug, Clone)]
enum PathType {
  Lib,
  Simple,
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
        "make" => Ok(Eval::Str("make".to_owned())),

        "opam-version" => Ok(Eval::Str("2.0".to_owned())),
        ident if ident == ctx.name().0 => Ok(Eval::Str("$out".to_owned())),
        
        // is it a package variable implicitly on `self`?
        ident => Self::resolve(ctx, VarScope::SelfScope, ident).or_else(|_| {
          // otherwise try looking it up as a package name
          match ctx.get(NameRef(ident)) {
            Some(pkg) => Self::resolve(ctx, VarScope::Package(Some(pkg)), "prefix"),
            
            // otherwise it might either be an uninstalled package,
            // an unknown global or possibly a dynamic var, which we don't support
            // TODO quietly return undefined once this is more mature
            None => Err(anyhow!("TODO unknown ident: {:?}", ident)),
          }
        })
      },
      VarScope::SelfScope => match ident {
        "name" => Ok(Eval::Str(ctx.name().0.to_owned())),
        "version" => Err(anyhow!("TODO: version")),
        ident => Self::resolve_bool(true, ident).map(Ok)
          .unwrap_or_else(|| Self::resolve_path(PkgImpl {
            path: Expr::Str("$out".to_owned()),
            name: ctx.name(),
          }, ident)),
      },
      // TODO pseudo-package for `ocaml`?
      VarScope::Package(pkg) => Self::resolve_bool(pkg.is_some(), ident).map(Ok).unwrap_or_else(|| {
        // Unimplemented:
        // depends: resolved direct dependencies of the package
        // enable: takes the value "enable" or "disable" depending on whether the package is installed
        // bin, sbin, lib, man, doc, share, etc: the corresponding directories for this package (similar to <pkgname>.install)
        // build: directory where the package was built
        // hash: hash of the package archive
        // dev: true if this is a development package, i.e. it was not built from a release archive
        // build-id: a hash identifying the precise package version and metadata, and that of all its dependencies
        // opamfile: if the package is installed, path of its opam file, from opam internals, otherwise not defined
        match pkg {
          None => Ok(Eval::Undefined),
          Some(pkg) => {
            let drv = Expr::FunCall(Box::new(FunCall {
              subject: Expr::Literal("getDrv".to_owned()),
              args: vec!(Expr::Str(pkg.key.as_str().to_owned()))
            }));
            Self::resolve_path(PkgImpl {
              path: drv,
              name: &pkg.name,
            }, ident)
          },
        }
      }),
    };
    resolved.with_context(|| format!("resolving {:?} in scope {:?}", ident, &scope))
  }
  
  fn resolve_bool(installed: bool, ident: &str) -> Option<Eval<'static>> {
    match ident {
      "installed" => Some(Eval::Bool(installed)),

      // preinstalled means packages suppose they can't write to the ocaml directory
      // (we assume people only use this for the `ocaml` package)
      "preinstalled"
      | "native"
      | "native-dynlink"
      | "native-tools"
        => Some(Eval::Bool(true)),

      "pinned" // TODO do we ever want to pretend to be pinned / dev?
      | "dev"
      | "with-test"
      | "with-doc"
        => Some(Eval::Bool(false)),

      "enable" => {
        let s = if installed { "enable" } else { "disable" };
        Some(Eval::Str(s.to_owned()))
      },
      _ => None
    }
  }

  fn resolve_path(pkg: PkgImpl, ident: &str) -> Result<Eval<'static>> {
    let simple = PathType::Simple;
    let named = PathScope::Named;
    let rel_lib_and_scope = match ident {
      "prefix" => Ok((None, simple, PathScope::Root)),

      "share"
      | "doc"
      | "bin"
      | "sbin"
      | "man"
      | "etc"
      => Ok((Some(ident), simple, named)),

      "lib" => Ok((None, PathType::Lib, named)),
      "stublibs" | "toplevel" => Ok((Some(ident), simple, named)),
      "lib_root" => Ok((Some("lib"), PathType::Lib, PathScope::Root)),
      "share_root" => Ok((Some("share"), PathType::Simple, PathScope::Root)),

      _ => Err(anyhow!("TODO unknown package[{:?}] var: {:?}", &pkg, ident)),
    };

    rel_lib_and_scope.map(|(rel, lib, scope)| {
      let suffix = match (rel, scope) {
        (Some(rel), PathScope::Named) => format!("/{}/{}", rel, pkg.name.0),
        (None, PathScope::Named) => format!("/{}", pkg.name.0),
        (Some(rel), PathScope::Root) => format!("/{}", rel),
        (None, PathScope::Root) => "".to_owned(),
      };
      Eval::Nix(match lib {
        PathType::Lib => {
          let PkgImpl { path, name } = pkg;
          Expr::StrInterp(vec!(
            StringComponent::Expr(path),
            StringComponent::Literal("/".to_owned()),
            StringComponent::Expr(Expr::FunCall(Box::new(FunCall {
              subject: Expr::Literal("siteLib".to_owned()),
              args: vec!(Expr::Str(name.0.clone())),
            }))),
          ))
        },
        PathType::Simple => Expr::StrInterp(vec!(
          StringComponent::Expr(pkg.path),
          StringComponent::Literal(suffix),
        )),
      })
    })
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

// Eval is used to reduce formulas down to primitives, where possible
#[derive(Debug, Clone)]
pub enum Eval<'a> {
  Complex(Value<'a>), // TODO: remove?
  Nix(Expr), // opaque nix expression (e.g. function call)
  Undefined,
  Bool(bool),
  Str(String),
  List(Vec<Eval<'a>>),
}

use Eval::*;

impl<'a> Eval<'a> {
  fn truthy(&self) -> bool {
    match self {
      Complex(_) | Nix(_) | Str(_) => true,
      Undefined => false,
      Bool(b) => *b,
      List(l) => l.iter().filter(|x| x.truthy()).count() > 0,
    }
  }

  fn as_bool(&self) -> Result<bool> {
    match self {
      Bool(b) => Ok(*b),
      Undefined => Ok(false),
      _ => Err(anyhow!("Can't coerce {:?} into boolean")),
    }
  }

  pub fn evaluate<C: NixCtx<'a>>(v: Value<'a>, c: &C) -> Result<Eval<'a>> {
    use Value::*;
    match v {
      // TODO could canonicalize() a string to turn it into a Str, but it's unclear if that
      // is ever needed
      // TODO need to dive into string components
      Int(_) | String(_) => Ok(Eval::Complex(v)),

      List(l) => Ok(Eval::List(
        l.into_iter()
        .map(|v| Eval::evaluate(v, c))
        // drop all elements which evaluate to false / undefined
        .filter(|result| result.as_ref().map(Eval::truthy).unwrap_or(true /* include failed */))
        .collect::<Result<Vec<Eval<'a>>>>()?
      )),

      Bool(x) => Ok(Eval::Bool(x)),
      Ident(x) => Ctx::resolve_ident(c, x),
      Varident(x) => Ctx::resolve_varident(c, &x),
      UnaryOp(op, v) => {
        use Op::*;
        let b = Self::evaluate(*v, c).and_then(|x| x.as_bool());
        match op {
          Not => b.map(|b| Eval::Bool(!b)),
          And
          | Or
          | Eq
          | Neq
          | Lte
          | Gte
          | Lt
          | Gt
          | Question
          => Err(anyhow!("Unimplemented: evaluate(UnaryOp({:?}, _))", op))?
        }
      },
      Binop(binop) => {
        let opam_parser::Binop { a, op, b } = *binop;
        // TODO: it's a bit annoying that we need to clone here...
        let a_bool = || Self::evaluate(a.clone(), c).and_then(|x| x.as_bool());
        let b_bool = || Self::evaluate(b.clone(), c).and_then(|x| x.as_bool());
        let bools = a_bool().and_then(|a| b_bool().map(|b| (a,b)));

        use Op::*;
        match op {
          // The explicit matching is so that we can short-circuit even when we can't
          // evaluate one side of the operand
          And => match (a_bool(), b_bool()) {
            (Ok(false), _) | (_, Ok(false)) => Ok(Eval::Bool(false)),
            _ => bools.map(|(a, b)| Eval::Bool(a && b)),
          },

          Or => match (a_bool(), b_bool()) {
            (Ok(true), _) | (_, Ok(true)) => Ok(Eval::Bool(true)),
            _ => bools.map(|(a, b)| Eval::Bool(a && b)),
          },
          
          // for comparisons we assume we're running new versions,
          // just to get past this stage for POC
          Lt | Lte => {
            warn!("TODO: assuming <= comparison returns false");
            Ok(Eval::Bool(false))
          },
          Gt | Gte => {
            warn!("TODO: assuming >= comparison returns true");
            Ok(Eval::Bool(true))
          },

          Eq
          | Neq
          | Not
          | Question
          => Err(anyhow!("Unimplemented: evaluate(Binop(_, {:?}, _))", op))?
        }
      },
      Option(x) => {
        let ValueWithOption { value, option } = *x;
        let filter = Eval::evaluate(option, c)?;
        match filter {
          Eval::Bool(b) => if b {
            Eval::evaluate(value, c)
          } else {
            Ok(Eval::Undefined)
          }
          other => Err(anyhow!("Unsupported filter value: {:?}", other))
        }
      },
    }
  }

  
  pub fn into_nix<C: NixCtx<'a>>(self, c: &C) -> Result<Expr> {
    match self {
      Eval::Complex(value) => {
        use Value::*;
        match value {
          // TODO does this belong here? Or should it be hoisted to Eval?
          String(x) => {
            let parts = x.into_iter()
              .map(|x| x.into_nix(c))
              .collect::<Result<Vec<expr::StringComponent>>>()?;
            Ok(Expr::StrInterp(parts).canonicalize())
          },
          Int(x) => Ok(Expr::Literal(format!("{}", x))),

          // all of these should have been replaced by `eval`, or make no sense at the toplevel
          Bool(_) |
          List(_) |
          Varident(_) |
          Ident(_) |
          UnaryOp(_, _) |
          Binop(_) |
          Option(_) => Err(anyhow!("Unimplemented: {:?}.into_nix()", value))?,
        }
      },
      Eval::Nix(expr) => Ok(expr),
      Eval::Undefined => Err(anyhow!("TODO: undefined")),
      Eval::Bool(b) => Ok(Expr::Literal(format!("{}", b))),
      Eval::Str(s) => Ok(Expr::Str(s)),
      Eval::List(l) => {
        let exprs = l.into_iter().map(|x| x.into_nix(c)).collect::<Result<Vec<Expr>>>()?;
        Ok(Expr::List(exprs))
      },
    }
  }
}