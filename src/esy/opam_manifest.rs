use crate::opam::opam2nix::{SelectedPackage, Command, Depexts};
use crate::esy::parser;
use crate::esy::build::*;
use crate::esy::eval::*;
use crate::esy::parser::opam::*;
use crate::esy::parser::*;
use crate::Expr;
use anyhow::*;

// public struct, containing only what we need for fetlock purposes
#[derive(Clone, Debug)]
pub struct Opam<'a> {
	build: Option<Value<'a>>,
	install: Option<Value<'a>>,
	depexts: Vec<Value<'a>>,
}

pub struct OpamJson<'a>(pub &'a SelectedPackage);
impl<'a> OpamJson<'a> {
	fn parse_str<'s>(s: &'s str) -> Result<Value<'s>> {
		parser::parse(parser::opam::entire_string, &s)
			.with_context(|| format!("Parsing opam string: {:?}", s))
	}

	fn parse_cmd<'c>(script: &'c Vec<Command>) -> Result<Value<'c>> {
		let values: Vec<Value<'c>> = script.iter().map(|cmd|
			cmd.0.iter().map(|arg| Self::parse_str(arg)).collect::<Result<Vec<Value<'c>>>>().map(Value::List)
		).collect::<Result<Vec<Value<'c>>>>()?;
		Ok(Value::List(values))
	}

	pub fn build<'c, C: NixCtx>(self, ctx: &C) -> Result<NixBuild> {
		let mut nix_build = NixBuild::empty(PkgType::Opam);
		let SelectedPackage {
			depexts,
			build_commands,
			install_commands,
			..
		} = self.0;
		let parsed = Self::parse_cmd(&build_commands)?;
		nix_build.build = Some(NixBuild::script(PkgType::Opam, ctx, parsed)?);

		let parsed = Self::parse_cmd(&install_commands)?;
		nix_build.install = Some(NixBuild::script(PkgType::Opam, ctx, parsed)?);
		
		let Depexts { required, optional } = depexts;

		if required.len() > 0 {
			nix_build.depexts = Some(Expr::List(required.iter().map(|d| Expr::str(d.to_owned())).collect()));
		}
		
		if optional.len() > 0 {
			// TODO these aren't referenced by the nix frontend yet
			nix_build.depext_opts = Some(Expr::List(optional.iter().map(|d| Expr::str(d.to_owned())).collect()));
		}

		Ok(nix_build)
	}
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
				FileItem::FieldBinding(b) => match b.ident {
					"build" => build = Some(b.value),
					"install" => install = Some(b.value),
					"depexts" => match b.value {
						Value::List(deps) => depexts = Some(deps),
						_ => todo!(),
					},
					_ => (),
				},
				FileItem::Section(_) => (),
			}
		}
		Self {
			build,
			install,
			depexts: depexts.unwrap_or_else(|| Vec::new()),
		}
	}

	pub fn into_nix<'c: 'a, Ctx: NixCtx>(self, ctx: &'c Ctx) -> Result<NixBuild> {
		let Self {
			build,
			install,
			depexts,
		} = self;
		let mode = PkgType::Opam;

		let mut depexts = Some(Value::List(depexts).into_nix(ctx)?.flatten());
		// suppress empty depexts
		if let Some(Expr::List(l)) = &depexts {
			if l.len() == 0 {
				depexts = None;
			}
		}

		Ok(NixBuild {
			mode,
			depexts,
			depext_opts: None,
			build: build.map_or(Ok(None), |x| NixBuild::script(mode, ctx, x).map(Some))?,
			install: install.map_or(Ok(None), |x| NixBuild::script(mode, ctx, x).map(Some))?,
			extra: Default::default(),
		})
	}
}
