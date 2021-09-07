final: prev: {
  copyFilesHook = final.makeHook "copy-files" ''
    function copyOpamFiles {
      echo "+ copyOpamFiles"
      cp -r --no-preserve=mode --dereference -v $files/. ./
    }
    preBuildHooks+=(copyOpamFiles)
  '';

  extend = (
    let
      pkgs = prev.pkgs;
      # TODO use the same version of ocaml as selection?
      ocamlPackages = pkgs.ocamlPackages_latest;

      # too inconvenient to declare as a dependency, just include it always
      commonBuildDeps = [ prev.pkgs.which ];

      # TODO we're sidestepping a bootstrapping problem here.
      # opam-installer depends on dune, and dune will use this hook.
      # but it's OK as long as the upstream opam-installer isn't a fetlock package.
      # TODO it'd be nice to use ocaml from the selections instead of bringing another
      # one along here.
      opam-installer = pkgs.opam.installer;

      path = final.makeHook "ocaml-path-hooks" ''
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

      # updating pname is a bit cheeky - we want the canonical pname
      # (e.g. esy-whatever) in nix land, but during build we'd prefer it
      # to match the opam name, rather than having to introduce a separate
      # opamName concept (we only populate opamName where it's != pname)

      # Creating stublibs ensures that ocamlfind won't try to mess with ld.conf,
      # see https://linux.die.net/man/1/ocamlfind
      outputDirs = prev.makeHook "ocaml-output-dirs" ''
        function ocamlInitDirs {
          echo "+ ocamlInitDirs"
          if [ -n "''${opamName:-}" ]; then
            echo "setting pname to $opamName"
            export pname="$opamName"
          fi
          for d in \
            $out/bin \
            ${final.siteLib "$out"}/$pname \
            ${final.siteLib "$out"}/stublibs/$pname \
            ${final.siteLib "$out"}/toplevel/$pname \
          ; do
            echo "Creating: $d"
            mkdir -p "$d"
          done
        }

        function ocamlCleanEmptyDirs {
          echo "+ ocamlCleanEmptyDirs"
          find "$out" -mindepth 1 -depth -empty -a -type d -exec rmdir {} \;
        }
        postUnpackHooks+=(ocamlInitDirs)
        preFixupHooks+=(ocamlCleanEmptyDirs)
      '';

      installFile = prev.makeHook "ocaml-install" ''
        function ocamlInstall {
          echo '+ ocamlInstall'
          if [ -e "$pname.install" ]; then
            echo "installing $pname.install"
            ${opam-installer}/bin/opam-installer "$pname.install" \
              --prefix="$out" \
              --libdir="${final.siteLib "$out"}" \
              ;
          else
            echo "no $pname.insall file; skipping"
          fi
        }
        preInstallHooks+=(ocamlInstall)
      '';
              ## TODO upgrade hooks to install every .install file in the root?
              ## (and hope we don't have arbitrary other install files in the src)
              #installPhase = ''
              #  for f in *.install; do
              #    dune install "$(basename $f .install)" \
              #      --prefix="$out" \
              #      --libdir="${self.siteLib "$out"}"
              #  done
              #'';

      esyHooks = [
        # Note: use of `$PWD` means we need to run this
        # after srcDir has been detected and `cd`d into
        # NOTE: can't mkdir -p "$cur__target_dir" since some builds
        # (e.g. esy-harfbuzz) do a cp to that directory so expect it to be missing
        (prev.makeHook "esy-env" ''
          function esySetupEnvVars {
            echo '+ esySetupEnvVars'
            export cur__bin=$out/bin
            export cur__root=$PWD
            export cur__target_dir=$PWD/_build
            export cur__install=$out
            export cur__lib=${final.siteLib "$out"}
            export cur__share=$out/share
            export cur__man=$out/man
            export cur__doc=$out/doc
            export cur__stublibs=${final.siteLib "$out"}/stublibs
            export cur__toplevel=${final.siteLib "$out"}/toplevel
            env | grep '^cur__'
          }
          preBuildHooks+=(esySetupEnvVars)
        '')

        (pkgs.stdenv.mkDerivation {
          name = "esy-installer-shim";
          buildCommand = ''
            mkdir -p $out/bin
            cat > $out/bin/esy-installer <<"EOF"
              #!${pkgs.bash}/bin/bash
              exec ${opam-installer}/bin/opam-installer \
                --prefix="$out" \
                --libdir="${final.siteLib "$out"}" \
                "$@"
            EOF
            chmod +x $out/bin/esy-installer
          '';
        })
      ];
      opamHooks = [
        installFile
      ];
    in
  mode: { pname , ... }@ attrs:
    let
      modeHooks =
        if mode == "esy" then (esyHooks ++
          (if (attrs.build or {}) ? installPhase then [] else [ installFile ])
        )
        else if mode == "opam" then opamHooks
        else [];
      hooks = [ commonBuildDeps path outputDirs ] ++ modeHooks;
    in
    attrs // {
      buildInputs = hooks ++ (attrs.buildInputs or []);
    }
  );
}