{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../nix {};
  selection = fetlock.yarn.load ./lock.nix {};
in
selection.root
