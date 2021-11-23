{ pkgs ? import <nixpkgs> {}, enableOcaml ? false }: with pkgs;
let
	sources = (builtins.fromJSON (builtins.readFile ./wrangle.json)).sources;
	wrangle = callPackage "${fetchFromGitHub sources.nix-wrangle.fetch}/nix/api.nix" {};
	opam2nix = callPackage "${fetchFromGitHub sources.opam2nix.fetch}/default.nix" {};
in
callPackage ./fetlock.nix {
	inherit opam2nix;
	src = wrangle.exportLocalGit { path = ../.; ref = "HEAD";
}; }
