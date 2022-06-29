
// This is set to $PWD/nix in a development shell (e.g. shell.nix).
// When building from nix, it's set to ${src}/nix, so it'll be
// a nix store path.
const FETLOCK_NIX: Option<&'static str> = option_env!("FETLOCK_NIX");

pub fn nix() -> &'static str {
	FETLOCK_NIX.unwrap_or("./nix")
}

const FETLOCK_BUNDLER: Option<&'static str> = option_env!("FETLOCK_BUNDLER");

pub fn bundler() -> &'static str {
	FETLOCK_BUNDLER.unwrap_or("./src/bundler")
}
