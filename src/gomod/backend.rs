use std::collections::{HashMap, BTreeMap};

use anyhow::*;
use async_trait::async_trait;
use tokio::process::Command;

use crate::*;


#[derive(Clone, Debug)]
pub struct GoLock(Lock<Spec>);

impl GoLock {
	fn src_for(id: Id, sum: Option<String>, modfile_sum: Option<String>) -> CustomSrc {
		let Id { name, version } = id.clone();
		let mut attrs = BTreeMap::new();
		attrs.insert("name".to_owned(), Expr::str(name));
		attrs.insert("version".to_owned(), Expr::str(version));
		if let Some(sum) = sum {
			attrs.insert("goSum".to_owned(), Expr::str(sum));
		}
		if let Some(sum) = modfile_sum {
			attrs.insert("goModSum".to_owned(), Expr::str(sum));
		}
		CustomSrc {
			fn_name: "final.fetchGoModule",
			id,
			attrs,
		}
	}
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
	type Spec = lock::Spec;

	async fn load(src: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		let sum_path = src.lock_path();

		let sum_file = fs_util::read_to_string(&sum_path)?;
		let mut mod_sums = sum_file
			.lines()
			.map(|l| l.trim())
			.filter(|l| !l.is_empty())
			.map(|line| {
				let result: Result<(Id, String)> = (|| {
					let err = || { anyhow!("Invalid go.sum line: {}", line) };
					let mut it = line.split(char::is_whitespace);
					let name = it.next().ok_or_else(err)?.to_owned();
					let version = it.next().ok_or_else(err)?.to_owned();
					let hash = it.next().ok_or_else(err)?.to_owned();
					Ok((Id { name, version }, hash))
				})();
				result
			})
			.collect::<Result<HashMap<Id, String>>>()?;

		let graph_output = cmd::run_stdout(
			"go mod graph", None,
			Command::new("go")
				.arg("mod")
				.arg("graph")
				.current_dir(sum_path.parent().unwrap()),
		).await?;

		let ctx = LockContext::new(lock::Type::Go);
		let mut first = true;
		let mut lock: Lock<Spec> = Lock::new(ctx);
		
		for full_line in graph_output.lines() {
			let line = full_line.trim();
			if line.is_empty() {
				continue;
			}
			let (pkg, dependency) = line.split_once(char::is_whitespace)
				.ok_or_else(|| anyhow!("invalid `go mod graph` line: {}", line))?;

			let dep = Key::new(dependency.to_owned());
			match lock.specs.get_mut(pkg) {
			// match map.get_mut(pkg) {
				Some(v) => v.dep_keys.push(dep),
				None => {
					let mut spec = PartialSpec::empty();

					let mut it = pkg.split('@');
					let name = it.next().unwrap();
					let id = Id::new(name.to_owned(), it.next().map(|s| s.to_owned()));
					spec.id = id.clone().into();
					spec.add_dep(dep);

					if first {
						spec.set_src(Src::None);
					} else {
						// TODO more clarity around silently dropping modules without sums here
						let sum = mod_sums.remove(&id);
						if let Some(sum) = sum {
							// TODO remove Some
							// This is very weird, but it saves us having to parse `/go.mod` at input time
							let modfile_sum = mod_sums.remove(&Id {
								name: id.name.clone(),
								version: format!("{}/go.mod", id.version),
							});
							let short_name = Expr::str(id.name.rsplit('/').next().unwrap().to_owned());
							spec.set_src(Src::Custom(GoLock::src_for(id, Some(sum), modfile_sum)));
							spec.extra.insert("pname".to_owned(), short_name);
						} else {
							continue;
						}
						// match sum {
						// 	None => {
						// 		let mut keys: Vec<&Id> = mod_sums.keys().collect();
						// 		keys.sort();
						// 		for key in keys {
						// 			warn!("[sum] {:?}", key);
						// 		}
						// 		return Err(anyhow!("Module not present in go.sum: {:?}", id))
						// 	},
						// }
					}
					lock.add_impl(Key::new(pkg.to_owned()), spec.build()?);
				},
			}

			// assume first line is root module
			if first {
				lock.context.root = lock::Root::Package(Key::new(pkg.to_owned()));
				first = false;
			}
		}
		Ok(GoLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		Ok(self.0)
	}
}
