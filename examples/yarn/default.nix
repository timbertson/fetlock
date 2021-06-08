{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  yarn = (callPackage ../nix/yarn {});
  selection = yarn.load ./yarn.nix {};
in
selection.root.overrideAttrs (o: {
	passthru = selection.drvsByName;
})
