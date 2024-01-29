final: prev:
with prev.pkgs.lib;
let
  nodeSuffix = "node_modules";
  linkNodeModules = keys:
    let
      linkModule = key:
        let
          impl = final.getDrv key;
          pkg = impl.pkgname;
          # note pkg may contain `/`, thus the `mkdir -p`
        in ''
          mkdir -p "node_modules/$(dirname "${pkg}")"
          ln -s "${impl}/${nodeSuffix}/${pkg}" "node_modules/${pkg}"
        '';
    in
    concatStringsSep "\n" (map linkModule keys);
  
  nodeModules = depKeys: prev.pkgs.stdenv.mkDerivation {
    pname = "node_modules";
    name = "node_modules";
    buildCommand = ''
      mkdir -p "$out"
      cd $out
      ${linkNodeModules depKeys}
    '';
  };

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
  nodePathDeps ? [],
  pkgname,
}@spec: {
  inherit pname version depKeys src;
  configurePhase = "true";
  passthru = {
    inherit pkgname;
    nodeModules = nodeModules depKeys;
  };
  buildPhase = ''
    if [ -e node_modules ]; then
      echo "Removing existing node_modules"
      rm -rf node_modules
    fi
    ${linkNodeModules depKeys}
  '';
  shellHook = ''
    export "NODE_MODULES=${nodeModules depKeys}/node_modules"
    echo >&2 'NOTE: to use synthesized node_modules you should ln -sfn \$NODE_MODULES'
  '';
  installPhase = ''
    mkdir -p $out/${nodeSuffix}/${pkgname}
    cp -r --no-preserve=mode ./. $out/${nodeSuffix}/${pkgname}
    ${if bin == null then "" else installBins { inherit pkgname nodePathDeps; specs = bin; }}
  '';

  buildInputs = [ final.nodejs final.pkgs.makeWrapper ];
}
