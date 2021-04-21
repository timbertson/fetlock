{ pkgs, stdenv, lib}:
with lib;
let
	noOverrides = (self: []);
	makeAPI = (
		{
			# args passed in by frontend (internal)
			fallback ? self: {},
			overlays,
			userArgs ? args: args, # massage user API into core API
			pkgOverrides ? noOverrides,
		}:
		let
			# prevent shadowing later:
			frontendOverlays = overlays;
			frontendOverrides = pkgOverrides;
			load = lock: args: _load lock (userArgs args);
			_load = (
				lock:
				{
					# args returned by userArgs (core API)
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
							overrideAll = fn: drvs: mapAttrs (k: fn) drvs;
							overrideOnly = attrs: fn:
								overrideAll (drv:
									if hasAttr drv.pname attrs
									then
									# lib.trace "Applying override for ${drv.pname}"
									(
										fn (getAttr drv.pname attrs) drv
									)
									else drv
								);
						in (fallback self) // {
							inherit pkgs getDrv;
							emptyDrv = stdenv.mkDerivation {
								name = "empty-drv";
								phases = "buildPhase fixupPhase";
								buildPhase = "mkdir $out";
							};
							makeHook = name: text:
								pkgs.makeSetupHook { inherit name; } (pkgs.writeText "setupHook.sh" text);
								
							# Take a subtree of some derivation and promote it to
							# a toplevel, fixed-output derivation. This lets us
							# alter e.g. the repository where files come from, but
							# not bust the cache if the files are unchanged.
							subtree = { name ? "subtree", base, path, hash }:
								stdenv.mkDerivation {
									outputHash = hash;
									outputHashMode = "recursive";
									inherit name;
									buildCommand = ''
										cp -r "${base}/${path}" "$out";
										chmod u+w "$out"
									'';
								};
							
							# apply frontend build function to all specs
							drvs = mapAttrs
								(key: v: self.specToDrv ({inherit key; } // v))
								self.specs;
								
							specToDrv = spec:
								let
									attrs = self.specToAttrs spec;
									passthru = { inherit spec; };
								in
								self.mkDerivation (attrs // {
									passthru = (attrs.passthru or {}) // passthru;
								});

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
							inherit overrideAll;

							override = attrs:
								overrideOnly attrs (fn: drv: fn drv);

							overrideAttrs = attrs:
								overrideOnly attrs (fn: drv: drv.overrideAttrs fn);

							addBuildInputs = attrs:
								overrideOnly attrs (extra: drv: drv.overrideAttrs (o: {
									buildInputs = (o.buildInputs or []) ++ extra;
								}));

							addPropagatedBuildInputs = attrs:
								overrideOnly attrs (extra: drv: drv.overrideAttrs (o: {
									propagatedBuildInputs = (o.propagatedBuildInputs or []) ++ extra;
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
}