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

    esy-libtools = (o: {
      buildInputs = (o.buildInputs or []) ++ [m4 perl];
      propagatedBuildInputs = (o.propagatedBuildInputs or []) ++ [glibtool];
    });
  })
]