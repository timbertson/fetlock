{ pkgs, src, opam2nix }: with pkgs;
# Note: building this derivation requires ./lock.nix,
# which is generated with fetlock itself.
# ../shell.nix can be used to bootstrap & build fetlock
# via cargo, without needing a lock.nix
let
	makeBackend = fetlockImpls:

	makeBackends = fetlockImpls:
	let
		core = fetlock: callPackage (import ./core.nix { inherit fetlockImpls; }) {};
		backend = path: callPackage (import path { inherit core; }) {};
	in
	{
		bundler = backend ./bundler;
		cargo = backend ./cargo;
		esy = backend ./esy;
		opam = backend ./opam;
		yarn = backend ./yarn;
		shell = stdenv.mkShell {
			packages = [ fetlockImpls.basic ];
		};
	};

	# import API with a nonfunctional fetlock
	# (it's only used to load ./lock.nix, and that doesn't make use of the fetlock binary)
	bootstrap = makeBackends { fetlockImpls.basic = abort "fetlock used from `bootstrap` expression"; };
	
	# import full API with the bootstrapped fetlock
	backends = makeBackends { basic = fetlockBasic; ocaml = fetlockWithOcaml; };

	osx = darwin.apple_sdk.frameworks;
	selection = bootstrap.cargo.load ./lock.nix {
		pkgOverrides = self: [
			(self.overrideAttrs {
				fetlock = o: ({
					inherit src;
					nativeBuildInputs = (o.nativeBuildInputs or [])
						++ (if stdenv.isDarwin then [ osx.Security ] else []);
				});
			})
		];
	};

	fetlockBasic = selection.root;
	fetlockWithOcaml = stdenv.mkDerivation {
		inherit (fetlockBasic) pname version;
		buildInputs = [ makeWrapper ];
		buildCommand = ''
			mkdir -p $out/bin
			makeWrapper ${fetlockBasic}/bin/fetlock $out/bin/fetlock \
				--prefix PATH : ${opam2nix}/bin
		'';
	};
in
# return the built fetlock derivation, with backends as passthru attributes
lib.extendDerivation true backends fetlockBasic
