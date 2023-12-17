{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  addToCache = { cache_path, file }: ''
    mkdir -p "$(dirname '${cache_path}')"
    ln -sfn '${file}' '${cache_path}'
  '';

  base = final: prev: {
    specToAttrs = import ./specToAttrs.nix final prev;

    buildSbtCache = { artifacts }:
      stdenv.mkDerivation {
        name = "sbt-cache";
        buildCommand = ''
          mkdir -p $out/cache
          cd $out/cache
        '' + concatStringsSep "\n" (map addToCache artifacts);
      };
    };

in core.makeAPI {
  overlays = [ base ];
}
