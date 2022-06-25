use std::collections::BTreeMap;

use anyhow::*;
use async_trait::async_trait;

use crate::*;


#[derive(Clone, Debug)]
pub struct GoLock(Lock<Spec>);

impl GoLock {
	fn vendor_src_for(src: &SrcDigest) -> CustomFetch {
		let mut attrs = BTreeMap::new();
		attrs.insert("src".to_owned(), src.as_expr());
		CustomFetch {
			fn_name: "fetchGoModules",
			cache_key: format!("{:?}", &src.src),
			attrs,
		}
	}
}

#[async_trait(?Send)]
impl Backend for GoLock {
	type Spec = lock::Spec;

	async fn load(src: &LocalSrc, opts: &WriteOpts) -> Result<Self> {
		let sum_path = src.lock_path();

		let mut mod_path = sum_path.clone();
		mod_path.set_file_name("go.mod");
		let mod_file = fs_util::read_to_string(&mod_path)?;

		let full_name = mod_file
			.lines()
			.map(|l| l.trim())
			.flat_map(|l| {
				l.strip_prefix("module").map(|m| m.trim())
			})
			.next()
			.ok_or_else(|| anyhow!("Error: no `module` line found in {:?}", &mod_path))?;
		
		let name = full_name.rsplit('/').next().unwrap();

		let mut builder = PartialSpec::empty();
		builder.id.set_name(name.to_owned());
		builder.set_src(Src::None);
		let spec = builder.build()?;

		let key = Key::from_id(&spec.id);

		let ctx = LockContext::new(lock::Type::Go);
		let mut lock: Lock<Spec> = Lock::new(ctx);
		lock.context.root = lock::Root::Package(key.clone());

		lock.add_impl(key, spec);

		Ok(GoLock(lock))
	}

	fn lock_mut(&mut self) -> &mut Lock<Self::Spec> {
		&mut self.0
	}

	async fn finalize(mut self) -> Result<Lock<Self::Spec>> {
		// fetlock populates `src`, but we need to also populate the vendor digest.
		for spec in self.0.specs.values_mut() {
			let mut mod_spec = spec.clone();

			// TODO how to pass in local src?
			let src_digest = spec.src_digest().ok_or_else(|| anyhow!("Src digest not populated"))?;

			mod_spec.src = Src::Custom(GoLock::vendor_src_for(&src_digest));
			mod_spec.digest = None;
			fetch::ensure_digest(&mut mod_spec).await?;
			let hash = mod_spec.digest.ok_or_else(|| anyhow!("digest not populated"))?.sri_string();
			spec.extra.insert("vendorSha256".to_owned(), Expr::str(hash));
		}
		Ok(self.0)
	}
}
