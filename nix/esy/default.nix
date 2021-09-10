{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  ocamlCommon = pkgs.callPackage ./ocamlCommon.nix {};

  base = final: prev: {
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

in core.makeAPI {
  pkgOverrides = self: (ocamlCommon.overrides self) ++ (import ./overrides.nix self);
  overlays = [ ocamlCommon.overlay base ];
}