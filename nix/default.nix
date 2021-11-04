{ pkgs ? import <nixpkgs> {} }: with pkgs;
let
	json = builtins.fromJSON (builtins.readFile ./wrangle.json);
	wrangleJson = json.sources.nix-wrangle;
	wrangle = callPackage "${fetchFromGitHub wrangleJson.fetch}/nix/api.nix" {};
in
callPackage ./fetlock.nix { src = wrangle.exportLocalGit { path = ../.; ref = "HEAD"; }; }
