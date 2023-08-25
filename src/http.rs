use std::collections::HashMap;

use log::*;
use serde::*;
use netrc_rs::*;
use crate::{cmd, fs_util};
use tokio::process::Command;
use anyhow::{*, Result};
use data_encoding::BASE64;

pub struct Client {
	client: reqwest::Client,
	auth: CredentialHeaders,
}

impl Client {
	pub async fn system() -> Result<Self> {
		let netrc = Self::load_netrc().await.unwrap_or_else(|_| Netrc::default());
		let auth = CredentialHeaders::compile(netrc);
		Ok(Client { auth, client: reqwest::Client::new() })
	}
	
	async fn load_netrc() -> Result<Netrc> {
		// we could probably pase this faster ourselves, but this is convenient...
		let nix_config_json = cmd::run_stdout("nix-config", None, Command::new("nix-config")
			.arg("--extra-experimental-features")
			.arg("nix-command")
			.arg("show-config")
			.arg("--json")
		).await?;
		let nix_config: NixConfig = serde_json::from_str(&nix_config_json)
			.context("parsing nix-config")?;
		let path = nix_config.netrc_file.value;
		let contents = fs_util::read_to_string(&path)?;
		debug!("Loading netrc: {}", &path);
		Ok(Netrc::parse(&contents, false).map_err(|_| anyhow!("Can't parse netrc at {}", &path))?)
	}
	
	pub async fn get(&self, u: &str) -> Result<reqwest::Response> {
		let url = reqwest::Url::parse(u)?;
		self.get_url(url).await
	}

	pub async fn get_url(&self, url: reqwest::Url) -> Result<reqwest::Response> {
		let url_desc = url.clone();
		let auth_token = url.host_str()
			.and_then(|host| self.auth.0.get(host));
		
		let mut req = self.client.request(reqwest::Method::GET, url);

		debug!("GET {} ({})",
			url_desc.as_str(), match auth_token {
				None => "anonymous",
				Some(ref creds) => &creds.login,
			});

		if let Some(token) = auth_token {
			req = req.header("Authorization", &token.auth_header);
		}

		let response = req.send().await
			.with_context(|| format!("GET {}", url_desc.as_str()))?;
		Ok(response)
	}
}

// Precomputed headers for all hosts defined in netrc
// (the assumption being we'll make more than one request to
// a private host, so we might as well precompute these)
struct CredentialHeaders(HashMap<String, HostCredentials>);
struct HostCredentials {
	login: String,
	auth_header: String,
}

impl CredentialHeaders {
	fn compile(netrc: Netrc) -> CredentialHeaders {
		let map = netrc.machines.into_iter().filter_map(|machine| {
			let Machine { name, login, password, account } = machine;
			name.as_deref().and_then(|machine_name| {
				match (login, password) {
					(Some(login), Some(password)) => {
						let kv = format!("{}:{}", login, password);
						debug!("Loaded netrc authorization for host {}", &machine_name);
						Some((
							machine_name.to_owned(),
							HostCredentials {
								login: login,
								auth_header: format!("basic {}", BASE64.encode(&kv.as_bytes())),
							}))
					},
					_ => {
						debug!("netrc entry for {} is missing login/password", &machine_name);
						None
					},
				}
			})
		}).collect();
		CredentialHeaders(map)
	}
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
