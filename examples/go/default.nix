{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = callPackage ../../nix {};
  selection = fetlock.go.load ./lock.nix {};
in
selection.root
# buildGoModule {
#   pname = "test";
#   version = "1.0";
#   src = "TODO";
#   vendorSha256 = null;
# }
