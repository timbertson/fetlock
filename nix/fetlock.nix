{ pkgs, src }: with pkgs;
# Note: building this derivation requires ./lock.nix,
# which is generated with fetlock itself.
# ../shell.nix can be used to bootstrap & build fetlock
# via cargo, without needing a lock.nix
let
	makeBackends = fetlock:
	let
		core = callPackage (import ./core.nix { inherit fetlock; }) {};
		backend = path: callPackage (import path { inherit core; }) {};
	in
	{
		bundler = backend ./bundler;
		cargo = backend ./cargo;
		esy = backend ./esy;
		opam = backend ./opam;
		yarn = backend ./yarn;
	};

	# import API with a nonfunctional fetlock
	# (it's only used in shell derivations, which we don't need)
	bootstrap = makeBackends (abort "fetlock used from `bootstrap` expression");
	
	# import full API with the bootstrapped fetlock
	backends = makeBackends selection.root;

	osx = darwin.apple_sdk.frameworks;
	selection = bootstrap.cargo.load ./lock.nix {
		pkgOverrides = self: [
			(self.overrideAttrs {
				fetlock = o: {
					inherit src;
					nativeBuildInputs = (o.nativeBuildInputs or []) ++ (if stdenv.isDarwin then [ osx.Security ] else []);
				};
			})
		];
	};
in
# return the built fetlock derivation, with backends as passthru attributes
lib.extendDerivation true backends selection.root
