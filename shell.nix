with import <nixpkgs> {};
mkShell {
	RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
	FETLOCK_NIX = toString ./nix;
	buildInputs = [ cargo rustc rustfmt rls libiconv yarn ] ++ (
		lib.optionals stdenv.isDarwin (with darwin.apple_sdk; [
			frameworks.Security
			frameworks.CoreServices
			frameworks.CoreFoundation
			frameworks.Foundation
			frameworks.AppKit
		])
	);
}
