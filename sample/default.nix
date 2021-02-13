{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  osx = darwin.apple_sdk.frameworks;
  esy = (callPackage ../nix/esy {});


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
      in [
      (self.addBuildInputs {
        autoconf = [m4 perl];
        automake = [perl];
        esy-libtools = [perl];
        esy-help2man = [perl];
        esy-tree-sitter = [gcc];
        esy-sdl2 = [libGL.dev] ++ (if stdenv.isDarwin
          then [
            osx.IOKit osx.CoreAudio
            osx.Foundation osx.AudioToolbox
            osx.AudioUnit osx.ForceFeedback
          ]
          else []);
        libvim = [ncurses.dev] ++ (if stdenv.isDarwin
          then [ osx.AppKit ]
          else []);
        yarn-pkg-config = [ libiconv ];
      })
      (self.addPropagatedBuildInputs {
        esy-cmake = [ pkgs.cmake cmakeHook ];
      })
      (self.overrideAttrs {
        ocamlfind = (o: {
          buildInputs = (o.buildInputs or []) ++ [ m4 ];
          # default install tries to add ocaml-stub which assumes an opam FS layout
          installPhase = "make install";
        });
      })
      (self.override {
        # skip esy builds entirely for things that are already packaged in nix
        esy-nasm = _: pkgs.nasm;
        esy-skia = _: pkgs.aseprite.skia.overrideAttrs (_: {
          pname = "esy-skia";
        });

        revery-esy-cmake = _: stdenv.mkDerivation rec {
          pname = "revery-esy-cmake";
          name = pname;
          src = self.emptyDrv;
          installPhase = "true";
          propagatedBuildInputs = [ cmake cmakeHook ];
        };
      })

      #(self.override {
      #  revery-esy-cmake = _: stdenv.mkDerivation rec {
      #    pname = "revery-esy-cmake";
      #    name = pname;
      #    src = self.emptyDrv;
      #    installPhase = "true";
      #    propagatedBuildInputs = [ cmake cmakeHook ];
      #  };
      #})
    ];
  };
in
selection.toplevelPackage.overrideAttrs (o: {
	passthru = selection.drvsByName;
})