use std::collections::HashMap;
use log::*;

use anyhow::*;
use async_trait::async_trait;
use tokio::process::Command;

use crate::{Backend, Spec, Lock, LocalSrc, WriteOpts, AsSpec, cmd, LockContext, lock};


#[derive(Clone, Debug)]
pub struct GoLock(Lock<GoSpec>);

#[derive(Clone, Debug)]
pub struct GoSpec {
	spec: Spec,
}

/*

`go` cmds:

 - go mod graph:
   space-separated lines of [pkg] [dep]
 - go mod download -json
   (add -x to print status, but that might interfere)


 for `src`, we can run
 - go mod download -json `pkgid`
   same output format, produces a single dir
   
   (note: can we guess or encode the dir instead of parsing JSON in bash?)
  
 https://github.com/tweag/gomod2nix/blob/master/builder/fetch.sh
*/

#[async_trait(?Send)]
impl Backend for GoLock {
	type Spec = GoSpec;

	async fn load(src: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		let lock_path = src.lock_path();
		let output = cmd::run_stdout(
			"go mod graph", None,
			Command::new("go")
				.arg("mod")
				.arg("graph")
				.current_dir(lock_path.parent().unwrap()),
		).await?;
		let mut map: HashMap<String, Vec<String>> = HashMap::new();
		for full_line in output.lines() {
			let line = full_line.trim();
			if line.is_empty() {
				continue;
			}
			let (pkg, dependency) = line.split_once(char::is_whitespace)
				.ok_or_else(|| anyhow!("invalid `go mod graph` line: {}", line))?;
			match map.get_mut(pkg) {
				Some(v) => v.push(dependency.to_owned()),
				None => {
					map.insert(pkg.to_owned(), vec!(dependency.to_owned()));
				},
			}
		}
		error!("got dep map: {:?}", map);
		let ctx = LockContext::new(lock::Type::Go);
		let lock = Lock::new(ctx);
		Ok(GoLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}
}


// TODO is this needed?
impl AsSpec for GoSpec {
	fn wrap(spec: Spec) -> Self {
		GoSpec {
			spec,
		}
	}
	fn as_spec_ref(&self) -> &Spec {
		&self.spec
	}
	fn as_spec_mut(&mut self) -> &mut Spec {
		&mut self.spec
	}
}
