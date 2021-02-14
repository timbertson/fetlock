final: prev:
let
  pkgs = prev.pkgs;
  # TODO use the same version of ocaml as selection?
  ocamlPackages = pkgs.ocamlPackages_latest;
  opam-installer =
    # TODO use upstream when it works properly.
    # currently lablgtk doesn't compile and it's a pointless dependency anyway
    let
      callOcamlPackage = ocamlPackages.newScope rec {
        ocamlgraph = callOcamlPackage "${pkgs.path}/pkgs/development/ocaml-modules/ocamlgraph/default.nix" {
          lablgtk = null;
          gtkSupport = false;
        };
        opam-core = callOcamlPackage "${pkgs.path}/pkgs/development/ocaml-modules/opam-core/default.nix" {
          inherit ocamlgraph;
        };
        opam-format = callOcamlPackage "${pkgs.path}/pkgs/development/ocaml-modules/opam-format/default.nix" {
          inherit opam-core;
        };
        opam-installer = callOcamlPackage "${pkgs.path}/pkgs/development/tools/ocaml/opam/installer.nix" {
          ocamlPackages = ocamlPackages // {
            inherit opam-format;
          };
        };
      };
    in
    callOcamlPackage ({ opam-installer }: opam-installer ) {};


  path = prev.makeHook "ocaml-path-hooks" ''
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

  # TODO we're sidestepping a bootstrapping problem here.
  # opam-installer depends on dune, and dune will use this hook.
  # but it's OK as long as the upstream opam-installer isn't a fetlock package.
  # TODO it'd be nice to use ocaml from the selections instead of bringing another
  # one along here.
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
        export cur__lib=${final.siteLib "$out"}/$pname
        export cur__share=$out/share
        export cur__man=$out/man
        export cur__doc=$out/doc
        export cur__stublibs=${final.siteLib "$out"}/stublibs/$pname
        export cur__toplevel=${final.siteLib "$out"}/toplevel/$pname
        env | grep '^cur__'
      }
      preBuildHooks+=(esySetupEnvVars)
    '')
  ];
  opamHooks = [
  ];
in

mode:
{ pname , ... }@ attrs:
let
  modeHooks =
    if mode == "esy" then esyHooks
    else if mode == "opam" then opamHooks
    else [];
  hooks = [ path outputDirs installFile ] ++ modeHooks;
in
attrs // {
  buildInputs = hooks ++ (attrs.buildInputs or []);
}