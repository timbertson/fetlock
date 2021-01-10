use crate::esy::backend::EsyImpl;
use anyhow::*;

enum Manifest {
	Path(String),
	Coments(String),
	Unknown, // TODO can we ever drop this?
}

// This may involve actually downloading a file, so we
// do it async
async fn get_manifest(i: &EsyImpl) -> Result<Manifest> {
	Err(anyhow!("TODO"))
}
