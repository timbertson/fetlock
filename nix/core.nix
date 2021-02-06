{ pkgs, stdenv, lib}:
let
	# User-focussed API for conveniently making overlays of various types.
	# This is mixed into the return value (for frontends) and also the
	# result of makeAPI (for end users)
	overlayBuilders = {
	};
	makeAPI = (
		{
			# args passed in by frontend (internal)
			fallback ? self: {},
			overlays,
		}:
		let
			frontendOverlays = overlays; # we'll shadow `overlays` later
			load = (
				# args passed in by user (public API)
				lock:
				{
					overlays ? []
				}:
				with builtins;
				with pkgs;
				with lib;
				let
					base = self:
						let
							# Utility function for use in dependency lookup
							getDrv = key: getAttr key self.drvsByKey;
						in (fallback self) // {
							inherit pkgs getDrv;
							
							# apply frontend build function to all specs
							drvsByKey = mapAttrs
								(key: v: self.buildSpec ({ inherit key; } // v))
								self.specs;
								
							# keys typically embed version information,
							# names provide less brittle lookup for human use
							# (but may not be unique, so keys are preferred when possible)
							drvs = mapAttrs' (key: v:
								let drv = getAttr key self.drvsByKey; in
								{ name = drv.pname; value = drv; }
							) self.drvsByKey;

							# placeholder for better error messages
							buildSpec = abort "buildSpec must be overridden";
							
							toplevelPackages = map getDrv self.context.toplevel;
							toplevelPackage = head self.toplevelPackages;
						};

					sourceOverlay = import lock; # TODO allow literal?
					finalOverlay = composeManyExtensions (
						[sourceOverlay]
						++ frontendOverlays
						++ overlays
					);
					final = lib.fix (extends finalOverlay base);
				in
				final
			);
		in
		overlayBuilders // { inherit load; }
	);
in
overlayBuilders // {
	inherit makeAPI;
	emptyDrv = pkgs.runCommandLocal "empty" {} "mkdir $out";
}