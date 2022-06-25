{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
	base = final: prev: {
		specToDrv = spec:
			let overrides = {
				vendorSha256 = null;
				deleteVendor = true;
				passthru = (spec.passthru or {}) // final.mkPassthru spec;
			}; in
			final.pkgs.buildGoModule (spec // overrides);

		lockDependencies = [ pkgs.go ];
	};

in core.makeAPI {
	overlays = [ base ];
}
