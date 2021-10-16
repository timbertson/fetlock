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
  procMacro ? false,
}@spec: final.buildRustCrate{
  inherit pname version src features edition libPath procMacro;
  crateName = pname;
  dependencies = (map final.getDrv depKeys);
  buildDependencies = (map final.getDrv buildDepKeys);
}
