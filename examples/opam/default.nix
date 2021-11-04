{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../nix {};
  selection = fetlock.opam.load ./lock.nix {};
in
selection.root
