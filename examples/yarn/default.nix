{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  yarn = (callPackage ../../nix/yarn {});
  selection = yarn.load ./lock.nix {};
in
selection.root.overrideAttrs (o: {
	passthru = selection.drvsByName;
})
