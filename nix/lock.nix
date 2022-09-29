final:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "cargo";
    version = "1";
    root = "fetlock-0.1.0";
  };
  specs = {
    "aho-corasick-0.7.15" = {
      pname = "aho-corasick";
      version = "0.7.15";
      depKeys = [
        ("memchr-2.3.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-dAT+v/qkfayBqkTbpxUjydBpsb3FCnfbQRlRSeF/aOU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/aho-corasick/0.7.15/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "anyhow-1.0.48" = {
      pname = "anyhow";
      version = "1.0.48";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YuH0f33AQiAnpONw3UVI1NZrJnguUT6Y3KHmieBYqA4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/anyhow/1.0.48/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "arrayvec-0.5.2" = {
      pname = "arrayvec";
      version = "0.5.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-I7Yvxl3o5Of1JTT7UrDz7QR0auJnUZ7vKoOUHoCFBos=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/arrayvec/0.5.2/download";
      });
      edition = "2018";
      features = [
        ("array-sizes-33-128")
      ];
    };
    "async-trait-0.1.57" = {
      pname = "async-trait";
      version = "0.1.57";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-dkZERri8MnWNfojuGoBNmRTNmxyyZMApiZaAsL4pgm8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/async-trait/0.1.57/download";
      });
      build = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "atty-0.2.14" = {
      pname = "atty";
      version = "0.2.14";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2bOb4Ydw0RQhzbG5lHpF3T836TCSy/N3YUgooxnV/ug=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/atty/0.2.14/download";
      });
      edition = "2015";
    };
    "autocfg-1.1.0" = {
      pname = "autocfg";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1GiAK6sXy8DMV16bBT9B5yqja/prf1XjUp/6QxYbl/o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/autocfg/1.1.0/download";
      });
      edition = "2015";
    };
    "base64-0.13.0" = {
      pname = "base64";
      version = "0.13.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-kE3+rFDzzauij8b1f9zdt19J7WE0ZnanjE/+VYd4Av0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/base64/0.13.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "bitflags-1.3.2" = {
      pname = "bitflags";
      version = "1.3.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vvONRRY8Lx3eCUp9/TPM9ZXJKQXI+PT9wY0G+xA3cYo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bitflags/1.3.2/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "bitvec-0.19.6" = {
      pname = "bitvec";
      version = "0.19.6";
      depKeys = [
        ("funty-1.1.0")
        ("radium-0.5.3")
        ("tap-1.0.1")
        ("wyz-0.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Vfk9DvM2PDZNWXZkajjwTPZ8/h1MjRYM3qAsqywRazM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bitvec/0.19.6/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "block-buffer-0.9.0" = {
      pname = "block-buffer";
      version = "0.9.0";
      depKeys = [
        ("generic-array-0.14.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-QVIRb9bp2tspGuGPwew1de1thMKWQtl4kPS0o0Fyl+Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/block-buffer/0.9.0/download";
      });
      edition = "2018";
    };
    "bumpalo-3.11.0" = {
      pname = "bumpalo";
      version = "3.11.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-wa2CIRjSDSwjT0JwANWsw26r4eKaNIyJtj3WCxPyjl0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bumpalo/3.11.0/download";
      });
      edition = "2021";
      features = [
        ("default")
      ];
    };
    "bytes-1.2.1" = {
      pname = "bytes";
      version = "1.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-7Ip7anD96ANyFUxlcC8AoPVvPhw2q7xsRASEviSIVts=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bytes/1.2.1/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "camino-1.1.1" = {
      pname = "camino";
      version = "1.1.1";
      depKeys = [
        ("serde-1.0.144")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-iK0OHj6I3SN6FWq59XECG4oVjKoK5EsZaKJB77UUTB4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/camino/1.1.1/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("serde")
        ("serde1")
      ];
    };
    "cargo-platform-0.1.2" = {
      pname = "cargo-platform";
      version = "0.1.2";
      depKeys = [
        ("serde-1.0.144")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-y9uCXail3weaQ2dtvgQnAvFwexEJ9xOgFCD7tMxx+ic=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo-platform/0.1.2/download";
      });
      edition = "2018";
    };
    "cargo-util-0.1.2" = {
      pname = "cargo-util";
      version = "0.1.2";
      depKeys = [
        ("anyhow-1.0.48")
        ("core-foundation-0.9.3")
        ("crypto-hash-0.3.4")
        ("filetime-0.2.17")
        ("hex-0.4.3")
        ("jobserver-0.1.24")
        ("libc-0.2.132")
        ("log-0.4.17")
        ("same-file-1.0.6")
        ("shell-escape-0.1.5")
        ("tempfile-3.3.0")
        ("walkdir-2.3.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-pRx4MWO99FSYILgJaNOGyU7UXtI4Gck/Wcyn69l/4Os=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo-util/0.1.2/download";
      });
      edition = "2021";
    };
    "cargo_metadata-0.14.2" = {
      pname = "cargo_metadata";
      version = "0.14.2";
      depKeys = [
        ("camino-1.1.1")
        ("cargo-platform-0.1.2")
        ("semver-1.0.13")
        ("serde-1.0.144")
        ("serde_json-1.0.85")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-SsuwnZ7o4jaZuWNDdccnldCVvyaEOdqIViz5tQHxgfo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo_metadata/0.14.2/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "cc-1.0.73" = {
      pname = "cc";
      version = "1.0.73";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-L/8qaSezu4f5WV1nGWpwST9idoenHYeg1pIkLDP1jBE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cc/1.0.73/download";
      });
      crateBin = [
        ({
          name = "gcc-shim";
          path = "src/bin/gcc-shim.rs";
        })
      ];
      edition = "2018";
    };
    "cfg-if-1.0.0" = {
      pname = "cfg-if";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-uvHeQzl2FYi8Bhnjy8ASDuWC67dLU7Tvv3kRe9LaQP0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cfg-if/1.0.0/download";
      });
      edition = "2018";
    };
    "clap-3.2.17" = {
      pname = "clap";
      version = "3.2.17";
      depKeys = [
        ("atty-0.2.14")
        ("bitflags-1.3.2")
        ("clap_derive-3.2.17")
        ("clap_lex-0.2.4")
        ("indexmap-1.9.1")
        ("once_cell-1.13.1")
        ("strsim-0.10.0")
        ("termcolor-1.1.3")
        ("textwrap-0.15.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Keckpo2TGTQ7szKMnMLf3iY/SzFC7hBZqZgFgBcclUs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap/3.2.17/download";
      });
      crateBin = [
        ({
          name = "stdio-fixture";
          path = "src/bin/stdio-fixture.rs";
        })
      ];
      edition = "2021";
      features = [
        ("atty")
        ("clap_derive")
        ("color")
        ("default")
        ("derive")
        ("once_cell")
        ("std")
        ("strsim")
        ("suggestions")
        ("termcolor")
      ];
    };
    "clap_derive-3.2.17" = {
      pname = "clap_derive";
      version = "3.2.17";
      depKeys = [
        ("heck-0.4.0")
        ("proc-macro-error-1.0.4")
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-E1R/cBLAGrSg6PiWdzCtqPn99BnotseSeI85z05G7vo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap_derive/3.2.17/download";
      });
      edition = "2021";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "clap_lex-0.2.4" = {
      pname = "clap_lex";
      version = "0.2.4";
      depKeys = [
        ("os_str_bytes-6.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-KFDy9agsv0N91a9NSYSPvfwnwVfD0BA0V3b5UnZSYcU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap_lex/0.2.4/download";
      });
      edition = "2021";
    };
    "commoncrypto-0.2.0" = {
      pname = "commoncrypto";
      version = "0.2.0";
      depKeys = [
        ("commoncrypto-sys-0.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-0FaoWGuiWh5NYcsJCQDklZUseIZ4b8VfkJqy+Bm2kAc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/commoncrypto/0.2.0/download";
      });
      edition = "2015";
    };
    "commoncrypto-sys-0.2.0" = {
      pname = "commoncrypto-sys";
      version = "0.2.0";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-H+009GdHqnPfqleAaf2CedKBit4rVfOPIqlAHH9Ag+I=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/commoncrypto-sys/0.2.0/download";
      });
      edition = "2015";
    };
    "core-foundation-0.9.3" = {
      pname = "core-foundation";
      version = "0.9.3";
      depKeys = [
        ("core-foundation-sys-0.8.3")
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GUp6nm3lP6VRFpNAZ8hE2ddJMS91xvbQmA6MJS+MIUY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/core-foundation/0.9.3/download";
      });
      edition = "2015";
      features = [
        ("mac_os_10_7_support")
      ];
    };
    "core-foundation-sys-0.8.3" = {
      pname = "core-foundation-sys";
      version = "0.8.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WCfOv0ZwRouHct0ZGFZ2iu3LGwJ4oE+Yn3dmNRkXudw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/core-foundation-sys/0.8.3/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("mac_os_10_7_support")
      ];
    };
    "cpufeatures-0.2.4" = {
      pname = "cpufeatures";
      version = "0.2.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-3JSOu5YkG7QKtz7/64DZ+Tr6rUk1nRWaXmG+UWGf6BM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cpufeatures/0.2.4/download";
      });
      edition = "2018";
    };
    "crypto-hash-0.3.4" = {
      pname = "crypto-hash";
      version = "0.3.4";
      depKeys = [
        ("commoncrypto-0.2.0")
        ("hex-0.3.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-incWIkD9lySNGaVkpWXrVjo/WSs4bkE2+zAJCeZ93co=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/crypto-hash/0.3.4/download";
      });
      edition = "2015";
    };
    "data-encoding-2.3.2" = {
      pname = "data-encoding";
      version = "2.3.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-PuI5PEqRQp3/tL7fGfTWq/J9inMsjOSYAwXXguVCbVc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/data-encoding/2.3.2/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "digest-0.9.0" = {
      pname = "digest";
      version = "0.9.0";
      depKeys = [
        ("generic-array-0.14.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-091g0QgKV6BasDI3cEngWRQV0rMa/XAoNW2/PMbcsGY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/digest/0.9.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "either-1.8.0" = {
      pname = "either";
      version = "1.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-kOXByDaIAxE78MlYT8SVpYuG3Iop7b+P6HfSHZUH55c=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/either/1.8.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("use_std")
      ];
    };
    "encoding_rs-0.8.31" = {
      pname = "encoding_rs";
      version = "0.8.31";
      depKeys = [
        ("cfg-if-1.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-mFJjVYncn56htv6fBbUO8gjIXINKVi8MarscR1c27Cs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/encoding_rs/0.8.31/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
      ];
    };
    "env_logger-0.7.1" = {
      pname = "env_logger";
      version = "0.7.1";
      depKeys = [
        ("atty-0.2.14")
        ("humantime-1.3.0")
        ("log-0.4.17")
        ("regex-1.4.6")
        ("termcolor-1.1.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RFM7u7O7PB+hfZ8uTji7uvg5a6ghk8TLG2RF1xFEXTY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/env_logger/0.7.1/download";
      });
      edition = "2018";
      features = [
        ("atty")
        ("default")
        ("humantime")
        ("regex")
        ("termcolor")
      ];
    };
    "fastrand-1.8.0" = {
      pname = "fastrand";
      version = "1.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-p6QHz6ozhcSuayPoRiPUjCeY0G4+ahh49/WfF7P4ZJk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/fastrand/1.8.0/download";
      });
      edition = "2018";
    };
    "fetlock-0.1.0" = {
      pname = "fetlock";
      version = "0.1.0";
      depKeys = [
        ("anyhow-1.0.48")
        ("async-trait-0.1.57")
        ("cargo-platform-0.1.2")
        ("cargo-util-0.1.2")
        ("cargo_metadata-0.14.2")
        ("clap-3.2.17")
        ("data-encoding-2.3.2")
        ("either-1.8.0")
        ("env_logger-0.7.1")
        ("fs2-0.4.3")
        ("futures-0.3.23")
        ("getopts-0.2.21")
        ("lazy_static-1.4.0")
        ("log-0.4.17")
        ("nom-6.2.1")
        ("percent-encoding-2.1.0")
        ("platforms-1.1.0")
        ("regex-1.4.6")
        ("reqwest-0.11.11")
        ("serde-1.0.144")
        ("serde_json-1.0.85")
        ("serde_yaml-0.8.26")
        ("sha2-0.9.9")
        ("tempdir-0.3.7")
        ("tokio-1.20.1")
      ];
      src = (final.pathSrc ../.);
      crateBin = [
        ({
          name = "fetlock";
          path = "src/bin/fetlock.rs";
        })
      ];
      edition = "2018";
    };
    "filetime-0.2.17" = {
      pname = "filetime";
      version = "0.2.17";
      depKeys = [
        ("cfg-if-1.0.0")
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-6Up7uqWTVLwg3XW2fyPieXtEkOnWkoID+xBceeRIyGw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/filetime/0.2.17/download";
      });
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.2.16";
          })
        ];
      };
      edition = "2018";
    };
    "fnv-1.0.7" = {
      pname = "fnv";
      version = "1.0.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-P57skY0/JAad7LmvFVTK18iA4tokqa/YisoABTGrgsE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/fnv/1.0.7/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
      libPath = "lib.rs";
    };
    "foreign-types-0.3.2" = {
      pname = "foreign-types";
      version = "0.3.2";
      depKeys = [
        ("foreign-types-shared-0.1.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-9vM564rcBSzSyniRD9qGmu+jjSLVy2SOZIXk0/wG87E=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/foreign-types/0.3.2/download";
      });
      edition = "2015";
    };
    "foreign-types-shared-0.1.1" = {
      pname = "foreign-types-shared";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ALAihBGQjKhoXbp/ws3XDsmZCm51Pom2rJGoTED7r0s=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/foreign-types-shared/0.1.1/download";
      });
      edition = "2015";
    };
    "form_urlencoded-1.0.1" = {
      pname = "form_urlencoded";
      version = "1.0.1";
      depKeys = [
        ("matches-0.1.9")
        ("percent-encoding-2.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-X8Jah/pP0glL/7BpJYUgNNkKF/DR4FGX1JVtNVV1IZE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/form_urlencoded/1.0.1/download";
      });
      edition = "2018";
    };
    "fs2-0.4.3" = {
      pname = "fs2";
      version = "0.4.3";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lWT8dY4VAltGqmZDsbd9BH0aVqGupuAQAqwMcCaHYhM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/fs2/0.4.3/download";
      });
      edition = "2015";
    };
    "fuchsia-cprng-0.1.1" = {
      pname = "fuchsia-cprng";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-oG931SbBpgG3xM3Zj1S16qv/wU1fLwKW/r3H81fG07o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/fuchsia-cprng/0.1.1/download";
      });
      edition = "2018";
    };
    "funty-1.1.0" = {
      pname = "funty";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-/tNM0QWRfpHapNprNyjEewaHSdamLFmBHwbtKscdnac=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/funty/1.1.0/download";
      });
      edition = "2018";
    };
    "futures-0.3.23" = {
      pname = "futures";
      version = "0.3.23";
      depKeys = [
        ("futures-channel-0.3.23")
        ("futures-core-0.3.23")
        ("futures-executor-0.3.23")
        ("futures-io-0.3.23")
        ("futures-sink-0.3.23")
        ("futures-task-0.3.23")
        ("futures-util-0.3.23")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-qzDperaqz+Y1+tWPIsK7Bsi2hfdCHrHgZKcp4qX0gfo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures/0.3.23/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("async-await")
        ("default")
        ("executor")
        ("futures-executor")
        ("std")
      ];
    };
    "futures-channel-0.3.23" = {
      pname = "futures-channel";
      version = "0.3.23";
      depKeys = [
        ("futures-core-0.3.23")
        ("futures-sink-0.3.23")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-K/xSy93P10W/F0AzhJK7C9g9dsZ7RF+Rxfsp+uKeyqE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-channel/0.3.23/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("futures-sink")
        ("sink")
        ("std")
      ];
    };
    "futures-core-0.3.23" = {
      pname = "futures-core";
      version = "0.3.23";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-0qztrojTgjWTbDkiR2sQ/O17K2gTb148A8LVvjSKERU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-core/0.3.23/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-executor-0.3.23" = {
      pname = "futures-executor";
      version = "0.3.23";
      depKeys = [
        ("futures-core-0.3.23")
        ("futures-task-0.3.23")
        ("futures-util-0.3.23")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HRGqIbW1h6ZGgsAJTCvdTfAHbFMklhpAzDq9fzeTBSg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-executor/0.3.23/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-io-0.3.23" = {
      pname = "futures-io";
      version = "0.3.23";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-k6ZvxtA1omo64lWm0ryjXtpjrkxVEr71REkRP3oSKOU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-io/0.3.23/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-macro-0.3.23" = {
      pname = "futures-macro";
      version = "0.3.23";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-DbnM5TKw6uLM8nZqskbxFLVrnPbUReAMJUn7wQDKBF0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-macro/0.3.23/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "futures-sink-0.3.23" = {
      pname = "futures-sink";
      version = "0.3.23";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-yguuH+l1LPf9mwBkxnSuY/l7N7xxTXRcveCvt+xOZ2U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-sink/0.3.23/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-task-0.3.23" = {
      pname = "futures-task";
      version = "0.3.23";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-hC/GO5MfQFaiTVneE/sSchNM4mGBbgY+Y0rQwVzcUwY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-task/0.3.23/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "futures-util-0.3.23" = {
      pname = "futures-util";
      version = "0.3.23";
      depKeys = [
        ("futures-channel-0.3.23")
        ("futures-core-0.3.23")
        ("futures-io-0.3.23")
        ("futures-macro-0.3.23")
        ("futures-sink-0.3.23")
        ("futures-task-0.3.23")
        ("memchr-2.3.4")
        ("pin-project-lite-0.2.9")
        ("pin-utils-0.1.0")
        ("slab-0.4.7")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-8IKKVHHjQCKcEcd8qAAXk3zjxYy3iKF+XxwtXEhalXc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-util/0.3.23/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("async-await")
        ("async-await-macro")
        ("channel")
        ("futures-channel")
        ("futures-io")
        ("futures-macro")
        ("futures-sink")
        ("io")
        ("memchr")
        ("sink")
        ("slab")
        ("std")
      ];
    };
    "generic-array-0.14.6" = {
      pname = "generic-array";
      version = "0.14.6";
      depKeys = [
        ("typenum-1.15.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-v/SelHKX8zEkR6vcp59F9HOAl8yCsG5yBU0iI/YB8bk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/generic-array/0.14.6/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("version_check-0.9.4")
      ];
      edition = "2015";
    };
    "getopts-0.2.21" = {
      pname = "getopts";
      version = "0.2.21";
      depKeys = [
        ("unicode-width-0.1.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FNu/1ccdcCQez55vE3N/e1zoI4IQYxiNfkbEHTce69U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/getopts/0.2.21/download";
      });
      edition = "2015";
    };
    "h2-0.3.14" = {
      pname = "h2";
      version = "0.3.14";
      depKeys = [
        ("bytes-1.2.1")
        ("fnv-1.0.7")
        ("futures-core-0.3.23")
        ("futures-sink-0.3.23")
        ("futures-util-0.3.23")
        ("http-0.2.8")
        ("indexmap-1.9.1")
        ("slab-0.4.7")
        ("tokio-1.20.1")
        ("tokio-util-0.7.3")
        ("tracing-0.1.36")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-XKMlks8hrHzKsYJc2H9smz2QIsRNCGFy7QlmvsivML4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/h2/0.3.14/download";
      });
      edition = "2018";
    };
    "hashbrown-0.12.3" = {
      pname = "hashbrown";
      version = "0.12.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ip7nDEOq9BfJFDlmRaD6hSYkgBsk67eueP6CcoiayIg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hashbrown/0.12.3/download";
      });
      edition = "2021";
      features = [
        ("raw")
      ];
    };
    "heck-0.4.0" = {
      pname = "heck";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-JUB3HmX8jLg81uiiN/cMMZvVwp947RCEul1Q7qyG9/k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/heck/0.4.0/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "hermit-abi-0.1.19" = {
      pname = "hermit-abi";
      version = "0.1.19";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YrRnNDuUukdtyyUA0kLa27OVV9+IkxCsd8XZkQCqrDM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hermit-abi/0.1.19/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "hex-0.3.2" = {
      pname = "hex";
      version = "0.3.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-gFAmpdAUH/wwq7O+MXOEitRqGxZk/mMkKEeWGaNkTXc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hex/0.3.2/download";
      });
      edition = "2015";
    };
    "hex-0.4.3" = {
      pname = "hex";
      version = "0.4.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-fyQlSqmlS1yFjq7i9bzNtGqvDkhqWV7V/Y+GulUjKnA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hex/0.4.3/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "http-0.2.8" = {
      pname = "http";
      version = "0.2.8";
      depKeys = [
        ("bytes-1.2.1")
        ("fnv-1.0.7")
        ("itoa-1.0.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-dfQ9QeJplcF+ce4SZFHdOUEBCwUUqBqdEfOzQd68I5k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/http/0.2.8/download";
      });
      edition = "2018";
    };
    "http-body-0.4.5" = {
      pname = "http-body";
      version = "0.4.5";
      depKeys = [
        ("bytes-1.2.1")
        ("http-0.2.8")
        ("pin-project-lite-0.2.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1fOPFtGE428kCKVSgc1ljsvTygXM5tZRChduyjk+JtE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/http-body/0.4.5/download";
      });
      edition = "2018";
    };
    "httparse-1.7.1" = {
      pname = "httparse";
      version = "1.7.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-SWzim7WlJ4W0Tg98ooR64LuDnJvSj2msrJuZ1GHAwEw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/httparse/1.7.1/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "httpdate-1.0.2" = {
      pname = "httpdate";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-xKHjbIIdvgRXT2AoSKGfdC9Ps8mNQESfEbytGNaxdCE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/httpdate/1.0.2/download";
      });
      edition = "2018";
    };
    "humantime-1.3.0" = {
      pname = "humantime";
      version = "1.3.0";
      depKeys = [
        ("quick-error-1.2.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-3wBM/KUO8jw2hQqqpZrVLMcNDpAkPDx3N6TdMtx6PE8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/humantime/1.3.0/download";
      });
      edition = "2015";
    };
    "hyper-0.14.20" = {
      pname = "hyper";
      version = "0.14.20";
      depKeys = [
        ("bytes-1.2.1")
        ("futures-channel-0.3.23")
        ("futures-core-0.3.23")
        ("futures-util-0.3.23")
        ("h2-0.3.14")
        ("http-0.2.8")
        ("http-body-0.4.5")
        ("httparse-1.7.1")
        ("httpdate-1.0.2")
        ("itoa-1.0.3")
        ("pin-project-lite-0.2.9")
        ("socket2-0.4.4")
        ("tokio-1.20.1")
        ("tower-service-0.3.2")
        ("tracing-0.1.36")
        ("want-0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Askp3Fw54zWgPEBSknKBGIYHIbEBkNmMKg8O/Vuq+6w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper/0.14.20/download";
      });
      edition = "2018";
      features = [
        ("client")
        ("h2")
        ("http1")
        ("http2")
        ("runtime")
        ("socket2")
        ("tcp")
      ];
    };
    "hyper-tls-0.5.0" = {
      pname = "hyper-tls";
      version = "0.5.0";
      depKeys = [
        ("bytes-1.2.1")
        ("hyper-0.14.20")
        ("native-tls-0.2.10")
        ("tokio-1.20.1")
        ("tokio-native-tls-0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1hg936mbhdphoUC+oO/JP99WzqoEGzfVU1GAMIJ/mQU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper-tls/0.5.0/download";
      });
      edition = "2018";
    };
    "idna-0.2.3" = {
      pname = "idna";
      version = "0.2.3";
      depKeys = [
        ("matches-0.1.9")
        ("unicode-bidi-0.3.8")
        ("unicode-normalization-0.1.21")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-QYoKb6uCFHX2NO/jzMRcAT90Lv4D2FPo0zVdXLhQ7Pg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/idna/0.2.3/download";
      });
      edition = "2018";
    };
    "indexmap-1.9.1" = {
      pname = "indexmap";
      version = "1.9.1";
      depKeys = [
        ("hashbrown-0.12.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-EKNal3MDIP/o4tQQtdO2knm5jSwUvbi3Dqiez3iI1B4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/indexmap/1.9.1/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
      ];
      edition = "2021";
      features = [
        ("std")
      ];
    };
    "instant-0.1.12" = {
      pname = "instant";
      version = "0.1.12";
      depKeys = [
        ("cfg-if-1.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-elu+gkxQfF2llWNV6Gp0bYLg4UZPZdhizF5x2nDpSyw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/instant/0.1.12/download";
      });
      edition = "2018";
    };
    "ipnet-2.5.0" = {
      pname = "ipnet";
      version = "2.5.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-h51Ug0yMdkV+9Ck6aJsqjFmwdgZ613sV76+7BfkqWSs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ipnet/2.5.0/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "itoa-1.0.3" = {
      pname = "itoa";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-bIr4RnT+HyI6mCyTOg7hCGrE1AUqoPuAYMEsatg451Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/itoa/1.0.3/download";
      });
      edition = "2018";
    };
    "jobserver-0.1.24" = {
      pname = "jobserver";
      version = "0.1.24";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ryWncpmn9xGgGXXDWmpCTraGIJLMLWxyxO1svFbfwfo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/jobserver/0.1.24/download";
      });
      edition = "2018";
    };
    "js-sys-0.3.59" = {
      pname = "js-sys";
      version = "0.3.59";
      depKeys = [
        ("wasm-bindgen-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-JYRRqxCzT4r1NBbR/atywi6AXwySoRNtWUcOwLEROLI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/js-sys/0.3.59/download";
      });
      edition = "2018";
    };
    "lazy_static-1.4.0" = {
      pname = "lazy_static";
      version = "1.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-4qutI/vEKzcA8vJ5hE3IMq2ysusGmy35GPRVxOGMxkY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lazy_static/1.4.0/download";
      });
      edition = "2015";
    };
    "lexical-core-0.7.6" = {
      pname = "lexical-core";
      version = "0.7.6";
      depKeys = [
        ("arrayvec-0.5.2")
        ("bitflags-1.3.2")
        ("cfg-if-1.0.0")
        ("ryu-1.0.11")
        ("static_assertions-1.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ZgfGKqFh0j0XqQcsxdoL5nzfyJ06+x6NnIQr68JSX/4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lexical-core/0.7.6/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("arrayvec")
        ("correct")
        ("default")
        ("ryu")
        ("static_assertions")
        ("std")
        ("table")
      ];
    };
    "libc-0.2.132" = {
      pname = "libc";
      version = "0.2.132";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-g3Hk5TQcOpbbEn6yRlrGgc7UxDPgHdDpOK2+8mupO6U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/libc/0.2.132/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "linked-hash-map-0.5.6" = {
      pname = "linked-hash-map";
      version = "0.5.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-BxfO8byLY2xuHBu978CeYyLaipMhlm6JKO+A0g9/dw8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/linked-hash-map/0.5.6/download";
      });
      edition = "2015";
    };
    "lock_api-0.4.7" = {
      pname = "lock_api";
      version = "0.4.7";
      depKeys = [
        ("scopeguard-1.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Mn+ltqaUDkaZ7Empvq4epIRca6uTFOT4SsaHQhOdjFM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lock_api/0.4.7/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
      ];
      edition = "2018";
    };
    "log-0.4.17" = {
      pname = "log";
      version = "0.4.17";
      depKeys = [
        ("cfg-if-1.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-q7EuaHz7RKpA9B/Dl473ZEj5tgOMrWrvQlnTwJWiOC4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/log/0.4.17/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("std")
      ];
    };
    "matches-0.1.9" = {
      pname = "matches";
      version = "0.1.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-o+N4tmoGDUiUe1kHN7MKG+dnBsjde4ug8v45icaKhT8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/matches/0.1.9/download";
      });
      edition = "2015";
      libPath = "lib.rs";
    };
    "memchr-2.3.4" = {
      pname = "memchr";
      version = "2.3.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-DuHEeqolbsq8rqNR6uSpsB7zntgQAE4pjSUR7ShLFSU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/memchr/2.3.4/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("std")
        ("use_std")
      ];
    };
    "mime-0.3.16" = {
      pname = "mime";
      version = "0.3.16";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-KmDHzlAcceA6nJwNNbhhQTrpJb2XnMek4w0GAGmqrI0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/mime/0.3.16/download";
      });
      edition = "2015";
    };
    "mio-0.8.4" = {
      pname = "mio";
      version = "0.8.4";
      depKeys = [
        ("libc-0.2.132")
        ("log-0.4.17")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-V+4cI8fGOwySUMM5/9xpJV8RCymLkBufbIJUe3uHyq8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/mio/0.8.4/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("net")
        ("os-ext")
        ("os-poll")
      ];
    };
    "miow-0.3.7" = {
      pname = "miow";
      version = "0.3.7";
      depKeys = [
        ("winapi-0.3.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ufHFsCXNqHb2bvQ6ET+R68n0zO80hDAA4K3267q4TiE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/miow/0.3.7/download";
      });
      edition = "2018";
    };
    "native-tls-0.2.10" = {
      pname = "native-tls";
      version = "0.2.10";
      depKeys = [
        ("lazy_static-1.4.0")
        ("libc-0.2.132")
        ("security-framework-2.7.0")
        ("security-framework-sys-2.6.1")
        ("tempfile-3.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-/X4vNhhVf5gOCxfohWJS7uPJf6EsVN/wyikPtiZspKk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/native-tls/0.2.10/download";
      });
      build = "build.rs";
      edition = "2015";
    };
    "nom-6.2.1" = {
      pname = "nom";
      version = "6.2.1";
      depKeys = [
        ("bitvec-0.19.6")
        ("funty-1.1.0")
        ("lexical-core-0.7.6")
        ("memchr-2.3.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-nFxRuQg6PGIPpnoqY10c59lbiX6VfWso/5pdqWChA6Y=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/nom/6.2.1/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("version_check-0.9.4")
      ];
      edition = "2018";
      features = [
        ("alloc")
        ("bitvec")
        ("default")
        ("funty")
        ("lexical")
        ("lexical-core")
        ("std")
      ];
    };
    "num_cpus-1.13.1" = {
      pname = "num_cpus";
      version = "1.13.1";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GeZFJuve4YI0FXLlDprQOWWqUQzZRCekVJRI8oXpV6E=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/num_cpus/1.13.1/download";
      });
      edition = "2015";
    };
    "once_cell-1.13.1" = {
      pname = "once_cell";
      version = "1.13.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-B0hk2iBrSXO4TrkWgwINvv1qjD8POOBU2TlU6JGTXk4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/once_cell/1.13.1/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("race")
        ("std")
      ];
    };
    "opaque-debug-0.3.0" = {
      pname = "opaque-debug";
      version = "0.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YkqDQMOMG4D9VJCHhi2kukPgiFivAlsjblCbZkn8E9U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/opaque-debug/0.3.0/download";
      });
      edition = "2018";
    };
    "openssl-0.10.41" = {
      pname = "openssl";
      version = "0.10.41";
      depKeys = [
        ("bitflags-1.3.2")
        ("cfg-if-1.0.0")
        ("foreign-types-0.3.2")
        ("libc-0.2.132")
        ("once_cell-1.13.1")
        ("openssl-macros-0.1.0")
        ("openssl-sys-0.9.75")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YY/r9lM2SQ388gtz+IX1ZRoMicZMLUqMNmJYWnC/W9A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl/0.10.41/download";
      });
      build = "build.rs";
      crateRenames = {
        openssl-sys = [
          ({
            rename = "ffi";
            version = "0.9.75";
          })
        ];
      };
      edition = "2018";
    };
    "openssl-macros-0.1.0" = {
      pname = "openssl-macros";
      version = "0.1.0";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-tQHkTxFmWWDH5/zwYsfZahSt5KqYEWwASy43tb59c2w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-macros/0.1.0/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "openssl-probe-0.1.5" = {
      pname = "openssl-probe";
      version = "0.1.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-/wEaMCw5alGXaSQx/BlIAZFUr8F4uvfY43NnRCpGAc8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-probe/0.1.5/download";
      });
      edition = "2015";
    };
    "openssl-sys-0.9.75" = {
      pname = "openssl-sys";
      version = "0.9.75";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5fm9DCcQVBo82nPW+axPGyQN5K4mEGXTCdvnPZ3OtC8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-sys/0.9.75/download";
      });
      build = "build/main.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
        ("cc-1.0.73")
        ("pkg-config-0.3.25")
      ];
      edition = "2015";
    };
    "os_str_bytes-6.3.0" = {
      pname = "os_str_bytes";
      version = "6.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-n/dBXprj//EiWFHfng2eTlR5+Udhl3RnemNXLlXoDv8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/os_str_bytes/6.3.0/download";
      });
      edition = "2021";
      features = [
        ("raw_os_str")
      ];
    };
    "parking_lot-0.12.1" = {
      pname = "parking_lot";
      version = "0.12.1";
      depKeys = [
        ("lock_api-0.4.7")
        ("parking_lot_core-0.9.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-N0KywQO58GvJ//Cjf/SRKTWFG+5tNvPAK8x1W8/sIo8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot/0.12.1/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "parking_lot_core-0.9.3" = {
      pname = "parking_lot_core";
      version = "0.9.3";
      depKeys = [
        ("cfg-if-1.0.0")
        ("libc-0.2.132")
        ("smallvec-1.9.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-CaJ5y/JcsHV4EDlPvB41mUm1njSBRcZDqTmlJWkuaSk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot_core/0.9.3/download";
      });
      build = "build.rs";
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.2.16";
          })
        ];
      };
      edition = "2018";
    };
    "percent-encoding-2.1.0" = {
      pname = "percent-encoding";
      version = "2.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1P1WQdAcjxiiPae2/ikpj/S1WvzM33iXOyTPMXX+4y4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/percent-encoding/2.1.0/download";
      });
      edition = "2015";
      libPath = "lib.rs";
    };
    "pin-project-lite-0.2.9" = {
      pname = "pin-project-lite";
      version = "0.2.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-4KeuOsLxFzCF05hTHHBXVslKTFaEN4XfhaYMGgr6wRY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pin-project-lite/0.2.9/download";
      });
      edition = "2018";
    };
    "pin-utils-0.1.0" = {
      pname = "pin-utils";
      version = "0.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-i4cNjBUbby+5PoShMUYTjwXQLtEcfnxU+IJqqvfJ8YQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pin-utils/0.1.0/download";
      });
      edition = "2018";
    };
    "pkg-config-0.3.25" = {
      pname = "pkg-config";
      version = "0.3.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HfjE7EsGJ+U73yFGFa0oc2fkglWM+EsQklCzdGTcA64=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pkg-config/0.3.25/download";
      });
      edition = "2015";
    };
    "platforms-1.1.0" = {
      pname = "platforms";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-mJ1DAS4socSgJQfGcoJpGgoyB/ncZ87FlrQ/6SWz0yU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/platforms/1.1.0/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "proc-macro-error-1.0.4" = {
      pname = "proc-macro-error";
      version = "1.0.4";
      depKeys = [
        ("proc-macro-error-attr-1.0.4")
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2iVJD/mJKqs/z3w28Iz7kC3T5xyg+flRe+oCpzpc44w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("version_check-0.9.4")
      ];
      edition = "2018";
      features = [
        ("default")
        ("syn")
        ("syn-error")
      ];
    };
    "proc-macro-error-attr-1.0.4" = {
      pname = "proc-macro-error-attr";
      version = "1.0.4";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ob5AGA5S7MmK2AsYSTS689DSn5eVdOQ5r1pVJ0s1+Gk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("version_check-0.9.4")
      ];
      edition = "2018";
      procMacro = true;
    };
    "proc-macro2-1.0.43" = {
      pname = "proc-macro2";
      version = "1.0.43";
      depKeys = [
        ("unicode-ident-1.0.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-CiyixhvJ89dNKIYpSre5hTq9nBrZA6OseBXFiYm7e6s=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro2/1.0.43/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("proc-macro")
      ];
    };
    "quick-error-1.2.3" = {
      pname = "quick-error";
      version = "1.2.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-odAZQdgvoqtQvh555nFCid183njrpMB0vFpDdPZQ3+A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/quick-error/1.2.3/download";
      });
      edition = "2015";
    };
    "quote-1.0.21" = {
      pname = "quote";
      version = "1.0.21";
      depKeys = [
        ("proc-macro2-1.0.43")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-u+RI83en1pYeMPWVX5uNEGw/XkSdST7hsSXB1DwrUXk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/quote/1.0.21/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("proc-macro")
      ];
    };
    "radium-0.5.3" = {
      pname = "radium";
      version = "0.5.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lBup142OL3zkdMAV7qTZxtJbajMn+YMu4ppN4n+Ru7g=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/radium/0.5.3/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "rand-0.4.6" = {
      pname = "rand";
      version = "0.4.6";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-VShAuXATsaJpksEerDS913jkZGAaTCBUtfC/98Z2EpM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand/0.4.6/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("libc")
        ("std")
      ];
    };
    "rand_core-0.3.1" = {
      pname = "rand_core";
      version = "0.3.1";
      depKeys = [
        ("rand_core-0.4.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-em/euDsHXoJm3Mh2LCJ3b2h3pjEREh9fjHQR5b5+7Us=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand_core/0.3.1/download";
      });
      edition = "2015";
    };
    "rand_core-0.4.2" = {
      pname = "rand_core";
      version = "0.4.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-nDOjxEygX6bxgH2OZ0Pzgk6FCb7KYlZpYzvgrL31Cdw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand_core/0.4.2/download";
      });
      edition = "2015";
    };
    "rdrand-0.4.0" = {
      pname = "rdrand";
      version = "0.4.0";
      depKeys = [
        ("rand_core-0.3.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Z4BU63coa1FYG6Q2IMyRGr8CdYyR+T9Hl2eu0PkEWLI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rdrand/0.4.0/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "redox_syscall-0.2.16" = {
      pname = "redox_syscall";
      version = "0.2.16";
      depKeys = [
        ("bitflags-1.3.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-+1pYwYVbS2gZ1ZASFVYD8LIq0wytdSYAqt/LaVJlUZo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/redox_syscall/0.2.16/download";
      });
      edition = "2018";
    };
    "regex-1.4.6" = {
      pname = "regex";
      version = "1.4.6";
      depKeys = [
        ("aho-corasick-0.7.15")
        ("memchr-2.3.4")
        ("regex-syntax-0.6.27")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-KiavQYtXS9VliDNbOjZZplcl1OY26xAWwvnjs4x8x1k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/regex/1.4.6/download";
      });
      edition = "2015";
      features = [
        ("aho-corasick")
        ("default")
        ("memchr")
        ("perf")
        ("perf-cache")
        ("perf-dfa")
        ("perf-inline")
        ("perf-literal")
        ("std")
        ("unicode")
        ("unicode-age")
        ("unicode-bool")
        ("unicode-case")
        ("unicode-gencat")
        ("unicode-perl")
        ("unicode-script")
        ("unicode-segment")
      ];
    };
    "regex-syntax-0.6.27" = {
      pname = "regex-syntax";
      version = "0.6.27";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-o/h7c84RsWGaPGMy9FNB4ARxc3cei4tz+Hv+77e1YkQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/regex-syntax/0.6.27/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("unicode")
        ("unicode-age")
        ("unicode-bool")
        ("unicode-case")
        ("unicode-gencat")
        ("unicode-perl")
        ("unicode-script")
        ("unicode-segment")
      ];
    };
    "remove_dir_all-0.5.3" = {
      pname = "remove_dir_all";
      version = "0.5.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Os0SVmVCKXOjOsnT3S34XtrQ9K6bANr7GgXkOp9e+Oc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/remove_dir_all/0.5.3/download";
      });
      edition = "2015";
    };
    "reqwest-0.11.11" = {
      pname = "reqwest";
      version = "0.11.11";
      depKeys = [
        ("base64-0.13.0")
        ("bytes-1.2.1")
        ("encoding_rs-0.8.31")
        ("futures-core-0.3.23")
        ("futures-util-0.3.23")
        ("h2-0.3.14")
        ("http-0.2.8")
        ("http-body-0.4.5")
        ("hyper-0.14.20")
        ("hyper-tls-0.5.0")
        ("ipnet-2.5.0")
        ("lazy_static-1.4.0")
        ("log-0.4.17")
        ("mime-0.3.16")
        ("native-tls-0.2.10")
        ("percent-encoding-2.1.0")
        ("pin-project-lite-0.2.9")
        ("serde-1.0.144")
        ("serde_urlencoded-0.7.1")
        ("tokio-1.20.1")
        ("tokio-native-tls-0.3.0")
        ("tower-service-0.3.2")
        ("url-2.2.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-t1qmmj8Gu8xm7eM68q8lPG96hrHKADP2DFgKJwdPv5I=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/reqwest/0.11.11/download";
      });
      crateRenames = {
        native-tls = [
          ({
            rename = "native_tls_crate";
            version = "0.2.10";
          })
        ];
      };
      edition = "2018";
      features = [
        ("__tls")
        ("default")
        ("default-tls")
        ("hyper-tls")
        ("native-tls-crate")
        ("tokio-native-tls")
      ];
    };
    "ryu-1.0.11" = {
      pname = "ryu";
      version = "1.0.11";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RQGr3/OugqHBtHehclLrac7p5m65FcGrqk9E2HPfnwk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ryu/1.0.11/download";
      });
      edition = "2018";
    };
    "same-file-1.0.6" = {
      pname = "same-file";
      version = "1.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-k/wdw6qpv+2V4C5urau0uvfjB4sL0bTXtrC2g3iQBQI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/same-file/1.0.6/download";
      });
      edition = "2018";
    };
    "schannel-0.1.20" = {
      pname = "schannel";
      version = "0.1.20";
      depKeys = [
        ("lazy_static-1.4.0")
        ("windows-sys-0.36.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-iNZzEUZGLqJdkkSy7V/R1xbSXFLk1Uqk+w88TphU2+I=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/schannel/0.1.20/download";
      });
      edition = "2018";
    };
    "scopeguard-1.1.0" = {
      pname = "scopeguard";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-0pqwxtP8Dukv5m4tmfcA6rF6jVfRwdO3SDgPsguqeM0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/scopeguard/1.1.0/download";
      });
      edition = "2015";
    };
    "security-framework-2.7.0" = {
      pname = "security-framework";
      version = "2.7.0";
      depKeys = [
        ("bitflags-1.3.2")
        ("core-foundation-0.9.3")
        ("core-foundation-sys-0.8.3")
        ("libc-0.2.132")
        ("security-framework-sys-2.6.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-K8G7l4BK9mMYE8VXOfdxBx4PLtM+4gtoyG7FBdkGNWw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/security-framework/2.7.0/download";
      });
      edition = "2021";
      features = [
        ("OSX_10_9")
        ("default")
      ];
    };
    "security-framework-sys-2.6.1" = {
      pname = "security-framework-sys";
      version = "2.6.1";
      depKeys = [
        ("core-foundation-sys-0.8.3")
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-AWChOhd6Rb+0POccAVgJmEdPVWrYVNy8qTbdKEGlxVY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/security-framework-sys/2.6.1/download";
      });
      edition = "2018";
      features = [
        ("OSX_10_9")
        ("default")
      ];
    };
    "semver-1.0.13" = {
      pname = "semver";
      version = "1.0.13";
      depKeys = [
        ("serde-1.0.144")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-k/aEHnCQA9aLst7ujDQ1cr9EYAPsIKWD5297Fc6/NxE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/semver/1.0.13/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("serde")
        ("std")
      ];
    };
    "serde-1.0.144" = {
      pname = "serde";
      version = "1.0.144";
      depKeys = [
        ("serde_derive-1.0.144")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-D3R3EN49zUO4jJFodzJU6AnY3b35ZTuE4lVKshnxeGA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde/1.0.144/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("derive")
        ("serde_derive")
        ("std")
      ];
    };
    "serde_derive-1.0.144" = {
      pname = "serde_derive";
      version = "1.0.144";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lO06gW+x0QGBL4PnifiIMiw04pH4lPGVkNwxCWPoegA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_derive/1.0.144/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "serde_json-1.0.85" = {
      pname = "serde_json";
      version = "1.0.85";
      depKeys = [
        ("itoa-1.0.3")
        ("ryu-1.0.11")
        ("serde-1.0.144")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5Voo46rvnVzgUG0KFNu6gFTdx+SZ71It2LJoWeydSkQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_json/1.0.85/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
        ("unbounded_depth")
      ];
    };
    "serde_urlencoded-0.7.1" = {
      pname = "serde_urlencoded";
      version = "0.7.1";
      depKeys = [
        ("form_urlencoded-1.0.1")
        ("itoa-1.0.3")
        ("ryu-1.0.11")
        ("serde-1.0.144")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-00kcFHFcoilMTWqI8V6Ec5eIwdAw7tjBEENqr9qi8/0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_urlencoded/0.7.1/download";
      });
      edition = "2018";
    };
    "serde_yaml-0.8.26" = {
      pname = "serde_yaml";
      version = "0.8.26";
      depKeys = [
        ("indexmap-1.9.1")
        ("ryu-1.0.11")
        ("serde-1.0.144")
        ("yaml-rust-0.4.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-V4p0M7d2tWo1eF7Vzpp+d3rAWYqsWm3RtLGKMHx/xxs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_yaml/0.8.26/download";
      });
      edition = "2021";
    };
    "sha2-0.9.9" = {
      pname = "sha2";
      version = "0.9.9";
      depKeys = [
        ("block-buffer-0.9.0")
        ("cfg-if-1.0.0")
        ("cpufeatures-0.2.4")
        ("digest-0.9.0")
        ("opaque-debug-0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-TVih4b85dJgH2Jzy2YrC36D/HLP6o4+7ZN2IrIAT2AA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/sha2/0.9.9/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "shell-escape-0.1.5" = {
      pname = "shell-escape";
      version = "0.1.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RbtnoY+pEmbMeAcYH2L5F4poc7+tfceIxC5kMNtAGE8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/shell-escape/0.1.5/download";
      });
      edition = "2015";
    };
    "signal-hook-registry-1.4.0" = {
      pname = "signal-hook-registry";
      version = "1.4.0";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5R5zMo3ErAx8y9o6SU36A98d4vRgGBJ/YMaT8mSEVbA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/signal-hook-registry/1.4.0/download";
      });
      edition = "2015";
    };
    "slab-0.4.7" = {
      pname = "slab";
      version = "0.4.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RhSnayqL4AWMqp27r2bZiFJ9htADwRqU+9M112Ye3O8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/slab/0.4.7/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
      ];
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "smallvec-1.9.0" = {
      pname = "smallvec";
      version = "1.9.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-L9DbdJWX2R/4Yv0dVeqH94VadEqEJaZGlbb8ojfR2tE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/smallvec/1.9.0/download";
      });
      edition = "2018";
    };
    "socket2-0.4.4" = {
      pname = "socket2";
      version = "0.4.4";
      depKeys = [
        ("libc-0.2.132")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ZtcrdZQ2rjKJiirwoUIY2/Ve/eP+6xcOtiNjfbhe4eA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/socket2/0.4.4/download";
      });
      edition = "2018";
      features = [
        ("all")
      ];
    };
    "static_assertions-1.1.0" = {
      pname = "static_assertions";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ouuTSbZESzJocuFA6xz158UiFU1p56D/sPuBwGs3VD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/static_assertions/1.1.0/download";
      });
      edition = "2015";
    };
    "strsim-0.10.0" = {
      pname = "strsim";
      version = "0.10.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-c0c8Dlnm1YEsXf4qBkpkRJSfCJ4g7smi5VBllklORiM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/strsim/0.10.0/download";
      });
      edition = "2015";
    };
    "syn-1.0.99" = {
      pname = "syn";
      version = "1.0.99";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("unicode-ident-1.0.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WNvvbsZVBV4guGsVqMxtQ5zKGbZnU3rGoTaVctFRqxM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/syn/1.0.99/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("clone-impls")
        ("default")
        ("derive")
        ("full")
        ("parsing")
        ("printing")
        ("proc-macro")
        ("quote")
        ("visit")
        ("visit-mut")
      ];
    };
    "tap-1.0.1" = {
      pname = "tap";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-VZN+F5kYWxKGPUR/Qll+1p2ZKGhrjYih3xc3agl9g2k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tap/1.0.1/download";
      });
      edition = "2015";
    };
    "tempdir-0.3.7" = {
      pname = "tempdir";
      version = "0.3.7";
      depKeys = [
        ("rand-0.4.6")
        ("remove_dir_all-0.5.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FfK1+wDM32ieAUnRsbPAP+rYHCs3c12BL6i9279Bttg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tempdir/0.3.7/download";
      });
      edition = "2015";
    };
    "tempfile-3.3.0" = {
      pname = "tempfile";
      version = "3.3.0";
      depKeys = [
        ("cfg-if-1.0.0")
        ("fastrand-1.8.0")
        ("libc-0.2.132")
        ("remove_dir_all-0.5.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-XNse9OrurdyPvTceUBcFcGSvCRGQLvNrOYAfZ8xteeQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tempfile/3.3.0/download";
      });
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.2.16";
          })
        ];
      };
      edition = "2018";
    };
    "termcolor-1.1.3" = {
      pname = "termcolor";
      version = "1.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-urJNMLkRsjdvOhPMLNRDFC8Mgd2gTBGGk+NbODV1d1U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/termcolor/1.1.3/download";
      });
      edition = "2018";
    };
    "textwrap-0.15.0" = {
      pname = "textwrap";
      version = "0.15.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-sRQdTWEJWyhBniLLC78CdV9eVOBSb5fx49HRYOYIhfs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/textwrap/0.15.0/download";
      });
      edition = "2018";
    };
    "tinyvec-1.6.0" = {
      pname = "tinyvec";
      version = "1.6.0";
      depKeys = [
        ("tinyvec_macros-0.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-h8xc6zh1uyDCiQAFpOImpGUSZKXHXtskIbUoYaCgy1A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tinyvec/1.6.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("tinyvec_macros")
      ];
    };
    "tinyvec_macros-0.1.0" = {
      pname = "tinyvec_macros";
      version = "0.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-zadNp+GmZPeVux+Kh+xAb7iaAlIs9uUGINAWrdbbv1w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tinyvec_macros/0.1.0/download";
      });
      edition = "2018";
    };
    "tokio-1.20.1" = {
      pname = "tokio";
      version = "1.20.1";
      depKeys = [
        ("bytes-1.2.1")
        ("libc-0.2.132")
        ("memchr-2.3.4")
        ("mio-0.8.4")
        ("num_cpus-1.13.1")
        ("once_cell-1.13.1")
        ("parking_lot-0.12.1")
        ("pin-project-lite-0.2.9")
        ("signal-hook-registry-1.4.0")
        ("socket2-0.4.4")
        ("tokio-macros-1.8.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-eoMl9jp9R3TdBB42OyQJ7Rxcu9D4Z3leZh3wZrKwpYE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio/1.20.1/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
      ];
      edition = "2018";
      features = [
        ("bytes")
        ("default")
        ("fs")
        ("full")
        ("io-std")
        ("io-util")
        ("libc")
        ("macros")
        ("memchr")
        ("mio")
        ("net")
        ("num_cpus")
        ("once_cell")
        ("parking_lot")
        ("process")
        ("rt")
        ("rt-multi-thread")
        ("signal")
        ("signal-hook-registry")
        ("socket2")
        ("sync")
        ("time")
        ("tokio-macros")
        ("winapi")
      ];
    };
    "tokio-macros-1.8.0" = {
      pname = "tokio-macros";
      version = "1.8.0";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lyT5qXX7mH73o82b4DUO3L4TBpivW496Yx4j1C0FJIQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-macros/1.8.0/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "tokio-native-tls-0.3.0" = {
      pname = "tokio-native-tls";
      version = "0.3.0";
      depKeys = [
        ("native-tls-0.2.10")
        ("tokio-1.20.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-99mVZgvSt/jBVoQUwRJgdsE/u3JcQBEtwBILeOubcXs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-native-tls/0.3.0/download";
      });
      edition = "2018";
    };
    "tokio-util-0.7.3" = {
      pname = "tokio-util";
      version = "0.7.3";
      depKeys = [
        ("bytes-1.2.1")
        ("futures-core-0.3.23")
        ("futures-sink-0.3.23")
        ("pin-project-lite-0.2.9")
        ("tokio-1.20.1")
        ("tracing-0.1.36")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-zEY82N7dw3cNIPmFIUPVC/YJTmQLSFyy4YmiCZCF/0U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-util/0.7.3/download";
      });
      edition = "2018";
      features = [
        ("codec")
        ("default")
        ("tracing")
      ];
    };
    "tower-service-0.3.2" = {
      pname = "tower-service";
      version = "0.3.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-trwcnOK1E1rH+TxykY/Df+uHK9xqVTOouF60uGv9rlI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tower-service/0.3.2/download";
      });
      edition = "2018";
    };
    "tracing-0.1.36" = {
      pname = "tracing";
      version = "0.1.36";
      depKeys = [
        ("cfg-if-1.0.0")
        ("pin-project-lite-0.2.9")
        ("tracing-core-0.1.29")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-L86VZ71gpn0IoWSIdWchujkvJPKQBkAogeQ7GarGQwc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing/0.1.36/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "tracing-core-0.1.29" = {
      pname = "tracing-core";
      version = "0.1.29";
      depKeys = [
        ("once_cell-1.13.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Wu6kMDB2VYoAcUuCP5rWfViju9od+D2IJ9IRkxVuIvc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing-core/0.1.29/download";
      });
      edition = "2018";
      features = [
        ("once_cell")
        ("std")
      ];
    };
    "try-lock-0.2.3" = {
      pname = "try-lock";
      version = "0.2.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WVR7znHZw4uD2cDpK2BmxCUzcfFQBd7www2WV/UMdkI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/try-lock/0.2.3/download";
      });
      edition = "2015";
    };
    "typenum-1.15.0" = {
      pname = "typenum";
      version = "1.15.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-3PgaxZ7cF8yGl/8xHo9e8tmfy9mBezTOxm+QtsPf2Yc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/typenum/1.15.0/download";
      });
      build = "build/main.rs";
      edition = "2018";
    };
    "unicode-bidi-0.3.8" = {
      pname = "unicode-bidi";
      version = "0.3.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-CZtxKDAdKF953dVbmoPV5rnpfJLg6g2uvucmPpMt6ZI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-bidi/0.3.8/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("hardcoded-data")
        ("std")
      ];
    };
    "unicode-ident-1.0.3" = {
      pname = "unicode-ident";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-xPWzehVJmajz+YzCOmKNhQ4VRHnNlN7PNBRpbhLjGq8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-ident/1.0.3/download";
      });
      edition = "2018";
    };
    "unicode-normalization-0.1.21" = {
      pname = "unicode-normalization";
      version = "0.1.21";
      depKeys = [
        ("tinyvec-1.6.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-hUy9xPe8auGcgg1Eq9wyd6w+GyuT2yCmNoJdkyL7YOY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-normalization/0.1.21/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "unicode-width-0.1.9" = {
      pname = "unicode-width";
      version = "0.1.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-PtdC1Oor0RduI2FyyEKar1RIbnrAmNsp/+ZSngzlCXM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-width/0.1.9/download";
      });
      edition = "2015";
      features = [
        ("default")
      ];
    };
    "url-2.2.2" = {
      pname = "url";
      version = "2.2.2";
      depKeys = [
        ("form_urlencoded-1.0.1")
        ("idna-0.2.3")
        ("matches-0.1.9")
        ("percent-encoding-2.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-pQfDg7LTO1/DXRhh535rOD0Viy2l4U/lG4Pf7fb9V4w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/url/2.2.2/download";
      });
      edition = "2018";
    };
    "vcpkg-0.2.15" = {
      pname = "vcpkg";
      version = "0.2.15";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-rM1Opi97t6gv4jBm+wlX1I72d/buuCFfNy9S5IuzJCY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/vcpkg/0.2.15/download";
      });
      edition = "2015";
    };
    "version_check-0.9.4" = {
      pname = "version_check";
      version = "0.9.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-SYdLUWe2XXGTuKuhVn9cfZPQAcr8NGAM7gA+2nh+SD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/version_check/0.9.4/download";
      });
      edition = "2015";
    };
    "walkdir-2.3.2" = {
      pname = "walkdir";
      version = "2.3.2";
      depKeys = [
        ("same-file-1.0.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-gIzyc1zUtoZhE/ZIt5HGrcVxRTe8Ii2TR7sgM4b/2lY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/walkdir/2.3.2/download";
      });
      edition = "2018";
    };
    "want-0.3.0" = {
      pname = "want";
      version = "0.3.0";
      depKeys = [
        ("log-0.4.17")
        ("try-lock-0.2.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HOipaMsc0RDRNv+LgZpVbW+22Rk2PGFTT2hgx+sXK6A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/want/0.3.0/download";
      });
      edition = "2018";
    };
    "wasi-0.11.0+wasi-snapshot-preview1" = {
      pname = "wasi";
      version = "0.11.0-wasi-snapshot-preview1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-nI2H5ytko7TbKNEc4pI3wkYYj09RBX1lp+q2O3mH5CM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasi/0.11.0+wasi-snapshot-preview1/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "wasm-bindgen-0.2.82" = {
      pname = "wasm-bindgen";
      version = "0.2.82";
      depKeys = [
        ("cfg-if-1.0.0")
        ("wasm-bindgen-macro-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-/HZS4/bEcGyNnNVIMsSkzLm1M24sO9FU1czPvxwfX30=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen/0.2.82/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("spans")
        ("std")
      ];
    };
    "wasm-bindgen-backend-0.2.82" = {
      pname = "wasm-bindgen-backend";
      version = "0.2.82";
      depKeys = [
        ("bumpalo-3.11.0")
        ("log-0.4.17")
        ("once_cell-1.13.1")
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
        ("wasm-bindgen-shared-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ZizUSAVYa9UpcblYax34XNu9kRLk702PQVWcM03GrD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-backend/0.2.82/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-futures-0.4.32" = {
      pname = "wasm-bindgen-futures";
      version = "0.4.32";
      depKeys = [
        ("cfg-if-1.0.0")
        ("js-sys-0.3.59")
        ("wasm-bindgen-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-+nb7Ihofis3fW1Ss6FkSYGmArWYax6UDtFcP/TpiTa0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-futures/0.4.32/download";
      });
      edition = "2018";
    };
    "wasm-bindgen-macro-0.2.82" = {
      pname = "wasm-bindgen-macro";
      version = "0.2.82";
      depKeys = [
        ("quote-1.0.21")
        ("wasm-bindgen-macro-support-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-smDxPTASBx37FRKEnAM7GSUDg3OupIztMBLAnflSxgI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.82/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
      procMacro = true;
    };
    "wasm-bindgen-macro-support-0.2.82" = {
      pname = "wasm-bindgen-macro-support";
      version = "0.2.82";
      depKeys = [
        ("proc-macro2-1.0.43")
        ("quote-1.0.21")
        ("syn-1.0.99")
        ("wasm-bindgen-backend-0.2.82")
        ("wasm-bindgen-shared-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-W+jmVL3Zt5IWwpKauQchqoL69lxIzfCL3E5/UTV7gNo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.82/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-shared-0.2.82" = {
      pname = "wasm-bindgen-shared";
      version = "0.2.82";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ZZjdC9PH1RCV/2UxpbI+AqzcgYBOMNjwevt3tyFaFAo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.82/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "web-sys-0.3.59" = {
      pname = "web-sys";
      version = "0.3.59";
      depKeys = [
        ("js-sys-0.3.59")
        ("wasm-bindgen-0.2.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-7QVasn+UFCMZfrhrIDVyCxo85AUE3wgsrC7MbtczNaE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/web-sys/0.3.59/download";
      });
      edition = "2018";
      features = [
        ("Blob")
        ("BlobPropertyBag")
        ("Event")
        ("EventTarget")
        ("File")
        ("FormData")
        ("Headers")
        ("MessageEvent")
        ("Request")
        ("RequestCredentials")
        ("RequestInit")
        ("RequestMode")
        ("Response")
        ("ServiceWorkerGlobalScope")
        ("Window")
        ("Worker")
        ("WorkerGlobalScope")
      ];
    };
    "winapi-0.3.9" = {
      pname = "winapi";
      version = "0.3.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-XIOaZ0/NepiVLlkyQupACr6TmSdGdh44ZBQF0osA9Bk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi/0.3.9/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("consoleapi")
        ("errhandlingapi")
        ("fileapi")
        ("handleapi")
        ("impl-debug")
        ("impl-default")
        ("ioapiset")
        ("minwinbase")
        ("minwindef")
        ("namedpipeapi")
        ("ntdef")
        ("ntsecapi")
        ("processenv")
        ("processthreadsapi")
        ("profileapi")
        ("std")
        ("synchapi")
        ("threadpoollegacyapiset")
        ("timezoneapi")
        ("winbase")
        ("wincon")
        ("wincrypt")
        ("winerror")
        ("winnt")
        ("winreg")
        ("winsock2")
        ("ws2def")
        ("ws2ipdef")
        ("ws2tcpip")
      ];
    };
    "winapi-i686-pc-windows-gnu-0.4.0" = {
      pname = "winapi-i686-pc-windows-gnu";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-rDuHxjYgQm3ZuZHlzgMp7/VFvMu7NPO+Cf9vtqtRt7Y=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download";
      });
      build = "build.rs";
      edition = "2015";
    };
    "winapi-util-0.1.5" = {
      pname = "winapi-util";
      version = "0.1.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cOxs6FuxWBUcrl5ch/lajpfSwMSwASI/M6M0485d4Xg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi-util/0.1.5/download";
      });
      edition = "2018";
    };
    "winapi-x86_64-pc-windows-gnu-0.4.0" = {
      pname = "winapi-x86_64-pc-windows-gnu";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cS4ieEHQV8HuHNL7Ivp+WlRhro5I+iynnsQs/BkxGD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download";
      });
      build = "build.rs";
      edition = "2015";
    };
    "windows-sys-0.36.1" = {
      pname = "windows-sys";
      version = "0.36.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-6gQVWhaln56reG/hKkpFDnXNsXX54NgNoeF9sJ9VuNI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows-sys/0.36.1/download";
      });
      edition = "2018";
      features = [
        ("Win32")
        ("Win32_Foundation")
        ("Win32_Networking")
        ("Win32_Networking_WinSock")
        ("Win32_Security")
        ("Win32_Security_Authentication")
        ("Win32_Security_Authentication_Identity")
        ("Win32_Security_Credentials")
        ("Win32_Security_Cryptography")
        ("Win32_Storage")
        ("Win32_Storage_FileSystem")
        ("Win32_System")
        ("Win32_System_IO")
        ("Win32_System_LibraryLoader")
        ("Win32_System_Memory")
        ("Win32_System_Pipes")
        ("Win32_System_SystemServices")
        ("Win32_System_WindowsProgramming")
        ("default")
      ];
    };
    "windows_aarch64_msvc-0.36.1" = {
      pname = "windows_aarch64_msvc";
      version = "0.36.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-m7jD/Tmt4tZ+mHSsTz2yHw1xC+4A/nyrFpSewYTuqkc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.36.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_i686_gnu-0.36.1" = {
      pname = "windows_i686_gnu";
      version = "0.36.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GA5szwHa9MQmuEbfxm2x/FGPB0uqeTqn2bmq7/rWo7Y=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_i686_gnu/0.36.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_i686_msvc-0.36.1" = {
      pname = "windows_i686_msvc";
      version = "0.36.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-4ueRcUiygS0e6vrrIql+SBPfpgo/j3jr4gS8yI8S8CQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_i686_msvc/0.36.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_gnu-0.36.1" = {
      pname = "windows_x86_64_gnu";
      version = "0.36.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Tc0XG4d2xBuXUh5doSei2GrSgBFIB9Cyqx5GK8dk2eE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.36.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_msvc-0.36.1" = {
      pname = "windows_x86_64_msvc";
      version = "0.36.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-yBHKSoyFPvQgq9hZK6U927rJBBD6tpA7PnmXKmMfdoA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.36.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "winreg-0.10.1" = {
      pname = "winreg";
      version = "0.10.1";
      depKeys = [
        ("winapi-0.3.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-gND04nLIXe8TlHY4CxL5rGCSZondLgHUkjIi9AWAhp0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winreg/0.10.1/download";
      });
      build = "build.rs";
      edition = "2015";
    };
    "wyz-0.2.0" = {
      pname = "wyz";
      version = "0.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-heYLDRtfmdslVpNOIZNwIHdqXTFSC/Fp6FGsROZCAhQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wyz/0.2.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
      ];
    };
    "yaml-rust-0.4.5" = {
      pname = "yaml-rust";
      version = "0.4.5";
      depKeys = [
        ("linked-hash-map-0.5.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-VsGTbEzHocmrIaHrtgLrlCuoaMvUSpnLfNxYkjNeHIU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/yaml-rust/0.4.5/download";
      });
      edition = "2018";
    };
  };
}