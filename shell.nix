{
	pkgs ? import <nixpkgs> {},
	fetlockBackends ? (import ./nix/backends.nix).default,
}:
with pkgs;
mkShell ({
	RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
	FETLOCK_NIX = toString ./nix;
	FETLOCK_BUNDLER = toString ./src/bundler;

	buildInputs = [ cargo rustc rustfmt rust-analyzer libiconv openssl.dev ] ++ (
		lib.optional stdenv.isDarwin apple-sdk
	) ++ (callPackage ./nix/runtimeDeps.nix {} fetlockBackends);
} // (import ./nix/openssl-build-env.nix { inherit openssl; }))
