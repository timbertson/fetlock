final: prev: with prev.pkgs.lib;
  let
    stdenv = prev.pkgs.stdenv;
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
  buildSpec = {
    key, pname, version,
    depKeys,
    src ? core.emptyDrv,
    build ? { mode = "esy"; } #TODO: after we support link-dev, use abort "no build instructions passed for derivation ${key}"
  }@spec:
    let buildWithDefault = (getAttr build.mode defaultBuilds) // build; in
    warn pname ( # TODO remove
    stdenv.mkDerivation {
      inherit pname version depKeys src;
      inherit (buildWithDefault) buildPhase installPhase;
      # TODO don't need to include ocaml as dependency if it's a node package
      propagatedBuildInputs = (map final.getDrv depKeys) ++ (build.depexts or []);
      
      # setupHooks comes from ./hooks.nix
      buildInputs = [(final.setupHooks build.mode)];
      passthru.spec = spec;
    });

  ocaml = final.context.ocaml or (abort ''

    ERROR: No ocaml version present in lockfile.
    If you still want to build this expression,
    you will need to set the root `ocaml` attribute
    in your override.
  '');
}