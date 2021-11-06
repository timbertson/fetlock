final: prev:
with prev.pkgs.lib;
let
  nodeSuffix = "node_modules";
  linkModules = keys:
    let
      linkModule = key:
        let
          impl = final.getDrv key;
          pkg = impl.pkgname;
          # note pkg may contain `/`, thus the `mkdir -p`
        in ''
          mkdir -p "$(dirname "${pkg}")"
          ln -s "${impl}/${nodeSuffix}/${pkg}" "${pkg}"
        '';
    in
    concatStringsSep "\n" (map linkModule keys);
in
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
  pkgname,
}@spec: {
  inherit pname version depKeys src;
  configurePhase = "true";
  passthru = { inherit pkgname; };
  buildPhase = ''
    if [ -e node_modules ]; then
      echo "Removing existing node_modules"
      rm -rf node_modules
    fi
    mkdir node_modules
    cd node_modules
    ${linkModules depKeys}
    cd ..
  '';
  installPhase = ''
    mkdir -p $out/${nodeSuffix}/${pkgname}
    cp -r --no-preserve=mode ./. $out/${nodeSuffix}/${pkgname}
  '';

  buildInputs = [ final.nodejs ]; # ++ (map final.getDrv depKeys);
}
