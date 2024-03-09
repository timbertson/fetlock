{ pkgs, src,
	fetlockBackends ? (import ./backends.nix).default,
}: with pkgs;
# Note: building this derivation requires ./lock.nix,
# which is generated with fetlock itself.
# ../shell.nix can be used to bootstrap & build fetlock
# via cargo, without needing a lock.nix
let
	runtimeDeps = pkgs.callPackage ./runtimeDeps.nix { } fetlockBackends;
	wrapFlags = lib.concatStringsSep " " (
		["--prefix PATH : \"${lib.makeBinPath runtimeDeps}\"" ]
	);

	osx = darwin.apple_sdk.frameworks;

	makeBackends = fetlock: let
		core = callPackage ./core.nix { inherit fetlock; };
		backend = path: callPackage (import path { inherit core; }) {};
	in {
		bundler = backend ./bundler;
		cargo = backend ./cargo;
		esy = backend ./esy;
		opam = backend ./opam;
		yarn = backend ./yarn;
		gomod = backend ./gomod;
		shell = mkShell {
			packages = [ fetlock ];
		};
	};

	# import API with a nonfunctional fetlock
	# (it's only used to load ./lock.nix, and that doesn't make use of the fetlock binary)
	bootstrap = makeBackends (abort "fetlock used from `bootstrap` expression");
	
	# import full API via bootstrap
	selection = bootstrap.cargo.load ./lock.nix {
		pkgOverrides = self: [
			(self.overrideAttrs {
				fetlock = o: {
					inherit src;
					FETLOCK_NIX = "${src}/nix";
					FETLOCK_BUNDLER = "${src}/src/bundler";
					nativeBuildInputs = (o.nativeBuildInputs or [])
						++ (if stdenv.isDarwin then [ osx.Security osx.SystemConfiguration ] else []);
				};

				openssl-sys = o: (import ./openssl-build-env.nix { inherit openssl; });
			})
			(self.overrideSpec {
				ring = o: {
					#TODO: include this in fetlock output?
					links = "ring_core_${lib.replaceStrings ["."] ["_"] o.version}";
				};
			})
		];
	};

	fetlockWrapped = stdenv.mkDerivation {
		inherit (selection.root) pname version;
		# add all backends as passthru attributes
		passthru = (makeBackends fetlockWrapped) // { inherit selection; };
		buildInputs = [ makeWrapper ] ++ runtimeDeps;
		buildCommand = ''
			mkdir -p $out/bin
			makeWrapper ${selection.root}/bin/fetlock $out/bin/fetlock ${wrapFlags}
		'';
	};
in
fetlockWrapped
