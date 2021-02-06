{ pkgs, stdenv, lib}:
with lib;
let
	noOverrides = (self: []);
	makeAPI = (
		{
			# args passed in by frontend (internal)
			fallback ? self: {},
			overlays,
			pkgOverrides ? noOverrides,
		}:
		let
			# prevent shadowing later:
			frontendOverlays = overlays;
			frontendOverrides = pkgOverrides;
			load = (
				# args passed in by user (public API)
				lock:
				{
					overlays ? [],
					pkgOverrides ? noOverrides,
				}:
				with builtins;
				with pkgs;
				let
					base = self:
						let
							# Utility function for use in dependency lookup
							getDrv = key: getAttr key self.drvs;
						in (fallback self) // {
							inherit pkgs getDrv;
							
							# apply frontend build function to all specs
							drvs = mapAttrs
								(key: v:
									let
										# ensure `spec` and `key` are accessible through the drv
										spec = { inherit key; } // v;
										attrs = self.specToAttrs spec;
										passthru = spec;
									in
									self.mkDerivation (attrs // {
										passthru = (attrs.passthru or {}) // passthru;
									})
								)
								self.specs;
								
							# keys typically embed version information,
							# names provide less brittle lookup for human use
							# (but may not be unique, so keys are preferred when possible)
							drvsByName = mapAttrs' (key: v:
								let drv = getAttr key self.drvs; in
								{ name = drv.pname; value = drv; }
							) self.drvs;

							# placeholder for better error messages
							mkDerivation = stdenv.mkDerivation;
							specToAttrs = abort "specToAttrs must be overridden";
							
							toplevelPackages = map getDrv self.context.toplevel;
							toplevelPackage = head self.toplevelPackages;

							# Utilities for overriding the result derivation set.
							overrideAll = fn: drvs: mapAttrs (k: fn) drvs;
							
							_overrideOnly = attrs: fn:
								final.overrideAll (drv:
									if hasAttr drv.pname attrs
									then lib.trace "Applying override for ${drv.pname}" (
										fn (getAttr drv.pname attrs) drv)
									else drv
								);

							override = attrs:
								final._overrideOnly attrs (fn: drv: fn drv);

							overrideAttrs = attrs:
								final._overrideOnly attrs (fn: drv: drv.overrideAttrs fn);

							addBuildInputs = attrs:
								final._overrideOnly attrs (extra: drv: drv.overrideAttrs (o: {
									buildInputs = (o.buildInputs or []) ++ extra;
								}));
						};

					sourceOverlay = import lock; # TODO allow literal?
					overrideOverlay = final: prev:
						let
							allOverrides = (frontendOverrides final) ++ (pkgOverrides final);
							applyOverride = drvs: override:
								let
									result = override drvs;
									resultType = builtins.typeOf result;
								in
								if resultType != "set" then
									abort "override produced ${resultType} (expected set)"
									else result;
						in {
							drvs = foldl applyOverride prev.drvs allOverrides;
						};

					finalOverlay = composeManyExtensions (
						[sourceOverlay]
						++ frontendOverlays
						++ overlays
						++ [overrideOverlay]
					);
					final = lib.fix (extends finalOverlay base);
				in
				final
			);
		in
		{ inherit load; }
	);
in
{
	inherit makeAPI;
	emptyDrv = pkgs.runCommandLocal "empty" {} "mkdir $out";
}