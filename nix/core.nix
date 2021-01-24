{ pkgs, stdenv, lib}:
let
	makeAPI = {
		fallback ? self: {},
		frontend
	}: {
		lock,
		overlays ? []
	}:
		with builtins;
		with pkgs;
		with lib;
		let
			base = self:
				let
					# Utility function for use in dependency lookup
					getDrv = key: getAttr key self.drvs;
				in (fallback self) // {
					# pkgs required for fetch* usage in lockfile
					inherit pkgs getDrv;
					
					# apply frontend build function to all specs
					drvs = mapAttrs
						(key: v: self.buildSpec ({ inherit key; } // v))
						self.specs;

					# placeholder for better error messages
					buildSpec = abort "buildSpec must be overridden";
					
					toplevel = map getDrv self.context.toplevel;
				};

			sourceOverlay = import lock; # TODO allow literal?
			internalOverlay = composeExtensions sourceOverlay frontend;
			userOverlay = composeManyExtensions overlays;
			finalOverlay = composeExtensions internalOverlay userOverlay;
			final = lib.fix (extends finalOverlay base);
		in
		{ inherit final; };
in
{
	inherit makeAPI;
	emptyDrv = pkgs.runCommandLocal "empty" {} "mkdir $out";
}