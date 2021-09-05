# esy includes all the logic to build opam packages
# (as well as esy packages), so we just delegate to it
{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  ocamlCommon = pkgs.callPackage ../esy/ocamlCommon.nix {};

in core.makeAPI {
  pkgOverrides = import ../esy/overrides.nix;
  overlays = [ ocamlCommon.overlay ];
}