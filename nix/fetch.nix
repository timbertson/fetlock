{ pkgs }:
{
	fetchGoModules = { src, hash }:
		(pkgs.buildGoModule {
			inherit src;
			vendorSha256 = hash;
			pname = "gomod";
			version = "vendor";
		}).go-modules;
		
	# builtins.fetchGit doesn't accept or produce a hash, so we wrap
	# it in a fixed output derivation for consistency
	fetchGitBuiltin = {hash, ... }@attrs: pkgs.stdenv.mkDerivation {
		name = "src";
		outputHash = hash;
		outputHashMode = "recursive";
		buildCommand =
			# some nix versions assume `master`, but `HEAD` always works.
			let
				filteredAttrs = { ref = "HEAD"; } // (pkgs.lib.filterAttrs (n: v: n != "hash") attrs);
			in
			''
				cp -a '${builtins.fetchGit filteredAttrs}' "$out"
			''
		;
	};
}
