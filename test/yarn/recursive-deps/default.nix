{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../../nix {};
in
(fetlock.yarn.load ./lock.nix {
  src = ./src;
}).root
