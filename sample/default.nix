{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  osx = darwin.apple_sdk.frameworks;
  ifDarwin = deps: if stdenv.isDarwin then deps else [];
  esy = (callPackage ../nix/esy {});
  yarn = (callPackage ../nix/yarn {});
  
  yarnSelection = yarn.load ./yarn.nix {};

  glibtool = if stdenv.isDarwin
    then (stdenv.mkDerivation {
      # https://stackoverflow.com/questions/54078839/mac-osx-where-can-i-download-glibtool
      name = "glibtool";
      buildInputs = [makeWrapper];
      buildCommand = ''
        mkdir -p $out/bin
        for f in ${libtool}/bin/*; do
          gname="g$(basename $f)"
          echo "Wrapping $f as $gname"
          makeWrapper $f $out/bin/$gname
        done
      '';
    })
    else libtool;
  esySelection = esy.load ./esy.nix {
    pkgOverrides = self:
      let
        # TODO this will interfere with genuine configure phases, but we don't have any yet
        cmakeHook = self.makeHook "esy-cmake" ''
          function esyCmake {
            export configurePhase=true
          }
          postUnpackHooks+=(esyCmake)
        '';
        fixupLibPath = name: o: stdenv.mkDerivation (self.specToAttrs (o.spec // {
          build = o.spec.build // {
            exportedEnv = (o.spec.build.exportedEnv or []) ++ ["${name}_LIB_PATH=$out/lib"];
          };
        }));

      in [
      (self.override {
        # we already have one in nix, just use that:
        esy-nasm = _: pkgs.nasm;

        # the esy package downloads deps at runtime, so we
        # have to prefetch them and symlink them,
        # then replicate the rest of the build process
        esy-skia = o: stdenv.mkDerivation (self.specToAttrs (o.spec // {
          buildInputs = (o.spec.buildInputs or []) ++ [ gn python2 ];
          build = o.spec.build // {
            # deps file thanks to https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/aseprite/skia-make-deps.sh
            buildPhase =
              let deps = import ./skia-deps.nix { inherit fetchgit; }; in
            ''
              mkdir -p third_party/externals
              ${
                with lib;
                concatStringsSep "\n" (
                  mapAttrsToList (name: impl:
                    "echo \"+ ln -s ${impl} third_party/externals/${name}\"\n" +
                    "ln -s ${impl} third_party/externals/${name}"
                  ) deps
                )
              }
              mkdir -p $cur__target_dir/out/Static
              echo '#!/usr/bin/env sh' > gn/xamarin_inject_compat.py
              chmod +x gn/xamarin_inject_compat.py
              gn gen $cur__target_dir/out/Static --script-executable="$PYTHON_BINARY" "--args=cc=\"$CC\" cxx=\"$CXX\" skia_use_system_libjpeg_turbo=true is_debug=false extra_cflags=[\"-I''${ESY_LIBJPEG_TURBO_PREFIX}/include\", \"-Wno-poison-system-directories\"] extra_ldflags=[\"-L''${ESY_LIBJPEG_TURBO_PREFIX}/lib\", \"-ljpeg\" ]" || exit -1
              ninja.exe -C $cur__target_dir/out/Static
            '';
          };
        }));
        # TODO raise PRs upstream
        # all these packages make the mistake of exporting "${self.lib}" as an
        # env var, despite not actually respecting that during build
        # - they actually install into a hardcoded $out/lib
        esy-sdl2 = fixupLibPath "SDL2";
        esy-freetype2 = fixupLibPath "FREETYPE2";
        esy-harfbuzz = fixupLibPath "HARFBUZZ";
        revery-esy-harfbuzz = fixupLibPath "HARFBUZZ";
        esy-libjpeg-turbo = fixupLibPath "JPEG";
        libvim = fixupLibPath "LIBVIM";
        esy-oniguruma = fixupLibPath "ONIGURUMA";
        revery-esy-libvterm = fixupLibPath "LIBVTERM";

        revery-esy-cmake = _: stdenv.mkDerivation rec {
          pname = "revery-esy-cmake";
          name = pname;
          src = self.emptyDrv;
          installPhase = "true";
          propagatedBuildInputs = [ cmake cmakeHook ];
        };
      })
      (self.overrideAttrs {
        ocaml = (o: {
          # upstream puts stuff in $out/lib, not the site-packages dir
          buildPhase = ''
            ./esy-configure --disable-cfi --prefix $out --libdir $OCAMLFIND_DESTDIR
            ./esy-build
          '';
        });
        ocamlfind = (o: {
          buildInputs = (o.buildInputs or []) ++ [ m4 ];
          # default build lacks topfind, we need to hack its destination so it doesn't
          # try to install to ocaml's store path
          buildPhase = ''
            sed -i -e '/INSTALL_TOPFIND/ s/OCAML_CORE_STDLIB/OCAML_SITELIB/' src/findlib/Makefile
            ./configure \
              -bindir "$out"/bin \
              -sitelib "${self.siteLib "$out"}/ocamlfind" \
              -mandir "$out"/man \
              -config "${self.siteLib "$out"}/ocamlfind/findlib.conf" \
              -no-custom
            make all
            make opt
          '';
          # default install tries to add ocaml-stub which assumes an opam FS layout
          installPhase = ''
            make install
            mkdir -p $out/nix-support
            cat <<EOF > $out/nix-support/setup-hook
              findlibSetup () {
                local base="$out"
            EOF
            cat <<"EOF" >> $out/nix-support/setup-hook
                if [[ "''${OCAMLTOP_INCLUDE_PATH:-}" != *$base* ]]; then
                  export OCAMLTOP_INCLUDE_PATH="''${OCAMLTOP_INCLUDE_PATH:+$OCAMLTOP_INCLUDE_PATH:}${self.siteLib "$base"}/ocamlfind"
                fi
              }
              addEnvHooks "$targetOffset" findlibSetup
            EOF
          '';
        });
        esy-libtools = (o: {
          buildInputs = (o.buildInputs or []) ++ [m4 perl];
          propagatedBuildInputs = (o.propagatedBuildInputs or []) ++ [glibtool];
        });
        revery = (o: {
          propagatedBuildInputs = (o.propagatedBuildInputs or [])
            ++ [ libiconv ]
            ++ (ifDarwin [ osx.Cocoa osx.ForceFeedback ]);
          patches = [
            # TODO:
            # the stdcxx stuff should be fixed by https://github.com/ocaml/dune/pull/3802
            # in dune 2.8
            # The Foundation include should be upstreamed
            ./revery-libcxx.diff # note: only works on darwin
          ];
        });
        revery-esy-libvterm = (o: {
          # something (maybe stdenv?) is causing a .dylib and .la to be built,
          # but revery expects an .a file?
          installPhase = o.installPhase + ''
            make install LIBRARY=libvterm.a PREFIX=$out
          '';
        });
        Oni2 = o:
          let
            yarn2nix = pkgs.yarn2nix-moretea;
            # TODO hacky...
            # lock file seems to be missing some versions, prioritising
            # less duplication over version constraints. Is there a flag
            # we can pass to allow it?
            yarnFiles = stdenv.mkDerivation {
              name = "oni2-yarn-files";
              buildCommand = ''
                mkdir -p $out
                cp ${o.src}/node/package.json $out/
                cp ${o.src}/node/yarn.lock $out/
                cd $out
                patch -p1 < ${./oni2-yarn.diff}
              '';
            };
            depDrv = yarn2nix.mkYarnModules {
              name = "oni2-yarn-deps";
              pname = "oni2-node";
              version = "1.0.0";
              packageJSON = "${yarnFiles}/package.json";
              yarnLock = "${yarnFiles}/yarn.lock";
              yarnNix = ./oni2-yarn.nix; # manually generated with yarn2nix
            };
          in
        {
          # sed 1: we have libintl via gettext dependency, don't use your silly hardcoded homebrew path!
          # buildinfo: requires git, and has all the wrong node_modules paths...
          # setup.json: default `node scripts/bootstrap.js is flush with references to the build dir and vendored stuff...
          # {
          #   "node": "/private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-Oni2-0.5.9-nightly.drv-0/source/vendor/node-v12.17.0/osx/node",
          #   "nodeScript": "/private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-Oni2-0.5.9-nightly.drv-0/source/node",
          #   "bundledExtensions": "/private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-Oni2-0.5.9-nightly.drv-0/source/extensions",
          #   "developmentExtensions": "/private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-Oni2-0.5.9-nightly.drv-0/source/development_extensions",
          #   "rg": "/private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-Oni2-0.5.9-nightly.drv-0/source/vendor/ripgrep-v0.10.0/mac/rg",
          #   "rls": "/private/var/folders/8h/9qtq_hhn6lg69q27h5d17lw80000gp/T/nix-build-Oni2-0.5.9-nightly.drv-0/source/vendor/reason-language-server/bin.native"
          # }
          buildPhase =
          ''
            sed -E -i -e 's|getLibIntlPath\(\)|"-lintl"|' src/reason-libvim/config/discover.re
            ln -s ${depDrv}/node_modules ./node/node_modules

            cat > src/gen_buildinfo/generator.re <<"EOF"
              let oc = open_out("BuildInfo.re");
              Printf.fprintf(
                oc,
                {|
              let commitId = "XXXXXXXX";
              let version = "1.0.0";
              let defaultUpdateChannel = "unstable";
              let extensionHostVersion = "1.0.0";
              |}
              );
              close_out(oc);
            EOF
            
            # node scripts/bootstrap.js
            cat > assets/configuration/setup.json <<EOF
            {
              "node": "${o.src}/vendor/node-v12.17.0/osx/node",
              "nodeScript": "$out/node",
              "bundledExtensions": "${o.src}/extensions",
              "developmentExtensions": "${o.src}/development_extensions",
              "rg": "${o.src}/vendor/ripgrep-v0.10.0/mac/rg",
              "rls": "${o.src}/vendor/reason-language-server/bin.native"
            }
            EOF
          '' + o.buildPhase;

          installPhase = o.installPhase + ''
            cp -a node $out/node
          '';
          passthru = o.passthru // { inherit depDrv; };
        };
      })
      (self.addBuildInputs {
        autoconf = [m4 perl];
        automake = [perl];
        esy-help2man = [perl];
        esy-tree-sitter = [gcc];
        revery-esy-libvterm = [ perl ];
        texinfo = [ perl ];
        yarn-pkg-config = [ libiconv ];
        Oni2 = [ gettext nodejs ];
      })
      (self.addPropagatedBuildInputs {
        esy-cmake = [ pkgs.cmake cmakeHook ];
        esy-sdl2 = [libGL.dev] ++ (ifDarwin [
          osx.IOKit osx.CoreAudio osx.Cocoa
          osx.Foundation osx.AudioToolbox
          osx.AudioUnit osx.ForceFeedback
        ]);
        libvim = [ncurses.dev] ++ (ifDarwin [ osx.AppKit ]);
        esy-skia = ifDarwin [ osx.ApplicationServices ];
        revery-terminal = ifDarwin [ osx.AppKit osx.Cocoa ];
      })
    ];
  };
in
{
  esy = esySelection.toplevelPackage.overrideAttrs (o: {
    passthru = esySelection.drvsByName;
  });
  yarn = yarnSelection.toplevelPackage.overrideAttrs (o: {
    passthru = yarnSelection.drvsByName;
  });
}