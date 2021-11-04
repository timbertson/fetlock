{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  osx = darwin.apple_sdk.frameworks;
  ifDarwin = deps: if stdenv.isDarwin then deps else [];
  fetlock = callPackage ../../nix {};
  yarnSelection = fetlock.yarn.load ../yarn/lock.nix {};
  
  selection = fetlock.esy.load ./lock.nix {
    pkgOverrides = self:
      let
        fixupLibPath = name: o: stdenv.mkDerivation (self.specToAttrs (o.spec // {
          build = o.spec.build // {
            exportedEnv = (o.spec.build.exportedEnv or []) ++ ["${name}_LIB_PATH=$out/lib"];
          };
        }));
      in [
      (self.overrideDrv {
        # we already have one in nix, just use that:
        esy-nasm = _: pkgs.nasm;

        # the esy package downloads deps at runtime, so we
        # have to prefetch them and symlink them,
        # then replicate the rest of the build process
        esy-skia = o: (stdenv.mkDerivation (self.specToAttrs (o.spec // {
          buildInputs = (o.spec.buildInputs or []) ++ [ gn python2 ];
          build = o.spec.build // {
            # deps file thanks to https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/aseprite/skia-make-deps.sh
            buildPhase =
              let deps = import ./src/skia-deps.nix { inherit fetchgit; }; in
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
        }))).overrideAttrs (_: {
          inherit (o) propagatedBuildInputs;
        });
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
          propagatedBuildInputs = [ cmake self.disableConfigureHook ];
        };
      })
      (self.overrideAttrs {
        revery = (o: {
          propagatedBuildInputs = (o.propagatedBuildInputs or [])
            ++ [ libiconv ]
            ++ (ifDarwin [ osx.Cocoa osx.ForceFeedback ]);
          patches = [
            # TODO:
            # the stdcxx stuff should be fixed by https://github.com/ocaml/dune/pull/3802
            # in dune 2.8
            # The Foundation include should be upstreamed
            ./src/revery-libcxx.diff # note: only works on darwin
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
        {
          src = fetchFromGitHub {
            owner = "onivim";
            repo = "Oni2";
            rev = "39bb26f68040326ecf4d03f6c4428c05f13a02d5";
            sha256 = "0lb7a48d7i93gshyqzvshbsff6nyknsl9hdjdszmqyirgawmrgs9";
          };
          patches = [
            ./src/oni2-buildinfo.patch
            ./src/oni2-gettext.patch
          ];
          # without passing explicitly, oni will search homebrew paths on mac
          GETTEXT_LIB_PATH = "${gettext}/lib";
          buildPhase =
          ''
            ln -s ${yarnSelection.root}/node_modules ./node/node_modules
            node scripts/bootstrap.js
          '' + o.buildPhase;

          # bootstrap.js hardcodes a bunch of paths relative to itself,
          # so we need to run it again after installation, from $out
          installPhase = o.installPhase + ''
            cp -a scripts $out/scripts
            cp -a assets $out/scripts

            ln -s ${o.src}/node $out/node
            ln -s ${o.src}/extensions $out/extensions
            ln -s ${o.src}/development_extensions $out/development_extensions
            ln -s ${o.src}/vendor $out/vendor

            node scripts/bootstrap.js
            rm -rf $out/scripts
          '';
          passthru = o.passthru;
        };
      })
      
      # NOTE: overrides below here could be hoisted into default overrides,
      # but they need to be applied _after_ the above overrides
      # which regenerate from specToAttrs
      (self.addBuildInputs {
        Oni2 = [ gettext nodejs ];
        revery-esy-libvterm = [ perl ];
      })

      (self.addPropagatedBuildInputs {
        esy-sdl2 = [libGL.dev] ++ (ifDarwin [
          osx.IOKit osx.CoreAudio osx.Cocoa
          osx.Foundation osx.AudioToolbox
          osx.AudioUnit osx.ForceFeedback
        ]);
        esy-skia = ifDarwin [ osx.ApplicationServices ];
        libvim = [ncurses.dev] ++ (ifDarwin [ osx.AppKit ]);
      })
    ];
  };
in
selection.root
