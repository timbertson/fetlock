{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  ocamlCommon = pkgs.callPackage ./ocamlCommon.nix {};
  
  # esy is itself packaged with yarn, so we can use fetlock's yarn backend
  # to make it available in `fetlock.esy.shell`
  yarnApi = pkgs.callPackage (import ../yarn { inherit core; }) {};
  esySelection = yarnApi.load ../../tools/esy-lock.nix {};

  base = final: prev: {
    lockDependencies = [ esySelection.root ];

    # esy expects `linux` / `windows` anything else probably won't work
    os = stdenv.buildPlatform.parsed.kernel.name;

    # TODO this will interfere with genuine configure phases, but we don't have any yet
    disableConfigureHook = final.makeHook "disable-configure" ''
      function disableConfigurePhase {
        export configurePhase=true
      }
      postUnpackHooks+=(disableConfigurePhase)
    '';

    exportVars = vars:
      concatStringsSep "\n" (map (line: "echo \"+ ${line}\"\nexport \"${line}\"") vars);

    # does nix already have something for this?
    exportEnvHook = { pname, exportedEnv }:
      let fname = replaceStrings ["-"] ["_"] pname; in
      prev.makeHook "export-env" ''
      function writeEnvSetupHook {
        echo "+ writeEnvSetupHook"
        mkdir -p $out/nix-support
      cat <<EOF > $out/nix-support/setup-hook
          esyEnvFrom_${fname} () {
            local out="$out"
      EOF
      cat <<"EOF" >> $out/nix-support/setup-hook
            if [ "''${esyEnv_already_${fname}:-}" = 1 ]; then
              return
            fi
            export esyEnv_already_${fname}=1
            echo "+ esyEnvFrom_${fname}"
        ${final.exportVars exportedEnv}
          }
          addEnvHooks "$targetOffset" esyEnvFrom_${fname}
      EOF
      }
      preInstallHooks+=(writeEnvSetupHook)
    '';
  };
  
  api = core.makeAPI {
    pkgOverrides = self: (ocamlCommon.overrides self) ++ (import ./overrides.nix self);
    overlays = [ ocamlCommon.overlay base ];
  };

in api
