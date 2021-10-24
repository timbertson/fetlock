{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  base = final: prev: {
    specToDrv = import ./specToDrv.nix final prev;
    lockTool = final.pkgs.cargo;
    lockCommand = "cargo generate-lockfile";
  };
in core.makeAPI {
  overlays = [ base ];
}
