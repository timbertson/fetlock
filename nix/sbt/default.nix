{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToAttrs = import ./specToAttrs.nix final prev;
  };

in core.makeAPI {
  overlays = [ base ];
}
