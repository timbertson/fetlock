use log::*;

#[tokio::main]
async fn main() {
	match fetlock::cli::main().await {
		Ok(()) => (),
		Err(e) => {
			error!("{:?}", e);
			std::process::exit(1)
		}
	}
}
