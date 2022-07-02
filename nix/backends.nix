rec {
	default = [ "bundler" "gomod" "yarn" "cargo"];
	all = default ++ ["esy" "opam"];
}
