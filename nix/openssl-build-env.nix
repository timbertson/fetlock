{ openssl }: {
	# required for openssl-sys; see
	# https://github.com/sfackler/rust-openssl/blob/2c0c391f8abea99abdf016175d5d7c257891541d/openssl-sys/build/find_normal.rs
	OPENSSL_LIB_DIR="${openssl.out}/lib";
	OPENSSL_INCLUDE_DIR="${openssl.dev}/include";
}
