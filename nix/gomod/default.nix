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

		lockDependencies = [ pkgs.go ];
	};

in core.makeAPI {
	overlays = [ base ];
}
