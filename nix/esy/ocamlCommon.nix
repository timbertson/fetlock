# Common utilities across opam / esy
{ pkgs, stdenv, lib }:
{
  overlay = final: prev: {
    # esy expects `linux` / `windows` anything else probably won't work
    siteLib = prefix: "${prefix}/lib/ocaml/${final.ocaml.version}/site-lib";
    specToAttrs = import ./specToAttrs.nix final prev;
    ocaml = final.drvs.ocaml or final.drvsByName.ocaml or (abort ''
      ERROR: No ocaml version present in lockfile.
      To build this expression, you will need to provide
      an `ocaml` implementation in your override.
    '');
  };
}