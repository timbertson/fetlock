{
	pkgs ? import <nixpkgs> {},
	fetlockBackends ? (import ./nix/backends.nix).default,
}:
with pkgs;
mkShell ({
	RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
	FETLOCK_NIX = toString ./nix;

	buildInputs = [ cargo rustc rustfmt rust-analyzer libiconv openssl.dev ] ++ (
		lib.optionals stdenv.isDarwin (with darwin.apple_sdk; [
			frameworks.Security
			frameworks.CoreServices
			frameworks.CoreFoundation
			frameworks.Foundation
			frameworks.AppKit
		])
	) ++ (callPackage ./nix/runtimeDeps.nix {} fetlockBackends);
} // (import ./nix/openssl-build-env.nix { inherit openssl; }))
