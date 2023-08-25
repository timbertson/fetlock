use log::*;
use serde::*;
use netrc_rs::*;
use crate::{cmd, fs_util};
use tokio::process::Command;
use anyhow::{*, Result};

pub struct Auth {
	contents: Option<Netrc>,
}

#[derive(Deserialize)]
struct NixConfig {
	#[serde(rename = "name")]
	netrc_file: NetrcFileConfig,
}

#[derive(Deserialize)]
struct NetrcFileConfig {
	value: String,
}

impl Auth {
	pub fn new() -> Self { Auth { contents: None } }
	
	pub async fn load(&mut self) -> Result<&Netrc> {
		if let None = self.contents {
			let nix_config_json = cmd::run_stdout("nix-config", None, Command::new("nix-config")
				.arg("--extra-experimental-features")
				.arg("nix-command")
				.arg("show-config")
				.arg("--json")
			).await?;
			let nix_config: NixConfig = serde_json::from_str(&nix_config_json)
				.context("parsing nix-config")?;
			let netrc_path = nix_config.netrc_file.value;
			self.contents = Some(match Self::load_netrc(&netrc_path) {
				Ok(contents) => contents,
				Err(err) => {
					debug!("Couldn't load netrc {}: {}", &netrc_path, &err);
					Netrc::default()
				},
			})
		}
		self.contents.as_ref().ok_or_else(|| anyhow!("impossible"))
	}
	
	fn load_netrc(path: &str) -> Result<Netrc> {
		let contents = fs_util::read_to_string(&path)?;
		Ok(Netrc::parse(&contents, false).map_err(|_| anyhow!("Can't parse netrc"))?)
	}

}
