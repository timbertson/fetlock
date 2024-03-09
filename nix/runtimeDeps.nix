{ pkgs }: with pkgs; with lib;
fetlockBackends:
let
	sources = callPackage ./sources.nix {};
	opam2nix = callPackage sources.opam2nix {};
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
	++ (ifEnabled "yarn" yarn-berry)
	++ (ifEnabled "cargo" cargo)
	++ (ifEnabled "cargo" rustc)
	++ (ifEnabled "esy" (callPackage ./esy/bin.nix {}))
	++ (optional (elem "opam" fetlockBackends || elem "esy" fetlockBackends) opam2nix)
