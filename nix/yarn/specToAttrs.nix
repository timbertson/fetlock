final: prev:
with prev.pkgs.lib;
let
  util = prev.pkgs.callPackage ../util.nix {};
  # addHooks = import ./hooks.nix final prev;
  addHooks = x: x; # todo
  defaultBuild = {
    buildPhase = ''
      if [ -e node_modules ]; then
        echo "Removing existing node_modules"
        rm -rf node_modules
      fi
    '';
    installPhase = ''
      mkdir $out
      cp -r --no-preserve=mode ./. $out/
    '';
  };
in
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
}@spec:
  let finalBuild = util.populateBuildPhases {}; in addHooks ({
    inherit pname version depKeys src;
    configurePhase = "true";
    inherit (finalBuild) installPhase buildPhase;
    buildInputs = [ final.nodejs ] ++ (map final.getDrv depKeys);
  })