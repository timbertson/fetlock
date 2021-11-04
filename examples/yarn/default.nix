{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../nix/yarn {};
  selection = fetlock.yarn.load ./lock.nix {};
in
selection.root
