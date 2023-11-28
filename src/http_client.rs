use lazy_static::*;
use reqwest::{ClientBuilder, Client, IntoUrl, Response};

lazy_static! {
	static ref INSTANCE: Client = ClientBuilder::new()
		// rustls supports SSL_CERT_FILE, so use that
		.use_rustls_tls()
		.build()
		.expect("Couldn't construct HTTP client");
}

pub fn instance() -> &'static Client {
	&INSTANCE
}

pub async fn get<T: IntoUrl>(url: T) -> reqwest::Result<Response> {
	instance().get(url).send().await
}
