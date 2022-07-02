{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToAttrs = import ./specToAttrs.nix final prev;
  };
  injectNode = nodejs: final: prev: { inherit nodejs; };

in core.makeAPI {
  overlays = [ base ];
  # accept `nodejs` and project it into the overlay
  userArgs = args: filterAttrs (n: v: n != "nodejs") (args // {
    overlays = (args.overlays or [])
      ++ [(injectNode args.nodejs or pkgs.nodejs)];
  });
}
