# esy includes all the logic to build opam packages
# (as well as esy packages), so we just delegate to it
{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  ocamlCommon = pkgs.callPackage ../esy/ocamlCommon.nix {};
	overlay = final: prev: {
		repositories = final.context.repositories;
	};

in core.makeAPI {
  pkgOverrides = self: (ocamlCommon.overrides self) ++ (import ./overrides.nix self);
  overlays = [ ocamlCommon.overlay overlay ];
}
