final: prev: with prev.pkgs.lib;
  let
    stdenv = prev.pkgs.stdenv;
    commonBuildDeps = [ prev.pkgs.which ];
    defaultBuilds = {
      opam = {
        buildPhase = "echo 'Default build: opam'";
        installPhase = "echo 'Default install: opam'";
      };
      esy = {
        buildPhase = "echo 'Default build: esy'";
        installPhase = "echo 'Default install: esy'";
      };
      node = {
        buildPhase = "echo 'Default build: node'";
        installPhase = "echo 'Default install: node'";
      };
    };
  in
  {
  specToAttrs = {
    key, pname, version,
    depKeys,
    src ? prev.emptyDrv,
    build ? { mode = "esy"; } #TODO: after we support link-dev, use abort "no build instructions passed for derivation ${key}"
  }@spec:
    let buildWithDefault = (getAttr build.mode defaultBuilds) // build; in
    {
      inherit pname version depKeys src;
      configurePhase = "true";
      inherit (buildWithDefault) buildPhase installPhase;

      # TODO don't need to include ocaml as dependency if it's a node package
      propagatedBuildInputs = (map final.getDrv depKeys) ++ (build.depexts or []);
      
      # setupHooks comes from ./hooks.nix
      buildInputs = [(final.setupHooks build.mode)] ++ commonBuildDeps;
    };
}