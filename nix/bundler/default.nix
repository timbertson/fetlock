{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  base = final: prev: {
    specToDrv = import ./specToDrv.nix final prev;
    buildRubyGem = pkgs.buildRubyGem; # TODO override ruby etc
  };
  injectRuby = ruby: final: prev: { inherit ruby; };

in core.makeAPI {
  overlays = [ base ];
  # accept `ruby` and project it into the overlay
  userArgs = args: filterAttrs (n: v: n != "ruby") (args // {
    overlays = (args.overlays or [])
      ++ [(injectRuby args.ruby or pkgs.ruby)];
  });
}