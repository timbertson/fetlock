{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    buildGoModule = final.pkgs.buildGoModule;

    specToDrv = spec:
      let overrides = {
        passthru = (spec.passthru or {}) // final.mkPassthru spec;
      }; in
      final.pkgs.buildGoModule (spec // overrides);
  };

  injectGo = go: final: prev: {
    buildGoModule = prev.buildGoModule.override { inherit go; };
  };

in core.makeAPI {

  # accept `go` and project it into the overlay's buildGoPackage
  userArgs = args:
    let
      extraArgs = if args ? go then {
        overlays = (args.overlays or []) ++ [ (injectGo args.go) ];
      } else {};

    in
    (filterAttrs (n: v: n != "go") args) // extraArgs;

  overlays = [ base ];
}
