rec {
	default = [ "bundler" "gomod" "yarn" "cargo" "sbt"];
	all = default ++ ["esy" "opam"];
}
