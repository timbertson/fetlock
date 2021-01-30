{ pkgs, stdenv, lib }:
with lib;
let
  core = pkgs.callPackage ../core.nix {};
  defaultBuilds = {
    opam = {
      buildPhase = "todo: opam";
      installPhase = "todo: opam";
    };
    esy = {
      buildPhase = "todo: esy";
      installPhase = "todo: esy";
    };
    node = {
      buildPhase = "todo: node";
      installPhase = "todo: node";
    };
  };

  overlay = final: prev: {
    # esy expects one of `linux`, `windows` and `linux`, anything else probably won't work
    platform = stdenv.buildPlatform.parsed.kernel.name;

    siteLib = prefix: "${prefix}/lib/ocaml/${final.ocaml.version}/site-lib";
    ocamlSetupHook = pkgs.makeSetupHook { name = "ocaml-path-hooks"; } (pkgs.writeText "setupHook.sh" ''
      function ocamlPathSetup {
        local libPath="lib/ocaml/${final.ocaml.version}/site-lib"
        local libdir="$1/$libPath"
        if test -d "$libdir"; then
          export OCAMLPATH="''${OCAMLPATH:+$OCAMLPATH:}$libdir"

          if test -d "$libdir/stublibs"; then
            export CAML_LD_LIBRARY_PATH="''${CAML_LD_LIBRARY_PATH:+$CAML_LD_LIBRARY_PATH:}$libdir/stublibs"
          else
            export CAML_LD_LIBRARY_PATH="''${CAML_LD_LIBRARY_PATH:+$CAML_LD_LIBRARY_PATH:}$libdir"
          fi
        fi
        export OCAMLFIND_DESTDIR="$out/$libPath"
      }
      addEnvHooks "$targetOffset" ocamlPathSetup
    '');
    buildSpec = {
      key, pname, version,
      depKeys,
      src ? core.emptyDrv,
      build ? { mode = "esy"; } #TODO: after we support link-dev, use abort "no build instructions passed for derivation ${key}"
    }:
      let buildWithDefault = (getAttr build.mode defaultBuilds) // build; in
      lib.warn key ( # TODO remove
      stdenv.mkDerivation {
        inherit pname version depKeys src;
        # TODO don't need to inclyde ocaml as dependency if it's a node package
        buildInputs = (map final.getDrv depKeys) ++ (build.depexts or []) ++ [final.ocamlSetupHook];
        buildPhase = ''
          mkdir -p $out
        '' + buildWithDefault.buildPhase;
        installPhase = buildWithDefault.buildPhase;
      });
    ocaml = final.context.ocaml or (abort ''

      ERROR: No ocaml version present in lockfile.
      If you still want to build this expression,
      you will need to set the root `ocaml` attribute
      in your override.
    '');
  };
in core.makeAPI {
  frontend = overlay;
}