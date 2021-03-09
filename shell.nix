with import <nixpkgs> {};
mkShell {
	buildInputs = [ cargo rustc rustfmt rls libiconv ] ++ (
		lib.optionals stdenv.isDarwin (with darwin.apple_sdk; [
			frameworks.Security
			frameworks.CoreServices
			frameworks.CoreFoundation
			frameworks.Foundation
			frameworks.AppKit
		])
	);
}
