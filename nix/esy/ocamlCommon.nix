# Common utilities across opam / esy
{ pkgs, stdenv, lib }:
  let frameworks = pkgs.darwin.apple_sdk.frameworks; in
{
  overlay = final: prev: {
    siteLib = prefix: "${prefix}/lib/ocaml/${final.ocaml.version}/site-lib";
    specToAttrs = import ./specToAttrs.nix final prev;
    ocaml = final.drvs.ocaml or final.drvsByName.ocaml or (abort ''
      ERROR: No ocaml version present in lockfile.
      To build this expression, you will need to provide
      an `ocaml` implementation in your override.
    '');
  };
  
  overrides = self: with self.pkgs; [
    (self.overrideAttrs {
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
    })

    (self.addBuildInputs {
      autoconf = [m4 perl];
      automake = [perl];
      esy-help2man = [perl];
      esy-tree-sitter = [gcc];
      texinfo = [ perl ];
      yarn-pkg-config = [ libiconv ];
      dune = if stdenv.isDarwin then [ frameworks.CoreServices ] else [];
    })
  ];
}
