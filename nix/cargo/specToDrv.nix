final: prev:
with prev.pkgs.lib;
{
  key, pname, version,
  depKeys,
  buildDepKeys ? [],
  src ? prev.emptyDrv,
  ...
}@spec:
let
  processedAttrs = [
    "key"
    "depKeys"
    "buildDepKeys"
  ];
  extraAttrs = builtins.removeAttrs spec processedAttrs;
in final.pkgs.buildRustCrate ({
  inherit src; # explicit so that the default to emptyDrv takes effect
  crateName = pname;
  dependencies = (map final.getDrv depKeys);
  buildDependencies = (map final.getDrv buildDepKeys);
  passthru = final.mkPassthru spec;
} // extraAttrs)
