final: prev:
with prev.pkgs.lib;
let
  addHooks = import ./hooks.nix final prev;
  stdenv = prev.pkgs.stdenv;
  # too inconvenient to declare as a dependency, just include it always
  commonBuildDeps = [ prev.pkgs.which ];

  # surround an (optional) `*Phase` attribute with
  # pre / post hooks
  populateBuildPhases = obj:
    let
      buildPhase = { attr = "buildPhase"; suffix = "Build"; };
      installPhase = { attr = "installPhase"; suffix = "Install"; };
      attr = phase: {
        name = phase.attr;
        value = ''
          runHook pre${phase.suffix}
          ${if hasAttr phase.attr obj
            then getAttr phase.attr obj
            else ""}
          runHook post${phase.suffix}
        '';
      };
    in
    obj // listToAttrs [(attr buildPhase) (attr installPhase)];
    
  copyFilesHook = prev.makeHook "copy-files" ''
    function copyOpamFiles {
      echo "+ copyOpamFiles"
      cp -r --no-preserve=mode --dereference -v $files/. ./
    }
    preBuildHooks+=(copyOpamFiles)
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
}:
  let finalBuild = populateBuildPhases build; in addHooks build.mode ({
    inherit pname version depKeys src;
    configurePhase = "true";
    inherit (finalBuild) buildPhase installPhase;

    # TODO don't need to include ocaml as dependency if it's a node package
    # TODO which deps can we get away with not propagating?
    propagatedBuildInputs =
      (map final.getDrv depKeys) ++
      (map getDepext (build.depexts or []));
 
    buildInputs = buildInputs ++ commonBuildDeps ++
      (if files != null then [ copyFilesHook ] else []);
  }
    // (if opamName != null then { inherit opamName; } else {})
    // (if files != null then { inherit files; } else {})
  )