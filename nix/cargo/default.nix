{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToDrv = import ./specToDrv.nix final prev;
    lockDependencies = [ final.pkgs.cargo];
  };
in core.makeAPI {
  overlays = [ base ];
}
