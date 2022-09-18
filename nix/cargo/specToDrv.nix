final: prev:
with prev.pkgs.lib;
{
  key, pname, version,
  depKeys,
  edition,
  libPath ? "",
  crateBin ? null,
  buildDepKeys ? [],
  features ? [],
  src ? prev.emptyDrv,
  buildSrc ? null,
  procMacro ? false,
  crateRenames ? {},
  extraRustcOpts ? null,
}@spec: final.pkgs.buildRustCrate ({
  inherit pname version src features edition libPath procMacro crateRenames;
  crateName = pname;
  dependencies = (map final.getDrv depKeys);
  buildDependencies = (map final.getDrv buildDepKeys);
  passthru = final.mkPassthru spec;
}
  // (if buildSrc == null then {} else { build = buildSrc; })
  // (if crateBin == null then {} else { inherit crateBin; })
  // (if extraRustcOpts == null then {} else { inherit extraRustcOpts; })
)
