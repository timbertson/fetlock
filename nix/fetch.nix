{ pkgs }:
{
	fetchGoModule = { name, version, goSum, goModSum, hash }:
		pkgs.stdenv.mkDerivation {
			outputHash = hash;
			outputHashMode = "recursive";
			pname = name;
			version = version;
			buildInputs = [ pkgs.go ];

			# `src` directory required to avoid error:
			# > ignoring go.mod in system temp root
			# (since nix sets $TEMP to $PWD)
			buildCommand = ''
				set -x
				
				mkdir -p "$out"

				mkdir download
				export GOMODCACHE="$(pwd)/download"

				mkdir src
				cd src

				echo '${name} ${version} ${goSum}' > go.sum
				echo 'module example.com/unused' > go.mod
				echo '${name} ${version}/go.mod ${goModSum}' >> go.sum

				go mod download '${name}@${version}'
				chmod -R u+w "$GOMODCACHE"
				mv "$GOMODCACHE/${pkgs.lib.head (builtins.split "/" name)}" "$out/"
			'';
		};
	
	fetchGoModules = { src, hash }:
		(pkgs.buildGoModule {
			inherit src;
			vendorSha256 = hash;
			pname = "gomod";
			version = "vendor";
		}).go-modules;
}
