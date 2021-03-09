{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  base = final: prev: {
    # esy expects `linux` / `windows` anything else probably won't work
    os = stdenv.buildPlatform.parsed.kernel.name;
    siteLib = prefix: "${prefix}/lib/ocaml/${final.ocaml.version}/site-lib";
    specToAttrs = import ./specToAttrs.nix final prev;
    ocaml = final.context.ocaml or (abort ''

      ERROR: No ocaml version present in lockfile.
      If you still want to build this expression,
      you will need to set the root `ocaml` attribute
      in your override.
    '');
  };

in core.makeAPI {
  overlays = [ base ];
}