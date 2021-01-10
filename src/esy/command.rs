use crate::esy::backend::EsySpec;
use anyhow::*;

#[derive(Debug, Clone)]
pub enum Manifest {
	Path(String),
	Coments(String),
	Unknown, // TODO can we ever drop this?
}

// This may involve actually downloading a file, so we
// do it async
async fn get_manifest(i: &EsySpec) -> Result<Manifest> {
	Err(anyhow!("TODO"))
}
