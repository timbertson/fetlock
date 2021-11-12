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

  installBins = { pkgname, specs, nodePathDeps }:
    let
      makeWrapperArgs = map (dep: "--prefix NODE_PATH : ${final.getDrv dep}/${nodeSuffix}") nodePathDeps;
      installBin = name: path: ''
        echo "Installing $out/bin/${name}"
        chmod +x "$out/${nodeSuffix}/${pkgname}/${path}"
        ln -s "../${nodeSuffix}/${pkgname}/${path}" "$out/bin/${name}"
        ${if nodePathDeps == [] then "" else ''
          echo "Wrapping $out/bin/${name}"
          wrapProgram $out/bin/${name} ${concatStringsSep " " makeWrapperArgs}
        '' }
      '';
    in
    concatStringsSep "\n" (["mkdir -p $out/bin"] ++ (mapAttrsToList installBin specs));
in
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
  bin ? null,
  nodePathDeps ? null,
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
    ${if bin == null then "" else installBins { inherit pkgname nodePathDeps; specs = bin; }}
  '';

  buildInputs = [ final.nodejs final.pkgs.makeWrapper ];
}
