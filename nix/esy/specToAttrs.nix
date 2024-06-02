final: prev:
with prev.pkgs.lib;
let
  util = prev.pkgs.callPackage ../util.nix {};
  ocamlCommon = prev.pkgs.callPackage ../ocamlCommon.nix;
  stdenv = prev.pkgs.stdenv;
  hooks = import ./hooks.nix final prev;
in
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
  build ? abort "No build instructions passed for esy package ${key}",
  buildInputs ? [],
  opamName ? null,
  files ? null,
  extraSources ? null,
}@spec:
  let finalBuild = util.populateBuildPhases build; in hooks.extend build.mode ({
    inherit pname version depKeys src;
    configurePhase = "true";
    inherit (finalBuild) installPhase;
    
    buildPhase =
      (if build ? buildEnv
        then (final.exportVars build.buildEnv) + "\n"
        else ""
      ) + finalBuild.buildPhase;

    # TODO preBuild?
    shellHook =
      (if build ? buildEnv
        then (final.exportVars build.buildEnv) + "\n"
        else ""
      );

    propagatedBuildInputs =
      (map final.getDrv depKeys) ++
      (build.depexts or []);
 
    buildInputs = buildInputs
      ++ (if files != null then [ hooks.copyFilesHook ] else [])
      ++ (if build ? exportedEnv
        then [ (final.exportEnvHook { inherit pname; inherit (build) exportedEnv; }) ]
        else []);
  }
    // (if opamName != null then { inherit opamName; } else {})
    // (if files != null then { inherit files; } else {})
    // (if extraSources != null then {
      postUnpack = let copyFile = (path: src: "cp -r '${src}' '${path}'"); in
        concatStringsSep "\n" (mapAttrsToList copyFile extraSources);
    } else {})

    # https://github.com/NixOS/nixpkgs/issues/39687
    // (if stdenv.isDarwin != null then { hardeningDisable = ["strictoverflow"]; } else {})
  )
