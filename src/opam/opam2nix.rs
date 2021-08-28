use crate::*;
use anyhow::*;
use log::*;
use serde;
use std::collections::HashMap;
use std::path::PathBuf;
use tokio::process;

// Input
#[derive(Clone, Debug, serde::Serialize)]
pub struct Repository {
	pub id: String,
	pub path: PathBuf,
}

#[derive(Clone, Debug, serde::Serialize)]
pub struct DirectSpec {
	pub name: String,
	pub version: Option<String>,
	pub definition: PathBuf,
}

#[derive(Clone, Debug, serde::Serialize)]
pub struct Request {
	pub repositories: Vec<Repository>,
	pub spec: Option<Vec<DirectSpec>>,
	pub solution: Option<Vec<DirectSpec>>,
}

// Output
#[derive(Clone, Debug, serde::Deserialize)]
pub struct Src {
	pub url: String,
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct Command(Vec<String>);

#[derive(Clone, Debug, Default, serde::Deserialize)]
pub struct Depexts {
	#[serde(default)]
	pub required: Vec<String>,

	#[serde(default)]
	pub optional: Vec<String>,
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct SelectedPackage {
	pub version: String,

	#[serde(default)]
	pub repository: Option<String>,

	pub src: Option<Src>,

	#[serde(default)]
	pub depends: Vec<String>,

	#[serde(default)]
	pub depexts: Depexts,

	pub build_commands: Vec<Command>,
	pub install_commands: Vec<Command>,
}

#[derive(Clone, Debug, serde::Deserialize)]
pub struct Solution(pub HashMap<String, SelectedPackage>);

pub async fn solve(request: &Request) -> Result<Solution> {
	let serialized_request = serde_json::to_string(&request)?;

	info!("invoking opam solver");
	let contents = cmd::run_stdout(
		"opam2nix extract",
		Some(&serialized_request),
		process::Command::new("opam2nix").arg("extract"),
	)
	.await?;

	Ok(serde_json::from_str(&contents)?)
}
