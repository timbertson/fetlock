{ pkgs }: with pkgs; with lib;
fetlockBackends:
let
	sources = (builtins.fromJSON (builtins.readFile ./wrangle.json)).sources;
	opam2nix = callPackage "${fetchFromGitHub sources.opam2nix.fetch}/default.nix" {};
	ifEnabled = name: value: optional (elem name fetlockBackends) value;
in
	# For convenience, we place all tools required for enabled backends on fetlock's $PATH and shell.
	# specifying a custom list of backends is usually a good idea to cut down closure size.
	# Note that these only appear in the wrapper derivation, so the fetlock binary itself
	# doesn't need to be rebuilt when you alter backends.
	[ nix ]
	++ (ifEnabled "bundler" bundler)
	++ (ifEnabled "gomod" go)
	++ (ifEnabled "yarn" nodejs)
	++ (ifEnabled "cargo" cargo)
	++ (ifEnabled "esy" (callPackage ./esy/bin.nix {}))
	++ (optional (elem "opam" fetlockBackends || elem "esy" fetlockBackends) opam2nix)
