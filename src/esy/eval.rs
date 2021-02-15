use anyhow::*;
use log::*;
use std::collections::HashMap;
use std::cmp::Ordering;
use std::cmp::PartialOrd;
use crate::esy::parser::*;
use crate::esy::parser;
use crate::esy::build::PkgType;
use crate::{Name, Key, Expr, FunCall, StringComponent, StringComponentOf};

#[derive(Debug, Clone)]
pub struct Pkg {
  pub name: Name,
  pub key: Key,
}

// TODO we only have one concrete implementation, drop this trait
pub trait NixCtx {
  fn name<'a>(&'a self) -> &'a Name;
  fn pkg_type(&self) -> PkgType;
  // TODO make this a KeyRef (again!)
  fn get<'a, 'b>(&'a self, name: &'b str) -> Option<&'a Pkg>;
}

pub struct NixCtxMap<'a> {
  name: &'a Name,
  pkg_type: PkgType,
  map: &'a HashMap<Name, Pkg>
}

impl<'c> NixCtx for NixCtxMap<'c> {
  fn name(&self) -> &Name { self.name }
  fn pkg_type(&self) -> PkgType { self.pkg_type }
  fn get<'a, 'b>(&'a self, name: &'b str) -> Option<&'a Pkg> {
    self.map.get(name)
  }
}

// used for tests
pub struct EmptyCtx {
  name: Name,
}

impl NixCtx for EmptyCtx {
  fn name(&self) -> &Name { &self.name }
  fn pkg_type(&self) -> PkgType { PkgType::Opam }
  fn get<'a, 'b>(&'a self, name: &'b str) -> Option<&'a Pkg> {
    None
  }
}

