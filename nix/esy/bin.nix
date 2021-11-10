{ pkgs, stdenv }:
stdenv.mkDerivation rec {
	pname = "esy";
	version = "0.6.11";
	src = pkgs.fetchurl {
		url = "https://registry.npmjs.org/esy/-/esy-${version}.tgz";
		sha256 = "0pvi9gl7a3395ng3sk84fgr9xncmi598732rc1phpkj4vij15wj8";
	};
	nativeBuildInputs = [ pkgs.nodejs ];
	buildPhase = ''
		node ./postinstall.js
	'';

	# `3/` corresponds to ESY_STORE_VERSION in postinstall script
	installPhase = ''
		mkdir -p $out
		cp -a bin _export 3 $out/
	'';
}
