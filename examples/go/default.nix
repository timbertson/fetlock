{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../nix {};
  selection = fetlock.go.load ./lock.nix {
    pkgOverrides = self: [
      (self.overrideAll (base: base.overrideAttrs (_: { doCheck = false; })))
    ];
  };
in
selection.root
