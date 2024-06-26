use crate::*;
use anyhow::*;
use log::*;
use serde;
use std::collections::{BTreeMap, HashMap};
use std::path::PathBuf;
use tokio::process;

// Input
#[derive(Clone, Debug, serde::Serialize)]
pub struct Repository {
	pub id: String,
	pub path: PathBuf,
}

#[derive(Clone, Debug)]
pub enum OpamSource {
	Path(PathBuf),
	Contents(String),
}

impl serde::Serialize for OpamSource {
	fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
	where
		S: serde::Serializer,
	{
		use serde::ser::*;
		match self {
			Self::Path(path) => path.serialize(serializer),
			Self::Contents(contents) => {
				let mut s = serializer.serialize_struct("opam_source", 1)?;
				s.serialize_field("contents", &contents)?;
				s.end()
			}
		}
	}
}

#[derive(Clone, Debug, serde::Serialize)]
pub struct DirectSpec {
	pub name: String,
	pub version: Option<String>,
	pub definition: OpamSource,
}

#[derive(Clone, Debug, serde::Serialize)]
pub struct SolveSpec {
	pub name: String,

	#[serde(skip_serializing_if = "Option::is_none")]
	pub constraints: Option<Vec<(&'static str, String)>>,

	pub definition: Option<OpamSource>,
}

#[derive(Clone, Debug, serde::Serialize)]
pub struct Request {
	pub ocaml_version: Option<String>,
	pub repositories: Vec<Repository>,
	pub spec: Option<Vec<SolveSpec>>,
	pub selection: Option<Vec<DirectSpec>>,
}

// Output
#[derive(Clone, Debug, serde::Deserialize)]
pub struct Src {
	pub url: String,
	pub digests: Vec<(String, String)>,
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct Command(pub Vec<String>);

#[derive(Clone, Debug, Default, serde::Deserialize)]
pub struct Depexts {
	#[serde(default)]
	pub required: Vec<String>,

	#[serde(default)]
	pub optional: Vec<String>,
}

impl Depexts {
	pub fn is_empty(&self) -> bool {
		self.required.is_empty() && self.optional.is_empty()
	}
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct SelectedPackage {
	pub version: String,

	#[serde(default)]
	pub repository: Option<String>,

	pub src: Option<Src>,

	#[serde(default)]
	pub extra_sources: BTreeMap<String, Src>,

	#[serde(default)]
	pub depends: Vec<Key>,

	#[serde(default)]
	pub depexts: Depexts,

	pub build_commands: Vec<Command>,
	pub install_commands: Vec<Command>,
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct Solution(pub HashMap<String, SelectedPackage>);

pub async fn solve(request: &Request) -> Result<Solution> {
	let serialized_request = serde_json::to_string_pretty(&request)?;
	info!("invoking opam solver");

	let mut command = process::Command::new("opam2nix");
	command.arg("extract");
	if log_enabled!(log::Level::Debug) {
		command.env("OPAM2NIX_VERBOSE", "1");
	}
	let contents =
		cmd::run_stdout("opam2nix extract", Some(&serialized_request), &mut command).await?;
	debug!("opam2nix extract result: {}", &contents);
	Ok(serde_json::from_str(&contents)?)
}
