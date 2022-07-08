{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToDrv = spec:
      let overrides = {
        passthru = (spec.passthru or {}) // final.mkPassthru spec;
      }; in
      final.pkgs.buildGoModule (spec // overrides);
  };

  injectGo = go: final: prev: {
    buildGoPackage = import "${pkgs.path}/pkgs/development/go-modules/generic" {
      go = buildPackages.go_1_18;
    };

};

in core.makeAPI {

  # overlays = [ base (injectRuby pkgs.ruby) ];

  # accept `go` and project it into the overlay's buildGoPackage
  userArgs = args:
    let
      extraArgs = if args ? go then {} else {
        overlays = (args.overlays or []) ++ [ (injectGo args.go) ];
      };

    in
    (filterAttrs (n: v: n != "go") args) // extraArgs;

  overlays = [ base ];
}
