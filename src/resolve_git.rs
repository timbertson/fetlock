use crate::cmd;
use crate::string_util::*;
use anyhow::*;
use log::*;
use tokio::process::Command;

#[derive(Clone, Debug)]
pub struct Commit(String);

#[derive(Clone, Debug)]
struct Resolution<'a> {
	names: Vec<&'a str>,
	commit: &'a str,
}

/*
Git ref is resolved though:
$ git ls-remote ~/dev/ocaml/gup/
$ git ls-remote https://github.com/timbertson/gup.git
Output: lines of `SHA<tab>ref`
*/

pub async fn resolve(remote: &str, commitish: &str) -> Result<String> {
	if commitish.len() == 40 && commitish.chars().all(|ch| ch.is_ascii_hexdigit()) {
		Ok(commitish.to_owned())
	} else {
		let output = cmd::run_stdout(
			"git ls-remote",
			None,
			Command::new("git").arg("ls-remote").arg(remote),
		)
		.await?;
		for resolution in parse_lines(&output) {
			debug!("Git ref: {:?}", resolution);
			let resolution = resolution?;
			if resolution.names.contains(&commitish) {
				info!(
					"[{}]: resolved {} -> {}",
					remote, commitish, resolution.commit
				);
				return Ok(resolution.commit.to_owned());
			}
		}
		Err(anyhow!(
			"Can't resolve {} to a git commit in {}",
			commitish,
			remote
		))
	}
}

fn parse_lines(contents: &str) -> impl Iterator<Item = Result<Resolution>> {
	contents.lines().map(|line| {
		split_one_or_else("\t", line, || anyhow!("Invalid ls-remote line: {:?}", line)).map(
			|(commit, name)| {
				let mut names = vec![name];
				let mut add_alias = |prefix| {
					if let Some(remainder) = name.strip_prefix(prefix) {
						names.push(remainder)
					}
				};
				add_alias("refs/heads/");
				add_alias("refs/tags/");
				Resolution { names, commit }
			},
		)
	})
}
