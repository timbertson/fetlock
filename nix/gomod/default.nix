{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    buildGoModule = prev.pkgs.buildGoModule;

    specToDrv = spec:
      let overrides = {
        passthru = (spec.passthru or {}) // final.mkPassthru spec;
      }; in
      final.buildGoModule (spec // overrides);
  };

  injectGo = go: final: prev: {
    buildGoModule = prev.pkgs.callPackage "${pkgs.path}/pkgs/build-support/go/module.nix" {
      inherit go;
    };

};

in core.makeAPI {

  # overlays = [ base (injectRuby pkgs.ruby) ];

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
