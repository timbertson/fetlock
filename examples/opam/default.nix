{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  opam = (callPackage ../../nix/opam {});
  selection = opam.load ./lock.nix {};
in
selection.root.overrideAttrs (o: {
	passthru = selection.drvsByName;
})