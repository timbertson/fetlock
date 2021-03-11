{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  osx = darwin.apple_sdk.frameworks;
  ifDarwin = deps: if stdenv.isDarwin then deps else [];
  esy = (callPackage ../nix/esy {});
  yarn = (callPackage ../nix/yarn {});
  
  yarnSelection = yarn.load ./yarn.nix {};

  esySelection = esy.load ./esy.nix {
    pkgOverrides = self:
      let
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
        esy-skia = o: (stdenv.mkDerivation (self.specToAttrs (o.spec // {
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
            ln -s ${yarnSelection.toplevelPackage}/node_modules ./node/node_modules

            cat > src/gen_buildinfo/generator.re <<"EOF"
              let oc = open_out("BuildInfo.re");
              Printf.fprintf(
                oc,
                {|
              let commitId = "[built-with-nix]";
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
{
  esy = esySelection.toplevelPackage.overrideAttrs (o: {
    passthru = esySelection.drvsByName;
  });
  yarn = yarnSelection.toplevelPackage.overrideAttrs (o: {
    passthru = yarnSelection.drvsByName;
  });
}