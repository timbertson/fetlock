final: prev:
with prev.pkgs.lib;
let
  util = prev.pkgs.callPackage ../util.nix {};
  addHooks = import ./hooks.nix final prev;
  stdenv = prev.pkgs.stdenv;
  # too inconvenient to declare as a dependency, just include it always
  commonBuildDeps = [ prev.pkgs.which ];

  copyFilesHook = prev.makeHook "copy-files" ''
    function copyOpamFiles {
      echo "+ copyOpamFiles"
      cp -r --no-preserve=mode --dereference -v $files/. ./
    }
    preBuildHooks+=(copyOpamFiles)
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
      ${exportVars exportedEnv}
        }
        addEnvHooks "$targetOffset" esyEnvFrom_${fname}
    EOF
    }
    preInstallHooks+=(writeEnvSetupHook)
  '';
  
  getDepext = p: getAttrFromPath (splitString "." p) final.pkgs;
in
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
  build ? { mode = "esy"; }, #TODO: after we support link-dev, use abort "no build instructions passed for derivation ${key}"
  buildInputs ? [],
  opamName ? null,
  files ? null,
}@spec:
  let finalBuild = util.populateBuildPhases build; in addHooks build.mode ({
    inherit pname version depKeys src;
    configurePhase = "true";
    inherit (finalBuild) installPhase;
    
    buildPhase =
      (if build ? buildEnv
        then (exportVars build.buildEnv) + "\n"
        else ""
      ) + finalBuild.buildPhase;

    # TODO don't need to include ocaml as dependency if it's a node package
    # TODO which deps can we get away with not propagating?
    propagatedBuildInputs =
      (map final.getDrv depKeys) ++
      (map getDepext (build.depexts or []));
 
    buildInputs = buildInputs ++ commonBuildDeps
      ++ (if files != null then [ copyFilesHook ] else [])
      ++ (if build ? exportedEnv
        then [ (exportEnvHook { inherit pname; inherit (build) exportedEnv; }) ]
        else []);
  }
    // (if opamName != null then { inherit opamName; } else {})
    // (if files != null then { inherit files; } else {})

    # https://github.com/NixOS/nixpkgs/issues/39687
    // (if stdenv.isDarwin != null then { hardeningDisable = ["strictoverflow"]; } else {})
  )