#[derive(Debug, Clone)]
pub struct PkgImpl<'a> {
  pub name: Option<&'a Name>,
  pub path: Expr,
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
  pub fn from_map<'a>(pkg_type: PkgType, name: &'a Name, map: &'a HashMap<Name, Pkg>) -> NixCtxMap<'a> {
    NixCtxMap { pkg_type, name, map }
  }

  pub fn empty<'a>(name: &'a str) -> EmptyCtx {
    // used in tests
    EmptyCtx { name: Name(name.to_owned()) }
  }

  fn resolve<'a, 'c: 'a, Ctx: NixCtx>(ctx: &Ctx, scope: VarScope<'a>, ident: &'a str) -> Result<Eval> {
    debug!("resolving {:?} in scope {:?}", ident, scope);
    let resolved = match scope {
      VarScope::Unknown => match ident {
        "jobs" => Ok(Eval::Str("$NIX_BUILD_CORES".to_owned())),

        "os" => {
          match ctx.pkg_type() {
            // for esy, used in a ternary
            PkgType::Esy => Ok(Eval::Nix(Expr::Literal("final.os".to_owned()))),
            // for opam, used in a filter (so we need it to be static, we don't support dynamic filters)
            // "nixos" is useful for depexts, but not for branched build instructions :/
            PkgType::Opam => Ok(Eval::Str("nixos".to_owned())),
          }
        },

        "os-family" | "os-distribution" => {
          match ctx.pkg_type() {
            PkgType::Esy => Err(anyhow!("os-family not defined for esy packages")),
            PkgType::Opam => Ok(Eval::Str("nixos".to_owned())),
          }
        },

        "make" => Ok(Eval::Str("make".to_owned())),

        "opam-version" => Ok(Eval::Str("2.0".to_owned())),
        ident if ident == ctx.name().0 => Ok(Eval::Str("$out".to_owned())),
        
        // try resolving as a global, a self-scoped var, or a package name
        ident => {
          Self::resolve_path(PkgImpl {
            path: Expr::str("$out".to_owned()),
            name: None, // global path
          }, ident).or_else(|_| {
            Self::resolve(ctx, VarScope::SelfScope, ident)
          }).or_else(|_| {
            // otherwise try looking it up as a package name
            match ctx.get(ident) {
              Some(pkg) => Self::resolve(ctx, VarScope::Package(Some(pkg)), "prefix"),
              
              // otherwise it might either be an uninstalled package,
              // an unknown global or possibly a dynamic var, which we don't support
              // TODO quietly return undefined once this is more mature
              None => Err(anyhow!("TODO unknown ident: {:?}", ident)),
            }
          })
        },
      },
      VarScope::SelfScope => match ident {
        "name" => Ok(Eval::Str(ctx.name().0.to_owned())),
        "version" => Err(anyhow!("TODO: version")),
        ident => Self::resolve_bool(true, ident).map(Ok)
          .unwrap_or_else(|| Self::resolve_path(PkgImpl {
            path: Expr::str("$out".to_owned()),
            name: Some(ctx.name()),
          }, ident)),
      },
      // TODO pseudo-package for `ocaml`?
      VarScope::Package(pkg) => {
        Self::resolve_bool(pkg.is_some(), ident).map(Ok).unwrap_or_else(|| {
          // Unimplemented:
          // depends: resolved direct dependencies of the package
          // enable: takes the value "enable" or "disable" depending on whether the package is installed
          // build: directory where the package was built
          // hash: hash of the package archive
          // dev: true if this is a development package, i.e. it was not built from a release archive
          // build-id: a hash identifying the precise package version and metadata, and that of all its dependencies
          // opamfile: if the package is installed, path of its opam file, from opam internals, otherwise not defined
          match pkg {
            None => Ok(Eval::Undefined),
            Some(pkg) => Self::resolve_path(PkgImpl {
              path: Expr::get_drv(pkg.key.to_string()),
              name: Some(&pkg.name),
            }, ident),
          }
        })
      },
    };
    resolved.with_context(|| format!("resolving {:?} in scope {:?}", ident, &scope))
  }
  
  fn resolve_bool(installed: bool, ident: &str) -> Option<Eval> {
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

  pub fn resolve_path(pkg: PkgImpl, ident: &str) -> Result<Eval> {
    let simple = PathType::Simple;
    let named = PathScope::Named;
    let rel_lib_and_scope = match ident {
      "prefix" | "install" /* esy */ => Ok((None, simple, PathScope::Root)),

      "share"
      | "doc"
      | "bin"
      | "sbin"
      | "man"
      | "etc"
      => Ok((Some(ident), simple, PathScope::Root)),

      "lib" => Ok((None, PathType::Lib, named)),
      "stublibs" | "toplevel" => Ok((Some(ident), PathType::Lib, named)),
      "lib_root" => Ok((None, PathType::Lib, PathScope::Root)),
      "share_root" => Ok((Some("share"), PathType::Simple, PathScope::Root)),

      _ => Err(anyhow!("TODO unknown package[{:?}] var: {:?}", &pkg, ident)),
    };

    rel_lib_and_scope.map(|(rel, lib, scope)| {
      // we only include the pkgname if this was a lookup specifically for a pacakge scope
      // (e.g. global `lib` resolves to $out/..../lib, while `_:lib` resolves to $out/..../lib/$pname)
      let name_suffix = match (scope, pkg.name) {
        (PathScope::Named, Some(name)) => Some(&name.0),
        _ => None,
      };
      let suffix = match (rel, name_suffix) {
        (Some(rel), Some(name)) => format!("/{}/{}", rel, name),
        (None, Some(name)) => format!("/{}", name),
        (Some(rel), None) => format!("/{}", rel),
        (None, None) => "".to_owned(),
      };
      Eval::Nix(match lib {
        PathType::Lib => {
          let PkgImpl { path, name } = pkg;
          Expr::Str(vec!(
            StringComponent::Expr(Expr::FunCall(Box::new(FunCall {
              subject: Expr::Literal("final.siteLib".to_owned()),
              args: vec!(path),
            }))),
            StringComponent::Literal(suffix),
          ))
        },
        PathType::Simple => Expr::Str(vec!(
          StringComponent::Expr(pkg.path),
          StringComponent::Literal(suffix),
        )),
      })
    })
  }

  fn scope<'a, 'c : 'a, Ctx: NixCtx>(ctx: &'c Ctx, scope: &'a str) -> VarScope<'a> {
    match scope {
      "_" | "self" /* esy */ => VarScope::SelfScope,
      name if name == ctx.name().0 => VarScope::SelfScope,
      scope => VarScope::Package(ctx.get(scope))
    }
  }

  pub fn resolve_ident<'a, 'c: 'a, Ctx: NixCtx>(ctx: &'c Ctx, ident: &'a str) -> Result<Eval> {
    let result = Self::resolve(ctx, VarScope::Unknown, ident);
    debug!("resolved {:?} -> {:?}", ident, result);
    result
  }

  pub fn resolve_varident<'a, 'c: 'a, Ctx: NixCtx>(ctx: &'c Ctx, ident: &Varident<'a>) -> Result<Eval> {
    if ident.additional_scopes.len() > 0 {
      todo!("support additional scopes");
    }
    let scope = match ident.scope {
      "_" => VarScope::SelfScope,
      name => Self::scope(ctx, name),
    };
    let result = Self::resolve(ctx, scope, ident.ident);
    debug!("resolved {:?} -> {:?}", ident, result);
    result
  }
}

