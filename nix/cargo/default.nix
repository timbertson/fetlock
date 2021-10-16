{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  base = final: prev: {
    specToDrv = import ./specToDrv.nix final prev;
    buildRustCrate = pkgs.buildRustCrate;
  };
in core.makeAPI {
  overlays = [ base ];
}
