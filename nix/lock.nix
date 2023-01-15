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
    "async-trait-0.1.61" = {
      pname = "async-trait";
      version = "0.1.61";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cFM54OSpaQ4pCNKz0EnYVoLPGfvVeCSUSY+/cAOmooI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/async-trait/0.1.61/download";
      });
      build = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "atty-0.2.14" = {
      pname = "atty";
      version = "0.2.14";
      depKeys = [
        ("libc-0.2.139")
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
    "base64-0.13.1" = {
      pname = "base64";
      version = "0.13.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-nhtYYnPFcCk2/nt9aJZkTYvnHmMUz+CdMWfJX3Elieg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/base64/0.13.1/download";
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
    "bumpalo-3.11.1" = {
      pname = "bumpalo";
      version = "3.11.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Vy9pUTYhEYgwjxatLKXIUacSxGQGCuaXSURFjrg4gLo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bumpalo/3.11.1/download";
      });
      edition = "2021";
      features = [
        ("default")
      ];
    };
    "bytes-1.3.0" = {
      pname = "bytes";
      version = "1.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-37JOhmsVoa8qG2Y/EMa2uPOXqEqtuCjxLlsonsI6Ojw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bytes/1.3.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "camino-1.1.2" = {
      pname = "camino";
      version = "1.1.2";
      depKeys = [
        ("serde-1.0.152")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-x33wQdw4MxnMZhtCi2lhoAXbTWgI1eElNpMbHKlVYFU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/camino/1.1.2/download";
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
        ("serde-1.0.152")
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
        ("crypto-hash-0.3.4")
        ("filetime-0.2.19")
        ("hex-0.4.3")
        ("jobserver-0.1.25")
        ("libc-0.2.139")
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
        ("camino-1.1.2")
        ("cargo-platform-0.1.2")
        ("semver-1.0.16")
        ("serde-1.0.152")
        ("serde_json-1.0.91")
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
    "cc-1.0.78" = {
      pname = "cc";
      version = "1.0.78";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ogEE4jNc6KZZ1t2SpRp2egwGJZnHOzQ/0VLLQB6CjD0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cc/1.0.78/download";
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
    "clap-3.2.23" = {
      pname = "clap";
      version = "3.2.23";
      depKeys = [
        ("atty-0.2.14")
        ("bitflags-1.3.2")
        ("clap_derive-3.2.18")
        ("clap_lex-0.2.4")
        ("indexmap-1.9.2")
        ("once_cell-1.17.0")
        ("strsim-0.10.0")
        ("termcolor-1.2.0")
        ("textwrap-0.16.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cWVcRcuYRdMnDJ1t+E6+crTa08K6P3AjrUfBROTkc6U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap/3.2.23/download";
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
    "clap_derive-3.2.18" = {
      pname = "clap_derive";
      version = "3.2.18";
      depKeys = [
        ("heck-0.4.0")
        ("proc-macro-error-1.0.4")
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-6gyLzlKMS+TaE+pv6tiWXpW2BzWFovBSBL2PQRn4KmU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap_derive/3.2.18/download";
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
        ("os_str_bytes-6.4.1")
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
        ("libc-0.2.139")
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
        ("libc-0.2.139")
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
    "cpufeatures-0.2.5" = {
      pname = "cpufeatures";
      version = "0.2.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-KNmXvV4kpZKN1D5G3FKYZ+IHkH/gsjnDR32ST38soyA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cpufeatures/0.2.5/download";
      });
      edition = "2018";
    };
    "crypto-hash-0.3.4" = {
      pname = "crypto-hash";
      version = "0.3.4";
      depKeys = [
        ("hex-0.3.2")
        ("openssl-0.10.45")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-incWIkD9lySNGaVkpWXrVjo/WSs4bkE2+zAJCeZ93co=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/crypto-hash/0.3.4/download";
      });
      edition = "2015";
    };
    "data-encoding-2.3.3" = {
      pname = "data-encoding";
      version = "2.3.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-I9hmbLAVM8Od3jK8urjiJ7TtZnmyySXroF/qvqOVCPs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/data-encoding/2.3.3/download";
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
        ("termcolor-1.2.0")
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
        ("async-trait-0.1.61")
        ("cargo-platform-0.1.2")
        ("cargo-util-0.1.2")
        ("cargo_metadata-0.14.2")
        ("clap-3.2.23")
        ("data-encoding-2.3.3")
        ("either-1.8.0")
        ("env_logger-0.7.1")
        ("fs2-0.4.3")
        ("futures-0.3.25")
        ("getopts-0.2.21")
        ("lazy_static-1.4.0")
        ("log-0.4.17")
        ("nom-6.2.1")
        ("percent-encoding-2.2.0")
        ("platforms-1.1.0")
        ("regex-1.4.6")
        ("reqwest-0.11.13")
        ("serde-1.0.152")
        ("serde_json-1.0.91")
        ("serde_yaml-0.8.26")
        ("sha2-0.9.9")
        ("tempdir-0.3.7")
        ("tokio-1.24.1")
      ];
      src = (final.pathSrc ../../.);
      crateBin = [
        ({
          name = "fetlock";
          path = "src/bin/fetlock.rs";
        })
      ];
      edition = "2018";
    };
    "filetime-0.2.19" = {
      pname = "filetime";
      version = "0.2.19";
      depKeys = [
        ("cfg-if-1.0.0")
        ("libc-0.2.139")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-TohGaM0MdIBQQjPpURdN3Ds4L3wmZuO3MQtcTnsMN/k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/filetime/0.2.19/download";
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
    "form_urlencoded-1.1.0" = {
      pname = "form_urlencoded";
      version = "1.1.0";
      depKeys = [
        ("percent-encoding-2.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-qcOE8WEVb1JgwkoJfFYRn5vox5hYauzBOvvL57fia/g=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/form_urlencoded/1.1.0/download";
      });
      edition = "2018";
    };
    "fs2-0.4.3" = {
      pname = "fs2";
      version = "0.4.3";
      depKeys = [
        ("libc-0.2.139")
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
    "futures-0.3.25" = {
      pname = "futures";
      version = "0.3.25";
      depKeys = [
        ("futures-channel-0.3.25")
        ("futures-core-0.3.25")
        ("futures-executor-0.3.25")
        ("futures-io-0.3.25")
        ("futures-sink-0.3.25")
        ("futures-task-0.3.25")
        ("futures-util-0.3.25")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ODkBBHY9w3pRRaU8KcY8EpC10xbWCG7DLCk/ZzYFG7A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures/0.3.25/download";
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
    "futures-channel-0.3.25" = {
      pname = "futures-channel";
      version = "0.3.25";
      depKeys = [
        ("futures-core-0.3.25")
        ("futures-sink-0.3.25")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-UromWpIlYQX0W3GWBaVx/+LR8P6jgHMEtSLB13j3nu0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-channel/0.3.25/download";
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
    "futures-core-0.3.25" = {
      pname = "futures-core";
      version = "0.3.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-BJCaen5GM65sSpqygK64baEjYkOne2lKSerNZZpL06w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-core/0.3.25/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-executor-0.3.25" = {
      pname = "futures-executor";
      version = "0.3.25";
      depKeys = [
        ("futures-core-0.3.25")
        ("futures-task-0.3.25")
        ("futures-util-0.3.25")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-esyF32cUwXarXt84YSP6/iF76IwIQOwR8ZlEETSgdOI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-executor/0.3.25/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-io-0.3.25" = {
      pname = "futures-io";
      version = "0.3.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-APX7UqBr3K3rVOjTZx+IiKOWl9ywuBsjtVF0AwQn9Os=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-io/0.3.25/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-macro-0.3.25" = {
      pname = "futures-macro";
      version = "0.3.25";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vfuM4FPYa5GRmq2YDCILH7hAGpOUQQ4cKJ7X5mthg10=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-macro/0.3.25/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "futures-sink-0.3.25" = {
      pname = "futures-sink";
      version = "0.3.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-OcFc8aSqed9A8btGL7OWdtCtnjZsKjO1kNfGb0+B/Pk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-sink/0.3.25/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-task-0.3.25" = {
      pname = "futures-task";
      version = "0.3.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-L/s5OsXZpuqp0/3zeuJ3Zla3BuIAyOFrG9sif1GY5uo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-task/0.3.25/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "futures-util-0.3.25" = {
      pname = "futures-util";
      version = "0.3.25";
      depKeys = [
        ("futures-channel-0.3.25")
        ("futures-core-0.3.25")
        ("futures-io-0.3.25")
        ("futures-macro-0.3.25")
        ("futures-sink-0.3.25")
        ("futures-task-0.3.25")
        ("memchr-2.3.4")
        ("pin-project-lite-0.2.9")
        ("pin-utils-0.1.0")
        ("slab-0.4.7")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GXZ2mHq9L5yt/4SSb0EK8cGDYI02ZBRl33OughHcZdY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-util/0.3.25/download";
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
        ("typenum-1.16.0")
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
        ("unicode-width-0.1.10")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FNu/1ccdcCQez55vE3N/e1zoI4IQYxiNfkbEHTce69U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/getopts/0.2.21/download";
      });
      edition = "2015";
    };
    "h2-0.3.15" = {
      pname = "h2";
      version = "0.3.15";
      depKeys = [
        ("bytes-1.3.0")
        ("fnv-1.0.7")
        ("futures-core-0.3.25")
        ("futures-sink-0.3.25")
        ("futures-util-0.3.25")
        ("http-0.2.8")
        ("indexmap-1.9.2")
        ("slab-0.4.7")
        ("tokio-1.24.1")
        ("tokio-util-0.7.4")
        ("tracing-0.1.37")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-X58pvJ3aNVJWspFs9SarAs4K6qryutYNZe8/EvEd0PQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/h2/0.3.15/download";
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
        ("libc-0.2.139")
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
    "hermit-abi-0.2.6" = {
      pname = "hermit-abi";
      version = "0.2.6";
      depKeys = [
        ("libc-0.2.139")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-7lEmQP41rL+0u3edtvDYBwTCys+i45tgHvPj9H0a5Mc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hermit-abi/0.2.6/download";
      });
      edition = "2021";
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
        ("bytes-1.3.0")
        ("fnv-1.0.7")
        ("itoa-1.0.5")
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
        ("bytes-1.3.0")
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
    "httparse-1.8.0" = {
      pname = "httparse";
      version = "1.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2JfzlLrWpwXV9BBHYuEWp1Y55HDYCQHu0FqGCpXLGQQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/httparse/1.8.0/download";
      });
      build = "build.rs";
      edition = "2018";
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
    "hyper-0.14.23" = {
      pname = "hyper";
      version = "0.14.23";
      depKeys = [
        ("bytes-1.3.0")
        ("futures-channel-0.3.25")
        ("futures-core-0.3.25")
        ("futures-util-0.3.25")
        ("h2-0.3.15")
        ("http-0.2.8")
        ("http-body-0.4.5")
        ("httparse-1.8.0")
        ("httpdate-1.0.2")
        ("itoa-1.0.5")
        ("pin-project-lite-0.2.9")
        ("socket2-0.4.7")
        ("tokio-1.24.1")
        ("tower-service-0.3.2")
        ("tracing-0.1.37")
        ("want-0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-A0cR+qydIWbLG68aL7C2Cx8nf4SS/XIXbBfzUV4avTw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper/0.14.23/download";
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
        ("bytes-1.3.0")
        ("hyper-0.14.23")
        ("native-tls-0.2.11")
        ("tokio-1.24.1")
        ("tokio-native-tls-0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1hg936mbhdphoUC+oO/JP99WzqoEGzfVU1GAMIJ/mQU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper-tls/0.5.0/download";
      });
      edition = "2018";
    };
    "idna-0.3.0" = {
      pname = "idna";
      version = "0.3.0";
      depKeys = [
        ("unicode-bidi-0.3.8")
        ("unicode-normalization-0.1.22")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-4U3fxwiEIC2yJEwiMgDCBMK9obxuCZjRG14CTWVyCeY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/idna/0.3.0/download";
      });
      edition = "2018";
    };
    "indexmap-1.9.2" = {
      pname = "indexmap";
      version = "1.9.2";
      depKeys = [
        ("hashbrown-0.12.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GIXnnB/EsQ8OFyxHX0WLf3uTBhBk2Ywyk+mMW6DIs5k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/indexmap/1.9.2/download";
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
    "ipnet-2.7.1" = {
      pname = "ipnet";
      version = "2.7.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-MOIr2GKTWYlUULWep6d2yFBWG5ajsdMTIcGUnZ5skUY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ipnet/2.7.1/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "itoa-1.0.5" = {
      pname = "itoa";
      version = "1.0.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-+tWC9Lnoa2yqYhyr6wljMy2S7qBHKasSiSwlM5UeZEA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/itoa/1.0.5/download";
      });
      edition = "2018";
    };
    "jobserver-0.1.25" = {
      pname = "jobserver";
      version = "0.1.25";
      depKeys = [
        ("libc-0.2.139")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Bose5nQ+TRH7nGoeYGSzaTobYA5/X1mIBH2Ys9yfuQs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/jobserver/0.1.25/download";
      });
      edition = "2018";
    };
    "js-sys-0.3.60" = {
      pname = "js-sys";
      version = "0.3.60";
      depKeys = [
        ("wasm-bindgen-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-SUCd8+O/CFa5FuLOrKCe4o5occ99nOl6aSys/bKiWkc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/js-sys/0.3.60/download";
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
        ("ryu-1.0.12")
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
    "libc-0.2.139" = {
      pname = "libc";
      version = "0.2.139";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-IB3jJ1IN8Ad1fB8K3OboJ/6FYvvCi/2cFVccZsofX3k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/libc/0.2.139/download";
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
    "lock_api-0.4.9" = {
      pname = "lock_api";
      version = "0.4.9";
      depKeys = [
        ("scopeguard-1.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Q1ARNm/lZYOxbPlW+d8AlbQFuC12QlvImBwOIuYOxN8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lock_api/0.4.9/download";
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
    "mio-0.8.5" = {
      pname = "mio";
      version = "0.8.5";
      depKeys = [
        ("libc-0.2.139")
        ("log-0.4.17")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5dcyvDAgemQjBo3wQ+PQLgc1sVWtfOGm92/iuqWxWN4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/mio/0.8.5/download";
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
    "native-tls-0.2.11" = {
      pname = "native-tls";
      version = "0.2.11";
      depKeys = [
        ("log-0.4.17")
        ("openssl-0.10.45")
        ("openssl-probe-0.1.5")
        ("openssl-sys-0.9.80")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ByJhc8MvKSYCe2PM5LzYB2w1UoRsvnkl86r/6sCjuS4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/native-tls/0.2.11/download";
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
    "num_cpus-1.15.0" = {
      pname = "num_cpus";
      version = "1.15.0";
      depKeys = [
        ("libc-0.2.139")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-D6yeLaE7XrRHps49OS8jop2GlL/3gb8DoWzZrIaXWTs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/num_cpus/1.15.0/download";
      });
      edition = "2015";
    };
    "once_cell-1.17.0" = {
      pname = "once_cell";
      version = "1.17.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-b2H7oXQeorPWoeMXhyGAS7cWpopq66EUm11S49Rk6mY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/once_cell/1.17.0/download";
      });
      edition = "2021";
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
    "openssl-0.10.45" = {
      pname = "openssl";
      version = "0.10.45";
      depKeys = [
        ("bitflags-1.3.2")
        ("cfg-if-1.0.0")
        ("foreign-types-0.3.2")
        ("libc-0.2.139")
        ("once_cell-1.17.0")
        ("openssl-macros-0.1.0")
        ("openssl-sys-0.9.80")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-sQJCj9A7xe35f2JiD3KYYUxFzt8ofCceftRQu6+D8uE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl/0.10.45/download";
      });
      build = "build.rs";
      crateRenames = {
        openssl-sys = [
          ({
            rename = "ffi";
            version = "0.9.80";
          })
        ];
      };
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "openssl-macros-0.1.0" = {
      pname = "openssl-macros";
      version = "0.1.0";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
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
    "openssl-sys-0.9.80" = {
      pname = "openssl-sys";
      version = "0.9.80";
      depKeys = [
        ("libc-0.2.139")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-I7u/eFTNRbg5WOvpGfDo5RZ5NydlLif9oQqDhM/HkLc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-sys/0.9.80/download";
      });
      build = "build/main.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
        ("cc-1.0.78")
        ("pkg-config-0.3.26")
      ];
      edition = "2015";
    };
    "os_str_bytes-6.4.1" = {
      pname = "os_str_bytes";
      version = "6.4.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-m3ggudrqVFfJ8hxpRIkF1yP70hE2zPUhdI8j/UnnI+4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/os_str_bytes/6.4.1/download";
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
        ("lock_api-0.4.9")
        ("parking_lot_core-0.9.6")
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
    "parking_lot_core-0.9.6" = {
      pname = "parking_lot_core";
      version = "0.9.6";
      depKeys = [
        ("cfg-if-1.0.0")
        ("libc-0.2.139")
        ("smallvec-1.10.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-uh74gUtcmTQQuzrfrXpe0mlWPkovkMQfXYW+f7RxM78=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot_core/0.9.6/download";
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
    "percent-encoding-2.2.0" = {
      pname = "percent-encoding";
      version = "2.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-R4xXLD1zGB/zwlOQRfbrmeVJEhjq6Rk3CZO4kM292Y4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/percent-encoding/2.2.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
      ];
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
    "pkg-config-0.3.26" = {
      pname = "pkg-config";
      version = "0.3.26";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-asmln3NHPxuNhSQh5Z5kgJ8CWZSDfvdDYVxtDFswUWA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pkg-config/0.3.26/download";
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
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
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
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
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
    "proc-macro2-1.0.49" = {
      pname = "proc-macro2";
      version = "1.0.49";
      depKeys = [
        ("unicode-ident-1.0.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-V6jsqfnE/95BcUM03ud3WWJkx4JUIPUhq8krW13rY6U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro2/1.0.49/download";
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
    "quote-1.0.23" = {
      pname = "quote";
      version = "1.0.23";
      depKeys = [
        ("proc-macro2-1.0.49")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-iFbYNk0lKhTUdANuoTWNY8nmllyOXBiFwY9z1wv/nHs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/quote/1.0.23/download";
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
        ("libc-0.2.139")
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
        ("regex-syntax-0.6.28")
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
    "regex-syntax-0.6.28" = {
      pname = "regex-syntax";
      version = "0.6.28";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RWxgO+Po1EiwcvQQkAwJ+vFk+84tSARW9Q7qbiX5yEg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/regex-syntax/0.6.28/download";
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
    "reqwest-0.11.13" = {
      pname = "reqwest";
      version = "0.11.13";
      depKeys = [
        ("base64-0.13.1")
        ("bytes-1.3.0")
        ("encoding_rs-0.8.31")
        ("futures-core-0.3.25")
        ("futures-util-0.3.25")
        ("h2-0.3.15")
        ("http-0.2.8")
        ("http-body-0.4.5")
        ("hyper-0.14.23")
        ("hyper-tls-0.5.0")
        ("ipnet-2.7.1")
        ("log-0.4.17")
        ("mime-0.3.16")
        ("native-tls-0.2.11")
        ("once_cell-1.17.0")
        ("percent-encoding-2.2.0")
        ("pin-project-lite-0.2.9")
        ("serde-1.0.152")
        ("serde_urlencoded-0.7.1")
        ("tokio-1.24.1")
        ("tokio-native-tls-0.3.0")
        ("tower-service-0.3.2")
        ("url-2.3.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-aMxgV1hlx4MVSIY8wCNWUS4/HcLz+Cy4N9f8TMjzyXw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/reqwest/0.11.13/download";
      });
      crateRenames = {
        native-tls = [
          ({
            rename = "native_tls_crate";
            version = "0.2.11";
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
    "ryu-1.0.12" = {
      pname = "ryu";
      version = "1.0.12";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-e0uXQ+1ofUtLzt+f9eqnOYSVrhTmHLoKKVcE7bx97N4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ryu/1.0.12/download";
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
    "schannel-0.1.21" = {
      pname = "schannel";
      version = "0.1.21";
      depKeys = [
        ("windows-sys-0.42.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cTz7BscFnzWI+4BEwPrR0J48AdIl4luSINv9zxbbsbM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/schannel/0.1.21/download";
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
        ("libc-0.2.139")
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
        ("libc-0.2.139")
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
    "semver-1.0.16" = {
      pname = "semver";
      version = "1.0.16";
      depKeys = [
        ("serde-1.0.152")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WLyVZzePx2kNayrdrk5grC7uoHvsssZLnyGLU4Zcuio=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/semver/1.0.16/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("serde")
        ("std")
      ];
    };
    "serde-1.0.152" = {
      pname = "serde";
      version = "1.0.152";
      depKeys = [
        ("serde_derive-1.0.152")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-u30fDTAh00eoPlVvxGg96i6gnYe8zfiP9cElRdidXvs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde/1.0.152/download";
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
    "serde_derive-1.0.152" = {
      pname = "serde_derive";
      version = "1.0.152";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-r0h9EY7s0JQC1wpdclUYYOeI34e0ZK8w5epqOMdcVB4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_derive/1.0.152/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "serde_json-1.0.91" = {
      pname = "serde_json";
      version = "1.0.91";
      depKeys = [
        ("itoa-1.0.5")
        ("ryu-1.0.12")
        ("serde-1.0.152")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-h3wjVTNxSQeowkZCNvXEsqFyYu8b1x84816lksjaaIM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_json/1.0.91/download";
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
        ("form_urlencoded-1.1.0")
        ("itoa-1.0.5")
        ("ryu-1.0.12")
        ("serde-1.0.152")
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
        ("indexmap-1.9.2")
        ("ryu-1.0.12")
        ("serde-1.0.152")
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
        ("cpufeatures-0.2.5")
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
        ("libc-0.2.139")
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
    "smallvec-1.10.0" = {
      pname = "smallvec";
      version = "1.10.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-pQe+/nlUBEVjQd+rEM72bq1MBB9iuLEbu5K//l0JU+A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/smallvec/1.10.0/download";
      });
      edition = "2018";
    };
    "socket2-0.4.7" = {
      pname = "socket2";
      version = "0.4.7";
      depKeys = [
        ("libc-0.2.139")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-AuLS25Az0ToVZxId3XoJXuFE204cobG9o0GbwNopTr0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/socket2/0.4.7/download";
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
    "syn-1.0.107" = {
      pname = "syn";
      version = "1.0.107";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("unicode-ident-1.0.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-H0BktbFuA65QmEpajtXU+IA+a8H9Fwo82pGhvksY4/U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/syn/1.0.107/download";
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
        ("libc-0.2.139")
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
    "termcolor-1.2.0" = {
      pname = "termcolor";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vlXPiUL+rFx2XCyZNCKAaEPJqaRdTVxAetbdLqleubY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/termcolor/1.2.0/download";
      });
      edition = "2018";
    };
    "textwrap-0.16.0" = {
      pname = "textwrap";
      version = "0.16.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-IioiKlv+G7pKd7RexIinQbPLiHLl5JlFH9fQEpycfD0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/textwrap/0.16.0/download";
      });
      edition = "2021";
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
    "tokio-1.24.1" = {
      pname = "tokio";
      version = "1.24.1";
      depKeys = [
        ("bytes-1.3.0")
        ("libc-0.2.139")
        ("memchr-2.3.4")
        ("mio-0.8.5")
        ("num_cpus-1.15.0")
        ("parking_lot-0.12.1")
        ("pin-project-lite-0.2.9")
        ("signal-hook-registry-1.4.0")
        ("socket2-0.4.7")
        ("tokio-macros-1.8.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HZ92GD+R7PtV4dfVYCvR2XnjijpSL+kAJBzxlWJNZ64=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio/1.24.1/download";
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
        ("windows-sys")
      ];
    };
    "tokio-macros-1.8.2" = {
      pname = "tokio-macros";
      version = "1.8.2";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-0mbAD94of1XT8cPpbFAMNiorjGlQduwYDyeRiCC8bfg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-macros/1.8.2/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "tokio-native-tls-0.3.0" = {
      pname = "tokio-native-tls";
      version = "0.3.0";
      depKeys = [
        ("native-tls-0.2.11")
        ("tokio-1.24.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-99mVZgvSt/jBVoQUwRJgdsE/u3JcQBEtwBILeOubcXs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-native-tls/0.3.0/download";
      });
      edition = "2018";
    };
    "tokio-util-0.7.4" = {
      pname = "tokio-util";
      version = "0.7.4";
      depKeys = [
        ("bytes-1.3.0")
        ("futures-core-0.3.25")
        ("futures-sink-0.3.25")
        ("pin-project-lite-0.2.9")
        ("tokio-1.24.1")
        ("tracing-0.1.37")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-C7LgdfA7PWbY2HhTViJLpojSkGo3EBXiJb7rZcqSx0A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-util/0.7.4/download";
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
    "tracing-0.1.37" = {
      pname = "tracing";
      version = "0.1.37";
      depKeys = [
        ("cfg-if-1.0.0")
        ("pin-project-lite-0.2.9")
        ("tracing-core-0.1.30")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jOjDOo1IvUXWJKblI0Rf0h7BPTZTzVH2gav2dBj1Trg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing/0.1.37/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "tracing-core-0.1.30" = {
      pname = "tracing-core";
      version = "0.1.30";
      depKeys = [
        ("once_cell-1.17.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-JOsDug6rH9hFBQBYzl5hZVjo+Nj8pjPmsWP+JceXITo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing-core/0.1.30/download";
      });
      edition = "2018";
      features = [
        ("once_cell")
        ("std")
      ];
    };
    "try-lock-0.2.4" = {
      pname = "try-lock";
      version = "0.2.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-NSjs/RLEZsbxYzY8ry0CpxFh3V4cxq57NCB+otQtge0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/try-lock/0.2.4/download";
      });
      edition = "2015";
    };
    "typenum-1.16.0" = {
      pname = "typenum";
      version = "1.16.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-SXlh75PZdOI+tvQz61/ht5MLZZ8G0S3sb8RKj1VMC7o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/typenum/1.16.0/download";
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
    "unicode-ident-1.0.6" = {
      pname = "unicode-ident";
      version = "1.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-hKIrnyGLQGFK3LP0/wi3A3c61E+pQj5ODTRtXbhuTrw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-ident/1.0.6/download";
      });
      edition = "2018";
    };
    "unicode-normalization-0.1.22" = {
      pname = "unicode-normalization";
      version = "0.1.22";
      depKeys = [
        ("tinyvec-1.6.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-XFcT8PxLXbZooqxjzbe7RGnYyf7QR7HQKSzHsM4rqSE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-normalization/0.1.22/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "unicode-width-0.1.10" = {
      pname = "unicode-width";
      version = "0.1.10";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-wO3R5bFGU/eDdwvOSk2rtKUQilNwpfXYz+hxDDYfbIs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-width/0.1.10/download";
      });
      edition = "2015";
      features = [
        ("default")
      ];
    };
    "url-2.3.1" = {
      pname = "url";
      version = "2.3.1";
      depKeys = [
        ("form_urlencoded-1.1.0")
        ("idna-0.3.0")
        ("percent-encoding-2.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-DWjHma51diuMP+N1/rZgDvVgLIg8XSHrUcCfIrg8RkM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/url/2.3.1/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
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
        ("try-lock-0.2.4")
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
    "wasm-bindgen-0.2.83" = {
      pname = "wasm-bindgen";
      version = "0.2.83";
      depKeys = [
        ("cfg-if-1.0.0")
        ("wasm-bindgen-macro-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-6vn1rO7si+F8Eosuk+Ax+4pNRpu5xK4tfcGIiyaIcmg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen/0.2.83/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("spans")
        ("std")
      ];
    };
    "wasm-bindgen-backend-0.2.83" = {
      pname = "wasm-bindgen-backend";
      version = "0.2.83";
      depKeys = [
        ("bumpalo-3.11.1")
        ("log-0.4.17")
        ("once_cell-1.17.0")
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
        ("wasm-bindgen-shared-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-TI/7MyV5sFV7UtJouR/quN82FfJl1ScP7CqMlbF8EUI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-backend/0.2.83/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-futures-0.4.33" = {
      pname = "wasm-bindgen-futures";
      version = "0.4.33";
      depKeys = [
        ("cfg-if-1.0.0")
        ("js-sys-0.3.60")
        ("wasm-bindgen-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-I2OURhZcpaXehq4diJa3N66AMZVg+6pMKIe32m5+vX0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-futures/0.4.33/download";
      });
      edition = "2018";
    };
    "wasm-bindgen-macro-0.2.83" = {
      pname = "wasm-bindgen-macro";
      version = "0.2.83";
      depKeys = [
        ("quote-1.0.23")
        ("wasm-bindgen-macro-support-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-BSvg+UAm5svHXN78m64T/WBSzcr1MvpsReeuM6HmyBA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.83/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
      procMacro = true;
    };
    "wasm-bindgen-macro-support-0.2.83" = {
      pname = "wasm-bindgen-macro-support";
      version = "0.2.83";
      depKeys = [
        ("proc-macro2-1.0.49")
        ("quote-1.0.23")
        ("syn-1.0.107")
        ("wasm-bindgen-backend-0.2.83")
        ("wasm-bindgen-shared-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-B7wMBR3F8j4wexMoX51134a/34FsVyHlc97B+biqGTw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.83/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-shared-0.2.83" = {
      pname = "wasm-bindgen-shared";
      version = "0.2.83";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HDjARVNdk+xPC03v7ESOQpFjjuYIUwhjseK6EV1P/38=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.83/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "web-sys-0.3.60" = {
      pname = "web-sys";
      version = "0.3.60";
      depKeys = [
        ("js-sys-0.3.60")
        ("wasm-bindgen-0.2.83")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vNqQbYvhbnKP1a3FtymvrU5EThBqsozRxyVuVPphUQ8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/web-sys/0.3.60/download";
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
    "windows-sys-0.42.0" = {
      pname = "windows-sys";
      version = "0.42.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Wj4YIPCLhRP2dverbB+Z/zEvuXtVPTD/TdhvnxVyiqc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows-sys/0.42.0/download";
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
        ("Win32_Security_Authorization")
        ("Win32_Security_Credentials")
        ("Win32_Security_Cryptography")
        ("Win32_Storage")
        ("Win32_Storage_FileSystem")
        ("Win32_System")
        ("Win32_System_Console")
        ("Win32_System_IO")
        ("Win32_System_LibraryLoader")
        ("Win32_System_Memory")
        ("Win32_System_Pipes")
        ("Win32_System_SystemServices")
        ("Win32_System_Threading")
        ("Win32_System_WindowsProgramming")
        ("default")
      ];
    };
    "windows_aarch64_gnullvm-0.42.1" = {
      pname = "windows_aarch64_gnullvm";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jJhk6DJD/ex/ycVEQ4ncu/0lj3ReeFMZjzZePElopgg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.42.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_aarch64_msvc-0.42.1" = {
      pname = "windows_aarch64_msvc";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-TIsbZz/8FsR6n/SFcKnYXiXSZXNcUDaBMyWJr2JTxsc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.42.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_i686_gnu-0.42.1" = {
      pname = "windows_i686_gnu";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-3jiHUorVMLp727H6qCdex6EVWkX/pXw3mTlgJ3FF1kA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_i686_gnu/0.42.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_i686_msvc-0.42.1" = {
      pname = "windows_i686_msvc";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-v00RIjF+3db/NRqoUhGKJBitQhTmYTpQ4BkfcAQ3JgU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_i686_msvc/0.42.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_gnu-0.42.1" = {
      pname = "windows_x86_64_gnu";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-wQQPIhKF4X68y8JZH/3C1E7h+RhjJN0+hOmaxo1pnEU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.42.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_gnullvm-0.42.1" = {
      pname = "windows_x86_64_gnullvm";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Yov98jLaoisNZP22Kwn8w2uwHwWjk54gq3Oq+UcNBGM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.42.1/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_msvc-0.42.1" = {
      pname = "windows_x86_64_msvc";
      version = "0.42.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RHZgrTahMoix201CSOhXtRDow6IlyCK6T7dIwKr+z/0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.42.1/download";
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