pub type EvalSC = StringComponentOf<Eval>;

// Eval is used to reduce formulas down to primitives, where possible
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Eval {
  Nix(Expr), // opaque nix expression (e.g. function call)
  Undefined,
  Bool(bool),
  Str(String),
  StrInterp(Vec<EvalSC>),
  List(Vec<Eval>),
}

use Eval::*;

impl Eval {
  fn truthy(&self) -> bool {
    match self {
      Nix(_) | Str(_) => true,
      StrInterp(parts) => parts.len() > 0,
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
  
  pub fn evaluate<'a, 'c: 'a, C: NixCtx>(v: Value<'a>, c: &'c C) -> Result<Eval> {
    use Value::*;
    match v {
      // TODO could canonicalize() a string to turn it into a Str, but it's unclear if that
      // is ever needed
      Int(x) => Ok(Eval::Nix(Expr::Literal(format!("{}", x)))),
      String(parts) => match StringComponentOf::as_static_string(&parts) {
        Ok(s) => Ok(Eval::Str(s)),
        Err(()) => { 
          let parts = parts.into_iter()
            .map(|component| component.map_result(|v| {
              v.clone().into_nix(c)
              .with_context(|| format!("evaluating {:?}", v))
            }))
            .collect::<Result<Vec<StringComponent>>>()?;
          Ok(Eval::Nix(Expr::Str(parts).canonicalize()))
        }
      },

      List(l) => Ok(Eval::List(
        l.into_iter()
        .map(|v| Eval::evaluate(v, c))
        // drop all elements which evaluate to false / undefined
        .filter(|result| result.as_ref().map(Eval::truthy).unwrap_or(true /* include failed */))
        .collect::<Result<Vec<Eval>>>()?
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
          | Slash
          | Colon
          => Err(anyhow!("Unimplemented: evaluate(UnaryOp({:?}, _))", op))?
        }
      },
      Binop(binop) => {
        let parser::Binop { a, op, b } = *binop;
        // TODO: it's a bit annoying that we need to clone here...
        let a_eval = || Self::evaluate(a.clone(), c);
        let b_eval = || Self::evaluate(b.clone(), c);
        let a_bool = || a_eval().and_then(|x| x.as_bool());
        let b_bool = || b_eval().and_then(|x| x.as_bool());
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

          Eq => Ok(match a_eval()?.partial_cmp(&b_eval()?) {
            Some(b) => Eval::Bool(b == Ordering::Equal),
            None => Eval::Nix(Expr::LitSeq(vec!(
              a.into_nix(c)?,
              Expr::Literal("==".to_owned()),
              b.into_nix(c)?,
            ))),
          }),

          Slash => Ok(Eval::StrInterp(vec!(
            EvalSC::Expr(Self::evaluate(a, c)?),
            EvalSC::Literal("/".to_owned()), // TODO windows?
            EvalSC::Expr(Self::evaluate(b, c)?)
          ))),

          Colon => Ok(Eval::StrInterp(vec!(
            EvalSC::Expr(Self::evaluate(a, c)?),
            EvalSC::Literal(":".to_owned()), // TODO windows?
            EvalSC::Expr(Self::evaluate(b, c)?)
          ))),

          Neq
          | Not
          | Question
          => Err(anyhow!("Unimplemented: evaluate(Binop(_, {:?}, _))", op))?
        }
      },
      Ternop(op) => {
        let parser::Ternop { test, iftrue, iffalse } = *op;
        Ok(Eval::Nix(Expr::LitSeq(vec!(
          Expr::Literal("if".to_owned()),
          test.into_nix(c)?,
          Expr::Literal("then".to_owned()),
          iftrue.into_nix(c)?,
          Expr::Literal("else".to_owned()),
          iffalse.into_nix(c)?,
        ))))
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

  pub fn into_nix<C: NixCtx>(self, c: &C) -> Result<Expr> {
    match self {
      Eval::Nix(expr) => Ok(expr),
      Eval::Undefined => Ok(Expr::Str(Vec::new())),
      Eval::Bool(b) => Ok(Expr::Bool(b)),
      Eval::Str(s) => Ok(Expr::str(s)),
      Eval::StrInterp(parts) => {
        let nix_parts = parts.into_iter()
          .map(|part| part.map_result(|eval| eval.into_nix(c)))
          .collect::<Result<Vec<StringComponent>>>();
        Ok(Expr::Str(nix_parts?))
      },
      Eval::List(l) => {
        let exprs = l.into_iter().map(|x| x.into_nix(c)).collect::<Result<Vec<Expr>>>()?;
        Ok(Expr::List(exprs))
      },
    }
  }
}

impl PartialOrd for Eval {
  fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
    // statically evaluates equality for certain simple types
    let result = match (self, other) {
      (Eval::Bool(a), Eval::Bool(b)) => Some(a.cmp(b)),
      // TODO implement version ordering for inequal strings
      (Eval::Str(a), Eval::Str(b)) => Some(a.cmp(b)),
      _ => None,
    };
    debug!("partial_cmp({:?}, {:?}) => {:?}", self, other, result);
    result
  }
}


#[cfg(test)]
mod tests {
  use super::*;
  
  fn resolve(p: &'static str) -> Vec<StringComponent> {
    let name = Name("mypkg".to_owned());
    let pkg = PkgImpl {
      path: out(),
      name: Some(&name),
    };
    match Ctx::resolve_path(pkg, p) {
      Ok(Eval::Nix(Expr::Str(v))) => v,
      other => panic!("Expected nix str, got {:?}", other),
    }
  }
  
  fn out() -> Expr {
    Expr::str("$out".to_owned())
  }

  fn site_lib() -> StringComponent {
    StringComponent::Expr(Expr::FunCall(Box::new(FunCall {
      subject: Expr::Literal("final.siteLib".to_owned()),
      args: vec!(out()),
    })))
  }

  #[test]
  fn test_paths() {
    assert_eq!(
      resolve("lib"),
      vec!(site_lib(), StringComponent::Literal("/mypkg".to_owned()))
    );
    for dir in vec!("man", "doc", "share", "bin") {
      assert_eq!(
        resolve(dir),
        vec!(
          StringComponent::Expr(out()),
          StringComponent::Literal(format!("/{}", dir)),
        )
      );
    }
    assert_eq!(
      resolve("stublibs"),
      vec!(site_lib(), StringComponent::Literal("/stublibs/mypkg".to_owned()))
    );
    assert_eq!(
      resolve("toplevel"),
      vec!(site_lib(), StringComponent::Literal("/toplevel/mypkg".to_owned()))
    );
  }
}
