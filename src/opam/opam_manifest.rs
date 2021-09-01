use crate::opam::build::*;
use crate::opam::eval::*;
use crate::opam::parser;
use crate::opam::parser::*;
use crate::opam::opam2nix::{Command, SelectedPackage};
use anyhow::*;

// OPAM file as serialized by opam2nix extract (JSON)
pub struct OpamJson<'a>(pub &'a SelectedPackage);
impl<'a> OpamJson<'a> {
	fn parse_str<'s>(s: &'s str) -> Result<Value<'s>> {
		parser::parse(parser::opam::entire_string, &s)
			.with_context(|| format!("Parsing opam string: {:?}", s))
	}

	fn parse_cmd<'c>(script: &'c Vec<Command>) -> Result<Value<'c>> {
		let values: Vec<Value<'c>> = script
			.iter()
			.map(|cmd| {
				cmd.0
					.iter()
					.map(|arg| Self::parse_str(arg))
					.collect::<Result<Vec<Value<'c>>>>()
					.map(Value::List)
			})
			.collect::<Result<Vec<Value<'c>>>>()?;
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

		nix_build.depexts = depexts.clone();

		Ok(nix_build)
	}
}
