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
      in [
      (self.addBuildInputs {
        autoconf = [m4 perl];
        automake = [perl];
        esy-help2man = [perl];
        esy-tree-sitter = [gcc];
        esy-sdl2 = [libGL.dev] ++ (ifDarwin [
            osx.IOKit osx.CoreAudio
            osx.Foundation osx.AudioToolbox
            osx.AudioUnit osx.ForceFeedback
          ]);
        libvim = [ncurses.dev] ++ (ifDarwin [ osx.AppKit ]);
        revery-esy-libvterm = [ perl ];
        texinfo = [ perl ];
        yarn-pkg-config = [ libiconv ];
      })
      (self.addPropagatedBuildInputs {
        esy-cmake = [ pkgs.cmake cmakeHook ];
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
        # TODO this is specified in `exportedEnv` of package.json,
        # but fetlock doesn't support that
        esy-fzy = (o: {
          installPhase = (o.installPhase or "") + ''
            mkdir -p $out/nix-support
            cat <<EOF > $out/nix-support/setup-hook
              function exportFzyEnv {
                echo '+ exportFzyEnv'
                export FZY_INCLUDE_PATH=$out/include
                export FZY_LIB_PATH=$cur__lib/esy-fzy
                env | grep '^FZY_'
              }
              preBuildHooks+=(exportFzyEnv)
            EOF
          '';
        });
        revery = (o: {
          # TODO promote this more broadly, and maybe onoly on darwin?
          # https://github.com/NixOS/nixpkgs/issues/39687
          hardeningDisable = ["strictoverflow"];
          buildInputs = (o.buildInputs or []) ++ (ifDarwin [ osx.Cocoa ]);
        });
        # ctypes = (o: {
        #   # TODO promote this to general setup hook?
        #   # see https://linux.die.net/man/1/ocamlfind
        #   installPhase = ''
        #     mkdir -p $out/stublibs
        #     #mkdir -p ${self.siteLib "$out"}/stublibs
        #   '' + o.installPhase;
        # });
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