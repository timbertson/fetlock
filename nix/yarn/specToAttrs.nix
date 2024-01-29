final: prev:
with prev.pkgs.lib;
let
  nodeSuffix = "node_modules";
  linkNodeModules = keys:
    let
      # note pkg may contain `/`, thus the `mkdir -p`
      mkdirParent = impl: ''mkdir -p "node_modules/$(dirname "${impl.pkgname}")"'';
      copyModule = depKey: key:
        let
          impl = final.getDrv key;
          pkg = impl.pkgname;
          # a given cyclic dep may be needed for multiple deps,
          # so only install if not already present
        in trace "copying cyclic dep ${impl.pkgname} due to dependency on ${depKey}" ''
          ${mkdirParent impl}
          if [ ! -e "node_modules/${pkg}" ]; then
            cp -a "${impl}/${nodeSuffix}/${pkg}" "node_modules/${pkg}"
          fi
        '';
      linkModule = key:
        let
          impl = final.getDrv key;
          pkg = impl.pkgname;
          # if a direct dep has cyclic deps, we copy them all instead
          # of linking the module
        in trace "linking direct dep ${pkg}" (if (impl.cyclicDepKeys or []) == [] then ''
          ${mkdirParent impl}
          ln -s "${impl}/${nodeSuffix}/${pkg}" "node_modules/${pkg}"
        '' else concatStringsSep "\n" (map (copyModule key) impl.cyclicDepKeys));
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
      installBin = name: path: ''
        echo "Installing $out/bin/${name}"
        chmod +x "$out/${nodeSuffix}/${pkgname}/${path}"
        ln -s "../${nodeSuffix}/${pkgname}/${path}" "$out/bin/${name}"
      '';
    in
    concatStringsSep "\n" (["mkdir -p $out/bin"] ++ (mapAttrsToList installBin specs));
in
{
  key, pname, version,
  depKeys,
  cyclicDepKeys ? [],
  src ? prev.emptyDrv,
  bin ? null,
  nodePathDeps ? [],
  pkgname,
}@spec: {
  inherit pname version depKeys src;
  configurePhase = "true";
  passthru = {
    inherit pkgname cyclicDepKeys;
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
    echo >&2 'NOTE: to use synthesized node_modules you should ln -sfn "$NODE_MODULES"'
  '';
  installPhase = ''
    mkdir -p $out/${nodeSuffix}/${pkgname}
    cp -r --no-preserve=mode ./. $out/${nodeSuffix}/${pkgname}
    ${if bin == null then "" else installBins { inherit pkgname nodePathDeps; specs = bin; }}
  '';

  buildInputs = [ final.nodejs final.pkgs.makeWrapper ];
}
