{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  osx = darwin.apple_sdk.frameworks;
  ifDarwin = deps: if stdenv.isDarwin then deps else [];
  esy = (callPackage ../nix/esy {});

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
  selection = esy.load ./esy.nix {
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
        # skip esy builds entirely for things that are already packaged in nix
        esy-nasm = _: pkgs.nasm;
        #esy-skia = _: pkgs.aseprite.skia.overrideAttrs (_: {
        #  pname = "esy-skia";
        #});

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
            # installPhase = "set -x;" + o.spec.build.installPhase;
          };
        }));
        # esy-skia = o:
        # let attrs = self.specToAttrs (o.spec // {
        #   build = {
        #     inherit (o.spec.build) mode;
        #     # strange path, but it's what aseprite produces :shrug:
        #     exportedEnv = o.spec.build.exportedEnv ++ [ "SKIA_LIB_PATH=$out/out/Release" ];
        #       # Cflags: -I$cur__install -I\${includedir}/android -I\${includedir}/atlastext -I\${includedir}/c -I\${includedir}/codec -I\${includedir}/config -I\${includedir}/core -I\${includedir}/docs -I\${includedir}/effects -I\${includedir}/encode -I\${includedir}/gpu -I\${includedir}/pathops -I\${includedir}/ports -I\${includedir}/private -I\${includedir}/svg -I\${includedir}/third_party -I\${includedir}/utils $extraCFlags
        #     installPhase = ''
        #       mkdir -p $out
        #       cp -r ${pkgs.aseprite.skia}/. $out/
        #       cp -r include/c $out/include/c
        #     '';
        #      #
        #      # cat >$cur__lib/pkg-config/skia.pc << EOF
        #      # includedir=$cur__install/include
        #      # Name: skia
        #      # Description: 2D graphics library
        #      # Version: $cur__version
        #      # Libs: -lskia -lstdc++
        #      # EOF
        #   };
        #   # src = self.emptyDrv;
        # }); in
        # stdenv.mkDerivation (attrs // {
        #   # propagatedBuildInputs = (attrs.propagatedBuildInputs or []) ++ [ libcxx ];
        # });
        
        # TODO raise PRs upstream
        # all these packages make the mistake of exporting "${self.lib}" as an
        # env var, despite not actually respecting that during build
        # - they actually install into a hardcoded $out/lib
        esy-sdl2 = fixupLibPath "SDL2";
        esy-freetype2 = fixupLibPath "FREETYPE2";
        esy-harfbuzz = fixupLibPath "HARFBUZZ";
        revery-esy-harfbuzz = fixupLibPath "HARFBUZZ";
        esy-libjpeg-turbo = fixupLibPath "JPEG";
        esy-tree-sitter = fixupLibPath "TREESITTER";
        libvim = fixupLibPath "LIBVIM";
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
      })
      (self.addBuildInputs {
        autoconf = [m4 perl];
        automake = [perl];
        esy-help2man = [perl];
        esy-tree-sitter = [gcc];
        revery-esy-libvterm = [ perl ];
        texinfo = [ perl ];
        yarn-pkg-config = [ libiconv ];
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
selection.toplevelPackage.overrideAttrs (o: {
	passthru = selection.drvsByName;
})