use anyhow::*;
use std::collections::HashMap;
use crate::esy::opam_parser::*;
use crate::{Expr, Key, FunCall};

// public struct, containing only what we need for fetlock purposes
#[derive(Clone, Debug)]
pub struct Opam<'a> {
  build: Option<Value<'a>>,
  install: Option<Value<'a>>,
  depexts: Vec<Value<'a>>,
}

pub trait NixCtx<'a> {
  fn name(&self) -> &'a str;
  fn lookup_opam(&self, opam_name: &'a str) -> Option<&'a Key>;
}

pub struct NixCtxMap<'a> {
  name: &'a str,
  map: &'a HashMap<String, Key>
}

impl<'a> NixCtx<'a> for NixCtxMap<'a> {
  fn name(&self) -> &'a str { self.name }
  fn lookup_opam(&self, opam_name: &str) -> Option<&'a Key> {
    self.map.get(opam_name)
  }
}

pub enum VarScope<'a> {
  Global,
  SelfScope,
  Package(Option<&'a Key>),
}

pub struct Ctx;
impl Ctx {
  // for testing
  pub fn from_map<'a>(name: &'a str, map: &'a HashMap<String, Key>) -> NixCtxMap<'a> {
    NixCtxMap { name, map }
  }

  pub fn resolve<'a, 'expr: 'a, Ctx: NixCtx<'a>>(ctx: &Ctx, scope: VarScope<'a>, ident: &'expr str) -> Expr {
    match scope {
      VarScope::Global => match ident {
        // re-resolve specials against Self
        "name" => Self::resolve(ctx, VarScope::SelfScope, ident),
        "version" => Self::resolve(ctx, VarScope::SelfScope, ident),

        "jobs" => Expr::Str("$NIX_BUILD_CORES".to_owned()),
        other if other == ctx.name() => Expr::Str("$out".to_owned()),
        other => {
          match ctx.lookup_opam(other) {
            Some(key) => Expr::FunCall(Box::new(FunCall {
              subject: Expr::Literal("getDrv".to_owned()),
              args: vec!(Expr::Str(key.as_str().to_owned()))
            })),
            None => panic!("TODO unknown global: {:?}", other),
          }
        }
      },
      VarScope::SelfScope => match ident {
        "name" => Expr::Str(ctx.name().to_owned()),
        "version" => todo!(),
        other => panic!("TODO unknown self: {:?}", other),
      },
      VarScope::Package(key) => match ident {
        "installed" => Expr::Str(format!("{}", key.is_some())), // TODO this only works as a flag, not a filter
        other => match key {
          None => todo!("need to suppress entire surrounding expression (undefined)"),
          Some(key) => match ident {
            other => panic!("TODO unknown pakckage[{:?}] var: {:?}", key, other),
          }
        }
      },
    }
  }

  fn scope<'a, 'expr : 'a, Ctx: NixCtx<'a>>(ctx: &Ctx, scope: &'expr str) -> VarScope<'a> {
    match scope {
      "_" => VarScope::SelfScope,
      name if name == ctx.name() => VarScope::SelfScope,
      other => VarScope::Package(ctx.lookup_opam(other))
    }
  }

  pub fn resolve_ident<'a, Ctx: NixCtx<'a>>(ctx: &Ctx, ident: &'a str) -> Expr {
    Self::resolve(ctx, VarScope::Global, ident)
  }

  pub fn resolve_varident<'a, Ctx: NixCtx<'a>>(ctx: &Ctx, ident: &Varident<'a>) -> Expr {
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

#[derive(Clone, Debug)]
pub enum Depext {
  Mandatory(String),
  IfPresent(String),
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
            "depexts" => {
              match b.value {
                Value::List(deps) => depexts = Some(deps),
                _ => todo!(),
              }
            }
            _ => (),
          }
        },
        FileItem::Section(_) => (),
      }
    }
    Self { build, install, depexts: depexts.unwrap_or_else(||Vec::new()) }
  }
  
  fn add_sep<T: Clone>(vec: &mut Vec<T>, first: &mut bool, sep: &T) {
    if *first {
      *first = false;
    } else {
      vec.push(sep.clone());
    }
  }

  fn bash_of_commands(cmds: Expr) -> Result<Expr> {
    // Takes an opam command spec [[make "..."]]
    // and returns a multi-line bash string.
    // TODO: add quotes / escapes where necessary
    use crate::StringComponent;
    let mut buf = Vec::new();
    
    let newline = StringComponent::Literal("\n".to_owned());
    let space = StringComponent::Literal(" ".to_owned());

    match cmds {
      Expr::List(cmds) => {
        let mut first_cmd = true;
        if cmds.len() > 1 {
          // always start a multiline string with a newline
          first_cmd = false;
        }

        for cmd in cmds {
          match cmd {
            Expr::List(args) => {
              Self::add_sep(&mut buf, &mut first_cmd, &newline);
              let mut first_arg = true;

              for arg in args {
                Self::add_sep(&mut buf, &mut first_arg, &space);
                match arg {
                  Expr::Str(s) => buf.push(StringComponent::Literal(s)),
                  Expr::StrInterp(s) => buf.extend(s),
                  _ => todo!(),
                };
              }
            },
            _ => todo!(),
          }
        }
      },
      _ => todo!(),
    }
    Ok(Expr::StrInterp(buf))
  }

  pub fn into_nix<'c, Ctx: NixCtx<'c>>(self, ctx: &Ctx) -> Result<Nix> where 'a : 'c {
    let Self { build, install, depexts } = self;
    Ok(Nix {
      build: build.map_or(Ok(None), |x| x.into_nix(ctx).and_then(Self::bash_of_commands).map(Some))?,
      install: install.map_or(Ok(None), |x| x.into_nix(ctx).and_then(Self::bash_of_commands).map(Some))?,
      depexts: depexts.into_iter().map(|x| x.into_nix(ctx)).collect::<Result<Vec<Expr>>>()?,
    })
  }
}

#[derive(Clone, Debug)]
pub struct Nix {
  pub build: Option<Expr>,
  pub install: Option<Expr>,
  pub depexts: Vec<Expr>,
}

impl Nix {
  pub fn expr(self) -> Expr {
    let mut map = HashMap::new();
    let Self { build, install, depexts } = self;

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