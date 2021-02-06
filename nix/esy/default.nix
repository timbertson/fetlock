{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  base = final: prev: {
    # esy expects one of `linux`, `windows` and `linux`, anything else probably won't work
    os = stdenv.buildPlatform.parsed.kernel.name;
    siteLib = prefix: "${prefix}/lib/ocaml/${final.ocaml.version}/site-lib";
  };

in core.makeAPI {
  overlays = [
    base
    (import ./hooks.nix)
    (import ./specToAttrs.nix)
  ];
}