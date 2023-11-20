{ pkgs }:
let lib = pkgs.lib; in
{
	# Don't mess with an existing store path.
	# If there's a .git directory, export git.
	# Otherwise, fall back to a plain path
	pathSrc = p:
		if lib.isStorePath p
			then p
			else (
				if builtins.pathExists (p + "/.git")
					then builtins.fetchGit { url = p; }
					else lib.warn "Using source path: ${p} - this is less efficient than using a git repository or overriding `src`" p
			);

	fetchGoModules = { src, hash, deleteVendor ? false }:
		(pkgs.buildGoModule {
			inherit src deleteVendor;
			vendorSha256 = hash;
			pname = "gomod";
			version = "vendor";
		}).goModules;
		
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
	
	# builtins.fetchGit results in a store path string, but for
	# consistency we want derivation we can pass to `nix-build` etc.
	# This is only used for `--nix-expr`, actual fetchers will use fetchGitBuiltin
	# since they produce fixed-output derivations.
	ensureDerivation = drv:
		if pkgs.lib.isDerivation drv
		then drv
		else pkgs.stdenv.mkDerivation {
			name = "link";
			buildCommand = "ln -sfn ${drv} $out";
		};
}
