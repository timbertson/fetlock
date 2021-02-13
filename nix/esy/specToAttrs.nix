final: prev:
with prev.pkgs.lib;
let
  addHooks = import ./hooks.nix final prev;
  stdenv = prev.pkgs.stdenv;
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
in
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
  build ? { mode = "esy"; }, #TODO: after we support link-dev, use abort "no build instructions passed for derivation ${key}"
  opamName ? null,
}:
  let finalBuild = populateBuildPhases build; in addHooks build.mode ({
    inherit pname version depKeys src;
    configurePhase = "true";
    inherit (finalBuild) buildPhase installPhase;

    # TODO don't need to include ocaml as dependency if it's a node package
    propagatedBuildInputs = (map final.getDrv depKeys) ++ (build.depexts or []);
    
    buildInputs = commonBuildDeps;
  } // (if opamName != null then { inherit opamName; } else {}))