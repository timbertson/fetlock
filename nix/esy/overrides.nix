self: with self.pkgs;
let
  osx = darwin.apple_sdk.frameworks;
  ifDarwin = deps: if stdenv.isDarwin then deps else [];
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
in
[

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
  })

  (self.addBuildInputs {
    autoconf = [m4 perl];
    automake = [perl];
    esy-help2man = [perl];
    esy-tree-sitter = [gcc];
    texinfo = [ perl ];
    yarn-pkg-config = [ libiconv ];
  })

  (self.addPropagatedBuildInputs {
    esy-cmake = [ pkgs.cmake self.disableConfigureHook ];
    revery-terminal = ifDarwin [ osx.AppKit osx.Cocoa ];
  })
]