final:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "esy";
    version = "1";
    root = "Oni2@link-dev:./package.json";
  };
  specs = {
    "@brisk/brisk-reconciler@github:briskml/brisk-reconciler#c9d5c4c@d41d8cd9" = {
      pname = "brisk-brisk-reconciler";
      version = "1.0.0-alpha.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-AAB4ZzBnwfwFXOAqX/sIT6imOl70F0YNMt96SWOOE9w=";
        owner = "briskml";
        repo = "brisk-reconciler";
        rev = "c9d5c4c";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-0iOzuec+FO8vJB3cUi+jMPlLhgI=";
        url = "https://registry.npmjs.org/@esy-cross/ninja-build/-/ninja-build-1.8.2001.tgz";
      });
      build = {
        buildPhase = "make install";
        installPhase = "";
        mode = "esy";
      };
      opamName = "ninja-build";
    };
    "@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9" = {
      pname = "esy-ocaml-reason";
      version = "3.7.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/merlin-extend@opam:0.6@88755c91")
        ("@opam/menhir@opam:20210419@11c42419")
        ("@opam/fix@opam:20201120@0b212fb9")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-xZjSSbCA8J/I9DCONxOfO/OiwV11wuoIvXCsNR04acw=";
        owner = "EduardoRFS";
        repo = "reason";
        rev = "35aa4df3de0daa60bdc1133dcf97855decac48f7";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-Wevbuu3NoSP8ftj7KzArfYGemkY=";
        url = "https://registry.npmjs.org/@esy-ocaml/substs/-/substs-0.0.1.tgz";
      });
      build = {
        buildPhase = "cp ./substs $cur__bin/substs";
        mode = "esy";
      };
      opamName = "substs";
    };
    "@onivim/reason-native-crash-utils@1.0.2@d41d8cd9" = {
      pname = "onivim-reason-native-crash-utils";
      version = "1.0.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-7KXyrvnoFkt9ltjzPN8WbcZXcNo=";
        url = "https://registry.npmjs.org/@onivim/reason-native-crash-utils/-/reason-native-crash-utils-1.0.2.tgz";
      });
      build = {
        buildPhase = "dune build -p reason-native-crash-utils";
        mode = "esy";
      };
      opamName = "reason-native-crash-utils";
    };
    "@opam/angstrom@opam:0.15.0@105656d9" = {
      pname = "angstrom";
      version = "0.15.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ocaml-syntax-shims@opam:1.0.0@9f361fbb")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/bigstringaf@opam:0.7.0@152be977")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-UQR2jEBOqS/QpTpbD3XNUA==";
        url = "https://github.com/inhabitedtype/angstrom/archive/0.15.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p angstrom -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/astring@opam:0.8.5@1300cee8" = {
      pname = "astring";
      version = "0.8.5";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-4UiQfCQVfR30O+yJtYs+yA==";
        url = "https://erratique.ch/software/astring/releases/astring-0.8.5.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false";
        installPhase = "";
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
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/base-bytes@opam:base@19d0c2ff" = {
      pname = "base-bytes";
      version = "base";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        buildPhase = "";
        installPhase = "";
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
        buildPhase = "";
        installPhase = "";
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
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/base@opam:v0.14.1@9b424fee" = {
      pname = "base";
      version = "v0.14.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/sexplib0@opam:v0.14.0@155c136c")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-5EGermD1flU7FUhW8MrPQg==";
        url = "https://github.com/janestreet/base/archive/v0.14.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p base -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/bigarray-compat@opam:1.0.0@951830c6" = {
      pname = "bigarray-compat";
      version = "1.0.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-HMfCU4KokAuto0qt/WZjLg==";
        url = "https://github.com/mirage/bigarray-compat/archive/v1.0.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p bigarray-compat -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/bigstringaf@opam:0.7.0@152be977" = {
      pname = "bigstringaf";
      version = "0.7.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/conf-pkg-config@opam:2@de102891")
        ("@opam/bigarray-compat@opam:1.0.0@951830c6")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-PkdZMgC3f6bdJ1TTfpy+GQ==";
        url = "https://github.com/inhabitedtype/bigstringaf/archive/0.7.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p bigstringaf -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/biniou@opam:1.2.1@420bda02" = {
      pname = "biniou";
      version = "1.2.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/easy-format@opam:1.3.2@1ea9f987")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-NVRsaLGSmo5tJ6Ozns0Xs4MDoNR+ZeudFIDCBh6oQzU=";
        url = "https://github.com/mjambon/biniou/releases/download/1.2.1/biniou-1.2.1.tbz";
      });
      build = {
        buildPhase = "dune build -p biniou -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/bos@opam:0.2.0@8000d437" = {
      pname = "bos";
      version = "0.2.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/rresult@opam:0.6.0@4b185e72")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/logs@opam:0.7.0@1d03143e")
        ("@opam/fpath@opam:0.7.3@674d8125")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/astring@opam:0.8.5@1300cee8")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-rq50R1Z9tFnIVu5BtaZv0g==";
        url = "http://erratique.ch/software/bos/releases/bos-0.2.0.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/camomile@opam:1.0.2@4c270e23" = {
      pname = "camomile";
      version = "1.0.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-8KQZsK/8NlAPg7CG/6o2xUVWDO5dV+hLcp6PhRs9FjI=";
        url = "https://github.com/yoriyuki/Camomile/releases/download/1.0.2/camomile-1.0.2.tbz";
      });
      build = {
        buildPhase = ''
          ocaml configure.ml --share $out/share/camomile
          dune build -p camomile -j $NIX_BUILD_CORES @install
        '';
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/charInfo_width@opam:1.1.0@4296bdfe" = {
      pname = "charInfo_width";
      version = "1.1.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/camomile@opam:1.0.2@4c270e23")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-pTlDbR2krrk3ETA/EHvsfg==";
        url = "https://github.com/kandu/charInfo_width/archive/1.1.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p charInfo_width -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/conf-pkg-config@opam:2@de102891" = {
      pname = "conf-pkg-config";
      version = "2";
      depKeys = [
        ("yarn-pkg-config@github:esy-ocaml/yarn-pkg-config#db3a0b63883606dd57c54a7158d560d6cba8cd79@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        buildPhase = "pkg-config --help";
        depexts = [
          (pkgs.pkgconfig)
        ];
        installPhase = "mkdir -p \"${(final.siteLib "$out")}/pkgconfig\"";
        mode = "opam";
      };
    };
    "@opam/cppo@opam:1.6.7@57a6d52c" = {
      pname = "cppo";
      version = "1.6.7";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-21U+PmwgbfCbGFjDrvXiHlZWTVk2QqPHi87bavNvUp0=";
        url = "https://github.com/ocaml-community/cppo/releases/download/v1.6.7/cppo-v1.6.7.tbz";
      });
      build = {
        buildPhase = "dune build -p cppo -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/csexp@opam:1.5.1@8a8fb3a7" = {
      pname = "csexp";
      version = "1.5.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1gXkBl+pCliABEDvLzOi2TE5i/LCIGGorLffhFwKrAI=";
        url = "https://github.com/ocaml-dune/csexp/releases/download/1.5.1/csexp-1.5.1.tbz";
      });
      build = {
        buildPhase = "dune build -p csexp -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ctypes@opam:0.15.1@9c7ab4ec" = {
      pname = "ctypes";
      version = "0.15.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/integers@opam:0.4.0@76f68c9d")
        ("@opam/conf-pkg-config@opam:2@de102891")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-6HsmRvdZfgC4uaH1+ONu5g==";
        url = "https://github.com/ocamllabs/ocaml-ctypes/archive/0.15.1.tar.gz";
      });
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
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/decoders@opam:0.6.0@87322047")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GOu9mJAd/2fJlE1GXtUI3wGMjujhO/4DfVrXgFhO6/c=";
        url = "https://github.com/mattjbray/ocaml-decoders/releases/download/v0.4.0/decoders-v0.4.0.tbz";
      });
      build = {
        buildPhase = "dune build -p decoders-yojson -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/decoders@opam:0.6.0@87322047" = {
      pname = "decoders";
      version = "0.6.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5+PUNoXgGqv4woXCKKO+6dYB/v9PoGX+F3hg8W877Z4=";
        url = "https://github.com/mattjbray/ocaml-decoders/releases/download/v0.6.0/decoders-v0.6.0.tbz";
      });
      build = {
        buildPhase = "dune build -p decoders -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/dir@github:bryphe/reason-native:dir.opam#e16590c@d41d8cd9" = {
      pname = "dir";
      version = "github-bryphe-reason-native-dir.opam-e16590c";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/fp@github:bryphe/reason-native:fp.opam#e16590c@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-FB3pM59fUA55odNMOR8NlixoN/GqmLfy24/dSZ2lBXU=";
        owner = "bryphe";
        repo = "reason-native";
        rev = "e16590c";
      });
      build = {
        buildPhase = "dune build -p dir";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/dot-merlin-reader@opam:4.1@84436e1c" = {
      pname = "dot-merlin-reader";
      version = "4.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/csexp@opam:1.5.1@8a8fb3a7")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FKNtb7hkal30UwQgp4YXIvGk7gR1NxeUcwXjZ2Ax580=";
        url = "https://github.com/ocaml/merlin/releases/download/v4.1/dot-merlin-reader-v4.1.tbz";
      });
      build = {
        buildPhase = "dune build -p dot-merlin-reader -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/dune-build-info@opam:2.8.5@e0f9f654" = {
      pname = "dune-build-info";
      version = "2.8.5";
      depKeys = [
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-eQESg/t0x6J+sXrXUu+8w5s5Yzy6zI176X6OqGlENik=";
        url = "https://github.com/ocaml/dune/releases/download/2.8.5/dune-2.8.5.tbz";
      });
      build = {
        buildPhase = "dune build -p dune-build-info -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/dune-configurator@opam:2.5.1@5f41e4d9" = {
      pname = "dune-configurator";
      version = "2.5.1";
      depKeys = [
        ("@opam/dune-private-libs@opam:2.5.1@193344cb")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-j3fTqH8gjg18zKocSMS7G7h9YtB8PyXpuLopjgKM5Ss=";
        url = "https://github.com/ocaml/dune/releases/download/2.5.1/dune-2.5.1.tbz";
      });
      build = {
        buildPhase = "dune build -p dune-configurator -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/dune-private-libs@opam:2.5.1@193344cb" = {
      pname = "dune-private-libs";
      version = "2.5.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-j3fTqH8gjg18zKocSMS7G7h9YtB8PyXpuLopjgKM5Ss=";
        url = "https://github.com/ocaml/dune/releases/download/2.5.1/dune-2.5.1.tbz";
      });
      build = {
        buildPhase = "dune build -p dune-private-libs -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/dune@opam:2.8.5@01003f12" = {
      pname = "dune";
      version = "2.8.5";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/base-threads@opam:base@36803084")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-eQESg/t0x6J+sXrXUu+8w5s5Yzy6zI176X6OqGlENik=";
        url = "https://github.com/ocaml/dune/releases/download/2.8.5/dune-2.8.5.tbz";
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
    "@opam/easy-format@opam:1.3.2@1ea9f987" = {
      pname = "easy-format";
      version = "1.3.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-NEDCuILVN65ekBHrBqu1P1Zn5lHqS7O0YOqCMPqMGSY=";
        url = "https://github.com/mjambon/easy-format/releases/download/1.3.2/easy-format-1.3.2.tbz";
      });
      build = {
        buildPhase = "dune build -p easy-format -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/fix@opam:20201120@0b212fb9" = {
      pname = "fix";
      version = "20201120";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-frVwt1ljX+ZvNVbSscyI4w==";
        url = "https://gitlab.inria.fr/fpottier/fix/-/archive/20201120/archive.tar.gz";
      });
      build = {
        buildPhase = "dune build -p fix -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/fmt@opam:0.8.9@e0843a5b" = {
      pname = "fmt";
      version = "0.8.9";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/stdlib-shims@opam:0.3.0@0d088929")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-QAG1HN6Q6k/ZmkpQM+z0EQ==";
        url = "https://erratique.ch/software/fmt/releases/fmt-0.8.9.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false --with-base-unix true --with-cmdliner false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/fp@github:bryphe/reason-native:fp.opam#e16590c@d41d8cd9" = {
      pname = "fp";
      version = "github-bryphe-reason-native-fp.opam-e16590c";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-FB3pM59fUA55odNMOR8NlixoN/GqmLfy24/dSZ2lBXU=";
        owner = "bryphe";
        repo = "reason-native";
        rev = "e16590c";
      });
      build = {
        buildPhase = "dune build -p fp";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/fpath@opam:0.7.3@674d8125" = {
      pname = "fpath";
      version = "0.7.3";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/astring@opam:0.8.5@1300cee8")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-B0C1MOj+1bCtxe7oRjz8Lw==";
        url = "https://erratique.ch/software/fpath/releases/fpath-0.7.3.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/fs@github:bryphe/reason-native:fs.opam#e16590c@d41d8cd9" = {
      pname = "fs";
      version = "github-bryphe-reason-native-fs.opam-e16590c";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/fp@github:bryphe/reason-native:fp.opam#e16590c@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-FB3pM59fUA55odNMOR8NlixoN/GqmLfy24/dSZ2lBXU=";
        owner = "bryphe";
        repo = "reason-native";
        rev = "e16590c";
      });
      build = {
        buildPhase = "dune build -p fs";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/integers@opam:0.4.0@76f68c9d" = {
      pname = "integers";
      version = "0.4.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-wUkjUuZSUEh5BQjFeq2Tww==";
        url = "https://github.com/ocamllabs/ocaml-integers/archive/0.4.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p integers -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/jane-street-headers@opam:v0.14.0@b38e12bf" = {
      pname = "jane-street-headers";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-6NJTrETSXIxmNnFToMd0lQ==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/jane-street-headers-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p jane-street-headers -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/jst-config@opam:v0.14.0@d33e0e2a" = {
      pname = "jst-config";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/stdio@opam:v0.14.0@a5affb43")
        ("@opam/ppx_assert@opam:v0.14.0@f5d6cf6a")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-7vusEEpZv5DIKZLMn7SH1Q==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/jst-config-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p jst-config -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/junit@opam:2.0.2@f4bd0016" = {
      pname = "junit";
      version = "2.0.2";
      depKeys = [
        ("@opam/tyxml@opam:4.5.0@4676c9e9")
        ("@opam/ptime@opam:0.8.5@0051d642")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-/alBtlNhOkpXMfmzVXNksSuqNB2qE8AWdsnrjWTpawE=";
        url = "https://github.com/Khady/ocaml-junit/releases/download/2.0.2/junit-2.0.2.tbz";
      });
      build = {
        buildPhase = "dune build -p junit -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/logs@opam:0.7.0@1d03143e" = {
      pname = "logs";
      version = "0.7.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/lwt@opam:5.4.1@37ffbe37")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/base-threads@opam:base@36803084")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-K/AhyhMzF3XjPPNKtgJG9w==";
        url = "https://erratique.ch/software/logs/releases/logs-0.7.0.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-js_of_ocaml false --with-fmt true --with-cmdliner false --with-lwt true --with-base-threads true";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/lru@github:bryphe/lru:lru.opam#2708c70@d41d8cd9" = {
      pname = "lru";
      version = "github-bryphe-lru-lru.opam-2708c70";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/psq@opam:0.2.0@e2fd474c")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-F3ehcd3yJ76UsRW+Uo6vTj07Eb5OGi7sghGIa/cf37U=";
        owner = "bryphe";
        repo = "lru";
        rev = "2708c70";
      });
      build = {
        buildPhase = "dune build -p lru -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/luv@github:bryphe/luv:luv.opam#8e9f2b0@d41d8cd9" = {
      pname = "luv";
      version = "github-bryphe-luv-luv.opam-8e9f2b0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/ctypes@opam:0.15.1@9c7ab4ec")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        fetchSubmodules = true;
        hash = "sha256-Q8CyrRHCTRdL7TvMkedOo0qrWAOZLhhJbJYqFyRtweI=";
        owner = "bryphe";
        repo = "luv";
        rev = "8e9f2b0";
      });
      build = {
        buildPhase = "dune build -p luv -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/lwt@opam:5.4.1@37ffbe37" = {
      pname = "lwt";
      version = "5.4.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ocplib-endian@opam:1.1@84c1ca88")
        ("@opam/ocaml-syntax-shims@opam:1.0.0@9f361fbb")
        ("@opam/mmap@opam:1.1.0@b85334ff")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@opam/base-unix@opam:base@87d0b2eb")
        ("@opam/base-threads@opam:base@36803084")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-Wo0qg+6TFHgfE30Uekxirg==";
        url = "https://github.com/ocsigen/lwt/archive/refs/tags/5.4.1.tar.gz";
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
    "@opam/lwt_ppx@opam:2.0.1@edf5ad68" = {
      pname = "lwt_ppx";
      version = "2.0.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppx_tools_versioned@opam:5.4.0@71229b42")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@caf9847c")
        ("@opam/lwt@opam:5.4.1@37ffbe37")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-1Xg/z/T7+n95yTA3duTRRA==";
        url = "https://github.com/ocsigen/lwt/archive/5.2.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p lwt_ppx -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/markup@opam:0.8.2@53ccafce" = {
      pname = "markup";
      version = "0.8.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uchar@opam:0.0.2@c8218eea")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-D+azoE2UHKQKXv3QgvEYPQ==";
        url = "https://github.com/aantron/markup.ml/archive/0.8.2.tar.gz";
      });
      build = {
        buildPhase = "dune build -p markup -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/menhir@opam:20210419@11c42419" = {
      pname = "menhir";
      version = "20210419";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/menhirSdk@opam:20210419@9c7661a4")
        ("@opam/menhirLib@opam:20210419@0b3db8d0")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-GvLRN+sggRx0ylFlABZP1A==";
        url = "https://gitlab.inria.fr/fpottier/menhir/-/archive/20210419/archive.tar.gz";
      });
      build = {
        buildPhase = "dune build -p menhir -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/menhirLib@opam:20210419@0b3db8d0" = {
      pname = "menhirLib";
      version = "20210419";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-GvLRN+sggRx0ylFlABZP1A==";
        url = "https://gitlab.inria.fr/fpottier/menhir/-/archive/20210419/archive.tar.gz";
      });
      build = {
        buildPhase = "dune build -p menhirLib -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/menhirSdk@opam:20210419@9c7661a4" = {
      pname = "menhirSdk";
      version = "20210419";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-GvLRN+sggRx0ylFlABZP1A==";
        url = "https://gitlab.inria.fr/fpottier/menhir/-/archive/20210419/archive.tar.gz";
      });
      build = {
        buildPhase = "dune build -p menhirSdk -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/merlin-extend@opam:0.6@88755c91" = {
      pname = "merlin-extend";
      version = "0.6";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-wvI2rpf+troLyQ8zvre3ND5C+YcbZt6boHl0kX4lbEM=";
        url = "https://github.com/let-def/merlin-extend/releases/download/v0.6/merlin-extend-v0.6.tbz";
      });
      build = {
        buildPhase = "dune build -p merlin-extend -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/mmap@opam:1.1.0@b85334ff" = {
      pname = "mmap";
      version = "1.1.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-jF1fvFNyltxSWGdTX7h4ug==";
        url = "https://github.com/mirage/mmap/releases/download/v1.1.0/mmap-v1.1.0.tbz";
      });
      build = {
        buildPhase = "dune build -p mmap -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ocaml-compiler-libs@opam:v0.12.3@316a19dc" = {
      pname = "ocaml-compiler-libs";
      version = "v0.12.3";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-qEA1MUOcFLvaLVBO+TYQ/Smo6VIPxwDyGInYk6UT48k=";
        url = "https://github.com/janestreet/ocaml-compiler-libs/releases/download/v0.12.3/ocaml-compiler-libs-v0.12.3.tbz";
      });
      build = {
        buildPhase = "dune build -p ocaml-compiler-libs -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ocaml-lsp-server@github:ocaml/ocaml-lsp:ocaml-lsp-server.opam#d5ba8b9@d41d8cd9" = {
      pname = "ocaml-lsp-server";
      version = "github-ocaml-ocaml-lsp-ocaml-lsp-server.opam-d5ba8b9";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ppx_yojson_conv_lib@opam:v0.14.0@605a6997")
        ("@opam/pp@opam:1.1.2@89ad03b5")
        ("@opam/dune-build-info@opam:2.8.5@e0f9f654")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/dot-merlin-reader@opam:4.1@84436e1c")
        ("@opam/csexp@opam:1.5.1@8a8fb3a7")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        fetchSubmodules = true;
        hash = "sha256-EsZwPomlojXVbGG1JDnR06OrxWsVGr2KWvFyH1RcJbc=";
        owner = "ocaml";
        repo = "ocaml-lsp";
        rev = "d5ba8b9";
      });
      build = {
        buildPhase = "dune build -j $NIX_BUILD_CORES ocaml-lsp-server.install --release";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ocaml-migrate-parsetree@opam:1.8.0@caf9847c" = {
      pname = "ocaml-migrate-parsetree";
      version = "1.8.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-scLRdv8URAQfJ3V4a6YFvnluRt/SrLBslvNdK7iLj7U=";
        url = "https://github.com/ocaml-ppx/ocaml-migrate-parsetree/releases/download/v1.8.0/ocaml-migrate-parsetree-v1.8.0.tbz";
      });
      build = {
        buildPhase = "dune build -p ocaml-migrate-parsetree -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ocaml-syntax-shims@opam:1.0.0@9f361fbb" = {
      pname = "ocaml-syntax-shims";
      version = "1.0.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ibLhk+kKDBaLbsXd9v7wkDNoG9y2ThGRPJdECici6Mg=";
        url = "https://github.com/ocaml-ppx/ocaml-syntax-shims/releases/download/1.0.0/ocaml-syntax-shims-1.0.0.tbz";
      });
      build = {
        buildPhase = "dune build -p ocaml-syntax-shims -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ocamlbuild@opam:0.14.0@6ac75d03" = {
      pname = "ocamlbuild";
      version = "0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-h7Kc6WlYCWwKGo7q/rYmgHey0R4b8rPeD168nPjULng=";
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
    "@opam/ocamlfind@opam:1.9.1@b748edf6" = {
      pname = "ocamlfind";
      version = "1.9.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-ZebcmzBcy+0SZydf4YD1OA==";
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
    "@opam/ocplib-endian@opam:1.1@84c1ca88" = {
      pname = "ocplib-endian";
      version = "1.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-3t9NacG4ezxscjT2MjmShQ==";
        url = "https://github.com/OCamlPro/ocplib-endian/archive/1.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ocplib-endian -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/octavius@opam:1.2.2@2205cc65" = {
      pname = "octavius";
      version = "1.2.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-cvnh2ZbmxQifxRPMkhhgew==";
        url = "https://github.com/ocaml-doc/octavius/archive/v1.2.2.tar.gz";
      });
      build = {
        buildPhase = "dune build -p octavius -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/omd@github:ocaml/omd:omd.opam#1535e3c@d41d8cd9" = {
      pname = "omd";
      version = "github-ocaml-omd-omd.opam-1535e3c";
      depKeys = [
        ("@opam/uchar@opam:0.0.2@c8218eea")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@opam/base-bigarray@opam:base@b03491b0")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-Tu60WdHvVq24m6QMJTe3B55gfNjtoxomW/Q3MT6//n4=";
        owner = "ocaml";
        repo = "omd";
        rev = "1535e3c";
      });
      build = {
        buildPhase = "dune build -p omd -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/pp@opam:1.1.2@89ad03b5" = {
      pname = "pp";
      version = "1.1.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5KTpjZaxu3aVD81tpOk4yG2YnfTX5I8C96RFlfWvHVY=";
        url = "https://github.com/ocaml-dune/pp/releases/download/1.1.2/pp-1.1.2.tbz";
      });
      build = {
        buildPhase = "dune build -p pp -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_assert@opam:v0.14.0@f5d6cf6a" = {
      pname = "ppx_assert";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/ppx_sexp_conv@opam:v0.14.1@0c0aebbb")
        ("@opam/ppx_here@opam:v0.14.0@c05577d4")
        ("@opam/ppx_compare@opam:v0.14.0@fbd22977")
        ("@opam/ppx_cold@opam:v0.14.0@91b05a20")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-U1tfJB638Q2owETCavvBhg==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_assert-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_assert -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_base@opam:v0.14.0@3221121a" = {
      pname = "ppx_base";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/ppx_sexp_conv@opam:v0.14.1@0c0aebbb")
        ("@opam/ppx_js_style@opam:v0.14.1@03f2d62f")
        ("@opam/ppx_hash@opam:v0.14.0@455f5f56")
        ("@opam/ppx_enumerate@opam:v0.14.0@2be34197")
        ("@opam/ppx_compare@opam:v0.14.0@fbd22977")
        ("@opam/ppx_cold@opam:v0.14.0@91b05a20")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-spokkH5g9C4FCtkOUgm7kg==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_base-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_base -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_cold@opam:v0.14.0@91b05a20" = {
      pname = "ppx_cold";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-amGAfNOxBbjIhb0gdphjOQ==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_cold-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_cold -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_compare@opam:v0.14.0@fbd22977" = {
      pname = "ppx_compare";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-kUmzoMlU/izvKwcF0lS54w==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_compare-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_compare -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_derivers@opam:1.2.1@ecf0aa45" = {
      pname = "ppx_derivers";
      version = "1.2.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-XcK/Ewwds8cx/g//xWSLQQ==";
        url = "https://github.com/ocaml-ppx/ppx_derivers/archive/1.2.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_derivers -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_deriving@opam:4.5@99c603e5" = {
      pname = "ppx_deriving";
      version = "4.5";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ppxfind@opam:1.4@eb33d73c")
        ("@opam/ppx_tools@opam:6.3@e259a756")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@caf9847c")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-95FTxSMboeA6NJH96VyoLsti/gW2CmSaN00vvF6l3ZJCEm3n376RfCL9cHfAJslA4YxrNsXODsS7bgfxHStxCw==";
        url = "https://github.com/ocaml-ppx/ppx_deriving/archive/v4.5.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_deriving -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_deriving_yojson@opam:3.5.3@253e094d" = {
      pname = "ppx_deriving_yojson";
      version = "3.5.3";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ppxfind@opam:1.4@eb33d73c")
        ("@opam/ppx_tools@opam:6.3@e259a756")
        ("@opam/ppx_deriving@opam:4.5@99c603e5")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-5RheSsnRSaMyVmE531XUCA==";
        url = "https://github.com/ocaml-ppx/ppx_deriving_yojson/archive/v3.5.3.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_deriving_yojson -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_enumerate@opam:v0.14.0@2be34197" = {
      pname = "ppx_enumerate";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-GIQhr5YHWfbkXddI9PCOjQ==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_enumerate-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_enumerate -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_hash@opam:v0.14.0@455f5f56" = {
      pname = "ppx_hash";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/ppx_sexp_conv@opam:v0.14.1@0c0aebbb")
        ("@opam/ppx_compare@opam:v0.14.0@fbd22977")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-t4ruGbtEaXMfliawT+fzQQ==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_hash-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_hash -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_here@opam:v0.14.0@c05577d4" = {
      pname = "ppx_here";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-uzu94JZKH4Zt4J899E3vTQ==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_here-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_here -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_inline_test@opam:v0.14.1@8b68b6f7" = {
      pname = "ppx_inline_test";
      version = "v0.14.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/time_now@opam:v0.14.0@54e3342e")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-EydU8HVxiMO3AKLFtqL7Pw==";
        url = "https://github.com/janestreet/ppx_inline_test/archive/v0.14.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_inline_test -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_js_style@opam:v0.14.1@03f2d62f" = {
      pname = "ppx_js_style";
      version = "v0.14.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/octavius@opam:1.2.2@2205cc65")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-LXmvpPlUrq+4G2Ts/BHD+w==";
        url = "https://github.com/janestreet/ppx_js_style/archive/refs/tags/v0.14.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_js_style -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_let@opam:v0.14.0@69852938" = {
      pname = "ppx_let";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-+vW0tp7yWVkW90//JRqdLA==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_let-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_let -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_optcomp@opam:v0.14.0@27dab73f" = {
      pname = "ppx_optcomp";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/stdio@opam:v0.14.0@a5affb43")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-cV+7AAWU1Q+zaJ2inGsKsA==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_optcomp-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_optcomp -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_sexp_conv@opam:v0.14.1@0c0aebbb" = {
      pname = "ppx_sexp_conv";
      version = "v0.14.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/sexplib0@opam:v0.14.0@155c136c")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-Q42My77ttalRftVai5p2jg==";
        url = "https://github.com/janestreet/ppx_sexp_conv/archive/v0.14.1.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_sexp_conv -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_tools@opam:6.3@e259a756" = {
      pname = "ppx_tools";
      version = "6.3";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-9vN/9//aSGBvo86xdWrY9zEuPKHxLowTSWhvRopiH1g=";
        url = "https://github.com/ocaml-ppx/ppx_tools/releases/download/6.3/ppx_tools-6.3.tbz";
      });
      build = {
        buildPhase = "dune build -p ppx_tools -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_tools_versioned@opam:5.4.0@71229b42" = {
      pname = "ppx_tools_versioned";
      version = "5.4.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@caf9847c")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-PoCaEcrpn1fAUdPQEAMR9g==";
        url = "https://github.com/ocaml-ppx/ppx_tools_versioned/archive/5.4.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_tools_versioned -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppx_yojson_conv_lib@opam:v0.14.0@605a6997" = {
      pname = "ppx_yojson_conv_lib";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-4jxVk6chGtT7CeJumnRpig==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/ppx_yojson_conv_lib-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p ppx_yojson_conv_lib -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppxfind@opam:1.4@eb33d73c" = {
      pname = "ppxfind";
      version = "1.4";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@caf9847c")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-mCkcafBPf3t82tG114bHD8WVVZ1GY8wEy3EawTLbSXE=";
        url = "https://github.com/jeremiedimino/ppxfind/releases/download/1.4/ppxfind-1.4.tbz";
      });
      build = {
        buildPhase = "dune build -p ppxfind -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ppxlib@opam:0.15.0@bab450db" = {
      pname = "ppxlib";
      version = "0.15.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/stdlib-shims@opam:0.3.0@0d088929")
        ("@opam/sexplib0@opam:v0.14.0@155c136c")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocaml-migrate-parsetree@opam:1.8.0@caf9847c")
        ("@opam/ocaml-compiler-libs@opam:v0.12.3@316a19dc")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-C2MNf410qJmlXMJxiLXOA+c1qT8H6gwt5WUy2P2TszA=";
        url = "https://github.com/ocaml-ppx/ppxlib/releases/download/0.15.0/ppxlib-0.15.0.tbz";
      });
      build = {
        buildPhase = "dune build -p ppxlib -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/printbox@opam:0.5@82f5d436" = {
      pname = "printbox";
      version = "0.5";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@647d53e6")
        ("@opam/tyxml@opam:4.5.0@4676c9e9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base-bytes@opam:base@19d0c2ff")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-LNGLYZjVjCfRu+xNGINjUw==";
        url = "https://github.com/c-cube/printbox/archive/0.5.tar.gz";
      });
      build = {
        buildPhase = "dune build @install -p printbox -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/psq@opam:0.2.0@e2fd474c" = {
      pname = "psq";
      version = "0.2.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-uU+xX4h4Fyv1hEa30Pt8Hg==";
        url = "https://github.com/pqwy/psq/releases/download/v0.2.0/psq-v0.2.0.tbz";
      });
      build = {
        buildPhase = "dune build -p psq -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/ptime@opam:0.8.5@0051d642" = {
      pname = "ptime";
      version = "0.8.5";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-TUgFXWI+zy23kkObPpalIA==";
        url = "https://erratique.ch/software/ptime/releases/ptime-0.8.5.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-js_of_ocaml false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/re@opam:1.9.0@9373f267" = {
      pname = "re";
      version = "1.9.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-vdrtTzhqIsrOeFDJx9rClg==";
        url = "https://github.com/ocaml/ocaml-re/releases/download/1.9.0/re-1.9.0.tbz";
      });
      build = {
        buildPhase = "dune build -p re -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/reason@opam:3.7.0@494dd52d" = {
      pname = "reason";
      version = "3.7.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ppx_derivers@opam:1.2.1@ecf0aa45")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/merlin-extend@opam:0.6@88755c91")
        ("@opam/menhir@opam:20210419@11c42419")
        ("@opam/fix@opam:20201120@0b212fb9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-frjLv/hWW5Pr+r9OynJU1A==";
        url = "https://registry.npmjs.org/@esy-ocaml/reason/-/reason-3.7.0.tgz";
      });
      build = {
        buildPhase = "dune build -p reason -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/result@opam:1.5@1c6a6533" = {
      pname = "result";
      version = "1.5";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-G4Lex4hJaAtJrpqKNluDGw==";
        url = "https://github.com/janestreet/result/releases/download/1.5/result-1.5.tbz";
      });
      build = {
        buildPhase = "dune build -p result -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/rresult@opam:0.6.0@4b185e72" = {
      pname = "rresult";
      version = "0.6.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/result@opam:1.5@1c6a6533")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-q6iM/6KQgXFEaMLHvN9/sQ==";
        url = "http://erratique.ch/software/rresult/releases/rresult-0.6.0.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/semver2@opam:1.2.0@ced7107e" = {
      pname = "semver2";
      version = "1.2.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/angstrom@opam:0.15.0@105656d9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-ZXxRE9wLQfEeZZ+yTlzw+Q==";
        url = "https://github.com/dividat/ocaml-semver/archive/refs/tags/1.2.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p semver2 -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/seq@opam:base@d8d7de1d" = {
      pname = "seq";
      version = "base";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        buildPhase = "";
        installPhase = "";
        mode = "opam";
      };
      files = (final.subtree {
        base = final.rootAttrs.src;
        hash = "sha256-y6yBw57sJ19iuwBvvKgK30LdNVL/kYdHXQE+jYm0Vt0=";
        path = "esy.lock/opam/seq.base/files";
      });
    };
    "@opam/sexplib0@opam:v0.14.0@155c136c" = {
      pname = "sexplib0";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-N6/wr4+Pb3WSSUdWhK69xA==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/sexplib0-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p sexplib0 -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/stdio@opam:v0.14.0@a5affb43" = {
      pname = "stdio";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-TL3xXwvojDJYqu/54E4A6Q==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/stdio-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p stdio -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/stdlib-shims@opam:0.3.0@0d088929" = {
      pname = "stdlib-shims";
      version = "0.3.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ur9y05F7hvcHiF8MVSjjbGP8y2mPS0bPK6tcfM3W2Eo=";
        url = "https://github.com/ocaml/stdlib-shims/releases/download/0.3.0/stdlib-shims-0.3.0.tbz";
      });
      build = {
        buildPhase = "dune build -p stdlib-shims -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/time_now@opam:v0.14.0@54e3342e" = {
      pname = "time_now";
      version = "v0.14.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ppx_optcomp@opam:v0.14.0@27dab73f")
        ("@opam/ppx_base@opam:v0.14.0@3221121a")
        ("@opam/jst-config@opam:v0.14.0@d33e0e2a")
        ("@opam/jane-street-headers@opam:v0.14.0@b38e12bf")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/base@opam:v0.14.1@9b424fee")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-qTEWk4eDWH+Ln1FS3VQwNw==";
        url = "https://ocaml.janestreet.com/ocaml-core/v0.14/files/time_now-v0.14.0.tar.gz";
      });
      build = {
        buildPhase = "dune build -p time_now -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/topkg@opam:1.0.3@e4e10f1c" = {
      pname = "topkg";
      version = "1.0.3";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-4oX3opbXfufYMbqaa/s5bw==";
        url = "http://erratique.ch/software/topkg/releases/topkg-1.0.3.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pkg-name topkg --dev-pkg false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/tyxml@opam:4.5.0@4676c9e9" = {
      pname = "tyxml";
      version = "4.5.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/seq@opam:base@d8d7de1d")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-xprM71303YnTj2qguq0B6P2k6emLt9rWG+wUUsVxYGg=";
        url = "https://github.com/ocsigen/tyxml/releases/download/4.5.0/tyxml-4.5.0.tbz";
      });
      build = {
        buildPhase = "dune build -p tyxml -j $NIX_BUILD_CORES @install";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/uchar@opam:0.0.2@c8218eea" = {
      pname = "uchar";
      version = "0.0.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-ybosc40mTEIMZC97sc9KNg==";
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
    "@opam/uucp@opam:13.0.0@647d53e6" = {
      pname = "uucp";
      version = "13.0.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-B+cGJJ3bLQLw+imIBNPHOQ==";
        url = "https://erratique.ch/software/uucp/releases/uucp-13.0.0.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --dev-pkg false --with-uutf true --with-uunf false --with-cmdliner false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/uutf@opam:1.0.2@4440868f" = {
      pname = "uutf";
      version = "1.0.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/uchar@opam:0.0.2@c8218eea")
        ("@opam/topkg@opam:1.0.3@e4e10f1c")
        ("@opam/ocamlfind@opam:1.9.1@b748edf6")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "md5-p8VCQFo5YwxomoK9fvIpLA==";
        url = "http://erratique.ch/software/uutf/releases/uutf-1.0.2.tbz";
      });
      build = {
        buildPhase = "ocaml pkg/pkg.ml build --pinned false --with-cmdliner false";
        installPhase = "";
        mode = "opam";
      };
    };
    "@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9" = {
      pname = "yojson";
      version = "github-onivim-yojson-yojson.opam-f480aef";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/easy-format@opam:1.3.2@1ea9f987")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/cppo@opam:1.6.7@57a6d52c")
        ("@opam/biniou@opam:1.2.1@420bda02")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-I9OY+jmjWVEhiV2G789d/AVB0l5pr7WJdyFt+4cR2qc=";
        owner = "onivim";
        repo = "yojson";
        rev = "f480aef";
      });
      build = {
        buildPhase = "dune build -p yojson -j $NIX_BUILD_CORES";
        installPhase = "";
        mode = "opam";
      };
    };
    "@reason-native/cli@0.0.1-alpha@d41d8cd9" = {
      pname = "reason-native-cli";
      version = "0.0.1-alpha";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@reason-native/pastel@0.3.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-C5EQU/p8xmHqwQ6tUNbqbMH82U0=";
        url = "https://registry.npmjs.org/@reason-native/cli/-/cli-0.0.1-alpha.tgz";
      });
      build = {
        buildPhase = "dune build -p cli";
        mode = "esy";
      };
      opamName = "cli";
    };
    "@reason-native/file-context-printer@0.0.3@d41d8cd9" = {
      pname = "reason-native-file-context-printer";
      version = "0.0.3";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@reason-native/pastel@0.3.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-uS7sexAQfMsnUo+e6pu1ElK8pJE=";
        url = "https://registry.npmjs.org/@reason-native/file-context-printer/-/file-context-printer-0.0.3.tgz";
      });
      build = {
        buildPhase = "dune build -p file-context-printer";
        installPhase = "esy-installer file-context-printer.install";
        mode = "esy";
      };
      opamName = "file-context-printer";
    };
    "@reason-native/pastel@0.3.0@d41d8cd9" = {
      pname = "reason-native-pastel";
      version = "0.3.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-B9o8Wgkz5hvDs1O8hapxrHwPMRw=";
        url = "https://registry.npmjs.org/@reason-native/pastel/-/pastel-0.3.0.tgz";
      });
      build = {
        buildPhase = "dune build -p pastel";
        mode = "esy";
      };
      opamName = "pastel";
    };
    "@reason-native/rely@3.2.1@d41d8cd9" = {
      pname = "reason-native-rely";
      version = "3.2.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@reason-native/pastel@0.3.0@d41d8cd9")
        ("@reason-native/file-context-printer@0.0.3@d41d8cd9")
        ("@reason-native/cli@0.0.1-alpha@d41d8cd9")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/junit@opam:2.0.2@f4bd0016")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-eUWsalF3Ope4+M/ZfShVrHrE7LI=";
        url = "https://registry.npmjs.org/@reason-native/rely/-/rely-3.2.1.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-GdNUIbjsEcVFoWBx/CPFzrA6K8s=";
        url = "https://registry.npmjs.org/@revery/esy-cmake/-/esy-cmake-0.3.5001.tgz";
      });
      build = {
        buildPhase = ''
          bash -c "${if final.os == "windows" then "./build-windows.sh" else "./build.sh"}"
          ls -a $out/bin
        '';
        mode = "esy";
      };
      opamName = "esy-cmake";
    };
    "@revery/esy-harfbuzz@2.6.8002@d41d8cd9" = {
      pname = "revery-esy-harfbuzz";
      version = "2.6.8002";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-Hm0jyIg9n271FQ5UPhYuyDuQScs=";
        url = "https://registry.npmjs.org/@revery/esy-harfbuzz/-/esy-harfbuzz-2.6.8002.tgz";
      });
      build = {
        buildPhase = ''
          bash -c ./esy/prep.sh
          bash -c "${if final.os == "windows" then "./esy/configure-windows.sh" else "echo"}"
          bash -c "${if final.os == "darwin" then "./esy/configure-osx.sh" else "echo"}"
          bash -c "${if final.os == "linux" then "./esy/configure-linux.sh" else "echo"}"
          bash -c ./esy/build.sh
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
    "@revery/esy-libvterm@1.0.5@d41d8cd9" = {
      pname = "revery-esy-libvterm";
      version = "1.0.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-xE/ePnaNJ1aLkLcJg17oumeVxJ8=";
        url = "https://registry.npmjs.org/@revery/esy-libvterm/-/esy-libvterm-1.0.5.tgz";
      });
      build = {
        buildPhase = "bash -c \"${if final.os == "linux" then "CFLAGS=-fPIC" else ""} PREFIX=$cur__install ${if final.os == "windows" then "CC=x86_64-w64-mingw32-gcc" else "CC=gcc"} ${if final.os == "windows" then "AR=x86_64-w64-mingw32-ar" else "AR=ar"} make install\"";
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
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/logs@opam:0.7.0@1d03143e")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-NwUMIKnTOpAcVmiBUukWg9C/pTk=";
        url = "https://registry.npmjs.org/@revery/timber/-/timber-2.0.0.tgz";
      });
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
        ("revery@github:revery-ui/revery#dd10c87@d41d8cd9")
        ("rench@1.10.0@d41d8cd9")
        ("reason-native-crash-utils@github:onivim/reason-native-crash-utils#a80a9d9@d41d8cd9")
        ("reason-fzy@github:bryphe/reason-fzy#5a1daf4@d41d8cd9")
        ("ocaml@4.12.0@d41d8cd9")
        ("libvim@8.10869.89@d41d8cd9")
        ("isolinear@github:revery-ui/isolinear#049ad1e@d41d8cd9")
        ("esy-tree-sitter@1.4.1@d41d8cd9")
        ("esy-skia@github:revery-ui/esy-skia#1c81aac@d41d8cd9")
        ("esy-sdl2@2.0.14000@d41d8cd9")
        ("esy-oniguruma@github:onivim/esy-oniguruma#4698ce4@d41d8cd9")
        ("esy-macdylibbundler@0.4.5001@d41d8cd9")
        ("esy-angle-prebuilt@1.0.0@d41d8cd9")
        ("axios@0.19.2@d41d8cd9")
        ("@revery/timber@2.0.0@d41d8cd9")
        ("@revery/esy-libvterm@1.0.5@d41d8cd9")
        ("@opam/yojson@github:onivim/yojson:yojson.opam#f480aef@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@647d53e6")
        ("@opam/semver2@opam:1.2.0@ced7107e")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/re@opam:1.9.0@9373f267")
        ("@opam/ppxlib@opam:0.15.0@bab450db")
        ("@opam/ppx_optcomp@opam:v0.14.0@27dab73f")
        ("@opam/ppx_let@opam:v0.14.0@69852938")
        ("@opam/ppx_inline_test@opam:v0.14.1@8b68b6f7")
        ("@opam/ppx_deriving_yojson@opam:3.5.3@253e094d")
        ("@opam/ppx_deriving@opam:4.5@99c603e5")
        ("@opam/ocamlbuild@opam:0.14.0@6ac75d03")
        ("@opam/markup@opam:0.8.2@53ccafce")
        ("@opam/lwt@opam:5.4.1@37ffbe37")
        ("@opam/luv@github:bryphe/luv:luv.opam#8e9f2b0@d41d8cd9")
        ("@opam/lru@github:bryphe/lru:lru.opam#2708c70@d41d8cd9")
        ("@opam/logs@opam:0.7.0@1d03143e")
        ("@opam/fs@github:bryphe/reason-native:fs.opam#e16590c@d41d8cd9")
        ("@opam/fp@github:bryphe/reason-native:fp.opam#e16590c@d41d8cd9")
        ("@opam/fmt@opam:0.8.9@e0843a5b")
        ("@opam/dune-private-libs@opam:2.5.1@193344cb")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/dir@github:bryphe/reason-native:dir.opam#e16590c@d41d8cd9")
        ("@opam/decoders-yojson@opam:0.4.0@cb39dea6")
        ("@opam/charInfo_width@opam:1.1.0@4296bdfe")
        ("@opam/angstrom@opam:0.15.0@105656d9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-KdM4bMci7QhCMHop2yMd5hEGeJIuCCH4v0QqWwa2EUE=";
        owner = "onivim";
        repo = "oni2";
        rev = "b2792529e660975041c6e35dd465e2aa42ca5d86";
      });
      build = {
        buildEnv = [
          ("ONI2_APPCAST_BASEURL=${"http://localhost:8080/"}")
          ("ONI2_BUILD_MODE=${"Debug"}")
          ("ONI2_ROOT=${"$PWD"}")
        ];
        buildPhase = "dune build -p libvim,textmate,treesitter,Oni2,vterm -j4";
        installPhase = ''
          esy-installer Oni2.install
          bash -c "${if final.os == "windows" then "cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/*.dll '$cur__bin'" else "echo"}"
          bash -c "cp ${(final.getDrv "esy-sdl2@2.0.14000@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-skia@github:revery-ui/esy-skia#1c81aac@d41d8cd9")}/bin/skia.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-angle-prebuilt@1.0.0@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
        '';
        mode = "esy";
      };
    };
    "axios@0.19.2@d41d8cd9" = {
      pname = "axios";
      version = "0.19.2";
      depKeys = [
        ("follow-redirects@1.5.10@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-PqNsXYgY0NX4qKl6bTa4bNwAyyc=";
        url = "https://registry.npmjs.org/axios/-/axios-0.19.2.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "balanced-match@1.0.2@d41d8cd9" = {
      pname = "balanced-match";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-6D46fj8wCzTLnYf2FfoMvzV2kO4=";
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "base64-js@1.5.1@d41d8cd9" = {
      pname = "base64-js";
      version = "1.5.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-GxtEAWClv3rUC2UPCVljSBkDkwo=";
        url = "https://registry.npmjs.org/base64-js/-/base64-js-1.5.1.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "brace-expansion@1.1.11@d41d8cd9" = {
      pname = "brace-expansion";
      version = "1.1.11";
      depKeys = [
        ("concat-map@0.0.1@d41d8cd9")
        ("balanced-match@1.0.2@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-PH/L9SnYcibz0vUrlm/1Jx60Qd0=";
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "concat-map@0.0.1@d41d8cd9" = {
      pname = "concat-map";
      version = "0.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-2Klr13/Wjfd5OnMDajug1UBdR3s=";
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-W7WgZyYotkFJVmuhaBnmFRjGcmE=";
        url = "https://registry.npmjs.org/debug/-/debug-3.1.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "esy-angle-prebuilt@1.0.0@d41d8cd9" = {
      pname = "esy-angle-prebuilt";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-4yF/eFfxTEcp/hwjg4BT2CndWZQ=";
        url = "https://registry.npmjs.org/esy-angle-prebuilt/-/esy-angle-prebuilt-1.0.0.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-LfC9/pMX+83tX0Y/yh80ZGRJTHo=";
        url = "https://registry.npmjs.org/esy-cmake/-/esy-cmake-0.3.5.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-zcREP2v3Y/1Es+6vj9Cxwd9v3qk=";
        url = "https://registry.npmjs.org/esy-freetype2/-/esy-freetype2-2.9.1008.tgz";
      });
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
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-4UPBZMedXX5WpwcGu5p01J9e2mQdqP36nPUxDgl8oVU=";
        owner = "bryphe";
        repo = "esy-fzy";
        rev = "301dbf6";
      });
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
    "esy-libjpeg-turbo@github:revery-ui/libjpeg-turbo#dbb3dd5@d41d8cd9" = {
      pname = "esy-libjpeg-turbo";
      version = "2.0.2000";
      depKeys = [
        ("esy-nasm@github:revery-ui/esy-nasm#64a802b@d41d8cd9")
        ("@revery/esy-cmake@0.3.5001@d41d8cd9")
        ("@esy-cross/ninja-build@1.8.2001@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-ngvQ87igjpA9w/9BrPpYYGMrw89xo9VlhgIbfYpJCt4=";
        owner = "revery-ui";
        repo = "libjpeg-turbo";
        rev = "dbb3dd5";
      });
      build = {
        buildPhase = "${if final.os == "windows" then "echo esy-libjpeg-turbo currently works on on Linux/OSX" else "bash ./esy-build.sh"}";
        exportedEnv = [
          ("JPEG_INCLUDE_PATH=${"$out/include"}")
          ("JPEG_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-macdylibbundler@0.4.5001@d41d8cd9" = {
      pname = "esy-macdylibbundler";
      version = "0.4.5001";
      depKeys = [
        ("esy-cmake@0.3.5@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-53o+bcrKrQlhycVwAcmMikGmrhs=";
        url = "https://registry.npmjs.org/esy-macdylibbundler/-/esy-macdylibbundler-0.4.5001.tgz";
      });
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
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-0YAN47SCECJJr+nuE6+yi6OTTWeWYjOIcI0ZcyM1o9U=";
        owner = "revery-ui";
        repo = "esy-nasm";
        rev = "64a802b";
      });
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
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-5TeqGK+kV/lJWPPVkXPG179kPIxLOOhfQeJ2GBgdH7I=";
        owner = "onivim";
        repo = "esy-oniguruma";
        rev = "4698ce4";
      });
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
    "esy-sdl2@2.0.14000@d41d8cd9" = {
      pname = "esy-sdl2";
      version = "2.0.14000";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-EG5D/vvEr0YTh5Ji3UufFm6Qwws=";
        url = "https://registry.npmjs.org/esy-sdl2/-/esy-sdl2-2.0.14000.tgz";
      });
      build = {
        buildPhase = "bash -c \"./build-scripts/esybuild.sh --os=${final.os}\"";
        exportedEnv = [
          ("SDL2_INCLUDE_PATH=${"$out/include"}")
          ("SDL2_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "esy-skia@github:revery-ui/esy-skia#1c81aac@d41d8cd9" = {
      pname = "esy-skia";
      version = "0.6.0";
      depKeys = [
        ("esy-libjpeg-turbo@github:revery-ui/libjpeg-turbo#dbb3dd5@d41d8cd9")
        ("@esy-cross/ninja-build@1.8.2001@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-xWOAxMNoA9eKqn0KmzZ/D1BA3E9BMl9BaB9RGTBvi1k=";
        owner = "revery-ui";
        repo = "esy-skia";
        rev = "1c81aac";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-Z3MdTgH7OR69GYikeB1B4VMqxrY=";
        url = "https://registry.npmjs.org/esy-tree-sitter/-/esy-tree-sitter-1.4.1.tgz";
      });
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
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-GomTOdlU5ZwElKK8CM4DEMr51YDIrFKmTxUCGMLL3c4=";
        owner = "bryphe";
        repo = "flex";
        rev = "5e19b05";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-e3qfmuov3/NnhqlP9kPtB/T/Xio=";
        url = "https://registry.npmjs.org/follow-redirects/-/follow-redirects-1.5.10.tgz";
      });
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
        ("graceful-fs@4.2.6@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-TxicRKoSO4lfcigE9V6iPq3DSOk=";
        url = "https://registry.npmjs.org/fs-extra/-/fs-extra-7.0.1.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "fs.realpath@1.0.0@d41d8cd9" = {
      pname = "fs.realpath";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-FQStJSMVjKpA20onh8sBQRmU6k8=";
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "function-bind@1.1.1@d41d8cd9" = {
      pname = "function-bind";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-pWiZ0+o8m6uHS7l3O3xe3pL0iV0=";
        url = "https://registry.npmjs.org/function-bind/-/function-bind-1.1.1.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "glob@7.1.7@d41d8cd9" = {
      pname = "glob";
      version = "7.1.7";
      depKeys = [
        ("path-is-absolute@1.0.1@d41d8cd9")
        ("once@1.4.0@d41d8cd9")
        ("minimatch@3.0.4@d41d8cd9")
        ("inherits@2.0.4@d41d8cd9")
        ("inflight@1.0.6@d41d8cd9")
        ("fs.realpath@1.0.0@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-Oxk+kjPwHULQs/eClLvutBj5SpA=";
        url = "https://registry.npmjs.org/glob/-/glob-7.1.7.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "graceful-fs@4.2.6@d41d8cd9" = {
      pname = "graceful-fs";
      version = "4.2.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-/wQLKwhTsjw9MQJ1I3BvGIXXa+4=";
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.6.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-ci18v8H2qoJB8W3YFOAR4fQeh5Y=";
        url = "https://registry.npmjs.org/has/-/has-1.0.3.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-Sb1jMdfQLQwJvJEKEHW6gWW1bfk=";
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "inherits@2.0.4@d41d8cd9" = {
      pname = "inherits";
      version = "2.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-D6LGT5MpF8NDOg3tVTY6rjdBa3w=";
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "innosetup-compiler@5.5.9@d41d8cd9" = {
      pname = "innosetup-compiler";
      version = "5.5.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-//VhobtJzl07Ez7ot4i1qGj17iE=";
        url = "https://registry.npmjs.org/innosetup-compiler/-/innosetup-compiler-5.5.9.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "interpret@1.4.0@d41d8cd9" = {
      pname = "interpret";
      version = "1.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-Zlq4vE2iendKQFhOgS4+D6RbGh4=";
        url = "https://registry.npmjs.org/interpret/-/interpret-1.4.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "is-core-module@2.4.0@d41d8cd9" = {
      pname = "is-core-module";
      version = "2.4.0";
      depKeys = [
        ("has@1.0.3@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-jp/I4VAnsBFBgCbpjw5vTYYwXME=";
        url = "https://registry.npmjs.org/is-core-module/-/is-core-module-2.4.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "isolinear@github:revery-ui/isolinear#049ad1e@d41d8cd9" = {
      pname = "isolinear";
      version = "3.0.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-YqVkD0tXNMlpId1mJ7ZcGmI+4l2VanbKPMKxKKzLQBs=";
        owner = "revery-ui";
        repo = "isolinear";
        rev = "049ad1e";
      });
      build = {
        buildPhase = "dune build -p isolinear";
        mode = "esy";
      };
    };
    "jsonfile@4.0.0@d41d8cd9" = {
      pname = "jsonfile";
      version = "4.0.0";
      depKeys = [
        ("graceful-fs@4.2.6@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-h3Gq4HmbZAdrdmQPygWPnBDjPss=";
        url = "https://registry.npmjs.org/jsonfile/-/jsonfile-4.0.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "libvim@8.10869.89@d41d8cd9" = {
      pname = "libvim";
      version = "8.10869.89";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-4tYiIujhgCsi1h1Xt5CVL5+jJeY=";
        url = "https://registry.npmjs.org/libvim/-/libvim-8.10869.89.tgz";
      });
      build = {
        buildPhase = "bash -c \"${if final.os == "windows" then "build/build-windows.sh" else "build/build-posix.sh"}\"";
        exportedEnv = [
          ("LIBVIM_INCLUDE_PATH=${"$out/include"}")
          ("LIBVIM_LIB_PATH=${"${(final.siteLib "$out")}"}")
        ];
        mode = "esy";
      };
    };
    "lodash@4.17.21@d41d8cd9" = {
      pname = "lodash";
      version = "4.17.21";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-Z5WRxWTDv/quhFTPCz3zcMPWkRw=";
        url = "https://registry.npmjs.org/lodash/-/lodash-4.17.21.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-UWbihkV/AzBgZL5Ul+jbsMPTIIM=";
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "ms@2.0.0@d41d8cd9" = {
      pname = "ms";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-VgiurfwAvmwpAd9fmGF4jeDVl8g=";
        url = "https://registry.npmjs.org/ms/-/ms-2.0.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "ocaml@4.12.0@d41d8cd9" = {
      pname = "ocaml";
      version = "4.12.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-KpefN1Nfqt7Yqj/fgrbxbyxx4oQ=";
        url = "https://registry.npmjs.org/ocaml/-/ocaml-4.12.0.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-WDsap3WWHUsROsF9nFC6753Xa9E=";
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "path-is-absolute@1.0.1@d41d8cd9" = {
      pname = "path-is-absolute";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-F0uSaHNVNP+8es5r9TpanhtcX18=";
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "path-parse@1.0.7@d41d8cd9" = {
      pname = "path-parse";
      version = "1.0.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-+8EUtgykKzDZ2vWFjkvWi77bZzU=";
        url = "https://registry.npmjs.org/path-parse/-/path-parse-1.0.7.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha1-qbkx0XwwTokS7wujvdYYK68uH4w=";
        url = "https://registry.npmjs.org/plist/-/plist-3.0.1.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "rcedit@2.0.0@d41d8cd9" = {
      pname = "rcedit";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-3Mhdk6qRpBwevFxqod/EPqKLfa0=";
        url = "https://registry.npmjs.org/rcedit/-/rcedit-2.0.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "reason-fzy@github:bryphe/reason-fzy#5a1daf4@d41d8cd9" = {
      pname = "reason-fzy";
      version = "1.0";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("esy-fzy@github:bryphe/esy-fzy#301dbf6@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/ppx_inline_test@opam:v0.14.1@8b68b6f7")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-sRgKlFVuujr0u4CQSYjc+5ocHAkj9rEg60snEivBD3E=";
        owner = "bryphe";
        repo = "reason-fzy";
        rev = "5a1daf4";
      });
      build = {
        buildPhase = "dune build -p Fzy";
        installPhase = "esy-installer Fzy.install";
        mode = "esy";
      };
    };
    "reason-native-crash-utils@github:onivim/reason-native-crash-utils#a80a9d9@d41d8cd9" = {
      pname = "reason-native-crash-utils";
      version = "1.0.2";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-5dM9efGFjlyMXWV0H086t6EK9X2oj77lOR0HvRQYHFc=";
        owner = "onivim";
        repo = "reason-native-crash-utils";
        rev = "a80a9d9";
      });
      build = {
        buildPhase = "dune build -p reason-native-crash-utils";
        mode = "esy";
      };
    };
    "rebez@github:jchavarri/rebez#03fa3b7@d41d8cd9" = {
      pname = "rebez";
      version = "0.0.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@esy-ocaml/reason@github:EduardoRFS/reason:reason.json#35aa4df3de0daa60bdc1133dcf97855decac48f7@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-khZSwtwW+mP/EvAvIZMQyOb6FgNR+gmzpBZoD9ZPkpY=";
        owner = "jchavarri";
        repo = "rebez";
        rev = "03fa3b7";
      });
      build = {
        buildPhase = "dune build -p rebez";
        mode = "esy";
      };
    };
    "rechoir@0.6.2@d41d8cd9" = {
      pname = "rechoir";
      version = "0.6.2";
      depKeys = [
        ("resolve@1.20.0@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-hSBLVNuoLVdC4oyWdW70OvUOM4Q=";
        url = "https://registry.npmjs.org/rechoir/-/rechoir-0.6.2.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "rench@1.10.0@d41d8cd9" = {
      pname = "rench";
      version = "1.10.0";
      depKeys = [
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/fpath@opam:0.7.3@674d8125")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-h7v2Y7clqwzESE70WuPrke2snHc=";
        url = "https://registry.npmjs.org/rench/-/rench-1.10.0.tgz";
      });
      build = {
        buildPhase = "dune build -p Rench -j4";
        installPhase = "esy-installer Rench.install";
        mode = "esy";
      };
    };
    "reperf@1.5.1@d41d8cd9" = {
      pname = "reperf";
      version = "1.5.1";
      depKeys = [
        ("ocaml@4.12.0@d41d8cd9")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/printbox@opam:0.5@82f5d436")
        ("@opam/dune@opam:2.8.5@01003f12")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-tEmaFeKZtFOx0JXv7ZSSMp9xbQo=";
        url = "https://registry.npmjs.org/reperf/-/reperf-1.5.1.tgz";
      });
      build = {
        buildPhase = "dune build -p reperf";
        installPhase = "esy-installer reperf.install";
        mode = "esy";
      };
    };
    "resolve@1.20.0@d41d8cd9" = {
      pname = "resolve";
      version = "1.20.0";
      depKeys = [
        ("path-parse@1.0.7@d41d8cd9")
        ("is-core-module@2.4.0@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-YpoBP7P3B1XW8LeTXMHCxTeLGXU=";
        url = "https://registry.npmjs.org/resolve/-/resolve-1.20.0.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "revery@github:revery-ui/revery#dd10c87@d41d8cd9" = {
      pname = "revery";
      version = "0.32.0";
      depKeys = [
        ("reperf@1.5.1@d41d8cd9")
        ("rench@1.10.0@d41d8cd9")
        ("rebez@github:jchavarri/rebez#03fa3b7@d41d8cd9")
        ("flex@github:bryphe/flex#5e19b05@d41d8cd9")
        ("esy-skia@github:revery-ui/esy-skia#1c81aac@d41d8cd9")
        ("esy-sdl2@2.0.14000@d41d8cd9")
        ("esy-freetype2@2.9.1008@d41d8cd9")
        ("esy-angle-prebuilt@1.0.0@d41d8cd9")
        ("@revery/timber@2.0.0@d41d8cd9")
        ("@revery/esy-harfbuzz@2.6.8002@d41d8cd9")
        ("@reason-native/rely@3.2.1@d41d8cd9")
        ("@opam/uutf@opam:1.0.2@4440868f")
        ("@opam/uucp@opam:13.0.0@647d53e6")
        ("@opam/reason@opam:3.7.0@494dd52d")
        ("@opam/ppx_optcomp@opam:v0.14.0@27dab73f")
        ("@opam/ppx_deriving@opam:4.5@99c603e5")
        ("@opam/omd@github:ocaml/omd:omd.opam#1535e3c@d41d8cd9")
        ("@opam/markup@opam:0.8.2@53ccafce")
        ("@opam/lwt_ppx@opam:2.0.1@edf5ad68")
        ("@opam/lwt@opam:5.4.1@37ffbe37")
        ("@opam/lru@github:bryphe/lru:lru.opam#2708c70@d41d8cd9")
        ("@opam/dune-configurator@opam:2.5.1@5f41e4d9")
        ("@opam/dune@opam:2.8.5@01003f12")
        ("@opam/ctypes@opam:0.15.1@9c7ab4ec")
        ("@opam/charInfo_width@opam:1.1.0@4296bdfe")
        ("@opam/bos@opam:0.2.0@8000d437")
        ("@onivim/reason-native-crash-utils@1.0.2@d41d8cd9")
        ("@brisk/brisk-reconciler@github:briskml/brisk-reconciler#c9d5c4c@d41d8cd9")
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-IOZuqcTfxiLb0jK2ihtBZsix6E4OmtV7dKs97s8R6aQ=";
        owner = "revery-ui";
        repo = "revery";
        rev = "dd10c87";
      });
      build = {
        buildPhase = "dune build -p reason-harfbuzz,reason-skia,reason-sdl2,Revery";
        installPhase = ''
          esy-installer reason-harfbuzz.install
          esy-installer reason-skia.install
          esy-installer reason-sdl2.install
          esy-installer Revery.install
          bash -c "${if final.os == "windows" then "cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/*.dll '$cur__bin'" else ":"}"
          bash -c "cp ${(final.getDrv "esy-skia@github:revery-ui/esy-skia#1c81aac@d41d8cd9")}/bin/skia.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
          bash -c "cp ${(final.getDrv "esy-sdl2@2.0.14000@d41d8cd9")}/bin/*.dll '$cur__bin' ${if final.os == "windows" then "" else "2>/dev/null || true"}"
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
        ("glob@7.1.7@d41d8cd9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-3naE/ut2f4cWsyYHiooAh1iQ48I=";
        url = "https://registry.npmjs.org/shelljs/-/shelljs-0.8.4.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "universalify@0.1.2@d41d8cd9" = {
      pname = "universalify";
      version = "0.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-tkb2m+OULavOzJ1mOcgNwQXvqmY=";
        url = "https://registry.npmjs.org/universalify/-/universalify-0.1.2.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "wrappy@1.0.2@d41d8cd9" = {
      pname = "wrappy";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-tSQ9jz7BqjXxNkYFvA0QNuMKtp8=";
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "xmlbuilder@9.0.7@d41d8cd9" = {
      pname = "xmlbuilder";
      version = "9.0.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-Ey7mPS7FVlxVfiD0wi35rKaGsQ0=";
        url = "https://registry.npmjs.org/xmlbuilder/-/xmlbuilder-9.0.7.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "xmldom@0.1.31@d41d8cd9" = {
      pname = "xmldom";
      version = "0.1.31";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha1-t2yaG9nwqXN+WnLcNyMc84N14v8=";
        url = "https://registry.npmjs.org/xmldom/-/xmldom-0.1.31.tgz";
      });
      build = {
        mode = "esy";
      };
    };
    "yarn-pkg-config@github:esy-ocaml/yarn-pkg-config#db3a0b63883606dd57c54a7158d560d6cba8cd79@d41d8cd9" = {
      pname = "yarn-pkg-config";
      version = "0.29.5";
      depKeys = [
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-ScaiPdyjYgdcChLDb8DU0nQ3AY9W6qzLjwUreyWN2LQ=";
        owner = "esy-ocaml";
        repo = "yarn-pkg-config";
        rev = "db3a0b63883606dd57c54a7158d560d6cba8cd79";
      });
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