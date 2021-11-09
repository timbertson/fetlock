{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../nix { enableOcaml = true; };
  selection = fetlock.opam.load ./lock.nix {};
in
selection.root
