{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  overlay = final: prev: {
    siteLib = prefix: "${prefix}/lib/ocaml/${final.ocaml.version}/site-lib";
    buildSpec = { key, pname, version, depKeys, src ? core.emptyDrv, opam ? {} }:
      lib.warn key (
      stdenv.mkDerivation {
        inherit pname version depKeys src;
        buildInputs = (map final.getDrv depKeys) ++ (opam.depexts or []);
        buildPhase = opam.buildPhase or "TODO: esy";
        installPhase = opam.buildPhase or "TODO: esy";
      });
    ocaml = final.context.ocaml or (abort ''

      ERROR: No ocaml version present in lockfile.
      If you still want to build this expression,
      you will need to set the root `ocaml` attribute
      in your override.
    '');
  };
in core.makeAPI {
  frontend = overlay;
}