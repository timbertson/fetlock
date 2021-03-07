final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "esy";
    version = "1";
    toplevel = [
      ("Oni2@link-dev:./package.json")
    ];
    ocaml = (final.getDrv "ocaml@4.10.0@d41d8cd9");
  };
  specs = {
    "@brisk/brisk-reconciler@github:briskml/brisk-reconciler#10cab2d@d41d8cd9" = {
      pname = "brisk-brisk-reconciler";
      version = "1.0.0-alpha.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "briskml";
        repo = "brisk-reconciler";
        rev = "10cab2d";
        sha256 = "0qhfa23hyhh8i955m2wfg2790rr6xpp350yy8nkigcl203ia5gwk";
      };
      build = {
        buildPhase = "dune build -p brisk-reconciler";
        mode = "esy";
      };
      opamName = "brisk-reconciler";
    };
    "@esy-cross/ninja-build@1.8.2001@d41d8cd9" = {
      pname = "esy-cross-ninja-build";
      version = "1.8.2001";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@esy-cross/ninja-build/-/ninja-build-1.8.2001.tgz";
        sha256 = "0wxy0l6zmkxikspq8dyk5c3wmzhygh7gqaf27xxz8rxmfc62rs5l";
      };
      build = {
        buildPhase = "make install";
        installPhase = "";
        mode = "esy";
      };
      opamName = "ninja-build";
    };
    "@esy-ocaml/reason@3.6.2@d41d8cd9" = {
      pname = "esy-ocaml-reason";
      version = "3.6.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/merlin-extend@opam:0.6@404f814c")
        ("@opam/menhir@opam:20201216@1a09d886")
        ("@opam/fix@opam:20201120@5c318621")
        ("@opam/dune@opam:2.5.0@e0bac278")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@esy-ocaml/reason/-/reason-3.6.2.tgz";
        sha256 = "1yn19rasy89qg5c34xz6l1fzfysix48jvh5jqlg747jq4l2l9py4";
      };
      build = {
        buildPhase = "dune build -p reason";
        mode = "esy";
      };
      opamName = "reason";
    };
    "@esy-ocaml/substs@0.0.1@d41d8cd9" = {
      pname = "esy-ocaml-substs";
      version = "0.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@esy-ocaml/substs/-/substs-0.0.1.tgz";
        sha256 = "1jfg84xcnzhqpn0a1qdy4nghsfp7614sa4hjyw4qnkwj1igla05g";
      };
      build = {
        buildPhase = "cp ./substs $cur__bin/substs";
        mode = "esy";
      };
      opamName = "substs";
    };
    "@onivim/reason-native-crash-utils@1.0.1@d41d8cd9" = {
      pname = "onivim-reason-native-crash-utils";
      version = "1.0.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@onivim/reason-native-crash-utils/-/reason-native-crash-utils-1.0.1.tgz";
        sha256 = "1rmzrj7nfhz0frkds0jl0vzix2c70jnp6albbl5379cwhj3bxya5";
      };
      build = {
        buildPhase = "dune build -p reason-native-crash-utils";
        mode = "esy";
      };
      opamName = "reason-native-crash-utils";
    };
    "@opam/angstrom@opam:0.15.0@48ede9cb" = {
      pname = "angstrom";
      version = "0.15.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ocaml-syntax-shims@opam:1.0.0@a9aa3bfa")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/bigstringaf@opam:0.6.1@35f5e6d1")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/inhabitedtype/angstrom/archive/0.15.0.tar.gz";
        sha256 = "01cjjal8vjsm225v9y0q6ixam8k5f821rcr6yix6i9nzs84aq6gi";
      };
      build = {
        buildPhase = "dune build -p angstrom -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/astring@opam:0.8.5@1300cee8" = {
      pname = "astring";
      version = "0.8.5";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/astring/releases/astring-0.8.5.tbz";
        sha256 = "1ykhg9gd3iy7zsgyiy2p9b1wkpqg9irw5pvcqs3sphq71iir4ml6";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false";
        mode = "opam";
      };
    };
    "@opam/atd@opam:2.2.1@071ab6bd" = {
      pname = "atd";
      version = "2.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/menhir@opam:20201216@1a09d886")
        ("@opam/easy-format@opam:1.3.2@0484b3c4")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ahrefs/atd/releases/download/2.2.1/atd-2.2.1.tbz";
        sha256 = "17jm79np69ixp53a4njxnlb1pg8sd1g47nm3nyki9clkc8d4qsyv";
      };
      build = {
        buildPhase = "dune build -p atd -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/atdgen-runtime@opam:2.2.1@6a3a6395" = {
      pname = "atdgen-runtime";
      version = "2.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/biniou@opam:1.2.1@d7570399")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ahrefs/atd/releases/download/2.2.1/atd-2.2.1.tbz";
        sha256 = "17jm79np69ixp53a4njxnlb1pg8sd1g47nm3nyki9clkc8d4qsyv";
      };
      build = {
        buildPhase = "dune build -p atdgen-runtime -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/atdgen@opam:2.2.1@d73fda11" = {
      pname = "atdgen";
      version = "2.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/biniou@opam:1.2.1@d7570399")
        ("@opam/atdgen-runtime@opam:2.2.1@6a3a6395")
        ("@opam/atd@opam:2.2.1@071ab6bd")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ahrefs/atd/releases/download/2.2.1/atd-2.2.1.tbz";
        sha256 = "17jm79np69ixp53a4njxnlb1pg8sd1g47nm3nyki9clkc8d4qsyv";
      };
      build = {
        buildPhase = "dune build -p atdgen -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/base-bigarray@opam:base@b03491b0" = {
      pname = "base-bigarray";
      version = "base";
      depKeys = [
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        mode = "opam";
      };
    };
    "@opam/base-bytes@opam:base@19d0c2ff" = {
      pname = "base-bytes";
      version = "base";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        mode = "opam";
      };
    };
    "@opam/base-threads@opam:base@36803084" = {
      pname = "base-threads";
      version = "base";
      depKeys = [
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        mode = "opam";
      };
    };
    "@opam/base-unix@opam:base@87d0b2eb" = {
      pname = "base-unix";
      version = "base";
      depKeys = [
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        mode = "opam";
      };
    };
    "@opam/base@opam:v0.14.0@8bc55fce" = {
      pname = "base";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/sexplib0@opam:v0.14.0@ddeb6438")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/base-v0.14.0.tar.gz";
        sha256 = "1rkdhsgbcv0a8p29mwvpd2ldz8cjk97pixl43izm54wyin4lp778";
      };
      build = {
        buildPhase = "dune build -p base -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/bigarray-compat@opam:1.0.0@3a87ad65" = {
      pname = "bigarray-compat";
      version = "1.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/mirage/bigarray-compat/archive/v1.0.0.tar.gz";
        sha256 = "1bpmmnxb1yx72aqlbdaqfl18rgz1cq9cf6cqvnfl88mz5dfr4x0d";
      };
      build = {
        buildPhase = "dune build -p bigarray-compat -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/bigstringaf@opam:0.6.1@35f5e6d1" = {
      pname = "bigstringaf";
      version = "0.6.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/bigarray-compat@opam:1.0.0@3a87ad65")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/inhabitedtype/bigstringaf/archive/0.6.1.tar.gz";
        sha256 = "0nc9cxc2hf1qklkwl3mn46yrsjwdlv9j1824v2nagj3d021ys52s";
      };
      build = {
        buildPhase = "dune build -p bigstringaf -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/biniou@opam:1.2.1@d7570399" = {
      pname = "biniou";
      version = "1.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/easy-format@opam:1.3.2@0484b3c4")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/mjambon/biniou/releases/download/1.2.1/biniou-1.2.1.tbz";
        sha256 = "0da3m0g0dhl02jfynrbysjh070xk2z6rxcx34xnqx6ljn5l6qm1m";
      };
      build = {
        buildPhase = "dune build -p biniou -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/bos@opam:0.2.0@df49e63f" = {
      pname = "bos";
      version = "0.2.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/rresult@opam:0.6.0@4b185e72")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/logs@opam:0.7.0@1d03143e")
        ("@opam/fpath@opam:0.7.3@674d8125")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/astring@opam:0.8.5@1300cee8")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://erratique.ch/software/bos/releases/bos-0.2.0.tbz";
        sha256 = "1s10iqx8rgnxr5n93lf4blwirjf8nlm272yg5sipr7lsr35v49wc";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false";
        mode = "opam";
      };
    };
    "@opam/camomile@opam:1.0.2@40411a6b" = {
      pname = "camomile";
      version = "1.0.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/yoriyuki/Camomile/releases/download/1.0.2/camomile-1.0.2.tbz";
        sha256 = "0chn7ldqb3wyf95yhmsxxq65cif56smgz1mhhc7m0dpwmyq1k97h";
      };
      build = {
        buildPhase = ''
          ocaml configure.ml --share $out/share/camomile
          dune build -p camomile -j $NIX_BUILD_CORES @install
        '';
        mode = "opam";
      };
    };
    "@opam/charInfo_width@opam:1.1.0@4296bdfe" = {
      pname = "charInfo_width";
      version = "1.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/camomile@opam:1.0.2@40411a6b")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/kandu/charInfo_width/archive/1.1.0.tar.gz";
        sha256 = "0wl1hcwbx2mmgbhwh1wwgjixvppjq0k43nqyq13xm4pvgdxfvci1";
      };
      build = {
        buildPhase = "dune build -p charInfo_width -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/cmdliner@opam:1.0.4@93208aac" = {
      pname = "cmdliner";
      version = "1.0.4";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://erratique.ch/software/cmdliner/releases/cmdliner-1.0.4.tbz";
        sha256 = "1h04q0zkasd0mw64ggh4y58lgzkhg6yhzy60lab8k8zq9ba96ajw";
      };
      build = {
        buildPhase = "make all PREFIX=$out";
        installPhase = ''
          make install "LIBDIR=${(final.siteLib "$out")}/cmdliner" DOCDIR=$out/doc
          make install-doc "LIBDIR=${(final.siteLib "$out")}/cmdliner" DOCDIR=$out/doc
        '';
        mode = "opam";
      };
    };
    "@opam/conf-m4@opam:1@196bf219" = {
      pname = "conf-m4";
      version = "1";
      depKeys = [
        ("esy-m4@github:esy-packages/esy-m4#c7cf0ac9221be2b1f9d90e83559ca08397a629e7@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        buildPhase = "sh -exc \"echo | m4\"";
        depexts = [
          ("m4")
        ];
        mode = "opam";
      };
    };
    "@opam/conf-pkg-config@opam:1.2@d86c8f53" = {
      pname = "conf-pkg-config";
      version = "1.2";
      depKeys = [
        ("yarn-pkg-config@github:esy-ocaml/yarn-pkg-config#db3a0b63883606dd57c54a7158d560d6cba8cd79@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        buildPhase = "pkg-config --help";
        depexts = [
          ("pkgconfig")
        ];
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/cppo@opam:1.6.7@c28ac3ae" = {
      pname = "cppo";
      version = "1.6.7";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-community/cppo/releases/download/v1.6.7/cppo-v1.6.7.tbz";
        sha256 = "17ajdzrnmnyfig3s6hinb56mcmhywbssxhsq32dz0v90dhz3wmfv";
      };
      build = {
        buildPhase = "dune build -p cppo -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/csexp@opam:1.3.2@5cea14af" = {
      pname = "csexp";
      version = "1.3.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-dune/csexp/releases/download/1.3.2/csexp-1.3.2.tbz";
        sha256 = "0jhwrxfjb0x31xj4g4b89fzw34sq19j0rq2hs2zyh1vz4xxl47zj";
      };
      build = {
        buildPhase = "dune build -p csexp -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/ctypes@opam:0.15.1@9c7ab4ec" = {
      pname = "ctypes";
      version = "0.15.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/integers@opam:0.4.0@f7acfaeb")
        ("@opam/conf-pkg-config@opam:1.2@d86c8f53")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocamllabs/ocaml-ctypes/archive/0.15.1.tar.gz";
        sha256 = "0zn3yw4h9h6avp4c2rg4y089wr7xbhw3q619ixplm32bc45jrrwb";
      };
      build = {
        buildPhase = ''
          touch libffi.config
          make XEN=disable ctypes-base ctypes-stubs
        '';
        installPhase = "make install XEN=disable";
        mode = "opam";
      };
    };
    "@opam/decoders-yojson@opam:0.4.0@cb39dea6" = {
      pname = "decoders-yojson";
      version = "0.4.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/decoders@opam:0.5.0@9df01185")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/mattjbray/ocaml-decoders/releases/download/v0.4.0/decoders-v0.4.0.tbz";
        sha256 = "1xzb9rc81mssgl1zwfz1x278q0fz13amwijdjk4ngzqxj2cbvsqq";
      };
      build = {
        buildPhase = "dune build -p decoders-yojson -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/decoders@opam:0.5.0@9df01185" = {
      pname = "decoders";
      version = "0.5.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/mattjbray/ocaml-decoders/releases/download/v0.5.0/decoders-v0.5.0.tbz";
        sha256 = "06piq1zysxxs95vm3awhzqk5p60l7c1wb12kayvwzcdw5qm6f2zw";
      };
      build = {
        buildPhase = "dune build -p decoders -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/dir@github:bryphe/reason-native:dir.opam#5a7a756@d41d8cd9" = {
      pname = "dir";
      version = "github-bryphe-reason-native-dir.opam-5a7a756";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/reason@opam:3.6.0@58adb39a")
        ("@opam/fp@github:bryphe/reason-native:fp.opam#5a7a756@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "reason-native";
        rev = "5a7a756";
        sha256 = "1cqv3ngiklsdypyz00wyjqzmfwnsksawwwz35cbbplzci62pppbv";
      };
      build = {
        buildPhase = "dune build -p dir";
        mode = "opam";
      };
    };
    "@opam/dot-merlin-reader@opam:3.4.2@55baebb0" = {
      pname = "dot-merlin-reader";
      version = "3.4.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/csexp@opam:1.3.2@5cea14af")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/merlin/releases/download/v3.4.2/merlin-v3.4.2.tbz";
        sha256 = "109ai1ggnkrwbzsl1wdalikvs1zx940m6n65jllxj68in6bvidz1";
      };
      build = {
        buildPhase = "dune build -p dot-merlin-reader -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/dune-build-info@opam:2.6.2@03ffe168" = {
      pname = "dune-build-info";
      version = "2.6.2";
      depKeys = [
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/dune/releases/download/2.6.2/dune-2.6.2.tbz";
        sha256 = "1sc8ax198z42vhc3l6i04kknm9g44whifjivs19qgi3sybrw2vjg";
      };
      build = {
        buildPhase = "dune build -p dune-build-info -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/dune-configurator@opam:2.5.1@aeb9d8d5" = {
      pname = "dune-configurator";
      version = "2.5.1";
      depKeys = [
        ("@opam/dune-private-libs@opam:2.5.1@60c1661f")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/dune/releases/download/2.5.1/dune-2.5.1.tbz";
        sha256 = "0az5ih18wadsp3ljagvws1i7vf0vpg24h75ariy0v3i0gyld6xwg";
      };
      build = {
        buildPhase = "dune build -p dune-configurator -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/dune-private-libs@opam:2.5.1@60c1661f" = {
      pname = "dune-private-libs";
      version = "2.5.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/dune/releases/download/2.5.1/dune-2.5.1.tbz";
        sha256 = "0az5ih18wadsp3ljagvws1i7vf0vpg24h75ariy0v3i0gyld6xwg";
      };
      build = {
        buildPhase = "dune build -p dune-private-libs -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/dune@opam:2.5.0@e0bac278" = {
      pname = "dune";
      version = "2.5.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/base-threads@opam:base@36803084")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/dune/releases/download/2.5.0/dune-2.5.0.tbz";
        sha256 = "1nnpg0fvmp4vf5mk203xk83pkkm953pgip3yhs1x2g8pkcdndhcw";
      };
      build = {
        buildPhase = ''
          ocaml bootstrap.ml -j $NIX_BUILD_CORES
          ./dune.exe build -p dune --profile dune-bootstrap -j $NIX_BUILD_CORES
        '';
        mode = "opam";
      };
    };
    "@opam/easy-format@opam:1.3.2@0484b3c4" = {
      pname = "easy-format";
      version = "1.3.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/mjambon/easy-format/releases/download/1.3.2/easy-format-1.3.2.tbz";
        sha256 = "09hrikx310pac2sb6jzaa7k6fmiznnmhdsqij1gawdymhawc4h1l";
      };
      build = {
        buildPhase = "dune build -p easy-format -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/fix@opam:20201120@5c318621" = {
      pname = "fix";
      version = "20201120";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://gitlab.inria.fr/fpottier/fix/repository/20201120/archive.tar.gz";
        sha256 = "02xyn3wfcmz8if72y5pscy2imsnxv6s0fb0fvigjjdnknnd32wk9";
      };
      build = {
        buildPhase = "dune build -p fix -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/fmt@opam:0.8.9@e0843a5b" = {
      pname = "fmt";
      version = "0.8.9";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/stdlib-shims@opam:0.1.0@148f22ac")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/fmt/releases/fmt-0.8.9.tbz";
        sha256 = "0gkkkj4x678vxdda4xaw2dd44qjacavsvn5nx8gydfwah6pjbkxk";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false --with-base-unix true --with-cmdliner true";
        mode = "opam";
      };
    };
    "@opam/fp@github:bryphe/reason-native:fp.opam#5a7a756@d41d8cd9" = {
      pname = "fp";
      version = "github-bryphe-reason-native-fp.opam-5a7a756";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/reason@opam:3.6.0@58adb39a")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "reason-native";
        rev = "5a7a756";
        sha256 = "1cqv3ngiklsdypyz00wyjqzmfwnsksawwwz35cbbplzci62pppbv";
      };
      build = {
        buildPhase = "dune build -p fp";
        mode = "opam";
      };
    };
    "@opam/fpath@opam:0.7.3@674d8125" = {
      pname = "fpath";
      version = "0.7.3";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/astring@opam:0.8.5@1300cee8")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/fpath/releases/fpath-0.7.3.tbz";
        sha256 = "03z7mj0sqdz465rc4drj1gr88l9q3nfs374yssvdjdyhjbqqzc0j";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build";
        mode = "opam";
      };
    };
    "@opam/fs@github:bryphe/reason-native:fs.opam#5a7a756@d41d8cd9" = {
      pname = "fs";
      version = "github-bryphe-reason-native-fs.opam-5a7a756";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/reason@opam:3.6.0@58adb39a")
        ("@opam/fp@github:bryphe/reason-native:fp.opam#5a7a756@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "reason-native";
        rev = "5a7a756";
        sha256 = "1cqv3ngiklsdypyz00wyjqzmfwnsksawwwz35cbbplzci62pppbv";
      };
      build = {
        buildPhase = "dune build -p fs";
        mode = "opam";
      };
    };
    "@opam/integers@opam:0.4.0@f7acfaeb" = {
      pname = "integers";
      version = "0.4.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocamllabs/ocaml-integers/archive/0.4.0.tar.gz";
        sha256 = "0gwixy1i3qk83d8xirz3fcz1ik532w4lrp59rhz568n60rv0hvms";
      };
      build = {
        buildPhase = "dune build -p integers -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/jane-street-headers@opam:v0.14.0@59432b6a" = {
      pname = "jane-street-headers";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/jane-street-headers-v0.14.0.tar.gz";
        sha256 = "028yxb4h3iy025iy89v8653m5brh7flrjshghs4x99pd690pmfs7";
      };
      build = {
        buildPhase = "dune build -p jane-street-headers -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/jst-config@opam:v0.14.0@d0d7469e" = {
      pname = "jst-config";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/stdio@opam:v0.14.0@a624e254")
        ("@opam/ppx_assert@opam:v0.14.0@877b5900")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/jst-config-v0.14.0.tar.gz";
        sha256 = "1fppr29vn91zpqda8jlnp8bcssd4bf3rn36ig8fnd1yhjrsvz8f6";
      };
      build = {
        buildPhase = "dune build -p jst-config -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/junit@opam:2.0.2@0b7bd730" = {
      pname = "junit";
      version = "2.0.2";
      depKeys = [
        ("@opam/tyxml@opam:4.4.0@1dca5713")
        ("@opam/ptime@opam:0.8.5@0051d642")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/Khady/ocaml-junit/releases/download/2.0.2/junit-2.0.2.tbz";
        sha256 = "00bbx5j8vsy9fqbc04xa3lsalaxicirmbczr65bllfk1afv43agx";
      };
      build = {
        buildPhase = "dune build -p junit -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/lambda-term@opam:3.1.0@8adc2660" = {
      pname = "lambda-term";
      version = "3.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/zed@opam:3.1.0@86c55416")
        ("@opam/react@opam:1.2.1@0e11855f")
        ("@opam/mew_vi@opam:0.5.0@cf66c299")
        ("@opam/lwt_react@opam:1.1.4@7d2054d1")
        ("@opam/lwt_log@opam:1.1.1@2d7a797f")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/camomile@opam:1.0.2@40411a6b")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-community/lambda-term/archive/3.1.0.tar.gz";
        sha256 = "1462j2c2nnzv6ng8b6907bw0zy3mhhnnjdm8k6as0sgm9ls0r77r";
      };
      build = {
        buildPhase = "dune build -p lambda-term -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/logs@opam:0.7.0@1d03143e" = {
      pname = "logs";
      version = "0.7.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@opam/base-threads@opam:base@36803084")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/logs/releases/logs-0.7.0.tbz";
        sha256 = "1jnmd675wmsmdwyb5mx5b0ac66g4c6gpv5s4mrx2j6pb0wla1x46";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-js_of_ocaml false --with-fmt true --with-cmdliner true --with-lwt true --with-base-threads true";
        mode = "opam";
      };
    };
    "@opam/lru@github:bryphe/lru:lru.opam#2708c70@d41d8cd9" = {
      pname = "lru";
      version = "github-bryphe-lru-lru.opam-2708c70";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/psq@opam:0.2.0@247756d4")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "lru";
        rev = "2708c70";
        sha256 = "1dfz3zvnp20ihbn2w6jfpq8kngafmy755ghmn6abw9zjvmqs2xqp";
      };
      build = {
        buildPhase = "dune build -p lru -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/luv@github:bryphe/luv:luv.opam#8e9f2b0@d41d8cd9" = {
      pname = "luv";
      version = "github-bryphe-luv-luv.opam-8e9f2b0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/ctypes@opam:0.15.1@9c7ab4ec")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "luv";
        rev = "8e9f2b0";
        sha256 = "1qn1dlj1falndi4ihblr0dcanjm39vkr3k1vxm5ifkf226nv5h23";
        fetchSubmodules = true;
      };
      build = {
        buildPhase = "dune build -p luv -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/lwt@opam:4.5.0@542100aa" = {
      pname = "lwt";
      version = "4.5.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ocplib-endian@opam:1.1@84c1ca88")
        ("@opam/mmap@opam:1.1.0@b85334ff")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cppo@opam:1.6.7@c28ac3ae")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/base-threads@opam:base@36803084")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocsigen/lwt/archive/4.5.0.tar.gz";
        sha256 = "11k1g118wq093zc5a93dnvdzmp09xvg0k7ayjwnq01div1f88zg0";
      };
      build = {
        buildPhase = "dune build -p lwt -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/lwt_log@opam:1.1.1@2d7a797f" = {
      pname = "lwt_log";
      version = "1.1.1";
      depKeys = [
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/aantron/lwt_log/archive/1.1.1.tar.gz";
        sha256 = "0gszc8nvk2hpfq47plb36qahlnyfq28sa9mhicnf6mg5c7n1kyql";
      };
      build = {
        buildPhase = "dune build -p lwt_log -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/lwt_ppx@opam:2.0.1@e6a764a0" = {
      pname = "lwt_ppx";
      version = "2.0.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppx_tools_versioned@opam:5.4.0@32d1a414")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocsigen/lwt/archive/5.2.0.tar.gz";
        sha256 = "0cmim5s7ay72pxpc66bmxmnj5lbg5yvm0ydrpnfh3nyhlcyjphcp";
      };
      build = {
        buildPhase = "dune build -p lwt_ppx -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/lwt_react@opam:1.1.4@7d2054d1" = {
      pname = "lwt_react";
      version = "1.1.4";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/react@opam:1.2.1@0e11855f")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      buildInputs = [
        (pkgs.unzip)
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocsigen/lwt/archive/5.4.0.zip";
        sha256 = "1lv5i3znmiqx6fiq2q1lapsq1bk20bgw7h57wmk9czx9x050a5n5";
      };
      build = {
        buildPhase = "dune build -p lwt_react -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/markup@opam:0.8.2@87975241" = {
      pname = "markup";
      version = "0.8.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uchar@opam:0.0.2@c8218eea")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/aantron/markup.ml/archive/0.8.2.tar.gz";
        sha256 = "05yxfnl56clx5s2iyxrw7xj64c998kzz47280kvv49x7r1gzp6qs";
      };
      build = {
        buildPhase = "dune build -p markup -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/menhir@opam:20201216@1a09d886" = {
      pname = "menhir";
      version = "20201216";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/menhirSdk@opam:20201216@5e08e674")
        ("@opam/menhirLib@opam:20201216@bb5a1851")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://gitlab.inria.fr/fpottier/menhir/repository/20201216/archive.tar.gz";
        sha256 = "05fpg5c83a6q0q12kd2ll069pg80yd91s4rzx3742ard3l2aml8z";
      };
      build = {
        buildPhase = "dune build -p menhir -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/menhirLib@opam:20201216@bb5a1851" = {
      pname = "menhirLib";
      version = "20201216";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://gitlab.inria.fr/fpottier/menhir/repository/20201216/archive.tar.gz";
        sha256 = "05fpg5c83a6q0q12kd2ll069pg80yd91s4rzx3742ard3l2aml8z";
      };
      build = {
        buildPhase = "dune build -p menhirLib -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/menhirSdk@opam:20201216@5e08e674" = {
      pname = "menhirSdk";
      version = "20201216";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://gitlab.inria.fr/fpottier/menhir/repository/20201216/archive.tar.gz";
        sha256 = "05fpg5c83a6q0q12kd2ll069pg80yd91s4rzx3742ard3l2aml8z";
      };
      build = {
        buildPhase = "dune build -p menhirSdk -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/merlin-extend@opam:0.6@404f814c" = {
      pname = "merlin-extend";
      version = "0.6";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cppo@opam:1.6.7@c28ac3ae")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/let-def/merlin-extend/releases/download/v0.6/merlin-extend-v0.6.tbz";
        sha256 = "0hvc4mz92x3rl2dxwrhvhzwl4gilnyvvwcqgr45vmdpyjyp3dwn2";
      };
      build = {
        buildPhase = "dune build -p merlin-extend -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/mew@opam:0.1.0@a74f69d6" = {
      pname = "mew";
      version = "0.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/trie@opam:1.0.0@d2efc587")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/kandu/mew/archive/0.1.0.tar.gz";
        sha256 = "1rjri9mgfb9gn9fmjn0ax21y9jd9wkvr7mmx2jrlqmzgabmqrlv4";
      };
      build = {
        buildPhase = "dune build -p mew -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/mew_vi@opam:0.5.0@cf66c299" = {
      pname = "mew_vi";
      version = "0.5.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/react@opam:1.2.1@0e11855f")
        ("@opam/mew@opam:0.1.0@a74f69d6")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/kandu/mew_vi/archive/0.5.0.tar.gz";
        sha256 = "1nmg3cysglgw4115n5zpz4azrfbnfxkn2kvw73chzs69viygm4m6";
      };
      build = {
        buildPhase = "dune build -p mew_vi -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/mmap@opam:1.1.0@b85334ff" = {
      pname = "mmap";
      version = "1.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/mirage/mmap/releases/download/v1.1.0/mmap-v1.1.0.tbz";
        sha256 = "0l6waidal2n8mkdn74avbslvc10sf49f5d889n838z03pra5chsc";
      };
      build = {
        buildPhase = "dune build -p mmap -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ocaml-compiler-libs@opam:v0.12.3@f0f069bd" = {
      pname = "ocaml-compiler-libs";
      version = "v0.12.3";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/janestreet/ocaml-compiler-libs/releases/download/v0.12.3/ocaml-compiler-libs-v0.12.3.tbz";
        sha256 = "1jg32fjr7n4933r01iqgablshagx20vgjkjh5pdbn54w8cqkah58";
      };
      build = {
        buildPhase = "dune build -p ocaml-compiler-libs -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ocaml-lsp-server@github:ocaml/ocaml-lsp:ocaml-lsp-server.opam#966a28f@d41d8cd9" = {
      pname = "ocaml-lsp-server";
      version = "github-ocaml-ocaml-lsp-ocaml-lsp-server.opam-966a28f";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/stdlib-shims@opam:0.1.0@148f22ac")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ppx_yojson_conv_lib@opam:v0.14.0@116b53d6")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/dune-build-info@opam:2.6.2@03ffe168")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/dot-merlin-reader@opam:3.4.2@55baebb0")
        ("@opam/csexp@opam:1.3.2@5cea14af")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "ocaml";
        repo = "ocaml-lsp";
        rev = "966a28f";
        sha256 = "00di9pb51np2g3kvvvz1kma1c7z3algf4247y8pw1v6wh7a36zna";
        fetchSubmodules = true;
      };
      build = {
        buildPhase = "dune build -j $NIX_BUILD_CORES ocaml-lsp-server.install --release";
        mode = "opam";
      };
    };
    "@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173" = {
      pname = "ocaml-migrate-parsetree";
      version = "1.8.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ocaml-migrate-parsetree/releases/download/v1.8.0/ocaml-migrate-parsetree-v1.8.0.tbz";
        sha256 = "1dcgifw2npgkjrnb1b6jvx36wydy0nk6ny3m4wgh8i0lzxvd3hmi";
      };
      build = {
        buildPhase = "dune build -p ocaml-migrate-parsetree -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ocaml-syntax-shims@opam:1.0.0@a9aa3bfa" = {
      pname = "ocaml-syntax-shims";
      version = "1.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ocaml-syntax-shims/releases/download/1.0.0/ocaml-syntax-shims-1.0.0.tbz";
        sha256 = "1j7848khli4p7j8i2kmnvhdnhcwhy3zgdpf5ds5ic30ax69y3cl9";
      };
      build = {
        buildPhase = "dune build -p ocaml-syntax-shims -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/ocamlbuild@opam:0.14.0@6ac75d03" = {
      pname = "ocamlbuild";
      version = "0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/ocamlbuild/archive/0.14.0.tar.gz";
        sha256 = "0y1fskw9rg2y1zgb7whv3v8v4xw04svgxslf3856q2aqd7lrrcl7";
      };
      build = {
        buildPhase = ''
          make -f configure.make all OCAMLBUILD_PREFIX=$out OCAMLBUILD_BINDIR=$out/bin "OCAMLBUILD_LIBDIR=${(final.siteLib "$out")}" OCAMLBUILD_MANDIR=$out/man OCAML_NATIVE=true OCAML_NATIVE_TOOLS=true
          make check-if-preinstalled all opam-install
        '';
        mode = "opam";
      };
    };
    "@opam/ocamlfind@opam:1.8.1@ff07b0f9" = {
      pname = "ocamlfind";
      version = "1.8.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/conf-m4@opam:1@196bf219")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://download.camlcity.org/download/findlib-1.8.1.tar.gz";
        sha256 = "00s3sfb02pnjmkax25pcnljcnhcggiliccfz69a72ic7gsjwz1cf";
      };
      build = {
        buildPhase = ''
          ./configure -bindir ${"$out"}/bin -sitelib "${(final.siteLib "$out")}" -mandir ${"$out"}/man -config "${(final.siteLib "$out")}/findlib.conf" -no-custom -no-topfind
          make all
          make opt
        '';
        installPhase = ''
          ./configure -bindir ${"$out"}/bin -sitelib "${(final.siteLib "$out")}" -mandir ${"$out"}/man -config "${(final.siteLib "$out")}/findlib.conf" -no-custom -no-topfind
          make install
          install -m 0755 ocaml-stub $out/bin/ocaml
        '';
        mode = "opam";
      };
      files = (final.subtree {
        base = pkgs.fetchFromGitHub {
  owner = "ocaml";
  repo = "opam-repository";
  rev = "7c396b25fe7954503325bd8f183d080d226dc202";
  sha256 = "04s7vywhbl1c0ifflrv38s50sj4h7vhs55vyx4iihd6mcywy6xk3";
};
        hash = "1mys1fls2adq4s851gnis9lq33gnjxisjxjkwzr5kar5j22rk71c";
        path = "packages/ocamlfind/ocamlfind.1.8.1/files";
      });
    };
    "@opam/ocamlformat@opam:0.15.0@8e036963" = {
      pname = "ocamlformat";
      version = "0.15.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uuseg@opam:13.0.0@f60712a7")
        ("@opam/stdio@opam:v0.14.0@a624e254")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/odoc@opam:1.5.2@236518eb")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173")
        ("@opam/menhir@opam:20201216@1a09d886")
        ("@opam/fpath@opam:0.7.3@674d8125")
        ("@opam/fix@opam:20201120@5c318621")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ocamlformat/releases/download/0.15.0/ocamlformat-0.15.0.tbz";
        sha256 = "0190vz59n6ma9ca1m3syl3mc8i1smj1m3d8x1jp21f710y4llfr6";
      };
      build = {
        buildPhase = "dune build -p ocamlformat -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ocplib-endian@opam:1.1@84c1ca88" = {
      pname = "ocplib-endian";
      version = "1.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cppo@opam:1.6.7@c28ac3ae")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/OCamlPro/ocplib-endian/archive/1.1.tar.gz";
        sha256 = "0qy5q7p11gxi5anhvi8jj6mr80ml0ih8lax5k579rsr2hsp3sns5";
      };
      build = {
        buildPhase = "dune build -p ocplib-endian -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/octavius@opam:1.2.2@b328d1f1" = {
      pname = "octavius";
      version = "1.2.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-doc/octavius/archive/v1.2.2.tar.gz";
        sha256 = "1bg0fcm7haqxvx5wx2cci0mbbq0gf1vw9fa4kkd6jsriw1611jga";
      };
      build = {
        buildPhase = "dune build -p octavius -j $NIX_BUILD_CORES @install";
        mode = "opam";
      };
    };
    "@opam/odoc@opam:1.5.2@236518eb" = {
      pname = "odoc";
      version = "1.5.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/tyxml@opam:4.4.0@1dca5713")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/fpath@opam:0.7.3@674d8125")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cppo@opam:1.6.7@c28ac3ae")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@opam/astring@opam:0.8.5@1300cee8")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/odoc/releases/download/1.5.2/odoc-1.5.2.tbz";
        sha256 = "0wa87h8q6izcc6rkzqn944vrb3hmc21lf0d0rmr8rhhbcvr66i6j";
      };
      build = {
        buildPhase = "dune build -p odoc -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/omd@github:ocaml/omd:omd.opam#1535e3c@d41d8cd9" = {
      pname = "omd";
      version = "github-ocaml-omd-omd.opam-1535e3c";
      depKeys = [
        ("@opam/uchar@opam:0.0.2@c8218eea")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@opam/base-bigarray@opam:base@b03491b0")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "ocaml";
        repo = "omd";
        rev = "1535e3c";
        sha256 = "0zpypwz32dzlbck1m8zdv1y617h7nwvja354kfwasmpgs5cv9vjf";
      };
      build = {
        buildPhase = "dune build -p omd -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_assert@opam:v0.14.0@877b5900" = {
      pname = "ppx_assert";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/ppx_sexp_conv@opam:v0.14.1@5fc4da3c")
        ("@opam/ppx_here@opam:v0.14.0@5ccc1c01")
        ("@opam/ppx_compare@opam:v0.14.0@615de7a6")
        ("@opam/ppx_cold@opam:v0.14.0@345dec7c")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_assert-v0.14.0.tar.gz";
        sha256 = "1l2rr4jz2q5b35ryn2z146z7m9v6k8krp5gpn8ilib66mnz5zx15";
      };
      build = {
        buildPhase = "dune build -p ppx_assert -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_base@opam:v0.14.0@b4702ed9" = {
      pname = "ppx_base";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/ppx_sexp_conv@opam:v0.14.1@5fc4da3c")
        ("@opam/ppx_js_style@opam:v0.14.0@10b020a8")
        ("@opam/ppx_hash@opam:v0.14.0@8e9618e4")
        ("@opam/ppx_enumerate@opam:v0.14.0@63db8245")
        ("@opam/ppx_compare@opam:v0.14.0@615de7a6")
        ("@opam/ppx_cold@opam:v0.14.0@345dec7c")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_base-v0.14.0.tar.gz";
        sha256 = "0b7a3fmi90jk8paz0g36yzaq670fbnrbi1j8r5ibh9wbcfli7ji6";
      };
      build = {
        buildPhase = "dune build -p ppx_base -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_cold@opam:v0.14.0@345dec7c" = {
      pname = "ppx_cold";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_cold-v0.14.0.tar.gz";
        sha256 = "1madfzhpir9amnxmg530n70vll0jrl59vyp71miji73i6b9sy6n2";
      };
      build = {
        buildPhase = "dune build -p ppx_cold -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_compare@opam:v0.14.0@615de7a6" = {
      pname = "ppx_compare";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_compare-v0.14.0.tar.gz";
        sha256 = "0mqxa2s194nif7x4fjn1p5gd9i3bakr8nv27gf8x1g5nmi8q9pmp";
      };
      build = {
        buildPhase = "dune build -p ppx_compare -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_derivers@opam:1.2.1@ecf0aa45" = {
      pname = "ppx_derivers";
      version = "1.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ppx_derivers/archive/1.2.1.tar.gz";
        sha256 = "159vqy616ni18mn0dlv8c2y4h7mb4hahwjn53yrr59yyhzhmwndn";
      };
      build = {
        buildPhase = "dune build -p ppx_derivers -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_deriving@opam:5.1@3037236f" = {
      pname = "ppx_deriving";
      version = "5.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cppo@opam:1.6.7@c28ac3ae")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ppx_deriving/releases/download/v5.1/ppx_deriving-v5.1.tbz";
        sha256 = "1i64fd7qrfzbam5hfbl01r0sx4iihsahcwqj13smmrjlnwi3nkxh";
      };
      build = {
        buildPhase = "dune build -p ppx_deriving -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_deriving_yojson@opam:3.6.1@faf11a7c" = {
      pname = "ppx_deriving_yojson";
      version = "3.6.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/ppx_deriving@opam:5.1@3037236f")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ppx_deriving_yojson/releases/download/v3.6.1/ppx_deriving_yojson-v3.6.1.tbz";
        sha256 = "1rj4i6l47f7pqr7cfxsfh05i5srb5pp9ns6df9719pbhghhfjbki";
      };
      build = {
        buildPhase = "dune build -p ppx_deriving_yojson -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_enumerate@opam:v0.14.0@63db8245" = {
      pname = "ppx_enumerate";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_enumerate-v0.14.0.tar.gz";
        sha256 = "1ij6sffgqhnjwnj9brhrrw1c6xgxlh0s6r17x1qkgnyrc73gfsz8";
      };
      build = {
        buildPhase = "dune build -p ppx_enumerate -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_hash@opam:v0.14.0@8e9618e4" = {
      pname = "ppx_hash";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/ppx_sexp_conv@opam:v0.14.1@5fc4da3c")
        ("@opam/ppx_compare@opam:v0.14.0@615de7a6")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_hash-v0.14.0.tar.gz";
        sha256 = "0x4wgdvhgd8a49bzari52jpkykxpv6ncgp5ncda3xgg0a9r49s8n";
      };
      build = {
        buildPhase = "dune build -p ppx_hash -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_here@opam:v0.14.0@5ccc1c01" = {
      pname = "ppx_here";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_here-v0.14.0.tar.gz";
        sha256 = "0b444djy68v6ji0ypwv5l02pkl151qzrgg96lyhl8dxfrzvj1zkj";
      };
      build = {
        buildPhase = "dune build -p ppx_here -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_inline_test@opam:v0.14.1@2e4fdd8d" = {
      pname = "ppx_inline_test";
      version = "v0.14.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/time_now@opam:v0.14.0@5e4046b3")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/janestreet/ppx_inline_test/archive/v0.14.1.tar.gz";
        sha256 = "0qzvm8rg07annl8zpqlhzx1z8ahrrf02r1brd43ykqas5sww3rfp";
      };
      build = {
        buildPhase = "dune build -p ppx_inline_test -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_js_style@opam:v0.14.0@10b020a8" = {
      pname = "ppx_js_style";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/octavius@opam:1.2.2@b328d1f1")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_js_style-v0.14.0.tar.gz";
        sha256 = "141fgxfipfn5jdaxc946dmp5y4fcnbhxms9maji9ddywgx82ya7l";
      };
      build = {
        buildPhase = "dune build -p ppx_js_style -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_let@opam:v0.14.0@eb9b93e0" = {
      pname = "ppx_let";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_let-v0.14.0.tar.gz";
        sha256 = "1qcrnd86pbr1di5m6z4ps4p15qawwa02jxwz3xfd82hdbjmdwf1s";
      };
      build = {
        buildPhase = "dune build -p ppx_let -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_optcomp@opam:v0.14.0@47cec200" = {
      pname = "ppx_optcomp";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/stdio@opam:v0.14.0@a624e254")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_optcomp-v0.14.0.tar.gz";
        sha256 = "0b4zrj9d0ph2j0lwgfwbwc7zhxzkwmld7x4kfyg1rgbi8zg9n5s7";
      };
      build = {
        buildPhase = "dune build -p ppx_optcomp -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_sexp_conv@opam:v0.14.1@5fc4da3c" = {
      pname = "ppx_sexp_conv";
      version = "v0.14.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/sexplib0@opam:v0.14.0@ddeb6438")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/janestreet/ppx_sexp_conv/archive/v0.14.1.tar.gz";
        sha256 = "0lpm5bjxmrb5r21fqj6w9xdyhb22c40mic5h8pal8d5r9kf4gy6c";
      };
      build = {
        buildPhase = "dune build -p ppx_sexp_conv -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_tools_versioned@opam:5.4.0@32d1a414" = {
      pname = "ppx_tools_versioned";
      version = "5.4.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ppx_tools_versioned/archive/5.4.0.tar.gz";
        sha256 = "0sw2676vgbsj133lgs3sl8494fhfldafzvgw4j4dnb1wqwha6pxy";
      };
      build = {
        buildPhase = "dune build -p ppx_tools_versioned -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppx_yojson_conv_lib@opam:v0.14.0@116b53d6" = {
      pname = "ppx_yojson_conv_lib";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_yojson_conv_lib-v0.14.0.tar.gz";
        sha256 = "1f1530pvyg05zwi83iwrk3v207w316wlljikwyl9ahjh24lsja46";
      };
      build = {
        buildPhase = "dune build -p ppx_yojson_conv_lib -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ppxlib@opam:0.15.0@6a9d8126" = {
      pname = "ppxlib";
      version = "0.15.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/stdlib-shims@opam:0.1.0@148f22ac")
        ("@opam/sexplib0@opam:v0.14.0@ddeb6438")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173")
        ("@opam/ocaml-compiler-libs@opam:v0.12.3@f0f069bd")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-ppx/ppxlib/releases/download/0.15.0/ppxlib-0.15.0.tbz";
        sha256 = "0c5kjgyxhck5wlnhrsh77ylkbrq3rssqhwf2bjjrka3limzhsqqb";
      };
      build = {
        buildPhase = "dune build -p ppxlib -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/printbox@opam:0.5@82f5d436" = {
      pname = "printbox";
      version = "0.5";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@e9b515e0")
        ("@opam/tyxml@opam:4.4.0@1dca5713")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/c-cube/printbox/archive/0.5.tar.gz";
        sha256 = "0n35yrwbz8r2m7zj786v9d6hp5hrw8kmjgqq5yh34x3y19pwz6sr";
      };
      build = {
        buildPhase = "dune build @install -p printbox -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/psq@opam:0.2.0@247756d4" = {
      pname = "psq";
      version = "0.2.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/pqwy/psq/releases/download/v0.2.0/psq-v0.2.0.tbz";
        sha256 = "1j4lqkq17rskhgcrpgr4n1m1a2b1x35mlxj6f9g05rhpmgvgvknk";
      };
      build = {
        buildPhase = "dune build -p psq -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/ptime@opam:0.8.5@0051d642" = {
      pname = "ptime";
      version = "0.8.5";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/ptime/releases/ptime-0.8.5.tbz";
        sha256 = "1fxq57xy1ajzfdnvv5zfm7ap2nf49znw5f9gbi4kb9vds942ij27";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-js_of_ocaml false";
        mode = "opam";
      };
    };
    "@opam/re@opam:1.9.0@d4d5e13d" = {
      pname = "re";
      version = "1.9.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/ocaml-re/releases/download/1.9.0/re-1.9.0.tbz";
        sha256 = "1gas4ky49zgxph3870nffzkr6y41kkpqp4nj38pz1gh49zcf12aj";
      };
      build = {
        buildPhase = "dune build -p re -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/react@opam:1.2.1@0e11855f" = {
      pname = "react";
      version = "1.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://erratique.ch/software/react/releases/react-1.2.1.tbz";
        sha256 = "1aj8w79gdd9xnrbz7s5p8glcb4pmimi8jp9f439dqnf6ih3mqb3v";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false";
        mode = "opam";
      };
    };
    "@opam/reason@opam:3.6.0@58adb39a" = {
      pname = "reason";
      version = "3.6.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@305b6173")
        ("@opam/merlin-extend@opam:0.6@404f814c")
        ("@opam/menhir@opam:20201216@1a09d886")
        ("@opam/fix@opam:20201120@5c318621")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@esy-ocaml/reason/-/reason-3.6.0.tgz";
        sha256 = "16mz4f4nzzafl4yihzxkra50i63aqa9yp6cdh3lm0g583dhj6617";
      };
      build = {
        buildPhase = "dune build -p reason -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/result@opam:1.5@6b753c82" = {
      pname = "result";
      version = "1.5";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/janestreet/result/releases/download/1.5/result-1.5.tbz";
        sha256 = "0cpfp35fdwnv3p30a06wd0py3805qxmq3jmcynjc3x2qhlimwfkw";
      };
      build = {
        buildPhase = "dune build -p result -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/rresult@opam:0.6.0@4b185e72" = {
      pname = "rresult";
      version = "0.6.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/result@opam:1.5@6b753c82")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://erratique.ch/software/rresult/releases/rresult-0.6.0.tbz";
        sha256 = "1k69a3gvrk7f2cshwjzvk7818f0bwxhacgd14wxy6d4gmrggci86";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false";
        mode = "opam";
      };
    };
    "@opam/semver2@opam:1.1.0@ec4fbaf4" = {
      pname = "semver2";
      version = "1.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/angstrom@opam:0.15.0@48ede9cb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/dividat/ocaml-semver/archive/1.1.0.tar.gz";
        sha256 = "01l0mf7jjy5py8ny6flqn6khwq42armqkvk7y1ichqydasc1dny5";
      };
      build = {
        buildPhase = "dune build -p semver2 -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/seq@opam:base@d8d7de1d" = {
      pname = "seq";
      version = "base";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        mode = "opam";
      };
      files = (final.subtree {
        base = pkgs.fetchFromGitHub {
  owner = "ocaml";
  repo = "opam-repository";
  rev = "7c396b25fe7954503325bd8f183d080d226dc202";
  sha256 = "04s7vywhbl1c0ifflrv38s50sj4h7vhs55vyx4iihd6mcywy6xk3";
};
        hash = "1pannj4qsgh1bm3qg4gza8sxshnz1albqvq0pdi5y9zckv1q3b6b";
        path = "packages/seq/seq.base/files";
      });
    };
    "@opam/sexplib0@opam:v0.14.0@ddeb6438" = {
      pname = "sexplib0";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/sexplib0-v0.14.0.tar.gz";
        sha256 = "0adrc0r1vvvr41dcpj8jwkzh1dfgqf0mks9xlnnskqfm3a51iavg";
      };
      build = {
        buildPhase = "dune build -p sexplib0 -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/stdio@opam:v0.14.0@a624e254" = {
      pname = "stdio";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/stdio-v0.14.0.tar.gz";
        sha256 = "1hj5hraprqy2i90a690l11yjszvb99j818q3d684ryx6p2lddk0l";
      };
      build = {
        buildPhase = "dune build -p stdio -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/stdlib-shims@opam:0.1.0@148f22ac" = {
      pname = "stdlib-shims";
      version = "0.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/stdlib-shims/releases/download/0.1.0/stdlib-shims-0.1.0.tbz";
        sha256 = "1jv6yb47f66239m7hsz7zzw3i48mjpbvfgpszws48apqx63wjwsk";
      };
      build = {
        buildPhase = "dune build -p stdlib-shims -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/time_now@opam:v0.14.0@5e4046b3" = {
      pname = "time_now";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ppx_optcomp@opam:v0.14.0@47cec200")
        ("@opam/ppx_base@opam:v0.14.0@b4702ed9")
        ("@opam/jst-config@opam:v0.14.0@d0d7469e")
        ("@opam/jane-street-headers@opam:v0.14.0@59432b6a")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/base@opam:v0.14.0@8bc55fce")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/time_now-v0.14.0.tar.gz";
        sha256 = "0hkn2jw4dz5gflnsblskl5wp6z7zbrahwjmaxmsskfviwjg82cqh";
      };
      build = {
        buildPhase = "dune build -p time_now -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/topkg@opam:1.0.3@e4e10f1c" = {
      pname = "topkg";
      version = "1.0.3";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://erratique.ch/software/topkg/releases/topkg-1.0.3.tbz";
        sha256 = "0b77gsz9bqby8v77kfi4lans47x9p2lmzanzwins5r29maphb8y6";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pkg-name topkg --dev-pkg false";
        mode = "opam";
      };
    };
    "@opam/trie@opam:1.0.0@d2efc587" = {
      pname = "trie";
      version = "1.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/kandu/trie/archive/1.0.0.tar.gz";
        sha256 = "1slq4kiwnc723dsaw15ms7xxpqz061v8zck1m6iyc5j2li70by62";
      };
      build = {
        buildPhase = "dune build -p trie -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/tyxml@opam:4.4.0@1dca5713" = {
      pname = "tyxml";
      version = "4.4.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocsigen/tyxml/releases/download/4.4.0/tyxml-4.4.0.tbz";
        sha256 = "0c150h2f4c4id73ickkdqkir3jya66m6c7f5jxlp4caw9bfr8qsi";
      };
      build = {
        buildPhase = "dune build -p tyxml -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/uchar@opam:0.0.2@c8218eea" = {
      pname = "uchar";
      version = "0.0.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml/uchar/releases/download/v0.0.2/uchar-0.0.2.tbz";
        sha256 = "1w2saw7zanf9m9ffvz2lvcxvlm118pws2x1wym526xmydhqpyfa7";
      };
      build = {
        buildPhase = ''
          ocaml pkg/git.ml
          ocaml pkg/build.ml native=true native-dynlink=true
        '';
        mode = "opam";
      };
    };
    "@opam/uucp@opam:13.0.0@e9b515e0" = {
      pname = "uucp";
      version = "13.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/uucp/releases/uucp-13.0.0.tbz";
        sha256 = "19kf8ypxaakacgg1dwwfzkc2zicaj88cmw11fw2z7zl24dn4gyiq";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false --with-uutf true --with-uunf false --with-cmdliner true";
        mode = "opam";
      };
    };
    "@opam/uuseg@opam:13.0.0@f60712a7" = {
      pname = "uuseg";
      version = "13.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@e9b515e0")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://erratique.ch/software/uuseg/releases/uuseg-13.0.0.tbz";
        sha256 = "1a635j8ra6p27g1ivfln3387lhwqmf6vq4r6bn7b6n1qsqyi1rls";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-uutf true --with-cmdliner true";
        mode = "opam";
      };
    };
    "@opam/uutf@opam:1.0.2@4440868f" = {
      pname = "uutf";
      version = "1.0.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/uchar@opam:0.0.2@c8218eea")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.8.1@ff07b0f9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/cmdliner@opam:1.0.4@93208aac")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "http://erratique.ch/software/uutf/releases/uutf-1.0.2.tbz";
        sha256 = "1nx1rly3qj23jzn9yk3x6fwqimcxjd84kv5859vvhdg56psq26p6";
      };
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-cmdliner true";
        mode = "opam";
      };
    };
    "@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9" = {
      pname = "yojson";
      version = "github-onivim-yojson-yojson.opam-f480aef";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/easy-format@opam:1.3.2@0484b3c4")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/cppo@opam:1.6.7@c28ac3ae")
        ("@opam/biniou@opam:1.2.1@d7570399")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "onivim";
        repo = "yojson";
        rev = "f480aef";
        sha256 = "19ys263znv91fy4vbbv9bv9421gwbp7yz1jxi4hm2nd377x9ilr3";
      };
      build = {
        buildPhase = "dune build -p yojson -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@opam/zed@opam:3.1.0@86c55416" = {
      pname = "zed";
      version = "3.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/react@opam:1.2.1@0e11855f")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/charInfo_width@opam:1.1.0@4296bdfe")
        ("@opam/camomile@opam:1.0.2@40411a6b")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://github.com/ocaml-community/zed/archive/3.1.0.tar.gz";
        sha256 = "1z95fs49hi00xy078a83m0vfdqwjb5953rwr15lfpirldi4v11y3";
      };
      build = {
        buildPhase = "dune build -p zed -j $NIX_BUILD_CORES";
        mode = "opam";
      };
    };
    "@reason-native/cli@0.0.1-alpha@d41d8cd9" = {
      pname = "reason-native-cli";
      version = "0.0.1-alpha";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@reason-native/pastel@0.1.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@reason-native/cli/-/cli-0.0.1-alpha.tgz";
        sha256 = "1d3pq15aqhpmfvlrqxzflv7jcfy6ixvs7kc9virzl10qyzsa4xfh";
      };
      build = {
        buildPhase = "dune build -p cli";
        mode = "esy";
      };
      opamName = "cli";
    };
    "@reason-native/console@0.1.0@d41d8cd9" = {
      pname = "reason-native-console";
      version = "0.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@reason-native/console/-/console-0.1.0.tgz";
        sha256 = "1wf3y97136mq4gqip9b5j2id6bm8m4qf8jaxsra7r445j8shva5w";
      };
      build = {
        buildPhase = "dune build -p console";
        installPhase = "esy-installer console.install";
        mode = "esy";
      };
      opamName = "console";
    };
    "@reason-native/file-context-printer@0.0.3@d41d8cd9" = {
      pname = "reason-native-file-context-printer";
      version = "0.0.3";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@reason-native/pastel@0.1.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@reason-native/file-context-printer/-/file-context-printer-0.0.3.tgz";
        sha256 = "06i4wf84aj8p3hgfphxq22pgfg1s8y66l96c3md792ip7fxvczrj";
      };
      build = {
        buildPhase = "dune build -p file-context-printer";
        installPhase = "esy-installer file-context-printer.install";
        mode = "esy";
      };
      opamName = "file-context-printer";
    };
    "@reason-native/pastel@0.1.0@d41d8cd9" = {
      pname = "reason-native-pastel";
      version = "0.1.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@reason-native/pastel/-/pastel-0.1.0.tgz";
        sha256 = "05hzip98vjp87p7wqbyz3vj420zm2iwcfa2rmzjdf424vywwzqb2";
      };
      build = {
        buildPhase = "dune build -p pastel";
        installPhase = "esy-installer pastel.install";
        mode = "esy";
      };
      opamName = "pastel";
    };
    "@reason-native/rely@3.2.1@d41d8cd9" = {
      pname = "reason-native-rely";
      version = "3.2.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@reason-native/pastel@0.1.0@d41d8cd9")
        ("@reason-native/file-context-printer@0.0.3@d41d8cd9")
        ("@reason-native/cli@0.0.1-alpha@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/junit@opam:2.0.2@0b7bd730")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@reason-native/rely/-/rely-3.2.1.tgz";
        sha256 = "11zj328c32wfs0zfbjdkcrzbji2dzmhysvi9pbf4sa4csqk3my9n";
      };
      build = {
        buildPhase = "dune build -p rely";
        installPhase = "esy-installer rely.install";
        mode = "esy";
      };
      opamName = "rely";
    };
    "@revery/esy-cmake@0.3.5001@d41d8cd9" = {
      pname = "revery-esy-cmake";
      version = "0.3.5001";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@revery/esy-cmake/-/esy-cmake-0.3.5001.tgz";
        sha256 = "06mb7ryb5gkbkf7zdjzx64akhc66y440rq611qrk8zymmirbphvi";
      };
      build = {
        buildPhase = ''
          bash -c "${if final.os == "windows" then "./build-windows.sh" else "./build.sh"}"
          ls -a $out/bin
        '';
        mode = "esy";
      };
      opamName = "esy-cmake";
    };
    "@revery/esy-harfbuzz@2.6.8001@d41d8cd9" = {
      pname = "revery-esy-harfbuzz";
      version = "2.6.8001";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@revery/esy-harfbuzz/-/esy-harfbuzz-2.6.8001.tgz";
        sha256 = "0zd0nwmz466przdxnxgm5q6k47dxgzx7i5lr97x04cmr8p3gcp21";
      };
      build = {
        buildPhase = ''
          ./esy/prep.sh
          bash -c "${if final.os == "windows" then "./esy/configure-windows.sh" else "echo"}"
          bash -c "${if final.os == "darwin" then "./esy/configure-osx.sh" else "echo"}"
          bash -c "${if final.os == "linux" then "./esy/configure-linux.sh" else "echo"}"
          ./esy/build.sh
        '';
        exportedEnv = [
          ("HARFBUZZ_BIN_PATH=${"$out/bin"}")
          ("HARFBUZZ_INCLUDE_PATH=${"$out/include/harfbuzz"}")
          ("HARFBUZZ_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
      opamName = "esy-harfbuzz";
    };
    "@revery/esy-libvterm@1.0.3@d41d8cd9" = {
      pname = "revery-esy-libvterm";
      version = "1.0.3";
      depKeys = [
        ("esy-libtools@github:revery-ui/esy-libtools#c9eb685@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@revery/esy-libvterm/-/esy-libvterm-1.0.3.tgz";
        sha256 = "1gfzy53cma5qckad56k1m2p1db7h6bd79zk7cgkqh34rbh9d83m5";
      };
      build = {
        buildPhase = "bash -c \"${if final.os == "linux" then "CFLAGS=-fPIC" else ""} PREFIX=$cur__install ${if final.os == "windows" then "CC=x86_64-w64-mingw32-gcc" else ""} make install\"";
        exportedEnv = [
          ("LIBVTERM_INCLUDE_PATH=${"$out/include"}")
          ("LIBVTERM_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        installPhase = "";
        mode = "esy";
      };
      opamName = "esy-libvterm";
    };
    "@revery/timber@2.0.0@d41d8cd9" = {
      pname = "revery-timber";
      version = "2.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/logs@opam:0.7.0@1d03143e")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@revery/timber/-/timber-2.0.0.tgz";
        sha256 = "1w9nyph4hbs5nnlhd324ff87psfpnvsi0ig4przaaixpy146zrkl";
      };
      build = {
        buildPhase = "dune build -p timber -j4";
        mode = "esy";
      };
      opamName = "timber";
    };
    "Oni2@link-dev:./package.json" = {
      pname = "Oni2";
      version = "0.5.9-nightly";
      depKeys = [
        ("revery-terminal@github:revery-ui/revery-terminal#a9cb168@d41d8cd9")
        ("revery@github:revery-ui/revery#931f3d0@d41d8cd9")
        ("rench@github:bryphe/rench#a976fe5@d41d8cd9")
        ("refmterr@3.3.2@d41d8cd9")
        ("reason-native-crash-utils@github:onivim/reason-native-crash-utils#38c8f00@d41d8cd9")
        ("reason-fzy@github:bryphe/reason-fzy#ab172e1@d41d8cd9")
        ("ocaml@4.10.0@d41d8cd9")
        ("libvim@8.10869.83@d41d8cd9")
        ("isolinear@github:revery-ui/isolinear#53fc4eb@d41d8cd9")
        ("esy-tree-sitter@1.4.1@d41d8cd9")
        ("esy-skia@github:revery-ui/esy-skia#91c98f6@d41d8cd9")
        ("esy-sdl2@2.0.10008@d41d8cd9")
        ("esy-oniguruma@github:onivim/esy-oniguruma#4698ce4@d41d8cd9")
        ("esy-macdylibbundler@0.4.5@d41d8cd9")
        ("esy-angle-prebuilt@1.0.0@d41d8cd9")
        ("axios@0.19.2@d41d8cd9")
        ("@revery/timber@2.0.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@e9b515e0")
        ("@opam/semver2@opam:1.1.0@ec4fbaf4")
        ("@opam/reason@opam:3.6.0@58adb39a")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/ppxlib@opam:0.15.0@6a9d8126")
        ("@opam/ppx_optcomp@opam:v0.14.0@47cec200")
        ("@opam/ppx_let@opam:v0.14.0@eb9b93e0")
        ("@opam/ppx_inline_test@opam:v0.14.1@2e4fdd8d")
        ("@opam/ppx_deriving_yojson@opam:3.6.1@faf11a7c")
        ("@opam/ppx_deriving@opam:5.1@3037236f")
        ("@opam/ocamlformat@opam:0.15.0@8e036963")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/markup@opam:0.8.2@87975241")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/luv@github:bryphe/luv:luv.opam#8e9f2b0@d41d8cd9")
        ("@opam/lru@github:bryphe/lru:lru.opam#2708c70@d41d8cd9")
        ("@opam/logs@opam:0.7.0@1d03143e")
        ("@opam/fs@github:bryphe/reason-native:fs.opam#5a7a756@d41d8cd9")
        ("@opam/fp@github:bryphe/reason-native:fp.opam#5a7a756@d41d8cd9")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/dune-private-libs@opam:2.5.1@60c1661f")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/dir@github:bryphe/reason-native:dir.opam#5a7a756@d41d8cd9")
        ("@opam/decoders-yojson@opam:0.4.0@cb39dea6")
        ("@opam/charInfo_width@opam:1.1.0@4296bdfe")
        ("@opam/angstrom@opam:0.15.0@48ede9cb")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "onivim";
        repo = "oni2";
        rev = "40b0ffc7d935c12bce94a6aeea9603cae964c67c";
        sha256 = "08gk7zdkfxccbpp2nbw6s113qklcz8bzdl841m7y9ld7izyw83sa";
      };
      build = {
        buildEnv = [
          ("ONI2_APPCAST_BASEURL=${"http://localhost:8080/"}")
          ("ONI2_BUILD_MODE=${"Debug"}")
          ("ONI2_ROOT=${"$PWD"}")
        ];
        buildPhase = "refmterr dune build -p libvim,textmate,treesitter,Oni2 -j4";
        installPhase = ''
          esy-installer Oni2.install
          bash -c "${if final.os == "windows" then "cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/*.dll '$cur__bin'" else "echo"}"
          bash -c "cp ${(final.getDrv "esy-sdl2@2.0.10008@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-skia@github:revery-ui/esy-skia#91c98f6@d41d8cd9")}/bin/skia.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-angle-prebuilt@1.0.0@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
        '';
        mode = "esy";
      };
    };
    "autoconf@github:esy-packages/esy-autoconf#fb93edf57b0adc4b27b34a57a562395b224002d3@d41d8cd9" = {
      pname = "autoconf";
      version = "2.69.000";
      depKeys = [
        ("esy-help2man@github:esy-packages/esy-help2man#c8e6931d1dcf58a81bd801145a777fd3b115c443@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "esy-packages";
        repo = "esy-autoconf";
        rev = "fb93edf57b0adc4b27b34a57a562395b224002d3";
        sha256 = "0c8j1sv9yxfgcykgf07xjdam5qn5frgq81pc5yg03l52zbk32zi3";
      };
      build = {
        buildPhase = ''
          find ./ -exec touch -t 200905010101 {} +
          chmod 755 ./configure
          ln -s /usr/bin/true $out/bin/makeinfo
          bash -c "${if final.os == "windows" then "./configure --prefix=$cur__install --host x86_64-w64-mingw32" else "./configure --prefix=$cur__install"}"
          make
          make install
        '';
        mode = "esy";
      };
      opamName = "esy-autoconf";
    };
    "automake@github:esy-packages/esy-automake#e959059ccc1560a1565b16fb63ed7052c663fca0@d41d8cd9" = {
      pname = "automake";
      version = "1.16.1000";
      depKeys = [
        ("autoconf@github:esy-packages/esy-autoconf#fb93edf57b0adc4b27b34a57a562395b224002d3@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "esy-packages";
        repo = "esy-automake";
        rev = "e959059ccc1560a1565b16fb63ed7052c663fca0";
        sha256 = "0gbcqwc5rfaaqi6qgiv4kv74zasx8frywm8650xf1b55y77p9m59";
      };
      build = {
        buildPhase = ''
          find ./ -exec touch -t 200905010101 {} + 
          bash -c "${if final.os == "windows" then "./configure --prefix=$cur__install --host x86_64-w64-mingw32" else "./configure --prefix=$cur__install"}"
          make
          make install
        '';
        mode = "esy";
      };
      opamName = "esy-automake";
    };
    "axios@0.19.2@d41d8cd9" = {
      pname = "axios";
      version = "0.19.2";
      depKeys = [
        ("follow-redirects@1.5.10@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/axios/-/axios-0.19.2.tgz";
        sha256 = "16axaxb71wvn5qwp79d7i7zg4m384xin1hlk3b25f6z37chxfmz9";
      };
      build = {
        mode = "esy";
      };
    };
    "balanced-match@1.0.0@d41d8cd9" = {
      pname = "balanced-match";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha256 = "1bgzp9jp8ws0kdfgq8h6w3qz8cljyzgcrmxypxkgbknk28n615i8";
      };
      build = {
        mode = "esy";
      };
    };
    "base64-js@1.5.1@d41d8cd9" = {
      pname = "base64-js";
      version = "1.5.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/base64-js/-/base64-js-1.5.1.tgz";
        sha256 = "118a46skxnrgx5bdd68ny9xxjcvyb7b1clj2hf82d196nm2skdxi";
      };
      build = {
        mode = "esy";
      };
    };
    "brace-expansion@1.1.11@d41d8cd9" = {
      pname = "brace-expansion";
      version = "1.1.11";
      depKeys = [
        ("concat-map@0.0.1@d41d8cd9")
        ("balanced-match@1.0.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha256 = "1nlmjvlwlp88knblnayns0brr7a9m2fynrlwq425lrpb4mcn9gc4";
      };
      build = {
        mode = "esy";
      };
    };
    "concat-map@0.0.1@d41d8cd9" = {
      pname = "concat-map";
      version = "0.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha256 = "0qa2zqn9rrr2fqdki44s4s2dk2d8307i4556kv25h06g43b2v41m";
      };
      build = {
        mode = "esy";
      };
    };
    "debug@3.1.0@d41d8cd9" = {
      pname = "debug";
      version = "3.1.0";
      depKeys = [
        ("ms@2.0.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-3.1.0.tgz";
        sha256 = "1v6mixq7h1plnik0v6nf543yh7s0kppr7j08ayfi83nfjbgfbj6s";
      };
      build = {
        mode = "esy";
      };
    };
    "esy-angle-prebuilt@1.0.0@d41d8cd9" = {
      pname = "esy-angle-prebuilt";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/esy-angle-prebuilt/-/esy-angle-prebuilt-1.0.0.tgz";
        sha256 = "17r08dyy6bm0v6pn7clzmcplmz3z2bk87r2l4fqy690cs6jdx0az";
      };
      build = {
        buildPhase = "bash ./build.sh \"${final.os}\"";
        exportedEnv = [
          ("ANGLE_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        installPhase = "bash ./install.sh \"${final.os}\"";
        mode = "esy";
      };
    };
    "esy-cmake@0.3.5@d41d8cd9" = {
      pname = "esy-cmake";
      version = "0.3.5";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/esy-cmake/-/esy-cmake-0.3.5.tgz";
        sha256 = "0rwxmvj4h605vmdrn4hhfy6c07rmbhlzdklm8nygd40204ff41gw";
      };
      build = {
        buildPhase = ''
          bash -c "${if final.os == "windows" then "./build-windows.sh" else "./build.sh"}"
          ls -a $out/bin
        '';
        mode = "esy";
      };
    };
    "esy-freetype2@2.9.1008@d41d8cd9" = {
      pname = "esy-freetype2";
      version = "2.9.1008";
      depKeys = [
        ("esy-cmake@0.3.5@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/esy-freetype2/-/esy-freetype2-2.9.1008.tgz";
        sha256 = "0rkg23fff95rgk7xifdssyyqcy60jhayy3mc06sirrx41lb0sngd";
      };
      build = {
        buildPhase = ''
          bash -c "${if final.os == "windows" then "echo \\\"skipping-configure\\\"" else "./esy/configure.sh"}"
          bash -c "${if final.os == "windows" then "echo \\\"skipping-build\\\"" else "./esy/build.sh"}"
        '';
        exportedEnv = [
          ("FREETYPE2_INCLUDE_PATH=${"$out/include/freetype2"}")
          ("FREETYPE2_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-fzy@github:bryphe/esy-fzy#301dbf6@d41d8cd9" = {
      pname = "esy-fzy";
      version = "5.9.1000";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "esy-fzy";
        rev = "301dbf6";
        sha256 = "0md1gh4hwcgmkkxgva0xckd5x7ylfjdbn1h7lxb7wpcxqxjc2hz1";
      };
      build = {
        buildPhase = ''
          bash -c "${if final.os == "windows" then "CC=x86_64-w64-mingw32-gcc make" else "echo"}"
          bash -c "${if final.os == "darwin" then "make" else "echo"}"
          bash -c "${if final.os == "macOS" then "make" else "echo"}"
          bash -c "${if final.os == "linux" then "CFLAGS=-fPIC make" else "echo"}"
          mkdir $out/include
          cp src/options.h $out/include
          cp src/match.h $out/include
          cp src/choices.h $out/include
          ar rcs libfzy.a src/match.o src/choices.o src/options.o
          cp libfzy.a "${(final.siteLib "$out")}"
        '';
        exportedEnv = [
          ("FZY_INCLUDE_PATH=${"$out/include"}")
          ("FZY_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-help2man@github:esy-packages/esy-help2man#c8e6931d1dcf58a81bd801145a777fd3b115c443@d41d8cd9" = {
      pname = "esy-help2man";
      version = "1.021.000";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "esy-packages";
        repo = "esy-help2man";
        rev = "c8e6931d1dcf58a81bd801145a777fd3b115c443";
        sha256 = "0pw5m5ijgm778xmjgbp81yd0cv64y27p4z9p3cgfyw90bdp7h906";
      };
      build = {
        buildPhase = ''
          chmod 755 ./configure ./mkinstalldirs
          ln -s /usr/bin/true $out/bin/makeinfo
          bash -c "${if final.os == "windows" then "./configure --prefix=$cur__install --host x86_64-w64-mingw32" else "./configure --prefix=$cur__install"}"
          make
          make install
        '';
        mode = "esy";
      };
    };
    "esy-libjpeg-turbo@github:revery-ui/libjpeg-turbo#dbb3dd5@d41d8cd9" = {
      pname = "esy-libjpeg-turbo";
      version = "2.0.2000";
      depKeys = [
        ("esy-nasm@github:revery-ui/esy-nasm#64a802b@d41d8cd9")
        ("@revery/esy-cmake@0.3.5001@d41d8cd9")
        ("@esy-cross/ninja-build@1.8.2001@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "libjpeg-turbo";
        rev = "dbb3dd5";
        sha256 = "1pha9657s6q2hrjxb8virz1jnqv0b3xaqhgzqcyr13m0p3rx02wy";
      };
      build = {
        buildPhase = "${if final.os == "windows" then "echo esy-libjpeg-turbo currently works on on Linux/OSX" else "bash ./esy-build.sh"}";
        exportedEnv = [
          ("JPEG_INCLUDE_PATH=${"$out/include"}")
          ("JPEG_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-libtools@github:revery-ui/esy-libtools#c9eb685@d41d8cd9" = {
      pname = "esy-libtools";
      version = "2.4.6000";
      depKeys = [
        ("texinfo@github:esy-packages/esy-texinfo#4a05feafbbcc4c57d5d25899fbdab98961b9a69c@d41d8cd9")
        ("automake@github:esy-packages/esy-automake#e959059ccc1560a1565b16fb63ed7052c663fca0@d41d8cd9")
        ("autoconf@github:esy-packages/esy-autoconf#fb93edf57b0adc4b27b34a57a562395b224002d3@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "esy-libtools";
        rev = "c9eb685";
        sha256 = "049n2ihsff5x9ibzgqvsdyc821j8z4nlmwjklahxnzmqm13m2rbq";
      };
      build = {
        buildEnv = [
          ("LT_INIT=${"2.4.6"}")
        ];
        buildPhase = ''
          find ./ -exec touch -t 200905010101 {} +
          ./configure --prefix=$out --disable-dependency-tracking "${if final.os == "windows" then "--host=x86_64-w64-mingw32" else ""}" "${if final.os == "windows" then "--target=x86_64-w64-mingw32" else ""}"
          bash -c ./files/create-serial.sh
          ${if final.os == "darwin" then "./validate-glibtool.sh" else "make install"}
        '';
        mode = "esy";
      };
    };
    "esy-m4@github:esy-packages/esy-m4#c7cf0ac9221be2b1f9d90e83559ca08397a629e7@d41d8cd9" = {
      pname = "esy-m4";
      version = "1.4.18";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "esy-packages";
        repo = "esy-m4";
        rev = "c7cf0ac9221be2b1f9d90e83559ca08397a629e7";
        sha256 = "0klh1miiksh47cmbq3822d3smz9kr4azv78zfji81py5sdi4lfg0";
      };
      build = {
        buildPhase = ''
          find ./ -exec touch -t 200905010101 {} +
          sh -c "${if final.os == "darwin" then "patch -p1 < secure_snprintf.patch" else "true"}"
          sh -c "${if final.os == "linux" then "patch -p1 < m4-1.4.18-glibc-change-work-around.patch" else "true"}"
          ./configure ${if final.os == "windows" then "--host x86_64-w64-mingw32" else ""} --disable-dependency-tracking --prefix=$out
          make -j4
        '';
        installPhase = "make install";
        mode = "esy";
      };
    };
    "esy-macdylibbundler@0.4.5@d41d8cd9" = {
      pname = "esy-macdylibbundler";
      version = "0.4.5";
      depKeys = [
        ("esy-cmake@0.3.5@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/esy-macdylibbundler/-/esy-macdylibbundler-0.4.5.tgz";
        sha256 = "1bb7s21jbkvjvr1wfs29hipvzfiwz14cn0b6lvshb70crgfyyz96";
      };
      build = {
        buildPhase = "make \"${if final.os == "darwin" then "install" else "noop"}\" PREFIX=$out";
        mode = "esy";
      };
    };
    "esy-nasm@github:revery-ui/esy-nasm#64a802b@d41d8cd9" = {
      pname = "esy-nasm";
      version = "2.14.0200";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "esy-nasm";
        rev = "64a802b";
        sha256 = "1md36lip66cdf2436qlncx6r78wbnapi7vp9mx4j4442nkihv06i";
      };
      build = {
        buildPhase = "bash esy-build.sh ${final.os}";
        mode = "esy";
      };
    };
    "esy-oniguruma@github:onivim/esy-oniguruma#4698ce4@d41d8cd9" = {
      pname = "esy-oniguruma";
      version = "6.9.4000";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "onivim";
        repo = "esy-oniguruma";
        rev = "4698ce4";
        sha256 = "1chz3lc1hxp285gyhf2bihy69gypqrrr3mgkb14zjmx4mwcaldz5";
      };
      build = {
        buildPhase = ''
          bash -c "${if final.os == "windows" then "CFLAGS=-O2 CC=x86_64-w64-mingw32-gcc ./configure --prefix=$cur__install --disable-dependency-tracking" else "CFLAGS=\\\"-O2 -fPIC\\\" ./configure --prefix=$cur__install --enable-shared=no --enable-static=yes --disable-dependency-tracking"}"
          make install
        '';
        exportedEnv = [
          ("ONIGURUMA_INCLUDE_PATH=${"$out/include"}")
          ("ONIGURUMA_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-sdl2@2.0.10008@d41d8cd9" = {
      pname = "esy-sdl2";
      version = "2.0.10008";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/esy-sdl2/-/esy-sdl2-2.0.10008.tgz";
        sha256 = "0nnilhvmrl08psnxypy0xmsxfifcazp3ambzm7q8c8k279fc832l";
      };
      build = {
        buildPhase = "bash -c \"./build-scripts/esybuild.sh --os=${final.os}\"";
        exportedEnv = [
          ("SDL2_INCLUDE_PATH=${"$out/include"}")
          ("SDL2_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-skia@github:revery-ui/esy-skia#91c98f6@d41d8cd9" = {
      pname = "esy-skia";
      version = "0.6.0";
      depKeys = [
        ("esy-libjpeg-turbo@github:revery-ui/libjpeg-turbo#dbb3dd5@d41d8cd9")
        ("@esy-cross/ninja-build@1.8.2001@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "esy-skia";
        rev = "91c98f6";
        sha256 = "0d5l634q8inqd5xqlqqjkqg17y8n5jkg538yjc70jazz2i41nzmb";
      };
      build = {
        buildPhase = "bash ./esy/build.sh \"${final.os}\" \"${(final.getDrv "esy-libjpeg-turbo@github:revery-ui/libjpeg-turbo#dbb3dd5@d41d8cd9")}\"";
        exportedEnv = [
          ("SKIA_INCLUDE_PATH=${"$out/include"}")
          ("SKIA_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        installPhase = "bash ./esy/install.sh \"${final.os}\"";
        mode = "esy";
      };
    };
    "esy-tree-sitter@1.4.1@d41d8cd9" = {
      pname = "esy-tree-sitter";
      version = "1.4.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/esy-tree-sitter/-/esy-tree-sitter-1.4.1.tgz";
        sha256 = "0v25c32bqy747jyx6rigax3ahdvi73i3xx0nmld4dflxz4jxfi4b";
      };
      build = {
        buildPhase = ''
          bash -c echo "${final.os}"
          bash -c "${if final.os == "windows" then "CC=x86_64-w64-mingw32-gcc script/build-lib" else "echo"}"
          bash -c "${if final.os == "linux" then "CFLAGS=-fPIC script/build-lib" else "echo"}"
          bash -c "${if final.os == "darwin" then "CC=gcc script/build-lib" else "echo"}"
          bash -c "${if final.os == "macOS" then "CC=gcc script/build-lib" else "echo"}"
        '';
        exportedEnv = [
          ("TREESITTER_INCLUDE_PATH=${"$out/include"}")
          ("TREESITTER_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        installPhase = ''
          cp libtree-sitter.a "${(final.siteLib "$out")}"
          mkdir -p $out/include
          cp -r lib/include $out
        '';
        mode = "esy";
      };
    };
    "flex@github:bryphe/flex#5e19b05@d41d8cd9" = {
      pname = "flex";
      version = "1.2.3";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "flex";
        rev = "5e19b05";
        sha256 = "1knxrg11h0hm9yk55b68h3azkjhh0g70ig52jh29rralv4wr728s";
      };
      build = {
        buildPhase = "dune build -p flex";
        mode = "esy";
      };
    };
    "follow-redirects@1.5.10@d41d8cd9" = {
      pname = "follow-redirects";
      version = "1.5.10";
      depKeys = [
        ("debug@3.1.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/follow-redirects/-/follow-redirects-1.5.10.tgz";
        sha256 = "1gyh7jddcmgzv98ibh5bil75ccq145d9q5z77p4mmf3y265hp2l6";
      };
      build = {
        mode = "esy";
      };
    };
    "fs-extra@7.0.1@d41d8cd9" = {
      pname = "fs-extra";
      version = "7.0.1";
      depKeys = [
        ("universalify@0.1.2@d41d8cd9")
        ("jsonfile@4.0.0@d41d8cd9")
        ("graceful-fs@4.2.4@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fs-extra/-/fs-extra-7.0.1.tgz";
        sha256 = "1f08bng4dgkdrwhd977f4xfch9419b7fbwvwwn1qpz3gy4zgja4b";
      };
      build = {
        mode = "esy";
      };
    };
    "fs.realpath@1.0.0@d41d8cd9" = {
      pname = "fs.realpath";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha256 = "174g5vay9jnd7h5q8hfdw6dnmwl1gdpn4a8sz0ysanhj2f3wp04y";
      };
      build = {
        mode = "esy";
      };
    };
    "function-bind@1.1.1@d41d8cd9" = {
      pname = "function-bind";
      version = "1.1.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/function-bind/-/function-bind-1.1.1.tgz";
        sha256 = "10p0s9ypggwmazik4azdhywjnnayagnjxk10cjzsrhxlk1y2wm9d";
      };
      build = {
        mode = "esy";
      };
    };
    "glob@7.1.6@d41d8cd9" = {
      pname = "glob";
      version = "7.1.6";
      depKeys = [
        ("path-is-absolute@1.0.1@d41d8cd9")
        ("once@1.4.0@d41d8cd9")
        ("minimatch@3.0.4@d41d8cd9")
        ("inherits@2.0.4@d41d8cd9")
        ("inflight@1.0.6@d41d8cd9")
        ("fs.realpath@1.0.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.6.tgz";
        sha256 = "1hm62p225wxx15k5kw9b5byif2rdi4ivn2a595lfvv26niq53c2l";
      };
      build = {
        mode = "esy";
      };
    };
    "graceful-fs@4.2.4@d41d8cd9" = {
      pname = "graceful-fs";
      version = "4.2.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.4.tgz";
        sha256 = "0l8p8vjiymrhvzizwh3z59vfrasl0k0dr7cz8s8j16c2dhn5gb98";
      };
      build = {
        mode = "esy";
      };
    };
    "has@1.0.3@d41d8cd9" = {
      pname = "has";
      version = "1.0.3";
      depKeys = [
        ("function-bind@1.1.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/has/-/has-1.0.3.tgz";
        sha256 = "0wsmn2vcbqb23xpbzxipjd7xcdljid2gwnwl7vn5hkp0zkpgk363";
      };
      build = {
        mode = "esy";
      };
    };
    "inflight@1.0.6@d41d8cd9" = {
      pname = "inflight";
      version = "1.0.6";
      depKeys = [
        ("wrappy@1.0.2@d41d8cd9")
        ("once@1.4.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha256 = "16w864087xsh3q7f5gm3754s7bpsb9fq3dhknk9nmbvlk3sxr7ss";
      };
      build = {
        mode = "esy";
      };
    };
    "inherits@2.0.4@d41d8cd9" = {
      pname = "inherits";
      version = "2.0.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
        sha256 = "1bxg4igfni2hymabg8bkw86wd3qhhzhsswran47sridk3dnbqkfr";
      };
      build = {
        mode = "esy";
      };
    };
    "innosetup-compiler@5.5.9@d41d8cd9" = {
      pname = "innosetup-compiler";
      version = "5.5.9";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/innosetup-compiler/-/innosetup-compiler-5.5.9.tgz";
        sha256 = "1w19a69j8fqphn14jffbln012bg4i3f42yvnz5hwbafnhra2ykds";
      };
      build = {
        mode = "esy";
      };
    };
    "interpret@1.4.0@d41d8cd9" = {
      pname = "interpret";
      version = "1.4.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/interpret/-/interpret-1.4.0.tgz";
        sha256 = "0yq848vkk6a11c3h00fh2pz9vmr6j4d9hh7b2915wlhn0kj26agp";
      };
      build = {
        mode = "esy";
      };
    };
    "is-core-module@2.2.0@d41d8cd9" = {
      pname = "is-core-module";
      version = "2.2.0";
      depKeys = [
        ("has@1.0.3@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/is-core-module/-/is-core-module-2.2.0.tgz";
        sha256 = "1p938n56sd0i861pghd7iw4lfmb9b2hn6hfnmkg9a4fxcslskzc5";
      };
      build = {
        mode = "esy";
      };
    };
    "isolinear@github:revery-ui/isolinear#53fc4eb@d41d8cd9" = {
      pname = "isolinear";
      version = "3.0.0";
      depKeys = [
        ("refmterr@3.3.2@d41d8cd9")
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "isolinear";
        rev = "53fc4eb";
        sha256 = "1zb572jwzahdh8p9cvxaj3wbrs77j85n3fhiary3za9044igc8gb";
      };
      build = {
        buildPhase = "refmterr dune build -p isolinear";
        mode = "esy";
      };
    };
    "jsonfile@4.0.0@d41d8cd9" = {
      pname = "jsonfile";
      version = "4.0.0";
      depKeys = [
        ("graceful-fs@4.2.4@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/jsonfile/-/jsonfile-4.0.0.tgz";
        sha256 = "1s701cy3mlbvgyhhyy2ypqcy064w5990sk8x81gv0200yybrbfaz";
      };
      build = {
        mode = "esy";
      };
    };
    "libvim@8.10869.83@d41d8cd9" = {
      pname = "libvim";
      version = "8.10869.83";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/libvim/-/libvim-8.10869.83.tgz";
        sha256 = "0ddxfrv4lbl15msqnhba0hf3xpyxpa3q71h7kpd3x360cnncb4ab";
      };
      build = {
        buildPhase = "bash -c \"${if final.os == "windows" then "build/build-windows.sh" else "build/build-posix.sh"}\"";
        exportedEnv = [
          ("LIBVIM_INCLUDE_PATH=${"$out/include"}")
          ("LIBVIM_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "lodash@4.17.20@d41d8cd9" = {
      pname = "lodash";
      version = "4.17.20";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/lodash/-/lodash-4.17.20.tgz";
        sha256 = "1qpjahj6j8l9sag75f9sxfl85r6ab8f7v8w5axv9319wzim8ranj";
      };
      build = {
        mode = "esy";
      };
    };
    "minimatch@3.0.4@d41d8cd9" = {
      pname = "minimatch";
      version = "3.0.4";
      depKeys = [
        ("brace-expansion@1.1.11@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha256 = "0wgammjc9myx0k0k3n9r9cjnv0r1j33cwqiy2fxx7w5nkgbj8sj2";
      };
      build = {
        mode = "esy";
      };
    };
    "ms@2.0.0@d41d8cd9" = {
      pname = "ms";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.0.0.tgz";
        sha256 = "1jrysw9zx14av3jdvc3kywc3xkjqxh748g4s6p1iy634i2mm489n";
      };
      build = {
        mode = "esy";
      };
    };
    "ocaml@4.10.0@d41d8cd9" = {
      pname = "ocaml";
      version = "4.10.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ocaml/-/ocaml-4.10.0.tgz";
        sha256 = "09xf7lxfgydzcqady0mhspna9lqbl1l9rs5yd410117918882gms";
      };
      build = {
        buildPhase = ''
          ./esy-configure --disable-cfi --prefix $cur__install
          ./esy-build
        '';
        mode = "esy";
      };
    };
    "once@1.4.0@d41d8cd9" = {
      pname = "once";
      version = "1.4.0";
      depKeys = [
        ("wrappy@1.0.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha256 = "1kygzk36kdcfiqz01dhql2dk75rl256m2vlpigv9iikhlc5lclfg";
      };
      build = {
        mode = "esy";
      };
    };
    "path-is-absolute@1.0.1@d41d8cd9" = {
      pname = "path-is-absolute";
      version = "1.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha256 = "0p7p04xxd8q495qhxmxydyjgzcf762dp1hp2wha2b52n3agp0vbf";
      };
      build = {
        mode = "esy";
      };
    };
    "path-parse@1.0.6@d41d8cd9" = {
      pname = "path-parse";
      version = "1.0.6";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/path-parse/-/path-parse-1.0.6.tgz";
        sha256 = "07x1wv7r4yky2hgcxl465a39a48hf5746840g9xkzggl3gb35ad4";
      };
      build = {
        mode = "esy";
      };
    };
    "plist@3.0.1@d41d8cd9" = {
      pname = "plist";
      version = "3.0.1";
      depKeys = [
        ("xmldom@0.1.31@d41d8cd9")
        ("xmlbuilder@9.0.7@d41d8cd9")
        ("base64-js@1.5.1@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/plist/-/plist-3.0.1.tgz";
        sha256 = "0q03wxgiydy0s2kaf9nh0ri23ynpxyiv2siwgnjpj3fw36lr1m2h";
      };
      build = {
        mode = "esy";
      };
    };
    "rcedit@2.0.0@d41d8cd9" = {
      pname = "rcedit";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/rcedit/-/rcedit-2.0.0.tgz";
        sha256 = "0mbw6882g2w6qmai72mlail1fh5zfy1kmgyss6xwzly2jzz60b5b";
      };
      build = {
        mode = "esy";
      };
    };
    "reason-fzy@github:bryphe/reason-fzy#ab172e1@d41d8cd9" = {
      pname = "reason-fzy";
      version = "1.0";
      depKeys = [
        ("refmterr@3.3.2@d41d8cd9")
        ("ocaml@4.10.0@d41d8cd9")
        ("esy-fzy@github:bryphe/esy-fzy#301dbf6@d41d8cd9")
        ("@opam/reason@opam:3.6.0@58adb39a")
        ("@opam/ppx_inline_test@opam:v0.14.1@2e4fdd8d")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "reason-fzy";
        rev = "ab172e1";
        sha256 = "0q556rswp7y8pyvla1v71q4cb7zwaxdd0fc044kc5av0ahqnhfba";
      };
      build = {
        buildPhase = "refmterr dune build -p Fzy";
        installPhase = "esy-installer Fzy.install";
        mode = "esy";
      };
    };
    "reason-native-crash-utils@github:onivim/reason-native-crash-utils#38c8f00@d41d8cd9" = {
      pname = "reason-native-crash-utils";
      version = "1.0.0";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "onivim";
        repo = "reason-native-crash-utils";
        rev = "38c8f00";
        sha256 = "1vj5sl2albfzd5fp6mk4glh5acf9c9q0m9kkspcfq9wfzkfmxl95";
      };
      build = {
        buildPhase = "dune build -p reason-native-crash-utils";
        mode = "esy";
      };
    };
    "rebez@github:jchavarri/rebez#03fa3b7@d41d8cd9" = {
      pname = "rebez";
      version = "0.0.1";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "jchavarri";
        repo = "rebez";
        rev = "03fa3b7";
        sha256 = "15lj9zb0ys0nljrhkyji0cbgmrn8229j2bzh2bzn7yhnvk1545lj";
      };
      build = {
        buildPhase = "dune build -p rebez";
        mode = "esy";
      };
    };
    "rechoir@0.6.2@d41d8cd9" = {
      pname = "rechoir";
      version = "0.6.2";
      depKeys = [
        ("resolve@1.19.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/rechoir/-/rechoir-0.6.2.tgz";
        sha256 = "0df65av0z6bzwnyaprcd6dh7a2b4mw4nlcrnwbxkz5glrrbal7ql";
      };
      build = {
        mode = "esy";
      };
    };
    "refmterr@3.3.2@d41d8cd9" = {
      pname = "refmterr";
      version = "3.3.2";
      depKeys = [
        ("ocaml@4.10.0@d41d8cd9")
        ("@reason-native/pastel@0.1.0@d41d8cd9")
        ("@reason-native/console@0.1.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@d4d5e13d")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/atdgen@opam:2.2.1@d73fda11")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/refmterr/-/refmterr-3.3.2.tgz";
        sha256 = "00iwafzy124fv804wgc768k3cq1chxmpf5vnwvzh00b2ilkvn9li";
      };
      build = {
        buildPhase = "dune build -p refmterr";
        installPhase = "esy-installer refmterr.install";
        mode = "esy";
      };
    };
    "rench@github:bryphe/rench#a976fe5@d41d8cd9" = {
      pname = "rench";
      version = "1.9.0";
      depKeys = [
        ("refmterr@3.3.2@d41d8cd9")
        ("@reason-native/rely@3.2.1@d41d8cd9")
        ("@reason-native/console@0.1.0@d41d8cd9")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/lambda-term@opam:3.1.0@8adc2660")
        ("@opam/fpath@opam:0.7.3@674d8125")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "bryphe";
        repo = "rench";
        rev = "a976fe5";
        sha256 = "05cd353i3mfagz3ynkrdawfdhn8sp65qy1xahbczx1nbj313fqlc";
      };
      build = {
        buildPhase = "refmterr dune build -p Rench -j4";
        installPhase = "esy-installer Rench.install";
        mode = "esy";
      };
    };
    "reperf@1.5.0@d41d8cd9" = {
      pname = "reperf";
      version = "1.5.0";
      depKeys = [
        ("refmterr@3.3.2@d41d8cd9")
        ("ocaml@4.10.0@d41d8cd9")
        ("@reason-native/pastel@0.1.0@d41d8cd9")
        ("@opam/printbox@opam:0.5@82f5d436")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/reperf/-/reperf-1.5.0.tgz";
        sha256 = "1xml6412g9dqhxk5qqmid19i1kx09dlmjiisqyr7nm6i62riq4mz";
      };
      build = {
        buildPhase = "refmterr dune build -p reperf";
        installPhase = "esy-installer reperf.install";
        mode = "esy";
      };
    };
    "resolve@1.19.0@d41d8cd9" = {
      pname = "resolve";
      version = "1.19.0";
      depKeys = [
        ("path-parse@1.0.6@d41d8cd9")
        ("is-core-module@2.2.0@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/resolve/-/resolve-1.19.0.tgz";
        sha256 = "0rpb2fl9gwc9nkgpkncklq7svxbbszk2w06ds6b50idvr4i9pjcc";
      };
      build = {
        mode = "esy";
      };
    };
    "revery-terminal@github:revery-ui/revery-terminal#a9cb168@d41d8cd9" = {
      pname = "revery-terminal";
      version = "1.0.0";
      depKeys = [
        ("revery@github:revery-ui/revery#931f3d0@d41d8cd9")
        ("isolinear@github:revery-ui/isolinear#53fc4eb@d41d8cd9")
        ("@revery/timber@2.0.0@d41d8cd9")
        ("@revery/esy-libvterm@1.0.3@d41d8cd9")
        ("@onivim/reason-native-crash-utils@1.0.1@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "revery-terminal";
        rev = "a9cb168";
        sha256 = "1hfkfh9n2353jdy510j8dibg5j41wj6vshqglhhjqgzsw05h40jq";
      };
      build = {
        buildPhase = "refmterr dune build -p revery-terminal";
        installPhase = "esy-installer revery-terminal.install";
        mode = "esy";
      };
    };
    "revery@github:revery-ui/revery#931f3d0@d41d8cd9" = {
      pname = "revery";
      version = "0.32.0";
      depKeys = [
        ("reperf@1.5.0@d41d8cd9")
        ("rench@github:bryphe/rench#a976fe5@d41d8cd9")
        ("rebez@github:jchavarri/rebez#03fa3b7@d41d8cd9")
        ("reason-native-crash-utils@github:onivim/reason-native-crash-utils#38c8f00@d41d8cd9")
        ("flex@github:bryphe/flex#5e19b05@d41d8cd9")
        ("esy-skia@github:revery-ui/esy-skia#91c98f6@d41d8cd9")
        ("esy-sdl2@2.0.10008@d41d8cd9")
        ("esy-freetype2@2.9.1008@d41d8cd9")
        ("esy-angle-prebuilt@1.0.0@d41d8cd9")
        ("@revery/timber@2.0.0@d41d8cd9")
        ("@revery/esy-harfbuzz@2.6.8001@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@e9b515e0")
        ("@opam/ppx_optcomp@opam:v0.14.0@47cec200")
        ("@opam/ppx_deriving@opam:5.1@3037236f")
        ("@opam/omd@github:ocaml/omd:omd.opam#1535e3c@d41d8cd9")
        ("@opam/markup@opam:0.8.2@87975241")
        ("@opam/lwt_ppx@opam:2.0.1@e6a764a0")
        ("@opam/lwt@opam:4.5.0@542100aa")
        ("@opam/lru@github:bryphe/lru:lru.opam#2708c70@d41d8cd9")
        ("@opam/dune-configurator@opam:2.5.1@aeb9d8d5")
        ("@opam/dune@opam:2.5.0@e0bac278")
        ("@opam/ctypes@opam:0.15.1@9c7ab4ec")
        ("@opam/charInfo_width@opam:1.1.0@4296bdfe")
        ("@opam/bos@opam:0.2.0@df49e63f")
        ("@esy-ocaml/reason@3.6.2@d41d8cd9")
        ("@brisk/brisk-reconciler@github:briskml/brisk-reconciler#10cab2d@d41d8cd9")
      ];
      src = pkgs.fetchFromGitHub {
        owner = "revery-ui";
        repo = "revery";
        rev = "931f3d0";
        sha256 = "0dxmfb9hm33myy1qpi3m1r9ra903lyzlvjbbl6sf65bc770rg3cb";
      };
      build = {
        buildPhase = "dune build -p reason-harfbuzz,reason-skia,reason-sdl2,Revery";
        installPhase = ''
          esy-installer reason-harfbuzz.install
          esy-installer reason-skia.install
          esy-installer reason-sdl2.install
          esy-installer Revery.install
          bash -c "${if final.os == "windows" then "cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/*.dll '$cur__bin'" else ":"}"
          bash -c "cp ${(final.getDrv "esy-skia@github:revery-ui/esy-skia#91c98f6@d41d8cd9")}/bin/skia.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-sdl2@2.0.10008@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-angle-prebuilt@1.0.0@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
        '';
        mode = "esy";
      };
    };
    "shelljs@0.8.4@d41d8cd9" = {
      pname = "shelljs";
      version = "0.8.4";
      depKeys = [
        ("rechoir@0.6.2@d41d8cd9")
        ("interpret@1.4.0@d41d8cd9")
        ("glob@7.1.6@d41d8cd9")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/shelljs/-/shelljs-0.8.4.tgz";
        sha256 = "1jara581y1dm9s8h34jwwq1j5d17civks77y97vwrcjshwd3shsy";
      };
      build = {
        mode = "esy";
      };
    };
    "texinfo@github:esy-packages/esy-texinfo#4a05feafbbcc4c57d5d25899fbdab98961b9a69c@d41d8cd9" = {
      pname = "texinfo";
      version = "6.6.000";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "esy-packages";
        repo = "esy-texinfo";
        rev = "4a05feafbbcc4c57d5d25899fbdab98961b9a69c";
        sha256 = "0mcfcna4xf5b0wwnpz5cn4zr8il1m1p2nz0v71781ik3dslya4bm";
      };
      build = {
        buildPhase = ''
          find ./ -exec touch -t 200905010101 {} +
          chmod 755 ./configure
          bash -c "${if final.os == "windows" then "./configure --prefix=$cur__install --host x86_64-w64-mingw32 --disable-dependency-tracking" else "./configure --prefix=$cur__install --disable-dependency-tracking"}"
          make
          make install
        '';
        mode = "esy";
      };
      opamName = "esy-texinfo";
    };
    "universalify@0.1.2@d41d8cd9" = {
      pname = "universalify";
      version = "0.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/universalify/-/universalify-0.1.2.tgz";
        sha256 = "0lykbpkmvjkjg0sqngrn086rxlyddgjkfnsi22r8hgixxzxb2alc";
      };
      build = {
        mode = "esy";
      };
    };
    "wrappy@1.0.2@d41d8cd9" = {
      pname = "wrappy";
      version = "1.0.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha256 = "1yzx63jf27yz0bk0m78vy4y1cqzm113d2mi9h91y3cdpj46p7wxg";
      };
      build = {
        mode = "esy";
      };
    };
    "xmlbuilder@9.0.7@d41d8cd9" = {
      pname = "xmlbuilder";
      version = "9.0.7";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/xmlbuilder/-/xmlbuilder-9.0.7.tgz";
        sha256 = "1jl1yb1jk38zn095x3nzg6d5fma3a8wij9zacrb0ajylfy2h2msa";
      };
      build = {
        mode = "esy";
      };
    };
    "xmldom@0.1.31@d41d8cd9" = {
      pname = "xmldom";
      version = "0.1.31";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/xmldom/-/xmldom-0.1.31.tgz";
        sha256 = "175myf315618n5v77i5q4lgbrjxqshddiy8vmica7ygs8gm6f6ik";
      };
      build = {
        mode = "esy";
      };
    };
    "yarn-pkg-config@github:esy-ocaml/yarn-pkg-config#db3a0b63883606dd57c54a7158d560d6cba8cd79@d41d8cd9" = {
      pname = "yarn-pkg-config";
      version = "0.29.5";
      depKeys = [
      ];
      src = pkgs.fetchFromGitHub {
        owner = "esy-ocaml";
        repo = "yarn-pkg-config";
        rev = "db3a0b63883606dd57c54a7158d560d6cba8cd79";
        sha256 = "1d6qiljpnaq5iz5srsjniw0kfx6jsk06zhqj19f0fqm3vhys5ij9";
      };
      build = {
        buildPhase = ''
          find ./ -exec touch -t 200905010101 {} +
          bash -c "./configure --with-internal-glib --prefix $cur__install ${if final.os == "windows" then "--host x86_64-w64-mingw32" else ""}"
          make
          make install
        '';
        mode = "esy";
      };
    };
  };
}