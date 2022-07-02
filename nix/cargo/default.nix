{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToDrv = import ./specToDrv.nix final prev;
  };
in core.makeAPI {
  userArgs = args: args;
  overlays = [ base ];
}
