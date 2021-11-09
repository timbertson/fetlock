final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "opam";
    version = "1";
    root = "vdoml";
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_12;
    repositories = {
      opam = (pkgs.fetchFromGitHub {
        owner = "ocaml";
        repo = "opam-repository";
        rev = "d814acf43af6b577737a332637d2b36a3d51be60";
        sha256 = "08mkymnvm1kysm8wi6yqsfc091lzfsvpjy31h83xr56i8j0sgsmq";
      });
    };
  };
  specs = {
    astring = {
      pname = "astring";
      version = "0.8.5";
      depKeys = [
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
        ("topkg")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ykhg9gd3iy7zsgyiy2p9b1wkpqg9irw5pvcqs3sphq71iir4ml6";
        url = "https://erratique.ch/software/astring/releases/astring-0.8.5.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false";
        installPhase = "";
        mode = "opam";
      };
    };
    base-bigarray = {
      pname = "base-bigarray";
      version = "base";
      depKeys = [
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    base-bytes = {
      pname = "base-bytes";
      version = "base";
      depKeys = [
        ("ocaml")
        ("ocamlfind")
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    base-threads = {
      pname = "base-threads";
      version = "base";
      depKeys = [
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    base-unix = {
      pname = "base-unix";
      version = "base";
      depKeys = [
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    biniou = {
      pname = "biniou";
      version = "1.2.1";
      depKeys = [
        ("dune")
        ("easy-format")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0da3m0g0dhl02jfynrbysjh070xk2z6rxcx34xnqx6ljn5l6qm1m";
        url = "https://github.com/mjambon/biniou/releases/download/1.2.1/biniou-1.2.1.tbz";
      });
      build = {
        buildPhase = "dune build -p biniou -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    cmdliner = {
      pname = "cmdliner";
      version = "1.0.4";
      depKeys = [
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1h04q0zkasd0mw64ggh4y58lgzkhg6yhzy60lab8k8zq9ba96ajw";
        url = "http://erratique.ch/software/cmdliner/releases/cmdliner-1.0.4.tbz";
      });
      build = {
        buildPhase = "make all PREFIX=$out";
        installPhase = ''
          make install "LIBDIR=${(final.siteLib "$out")}/cmdliner" DOCDIR=false
          make install-doc "LIBDIR=${(final.siteLib "$out")}/cmdliner" DOCDIR=false
        '';
        mode = "opam";
      };
    };
    conf-python-2-7 = {
      pname = "conf-python-2-7";
      version = "1.1";
      depKeys = [
      ];
      build = {
        buildPhase = "python2.7 test.py";
        depexts = [
          (pkgs.python27)
        ];
        installPhase = "";
        mode = "opam";
      };
      files = (final.subtree {
        base = final.repositories.opam;
        hash = "sha256:1cbp3zl1mbmjvp1q9jbs9g09llha53b5ysjijbly2py5915aj2zc";
        path = "packages/conf-python-2-7/conf-python-2-7.1.1/files";
      });
    };
    cppo = {
      pname = "cppo";
      version = "1.6.8";
      depKeys = [
        ("base-unix")
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0lxy4xkkkwgs1cj6d9lyzsqi9f6fc9r6cir5imi7yjqrpd86s1by";
        url = "https://github.com/ocaml-community/cppo/archive/v1.6.8.tar.gz";
      });
      build = {
        buildPhase = "dune build -p cppo -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    csexp = {
      pname = "csexp";
      version = "1.5.1";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "00mc19f89pxpmjl62862ya5kjcfrl8rjzvs00j05h2m9bw3f81fn";
        url = "https://github.com/ocaml-dune/csexp/releases/download/1.5.1/csexp-1.5.1.tbz";
      });
      build = {
        buildPhase = "dune build -p csexp -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    dune = {
      pname = "dune";
      version = "2.9.1";
      depKeys = [
        ("base-threads")
        ("base-unix")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09lzq04b642iy0ljp59p32lgk3q8iphjh8fkdp69q29l5frgwx5k";
        url = "https://github.com/ocaml/dune/releases/download/2.9.1/dune-2.9.1.tbz";
      });
      build = {
        buildPhase = ''
          ocaml bootstrap.ml -j $NIX_BUILD_CORES
          ./dune.exe build -p dune --profile dune-bootstrap -j $NIX_BUILD_CORES
        '';
        installPhase = "";
        mode = "opam";
      };
    };
    dune-configurator = {
      pname = "dune-configurator";
      version = "2.9.1";
      depKeys = [
        ("csexp")
        ("dune")
        ("ocaml")
        ("result")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09lzq04b642iy0ljp59p32lgk3q8iphjh8fkdp69q29l5frgwx5k";
        url = "https://github.com/ocaml/dune/releases/download/2.9.1/dune-2.9.1.tbz";
      });
      build = {
        buildPhase = "dune build -p dune-configurator -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    easy-format = {
      pname = "easy-format";
      version = "1.3.2";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09hrikx310pac2sb6jzaa7k6fmiznnmhdsqij1gawdymhawc4h1l";
        url = "https://github.com/mjambon/easy-format/releases/download/1.3.2/easy-format-1.3.2.tbz";
      });
      build = {
        buildPhase = "dune build -p easy-format -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    fmt = {
      pname = "fmt";
      version = "0.9.0";
      depKeys = [
        ("base-unix")
        ("cmdliner")
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
        ("topkg")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0q8j2in2473xh7k4hfgnppv9qy77f2ih89yp6yhpbp92ba021yzi";
        url = "https://erratique.ch/software/fmt/releases/fmt-0.9.0.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false --with-base-unix true --with-cmdliner true";
        installPhase = "";
        mode = "opam";
      };
    };
    fpath = {
      pname = "fpath";
      version = "0.7.3";
      depKeys = [
        ("astring")
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
        ("topkg")
      ];
      src = (pkgs.fetchurl {
        sha256 = "03z7mj0sqdz465rc4drj1gr88l9q3nfs374yssvdjdyhjbqqzc0j";
        url = "https://erratique.ch/software/fpath/releases/fpath-0.7.3.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build";
        installPhase = "";
        mode = "opam";
      };
    };
    js_of_ocaml = {
      pname = "js_of_ocaml";
      version = "3.11.0";
      depKeys = [
        ("dune")
        ("js_of_ocaml-compiler")
        ("ocaml")
        ("ppxlib")
        ("uchar")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0flws9mw0yjfw4d8d3y3k408mivy2xgky70xk1br3iqs4zksz38m";
        url = "https://github.com/ocsigen/js_of_ocaml/releases/download/3.11.0/js_of_ocaml-3.11.0.tbz";
      });
      build = {
        buildPhase = "dune build -p js_of_ocaml -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    js_of_ocaml-compiler = {
      pname = "js_of_ocaml-compiler";
      version = "3.9.1";
      depKeys = [
        ("cmdliner")
        ("dune")
        ("menhir")
        ("ocaml")
        ("ocamlfind")
        ("ppxlib")
        ("yojson")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ib551kfsjlp9vr3fk36hrbq7xxyl8bj6vcn3ccr0s370bsmgpm6";
        url = "https://github.com/ocsigen/js_of_ocaml/releases/download/3.9.1/js_of_ocaml-3.9.1.tbz";
      });
      build = {
        buildPhase = "dune build -p js_of_ocaml-compiler -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    js_of_ocaml-lwt = {
      pname = "js_of_ocaml-lwt";
      version = "3.11.0";
      depKeys = [
        ("dune")
        ("js_of_ocaml")
        ("js_of_ocaml-ppx")
        ("lwt")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0flws9mw0yjfw4d8d3y3k408mivy2xgky70xk1br3iqs4zksz38m";
        url = "https://github.com/ocsigen/js_of_ocaml/releases/download/3.11.0/js_of_ocaml-3.11.0.tbz";
      });
      build = {
        buildPhase = "dune build -p js_of_ocaml-lwt -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    js_of_ocaml-ppx = {
      pname = "js_of_ocaml-ppx";
      version = "3.11.0";
      depKeys = [
        ("dune")
        ("js_of_ocaml")
        ("ocaml")
        ("ppxlib")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0flws9mw0yjfw4d8d3y3k408mivy2xgky70xk1br3iqs4zksz38m";
        url = "https://github.com/ocsigen/js_of_ocaml/releases/download/3.11.0/js_of_ocaml-3.11.0.tbz";
      });
      build = {
        buildPhase = "dune build -p js_of_ocaml-ppx -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    logs = {
      pname = "logs";
      version = "0.7.0";
      depKeys = [
        ("base-threads")
        ("cmdliner")
        ("fmt")
        ("js_of_ocaml")
        ("lwt")
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
        ("topkg")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jnmd675wmsmdwyb5mx5b0ac66g4c6gpv5s4mrx2j6pb0wla1x46";
        url = "https://erratique.ch/software/logs/releases/logs-0.7.0.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-js_of_ocaml true --with-fmt true --with-cmdliner true --with-lwt true --with-base-threads true";
        installPhase = "";
        mode = "opam";
      };
    };
    lwt = {
      pname = "lwt";
      version = "5.4.2";
      depKeys = [
        ("base-threads")
        ("base-unix")
        ("cppo")
        ("dune")
        ("dune-configurator")
        ("mmap")
        ("ocaml")
        ("ocplib-endian")
        ("result")
        ("seq")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jyjq43q9rbrw7ijy8l8rd1rhiy74ix2j1w15q0694rdfbkcnsg1";
        url = "https://github.com/ocsigen/lwt/archive/refs/tags/5.4.2.tar.gz";
      });
      build = {
        buildPhase = ''
          dune exec -p lwt src/unix/config/discover.exe -- --save --use-libev false
          dune build -p lwt -j $NIX_BUILD_CORES
        '';
        installPhase = "";
        mode = "opam";
      };
    };
    lwt_ppx = {
      pname = "lwt_ppx";
      version = "2.0.2";
      depKeys = [
        ("dune")
        ("lwt")
        ("ocaml")
        ("ppxlib")
      ];
      buildInputs = [
        (pkgs.unzip)
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lv5i3znmiqx6fiq2q1lapsq1bk20bgw7h57wmk9czx9x050a5n5";
        url = "https://github.com/ocsigen/lwt/archive/5.4.0.zip";
      });
      build = {
        buildPhase = "dune build -p lwt_ppx -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    menhir = {
      pname = "menhir";
      version = "20190924";
      depKeys = [
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bm6d30fasnr9f1ghvl7hfipgqspb3b4x5m0ahk3vdjjf9hpg4ip";
        url = "https://gitlab.inria.fr/fpottier/menhir/-/archive/20190924/archive.tar.gz";
      });
      build = {
        buildPhase = "make -f Makefile PREFIX=$out USE_OCAMLFIND=true docdir=false/menhir \"libdir=${(final.siteLib "$out")}/menhir\" mandir=$out/man/man1";
        installPhase = "make -f Makefile install PREFIX=$out docdir=false/menhir \"libdir=${(final.siteLib "$out")}/menhir\" mandir=$out/man/man1";
        mode = "opam";
      };
    };
    mmap = {
      pname = "mmap";
      version = "1.1.0";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0l6waidal2n8mkdn74avbslvc10sf49f5d889n838z03pra5chsc";
        url = "https://github.com/mirage/mmap/releases/download/v1.1.0/mmap-v1.1.0.tbz";
      });
      build = {
        buildPhase = "dune build -p mmap -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    ocaml = {
      pname = "ocaml";
      version = "4.12.0";
      depKeys = [
        ("ocaml-base-compiler")
        ("ocaml-config")
      ];
      build = {
        buildPhase = "ocaml \"${(final.getDrv "ocaml-config")}/share/gen_ocaml_config.ml\" 4.12.0 ocaml";
        installPhase = "";
        mode = "opam";
      };
    };
    ocaml-base-compiler = {
      pname = "ocaml-base-compiler";
      version = "4.12.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0i37laikik5vwydw1cwygxd8xq2d6n35l20irgrh691njlwpmh5d";
        url = "https://github.com/ocaml/ocaml/archive/4.12.0.tar.gz";
      });
      build = {
        buildPhase = ''
          ./configure --prefix=$out -C CC=cc "ASPP=cc -c"
          make -j$NIX_BUILD_CORES
        '';
        installPhase = "make install";
        mode = "opam";
      };
      files = (final.subtree {
        base = final.repositories.opam;
        hash = "sha256:0i40sgs8kb2xm2nr2nqr1x082ryf97vsznfw2ln4lq4mj24w9874";
        path = "packages/ocaml-base-compiler/ocaml-base-compiler.4.12.0/files";
      });
    };
    ocaml-compiler-libs = {
      pname = "ocaml-compiler-libs";
      version = "v0.12.4";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0q3pl20pkx410gw9g4m26qq6dmzi9qan2dqlga6c2ifc6pnckjaf";
        url = "https://github.com/janestreet/ocaml-compiler-libs/releases/download/v0.12.4/ocaml-compiler-libs-v0.12.4.tbz";
      });
      build = {
        buildPhase = "dune build -p ocaml-compiler-libs -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    ocaml-config = {
      pname = "ocaml-config";
      version = "2";
      depKeys = [
        ("ocaml-base-compiler")
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
      files = (final.subtree {
        base = final.repositories.opam;
        hash = "sha256:0k03gm7bwnlkph6agvlkdaw1y5vw9bx3nf6hffp3vbbg4a9lmzm6";
        path = "packages/ocaml-config/ocaml-config.2/files";
      });
    };
    ocaml-migrate-parsetree = {
      pname = "ocaml-migrate-parsetree";
      version = "2.2.0";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "188v3z09bg4gyv80c138fa3a3j2w54w5gc4r1ajw7klr70yqz9mj";
        url = "https://github.com/ocaml-ppx/ocaml-migrate-parsetree/releases/download/v2.2.0/ocaml-migrate-parsetree-v2.2.0.tbz";
      });
      build = {
        buildPhase = "dune build -p ocaml-migrate-parsetree -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    ocaml-options-vanilla = {
      pname = "ocaml-options-vanilla";
      version = "1";
      depKeys = [
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    ocamlbuild = {
      pname = "ocamlbuild";
      version = "0.14.0";
      depKeys = [
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0y1fskw9rg2y1zgb7whv3v8v4xw04svgxslf3856q2aqd7lrrcl7";
        url = "https://github.com/ocaml/ocamlbuild/archive/0.14.0.tar.gz";
      });
      build = {
        buildPhase = ''
          make -f configure.make all OCAMLBUILD_PREFIX=$out OCAMLBUILD_BINDIR=$out/bin "OCAMLBUILD_LIBDIR=${(final.siteLib "$out")}" OCAMLBUILD_MANDIR=$out/man OCAML_NATIVE=true OCAML_NATIVE_TOOLS=true
          make check-if-preinstalled all opam-install
        '';
        installPhase = "";
        mode = "opam";
      };
    };
    ocamlfind = {
      pname = "ocamlfind";
      version = "1.9.1";
      depKeys = [
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qhgk25avmz4l4g47g8jvk0k1g9p9d5hbdrwpz2693a8ajyvhhib";
        url = "http://download.camlcity.org/download/findlib-1.9.1.tar.gz";
      });
      build = {
        buildPhase = ''
          ./configure -bindir $out/bin -sitelib "${(final.siteLib "$out")}" -mandir $out/man -config "${(final.siteLib "$out")}/findlib.conf" -no-custom -no-topfind
          make all
          make opt
        '';
        installPhase = ''
          make install
          install -m 0755 ocaml-stub $out/bin/ocaml
        '';
        mode = "opam";
      };
    };
    ocplib-endian = {
      pname = "ocplib-endian";
      version = "1.1";
      depKeys = [
        ("base-bytes")
        ("cppo")
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0qy5q7p11gxi5anhvi8jj6mr80ml0ih8lax5k579rsr2hsp3sns5";
        url = "https://github.com/OCamlPro/ocplib-endian/archive/1.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ocplib-endian -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    odoc = {
      pname = "odoc";
      version = "2.0.0";
      depKeys = [
        ("astring")
        ("cmdliner")
        ("cppo")
        ("dune")
        ("fmt")
        ("fpath")
        ("logs")
        ("ocaml")
        ("ocaml-migrate-parsetree")
        ("odoc-parser")
        ("re")
        ("result")
        ("tyxml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "01yh1h9cigcljp6gkb6ab2ba5ivw8ps438xgk04bkd0qzwmfnccc";
        url = "https://github.com/ocaml/odoc/releases/download/2.0.0/odoc-2.0.0.tbz";
      });
      build = {
        buildPhase = "dune build -p odoc -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    odoc-parser = {
      pname = "odoc-parser";
      version = "0.9.0";
      depKeys = [
        ("astring")
        ("dune")
        ("ocaml")
        ("result")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ydxy2sj2w9i4vvyjnxplgmp5gbkp5ilnv36pvk4vgrrmldss3fz";
        url = "https://github.com/ocaml-doc/odoc-parser/releases/download/0.9.0/odoc-parser-0.9.0.tbz";
      });
      build = {
        buildPhase = "dune build -p odoc-parser -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    ppx_derivers = {
      pname = "ppx_derivers";
      version = "1.2.1";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "159vqy616ni18mn0dlv8c2y4h7mb4hahwjn53yrr59yyhzhmwndn";
        url = "https://github.com/ocaml-ppx/ppx_derivers/archive/1.2.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_derivers -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    ppxlib = {
      pname = "ppxlib";
      version = "0.23.0";
      depKeys = [
        ("dune")
        ("ocaml")
        ("ocaml-compiler-libs")
        ("ppx_derivers")
        ("sexplib0")
        ("stdlib-shims")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1r8jzrqrklwgdbc9qwmp36shhkwgjvrr9nj7rxma3mdrhv0kcn0v";
        url = "https://github.com/ocaml-ppx/ppxlib/releases/download/0.23.0/ppxlib-0.23.0.tbz";
      });
      build = {
        buildPhase = "dune build -p ppxlib -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    re = {
      pname = "re";
      version = "1.10.3";
      depKeys = [
        ("dune")
        ("ocaml")
        ("seq")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1fqfg609996bgxr14yyfxhvl6hm9c1j0mm2xjdjigqrzgyb4crc4";
        url = "https://github.com/ocaml/ocaml-re/releases/download/1.10.3/re-1.10.3.tbz";
      });
      build = {
        buildPhase = "dune build -p re -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    result = {
      pname = "result";
      version = "1.5";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0cpfp35fdwnv3p30a06wd0py3805qxmq3jmcynjc3x2qhlimwfkw";
        url = "https://github.com/janestreet/result/releases/download/1.5/result-1.5.tbz";
      });
      build = {
        buildPhase = "dune build -p result -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    seq = {
      pname = "seq";
      version = "base";
      depKeys = [
        ("ocaml")
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
      files = (final.subtree {
        base = final.repositories.opam;
        hash = "sha256:1pannj4qsgh1bm3qg4gza8sxshnz1albqvq0pdi5y9zckv1q3b6b";
        path = "packages/seq/seq.base/files";
      });
    };
    sexplib0 = {
      pname = "sexplib0";
      version = "v0.14.0";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0adrc0r1vvvr41dcpj8jwkzh1dfgqf0mks9xlnnskqfm3a51iavg";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/sexplib0-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p sexplib0 -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    stdlib-shims = {
      pname = "stdlib-shims";
      version = "0.3.0";
      depKeys = [
        ("dune")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0jnqsv6pqp5b5g7lcjwgd75zqqvcwcl5a32zi03zg1kvj79p5gxs";
        url = "https://github.com/ocaml/stdlib-shims/releases/download/0.3.0/stdlib-shims-0.3.0.tbz";
      });
      build = {
        buildPhase = "dune build -p stdlib-shims -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    topkg = {
      pname = "topkg";
      version = "1.0.4";
      depKeys = [
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1kzw5cxkizcvh4rgzwgpjlj9hfxfk6yr686bxx6wrbsfs8as371k";
        url = "https://erratique.ch/software/topkg/releases/topkg-1.0.4.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pkg-name topkg --dev-pkg false";
        installPhase = "";
        mode = "opam";
      };
    };
    tyxml = {
      pname = "tyxml";
      version = "4.5.0";
      depKeys = [
        ("dune")
        ("ocaml")
        ("re")
        ("seq")
        ("uutf")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0s30f72m457c3gbdmdwbx7ls9zg806nvm83aiz9qkpglbppwr6n6";
        url = "https://github.com/ocsigen/tyxml/releases/download/4.5.0/tyxml-4.5.0.tbz";
      });
      build = {
        buildPhase = "dune build -p tyxml -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    uchar = {
      pname = "uchar";
      version = "0.0.2";
      depKeys = [
        ("ocaml")
        ("ocamlbuild")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1w2saw7zanf9m9ffvz2lvcxvlm118pws2x1wym526xmydhqpyfa7";
        url = "https://github.com/ocaml/uchar/releases/download/v0.0.2/uchar-0.0.2.tbz";
      });
      build = {
        buildPhase = ''
          ocaml pkg/git.ml
          ocaml pkg/build.ml native=true native-dynlink=true
        '';
        installPhase = "";
        mode = "opam";
      };
    };
    uutf = {
      pname = "uutf";
      version = "1.0.2";
      depKeys = [
        ("cmdliner")
        ("ocaml")
        ("ocamlbuild")
        ("ocamlfind")
        ("topkg")
        ("uchar")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nx1rly3qj23jzn9yk3x6fwqimcxjd84kv5859vvhdg56psq26p6";
        url = "http://erratique.ch/software/uutf/releases/uutf-1.0.2.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-cmdliner true";
        installPhase = "";
        mode = "opam";
      };
    };
    vdoml = {
      pname = "vdoml";
      version = "dev";
      depKeys = [
        ("conf-python-2-7")
        ("dune")
        ("js_of_ocaml")
        ("js_of_ocaml-lwt")
        ("js_of_ocaml-ppx")
        ("logs")
        ("lwt")
        ("lwt_ppx")
        ("ocaml")
        ("ocamlfind")
        ("odoc")
      ];
      src = (pkgs.fetchFromGitHub {
        owner = "timbertson";
        repo = "vdoml";
        rev = "fcbf81e89df989206bdad4a92327e593078525b2";
        sha256 = "1mzs82grpwigji3a0gcs2g4s7i1lfd5qdwpnvczh6p3rrsfwsawc";
      });
      build = {
        buildPhase = "dune build -p vdoml -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    yojson = {
      pname = "yojson";
      version = "1.7.0";
      depKeys = [
        ("biniou")
        ("cppo")
        ("dune")
        ("easy-format")
        ("ocaml")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1iich6323npvvs8r50lkr4pxxqm9mf6w67cnid7jg1j1g5gwcvv5";
        url = "https://github.com/ocaml-community/yojson/releases/download/1.7.0/yojson-1.7.0.tbz";
      });
      build = {
        buildPhase = "dune build -p yojson -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
  };
}