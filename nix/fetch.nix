{ pkgs }:
{
	fetchGoModules = { src, hash }:
		(pkgs.buildGoModule {
			inherit src;
			vendorSha256 = hash;
			pname = "gomod";
			version = "vendor";
		}).go-modules;
}
