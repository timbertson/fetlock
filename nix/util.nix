{ pkgs }:
with pkgs.lib; {
  # surround an (optional) `*Phase` attribute with
  # pre / post hooks
  populateBuildPhases = build:
    let
      buildPhase = { attr = "buildPhase"; suffix = "Build"; };
      installPhase = { attr = "installPhase"; suffix = "Install"; };
      attr = phase: {
        name = phase.attr;
        value = ''
          runHook pre${phase.suffix}
          ${if hasAttr phase.attr build
            then getAttr phase.attr build
            else ""}
          runHook post${phase.suffix}
        '';
      };
    in
    build // listToAttrs [(attr buildPhase) (attr installPhase)];
}