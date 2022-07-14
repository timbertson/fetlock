{
	pkgs ? import <nixpkgs> {},
	fetlockBackends ? (import ./nix/backends.nix).all,
}:
with pkgs;
mkShell {
	RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
	FETLOCK_NIX = toString ./nix;
	FETLOCK_BUNDLER = toString ./src/bundler;
	buildInputs = [ cargo rustc rustfmt rls libiconv openssl.dev ] ++ (
		lib.optionals stdenv.isDarwin (with darwin.apple_sdk; [
			frameworks.Security
			frameworks.CoreServices
			frameworks.CoreFoundation
			frameworks.Foundation
			frameworks.AppKit
		])
	) ++ (callPackage ./nix/runtimeDeps.nix {} fetlockBackends);
}
