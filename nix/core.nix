{ fetlock }:
{ pkgs, stdenv, lib }:
with lib;
let
	noOverrides = (self: []);
	
	makeAPI = (
		{
			# args passed in by frontend (internal)
			overlays,
			userArgs ? args: args, # massage user API into core API
			pkgOverrides ? noOverrides,
			apiPassthru ? {},
		}:
		let
			# prevent shadowing later:
			frontendOverlays = overlays;
			frontendOverrides = pkgOverrides;
			compose = { earlyOverlays, lateOverlays }:
				let
					allOverlays = (
						earlyOverlays
						++ frontendOverlays
						++ lateOverlays
					);
					finalOverlay = composeManyExtensions allOverlays;
				in
				lib.fix (extends finalOverlay base);
			
			base = self: (
				let
					# Utility function for use in dependency lookup
					getDrv = key: getAttr key self.drvs;

					rootKey = self.context.root;
					rootAttrs = getAttr rootKey self.specs;

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

					shellDeps = self.lockDependencies ++ [ fetlock pkgs.nix ];
					commonShellHook = ''
						${self.shellHook or ""}
						function log_exit {
							st=$?
							set +x
							if [ $st -eq 0 ]; then
								desc="successfully"
							else
								desc="with error status $st"
							fi
							echo >&2 "nix-shell exited $desc"
							exit $st
						}
						trap log_exit EXIT
					'';

				in {
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
						(key: v:
							let overrides = { inherit key; } //
								# convenient override for root src
								(if self.rootSrc != null && key == rootKey then { src = self.rootSrc; } else {});
							in
							self.specToDrv (v // overrides))
						self.specs;
						
					mkPassthru = spec: {
						inherit spec;
						inherit (self) drvsByName;
						overrideSpec = fn: self.specToDrv (fn spec);
					};
					
					specToDrv = spec:
						let
							attrs = self.specToAttrs spec;
							passthru = self.mkPassthru spec;
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
					lockCommand = abort "lockCommand not set for this backend";
					
					# root may not always be buildable, since not all backends
					# have enough package metadata for that
					# But in some cases it may be easier to override the root
					# spec than build your own derivation.
					root = getDrv rootKey;
					inherit rootAttrs;
					
					# In other cases, you can ignore `root` and use `dependencies`
					# (and optionally `src`) for your own derivation
					dependencies = map getDrv (getAttr rootKey self.specs).depKeys;
					src = (getAttr rootKey self.specs).src;

					# Utilities for overriding the result derivation set.
					inherit overrideAll;

					# overrideDrv: each attr is a function taking old drv and returning new
					overrideDrv = attrs:
						overrideOnly attrs (fn: drv: fn drv);

					# overrideDrv: each attr is a function taking oldAttrs and returning newAttrs
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

					# overrideSpec: each attr is a function taking oldSpec and returning newSpec
					# (spec is the fetlock concept, i.e. the representation in lock.nix)
					overrideSpec = attrs:
						overrideOnly attrs (fn: drv: drv.overrideSpec fn);

					# shell makes the lock tool available (e.g. cargo, bundler, etc)
					# This should be used with nix-shell, not nix-build
					shell = self.pkgs.mkShell {
						packages = shellDeps;
						shellHook = commonShellHook;
					};
					updateLock = self.pkgs.mkShell {
						packages = shellDeps;
						shellHook = commonShellHook + ''
							updateLock && exit 0
						'';
					};
				}
			);

			load = lock: args: _load lock (userArgs args);
			_load = (
				lock:
				{
					# args returned by userArgs (core API)
					overlays ? [],
					pkgOverrides ? noOverrides,
					src ? null, # override root src
				}:
				# with builtins;
				# with pkgs;
				let
					sourceOverlay = import lock; # TODO allow literal?
					rootSrcOverlay = final: prev: { rootSrc = src; };
					
					# applies all overrides to drvs. Note that overrides is a slightly simpler,
					# package-specific API compared to a full overlay
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
				in
				compose {
					earlyOverlays = [ sourceOverlay rootSrcOverlay ];
					lateOverlays = overlays ++ [ overrideOverlay ];
				}
			);
			
			# bootstrap doesn't have any lock information, but it's enough to
			# evaluate any backend-specific overrides
			bootstrap = compose { earlyOverlays = []; lateOverlays = []; };
		in
		{
			inherit load;
			inherit (bootstrap) shell updateLock;
		} // apiPassthru
	);
in
{
	inherit makeAPI;
}
