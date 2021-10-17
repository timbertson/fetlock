final: prev:
with prev.pkgs.lib;
{
  key, pname, version,
  depKeys,
  edition,
  libPath ? "",
  buildDepKeys ? [],
  features ? [],
  src ? prev.emptyDrv,
  buildSrc ? null,
  procMacro ? false,
}@spec: final.buildRustCrate ({
  inherit pname version src features edition libPath procMacro;
  crateName = pname;
  dependencies = (map final.getDrv depKeys);
  buildDependencies = (map final.getDrv buildDepKeys);
}
  // (if buildSrc == null then {} else { build = buildSrc; })
)
