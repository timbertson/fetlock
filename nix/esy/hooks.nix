final: prev:
  let pkgs = prev.pkgs; in
  with pkgs.lib; {
  setupHooks = mode: let
    makeHook = name: text:
      pkgs.makeSetupHook { inherit name; } (pkgs.writeText "setupHook.sh" text);
    path = makeHook "ocaml-path-hooks" ''
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
    '';
    outputDirs = makeHook "ocaml-output-dirs" ''
      function ocamlOutputDirs {
        echo \
          $out/bin \
          ;
      }
      function ocamlInitDirs {
        echo "+ ocamlInitDirs"
        for d in $(ocamlOutputDirs); do
          echo "Creating: $d"
          mkdir -p "$d"
          ls -l "$d"
        done
      }
      function ocamlCleanEmptyDirs {
        echo "+ ocamlCleanEmptyDirs"
        for d in $(ocamlOutputDirs); do
          echo "cleaning: $d"
          if [ -z "$(ls -A "$d")" ]; then
            rmdir "$d"
          fi
        done
      }
      postUnpackHooks+=(ocamlInitDirs)
      preFixupHooks+=(ocamlCleanEmptyDirs)
    '';
    modeSpecific = {
      esy = [
        (makeHook "esy-env" ''
          function esySetupEnvVars {
            echo '+ esySetupEnvVars'
            export cur__bin=$out/bin
            export cur__root=$PWD
            export cur__target_dir=$PWD/_build
            export cur__install=$out
            export cur__lib=${final.siteLib "$out"}/$pname
            export cur__share=$out/share
            export cur__man=$out/man
            export cur__doc=$out/doc
            export cur__stublibs=$out/stublibs/$pname
            export cur__stublibs=$out/toplevel/$pname
            env | grep '^cur__'
            mkdir -p "$cur__target_dir"
          }
          postUnpackHooks+=(esySetupEnvVars)
        '')
      ];
    };

  in [ path outputDirs ] ++ (
    if hasAttr mode modeSpecific then getAttr mode modeSpecific else []
  );
}