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
    "addr2line-0.15.2" = {
      pname = "addr2line";
      version = "0.15.2";
      depKeys = [
        ("gimli-0.24.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-56Lkeh++IJ7hAd1tYShSJnRMbI08Icjch4umy59Gfzo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/addr2line/0.15.2/download";
      });
      edition = "2015";
    };
    "adler-1.0.2" = {
      pname = "adler";
      version = "1.0.2";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-8mIBYEyHseAb09mPjV2aj8u4FejO20H/zL60v1k6Nf4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/adler/1.0.2/download";
      });
      edition = "2015";
    };
    "aho-corasick-0.7.15" = {
      pname = "aho-corasick";
      version = "0.7.15";
      depKeys = [
        ("memchr-2.3.4")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-I7Yvxl3o5Of1JTT7UrDz7QR0auJnUZ7vKoOUHoCFBos=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/arrayvec/0.5.2/download";
      });
      edition = "2018";
      features = [
        ("array-sizes-33-128")
      ];
    };
    "async-trait-0.1.73" = {
      pname = "async-trait";
      version = "0.1.73";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
      ];
      src = (final.fetchurl {
        hash = "sha256-vADOs0mAwDYU41o6TiGCdqCoJOkR0HZRzQ2FilHowPA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/async-trait/0.1.73/download";
      });
      build = "build.rs";
      edition = "2021";
      procMacro = true;
    };
    "atty-0.2.14" = {
      pname = "atty";
      version = "0.2.14";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-1GiAK6sXy8DMV16bBT9B5yqja/prf1XjUp/6QxYbl/o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/autocfg/1.1.0/download";
      });
      edition = "2015";
    };
    "backtrace-0.3.59" = {
      pname = "backtrace";
      version = "0.3.59";
      depKeys = [
        ("addr2line-0.15.2")
        ("cfg-if-1.0.0")
        ("libc-0.2.147")
        ("miniz_oxide-0.4.4")
        ("object-0.24.0")
        ("rustc-demangle-0.1.23")
      ];
      src = (final.fetchurl {
        hash = "sha256-RxfPy/qmYaD9SPhFOVGDeufo+B5IH7sTbjIC1ygFp0Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/backtrace/0.3.59/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("cc-1.0.83")
      ];
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "base64-0.21.2" = {
      pname = "base64";
      version = "0.21.2";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-YEF49sXCHwLcVVeEgQ7fuI00rCxzsurhCWVWSe5zzj0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/base64/0.21.2/download";
      });
      edition = "2021";
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
      src = (final.fetchurl {
        hash = "sha256-vvONRRY8Lx3eCUp9/TPM9ZXJKQXI+PT9wY0G+xA3cYo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bitflags/1.3.2/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "bitflags-2.4.0" = {
      pname = "bitflags";
      version = "2.4.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-tGgq5ih/z3Uuyqu/zHtvm3KqM5M9wjpVTYU66o7qhjU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bitflags/2.4.0/download";
      });
      edition = "2021";
      features = [
        ("std")
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
      src = (final.fetchurl {
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
        ("generic-array-0.14.7")
      ];
      src = (final.fetchurl {
        hash = "sha256-QVIRb9bp2tspGuGPwew1de1thMKWQtl4kPS0o0Fyl+Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/block-buffer/0.9.0/download";
      });
      edition = "2018";
    };
    "bumpalo-3.13.0" = {
      pname = "bumpalo";
      version = "3.13.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-o+LD2u+IPswbXVjBWtrpNHCpHUJfNTK6FpWEllavP8E=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bumpalo/3.13.0/download";
      });
      edition = "2021";
      features = [
        ("default")
      ];
    };
    "bytes-1.4.0" = {
      pname = "bytes";
      version = "1.4.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-ibL9Kg3PONeXHiGUtrbuurRa4BBnRWp/2T1VR6YbcL4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bytes/1.4.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "camino-1.1.6" = {
      pname = "camino";
      version = "1.1.6";
      depKeys = [
        ("serde-1.0.188")
      ];
      src = (final.fetchurl {
        hash = "sha256-xZ6StaOI9Um4Y6e+piYSwJ8kyDk1YHCaVFWKmr37O5w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/camino/1.1.6/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("serde")
        ("serde1")
      ];
    };
    "cargo-platform-0.1.3" = {
      pname = "cargo-platform";
      version = "0.1.3";
      depKeys = [
        ("serde-1.0.188")
      ];
      src = (final.fetchurl {
        hash = "sha256-LPol5grqdH7H4RJPI4gWdJ+qk3Wcb/WzHxzN2hN/RHk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo-platform/0.1.3/download";
      });
      edition = "2021";
    };
    "cargo-util-0.1.2" = {
      pname = "cargo-util";
      version = "0.1.2";
      depKeys = [
        ("anyhow-1.0.48")
        ("core-foundation-0.9.3")
        ("crypto-hash-0.3.4")
        ("filetime-0.2.22")
        ("hex-0.4.3")
        ("jobserver-0.1.26")
        ("libc-0.2.147")
        ("log-0.4.20")
        ("same-file-1.0.6")
        ("shell-escape-0.1.5")
        ("tempfile-3.8.0")
        ("walkdir-2.3.3")
      ];
      src = (final.fetchurl {
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
        ("camino-1.1.6")
        ("cargo-platform-0.1.3")
        ("semver-1.0.18")
        ("serde-1.0.188")
        ("serde_json-1.0.105")
      ];
      src = (final.fetchurl {
        hash = "sha256-SsuwnZ7o4jaZuWNDdccnldCVvyaEOdqIViz5tQHxgfo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo_metadata/0.14.2/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "cc-1.0.83" = {
      pname = "cc";
      version = "1.0.83";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-8RdPsLbsI4Y/i5cQJ4BKQmFONH6vsKlb8LEs2uIfxNA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cc/1.0.83/download";
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
      src = (final.fetchurl {
        hash = "sha256-uvHeQzl2FYi8Bhnjy8ASDuWC67dLU7Tvv3kRe9LaQP0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cfg-if/1.0.0/download";
      });
      edition = "2018";
    };
    "clap-3.2.25" = {
      pname = "clap";
      version = "3.2.25";
      depKeys = [
        ("atty-0.2.14")
        ("bitflags-1.3.2")
        ("clap_derive-3.2.25")
        ("clap_lex-0.2.4")
        ("indexmap-1.9.3")
        ("once_cell-1.18.0")
        ("strsim-0.10.0")
        ("termcolor-1.2.0")
        ("textwrap-0.16.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-TqGBv1ZvccuaXRelnhhxr2OBgKGPsANckq5itwUgcSM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap/3.2.25/download";
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
    "clap_derive-3.2.25" = {
      pname = "clap_derive";
      version = "3.2.25";
      depKeys = [
        ("heck-0.4.1")
        ("proc-macro-error-1.0.4")
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-1.0.109")
      ];
      src = (final.fetchurl {
        hash = "sha256-rmNxuL3It9OVnpz3si1ENe8+eeE4aIQh7GVKz4yBsAg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap_derive/3.2.25/download";
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
        ("os_str_bytes-6.5.1")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
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
        ("core-foundation-sys-0.8.4")
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-GUp6nm3lP6VRFpNAZ8hE2ddJMS91xvbQmA6MJS+MIUY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/core-foundation/0.9.3/download";
      });
      edition = "2015";
      features = [
        ("mac_os_10_7_support")
      ];
    };
    "core-foundation-sys-0.8.4" = {
      pname = "core-foundation-sys";
      version = "0.8.4";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-5JalD9qKrMzIbXUp4sHgiS29D4mKa1ZFtVYbicMhDvo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/core-foundation-sys/0.8.4/download";
      });
      edition = "2015";
      features = [
        ("mac_os_10_7_support")
      ];
    };
    "cpufeatures-0.2.9" = {
      pname = "cpufeatures";
      version = "0.2.9";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-oXt2/zpBYrCyfzVKDIcBXdrTnTX5wMNmB6O90XXd4fE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cpufeatures/0.2.9/download";
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
      src = (final.fetchurl {
        hash = "sha256-incWIkD9lySNGaVkpWXrVjo/WSs4bkE2+zAJCeZ93co=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/crypto-hash/0.3.4/download";
      });
      edition = "2015";
    };
    "data-encoding-2.4.0" = {
      pname = "data-encoding";
      version = "2.4.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-wuZsnYF/FyAgkYHDFtKGNcBQ+jBPnHnkelIIgmYbcwg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/data-encoding/2.4.0/download";
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
        ("generic-array-0.14.7")
      ];
      src = (final.fetchurl {
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
    "either-1.9.0" = {
      pname = "either";
      version = "1.9.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-omrkPXvMO4FN6UeWpec21AKe+w7pAMEuLVTJk60aHgc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/either/1.9.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("use_std")
      ];
    };
    "encoding_rs-0.8.33" = {
      pname = "encoding_rs";
      version = "0.8.33";
      depKeys = [
        ("cfg-if-1.0.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-cmizhilqAl5HTVFAZ4911t6Uk65VpdcJ7rndCBSZReE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/encoding_rs/0.8.33/download";
      });
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
        ("log-0.4.20")
        ("regex-1.4.6")
        ("termcolor-1.2.0")
      ];
      src = (final.fetchurl {
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
    "errno-0.3.2" = {
      pname = "errno";
      version = "0.3.2";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-azD2aaeWHvFjFnPSdmzJL1LWT37zVNT+Dd/TDtUvD08=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/errno/0.3.2/download";
      });
      edition = "2018";
    };
    "errno-dragonfly-0.1.2" = {
      pname = "errno-dragonfly";
      version = "0.1.2";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-qmjxsSdk+riU0nVdJRh1TnG0/YDs+4InFKEgbCqrOb8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/errno-dragonfly/0.1.2/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("cc-1.0.83")
      ];
      edition = "2018";
    };
    "fastrand-2.0.0" = {
      pname = "fastrand";
      version = "2.0.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-aZncGDclM2TC67BwS6l5lL2HTo8ZXWZcULdUj26pJ2Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/fastrand/2.0.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "fetlock-0.1.0" = {
      pname = "fetlock";
      version = "0.1.0";
      depKeys = [
        ("anyhow-1.0.48")
        ("async-trait-0.1.73")
        ("cargo-platform-0.1.3")
        ("cargo-util-0.1.2")
        ("cargo_metadata-0.14.2")
        ("clap-3.2.25")
        ("data-encoding-2.4.0")
        ("either-1.9.0")
        ("env_logger-0.7.1")
        ("fs2-0.4.3")
        ("futures-0.3.28")
        ("getopts-0.2.21")
        ("lazy_static-1.4.0")
        ("log-0.4.20")
        ("netrc-rs-0.1.2")
        ("nom-6.2.2")
        ("percent-encoding-2.3.0")
        ("platforms-1.1.0")
        ("regex-1.4.6")
        ("reqwest-0.11.20")
        ("serde-1.0.188")
        ("serde_json-1.0.105")
        ("serde_yaml-0.8.26")
        ("sha2-0.9.9")
        ("tempdir-0.3.7")
        ("tokio-1.32.0")
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
    "filetime-0.2.22" = {
      pname = "filetime";
      version = "0.2.22";
      depKeys = [
        ("cfg-if-1.0.0")
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-1AKe3T5zTab+BbbNe9KWB2CmFr0t3Q1ZoBJHRtYnKvA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/filetime/0.2.22/download";
      });
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.3.5";
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-ALAihBGQjKhoXbp/ws3XDsmZCm51Pom2rJGoTED7r0s=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/foreign-types-shared/0.1.1/download";
      });
      edition = "2015";
    };
    "form_urlencoded-1.2.0" = {
      pname = "form_urlencoded";
      version = "1.2.0";
      depKeys = [
        ("percent-encoding-2.3.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-pivBz2+DDC7BSlE6n7Ek0KITpilmikGG8ynbIf4EVlI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/form_urlencoded/1.2.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "fs2-0.4.3" = {
      pname = "fs2";
      version = "0.4.3";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-/tNM0QWRfpHapNprNyjEewaHSdamLFmBHwbtKscdnac=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/funty/1.1.0/download";
      });
      edition = "2018";
    };
    "futures-0.3.28" = {
      pname = "futures";
      version = "0.3.28";
      depKeys = [
        ("futures-channel-0.3.28")
        ("futures-core-0.3.28")
        ("futures-executor-0.3.28")
        ("futures-io-0.3.28")
        ("futures-sink-0.3.28")
        ("futures-task-0.3.28")
        ("futures-util-0.3.28")
      ];
      src = (final.fetchurl {
        hash = "sha256-IzQqvhKrpYOROy5i8iIl/5yVB3QGXkv7YaGc2XcP7EA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures/0.3.28/download";
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
    "futures-channel-0.3.28" = {
      pname = "futures-channel";
      version = "0.3.28";
      depKeys = [
        ("futures-core-0.3.28")
        ("futures-sink-0.3.28")
      ];
      src = (final.fetchurl {
        hash = "sha256-lVUY1H4Jslu+vHoY3xC4Hwx2bq9MTxzM7y/KXypPtfI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-channel/0.3.28/download";
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
    "futures-core-0.3.28" = {
      pname = "futures-core";
      version = "0.3.28";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-S8pYO34m9XEST+W3Vh1Jyyho15EWz6Du/OlVVXxv7ow=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-core/0.3.28/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-executor-0.3.28" = {
      pname = "futures-executor";
      version = "0.3.28";
      depKeys = [
        ("futures-core-0.3.28")
        ("futures-task-0.3.28")
        ("futures-util-0.3.28")
      ];
      src = (final.fetchurl {
        hash = "sha256-zOzugjKIElvYi01/VlyeWOQYWOR6ty6OotZOk2JDhuA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-executor/0.3.28/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-io-0.3.28" = {
      pname = "futures-io";
      version = "0.3.28";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-T/90CW5x7Uf44CMgTP0KoSic1UrlQwqVI74GDNuEmWQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-io/0.3.28/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-macro-0.3.28" = {
      pname = "futures-macro";
      version = "0.3.28";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
      ];
      src = (final.fetchurl {
        hash = "sha256-icpUWpQGG2Nl8sc1W0syvSDfP/lfAtqTKbNMzDvW7nI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-macro/0.3.28/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "futures-sink-0.3.28" = {
      pname = "futures-sink";
      version = "0.3.28";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-9Dvk/iGhO5eBppr6SYWw9u4OGvqyxvRUqM8w4rIje24=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-sink/0.3.28/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-task-0.3.28" = {
      pname = "futures-task";
      version = "0.3.28";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-dtPRMr5sDmqhU0BpxwWnSlmXo1bA3C+GpHdl5WF8W2U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-task/0.3.28/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "futures-util-0.3.28" = {
      pname = "futures-util";
      version = "0.3.28";
      depKeys = [
        ("futures-channel-0.3.28")
        ("futures-core-0.3.28")
        ("futures-io-0.3.28")
        ("futures-macro-0.3.28")
        ("futures-sink-0.3.28")
        ("futures-task-0.3.28")
        ("memchr-2.3.4")
        ("pin-project-lite-0.2.13")
        ("pin-utils-0.1.0")
        ("slab-0.4.9")
      ];
      src = (final.fetchurl {
        hash = "sha256-JrAeQLdy1Uz2xtchwdGr0GR6AQahLsqhwYYnM5KmlTM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-util/0.3.28/download";
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
    "generic-array-0.14.7" = {
      pname = "generic-array";
      version = "0.14.7";
      depKeys = [
        ("typenum-1.16.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-hWScpR/XInLXghra8nStkcKIJ3cT2cGIINhJmn/2npo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/generic-array/0.14.7/download";
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
      src = (final.fetchurl {
        hash = "sha256-FNu/1ccdcCQez55vE3N/e1zoI4IQYxiNfkbEHTce69U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/getopts/0.2.21/download";
      });
      edition = "2015";
    };
    "gimli-0.24.0" = {
      pname = "gimli";
      version = "0.24.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-DkB1OGYmZieG3bDskIHnx+6xujGVH0R8p4Dvn11WgYk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/gimli/0.24.0/download";
      });
      edition = "2018";
      features = [
        ("read")
      ];
    };
    "h2-0.3.21" = {
      pname = "h2";
      version = "0.3.21";
      depKeys = [
        ("bytes-1.4.0")
        ("fnv-1.0.7")
        ("futures-core-0.3.28")
        ("futures-sink-0.3.28")
        ("futures-util-0.3.28")
        ("http-0.2.9")
        ("indexmap-1.9.3")
        ("slab-0.4.9")
        ("tokio-1.32.0")
        ("tokio-util-0.7.8")
        ("tracing-0.1.37")
      ];
      src = (final.fetchurl {
        hash = "sha256-kfwjqhG+kpdu9HKRJ/GnSt822ENveBaxhdGN+VZ5CDM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/h2/0.3.21/download";
      });
      edition = "2018";
    };
    "hashbrown-0.12.3" = {
      pname = "hashbrown";
      version = "0.12.3";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-ip7nDEOq9BfJFDlmRaD6hSYkgBsk67eueP6CcoiayIg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hashbrown/0.12.3/download";
      });
      edition = "2021";
      features = [
        ("raw")
      ];
    };
    "heck-0.4.1" = {
      pname = "heck";
      version = "0.4.1";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-lVBcOLRXKy2RDOywKBVg9UtEChkzbLvLJ79s5q3G9ag=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/heck/0.4.1/download";
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
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-YrRnNDuUukdtyyUA0kLa27OVV9+IkxCsd8XZkQCqrDM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hermit-abi/0.1.19/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "hermit-abi-0.3.2" = {
      pname = "hermit-abi";
      version = "0.3.2";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-RDFEyM2t2T6/Ut20BW0lf1tSwE08gE5lfRnrc/wzZos=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hermit-abi/0.3.2/download";
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
    "http-0.2.9" = {
      pname = "http";
      version = "0.2.9";
      depKeys = [
        ("bytes-1.4.0")
        ("fnv-1.0.7")
        ("itoa-1.0.9")
      ];
      src = (final.fetchurl {
        hash = "sha256-vW7/yZr7Y0Ja/5sFg28CmSnjRaYUihS37NWrZ6+URII=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/http/0.2.9/download";
      });
      edition = "2018";
    };
    "http-body-0.4.5" = {
      pname = "http-body";
      version = "0.4.5";
      depKeys = [
        ("bytes-1.4.0")
        ("http-0.2.9")
        ("pin-project-lite-0.2.13")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
    "httpdate-1.0.3" = {
      pname = "httpdate";
      version = "1.0.3";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-3ztGQCqdWttMhqDPRj9C4ZmU4+6JEQGxhB8wpUXLSak=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/httpdate/1.0.3/download";
      });
      edition = "2021";
    };
    "humantime-1.3.0" = {
      pname = "humantime";
      version = "1.3.0";
      depKeys = [
        ("quick-error-1.2.3")
      ];
      src = (final.fetchurl {
        hash = "sha256-3wBM/KUO8jw2hQqqpZrVLMcNDpAkPDx3N6TdMtx6PE8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/humantime/1.3.0/download";
      });
      edition = "2015";
    };
    "hyper-0.14.27" = {
      pname = "hyper";
      version = "0.14.27";
      depKeys = [
        ("bytes-1.4.0")
        ("futures-channel-0.3.28")
        ("futures-core-0.3.28")
        ("futures-util-0.3.28")
        ("h2-0.3.21")
        ("http-0.2.9")
        ("http-body-0.4.5")
        ("httparse-1.8.0")
        ("httpdate-1.0.3")
        ("itoa-1.0.9")
        ("pin-project-lite-0.2.13")
        ("socket2-0.4.9")
        ("tokio-1.32.0")
        ("tower-service-0.3.2")
        ("tracing-0.1.37")
        ("want-0.3.1")
      ];
      src = (final.fetchurl {
        hash = "sha256-/7HP1lSoIZ6u+JiB/bO7OxzcX6dd7QXWkzsrOC45VGg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper/0.14.27/download";
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
        ("bytes-1.4.0")
        ("hyper-0.14.27")
        ("native-tls-0.2.11")
        ("tokio-1.32.0")
        ("tokio-native-tls-0.3.1")
      ];
      src = (final.fetchurl {
        hash = "sha256-1hg936mbhdphoUC+oO/JP99WzqoEGzfVU1GAMIJ/mQU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper-tls/0.5.0/download";
      });
      edition = "2018";
    };
    "idna-0.4.0" = {
      pname = "idna";
      version = "0.4.0";
      depKeys = [
        ("unicode-bidi-0.3.13")
        ("unicode-normalization-0.1.22")
      ];
      src = (final.fetchurl {
        hash = "sha256-fSDWsHv7wQiILYjtjjfTljbcwmDhXjDEXmugiWELkXw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/idna/0.4.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "indexmap-1.9.3" = {
      pname = "indexmap";
      version = "1.9.3";
      depKeys = [
        ("hashbrown-0.12.3")
      ];
      src = (final.fetchurl {
        hash = "sha256-vQcOOTNTeW6AHSCa0znolZbrTI1DDRjt5qHM7Y+vvZk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/indexmap/1.9.3/download";
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
    "ipnet-2.8.0" = {
      pname = "ipnet";
      version = "2.8.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-KLKaPNdPD0WYk07+OuukK64OtGgFVBKIUeu+ywKvFOY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ipnet/2.8.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "itoa-1.0.9" = {
      pname = "itoa";
      version = "1.0.9";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-rxUKtoj/ISL87yKb6Jy1DdZq+eAaT/MgzBN+7Mm6zDg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/itoa/1.0.9/download";
      });
      edition = "2018";
    };
    "jobserver-0.1.26" = {
      pname = "jobserver";
      version = "0.1.26";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-k2z9ISoBVZA7y8Bg4xb7bMfL8uGQcyk5HrrcH+DOd8I=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/jobserver/0.1.26/download";
      });
      edition = "2018";
    };
    "js-sys-0.3.64" = {
      pname = "js-sys";
      version = "0.3.64";
      depKeys = [
        ("wasm-bindgen-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-xfGV/kl/cC2w8xiwf91o7bFpVa7YMN+DY9g3VC+Pk1o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/js-sys/0.3.64/download";
      });
      edition = "2018";
    };
    "lazy_static-1.4.0" = {
      pname = "lazy_static";
      version = "1.4.0";
      depKeys = [
      ];
      src = (final.fetchurl {
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
        ("ryu-1.0.15")
        ("static_assertions-1.1.0")
      ];
      src = (final.fetchurl {
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
    "libc-0.2.147" = {
      pname = "libc";
      version = "0.2.147";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-tGaPsOqGHB3wlBJ6xfHaNAmoIRakunT8ouWO+ScVm7M=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/libc/0.2.147/download";
      });
      build = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("extra_traits")
        ("std")
      ];
    };
    "linked-hash-map-0.5.6" = {
      pname = "linked-hash-map";
      version = "0.5.6";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-BxfO8byLY2xuHBu978CeYyLaipMhlm6JKO+A0g9/dw8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/linked-hash-map/0.5.6/download";
      });
      edition = "2015";
    };
    "linux-raw-sys-0.4.5" = {
      pname = "linux-raw-sys";
      version = "0.4.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-V7z9rRuFjC23w4MDptKtTfr161Pf6wkQEossJtYVhQM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/linux-raw-sys/0.4.5/download";
      });
      edition = "2021";
      features = [
        ("errno")
        ("general")
        ("ioctl")
        ("no_std")
      ];
    };
    "lock_api-0.4.10" = {
      pname = "lock_api";
      version = "0.4.10";
      depKeys = [
        ("scopeguard-1.2.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-wcyXF6ILG7Ii8zPmqS/TL32KGN3FoxkaEa9F3L9NzRY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lock_api/0.4.10/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
      ];
      edition = "2018";
      features = [
        ("atomic_usize")
        ("default")
      ];
    };
    "log-0.4.20" = {
      pname = "log";
      version = "0.4.20";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-teYWPLjEkIjCw29Xh15YzNjIfHQn9/vVDqZxCy8/Lo8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/log/0.4.20/download";
      });
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
      src = (final.fetchurl {
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
    "mime-0.3.17" = {
      pname = "mime";
      version = "0.3.17";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-aHe7UUCB7ip/9e+d4ygfFKTdS86sTAk4gHSmtd+KE5o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/mime/0.3.17/download";
      });
      edition = "2015";
    };
    "miniz_oxide-0.4.4" = {
      pname = "miniz_oxide";
      version = "0.4.4";
      depKeys = [
        ("adler-1.0.2")
      ];
      src = (final.fetchurl {
        hash = "sha256-qSUY6YwHhYa8bJNAKK3MpMkqU9apWBlt6DUXCgHYTks=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/miniz_oxide/0.4.4/download";
      });
      build = "build.rs";
      buildDepKeys = [
        ("autocfg-1.1.0")
      ];
      edition = "2018";
    };
    "mio-0.8.8" = {
      pname = "mio";
      version = "0.8.8";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-knp2XNP8JiBuZrKWRl+p0+WrAD5lHBs8Bg55VtlrGdI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/mio/0.8.8/download";
      });
      edition = "2018";
      features = [
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
      src = (final.fetchurl {
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
        ("lazy_static-1.4.0")
        ("libc-0.2.147")
        ("security-framework-2.9.2")
        ("security-framework-sys-2.9.1")
        ("tempfile-3.8.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-ByJhc8MvKSYCe2PM5LzYB2w1UoRsvnkl86r/6sCjuS4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/native-tls/0.2.11/download";
      });
      build = "build.rs";
      edition = "2015";
    };
    "netrc-rs-0.1.2" = {
      pname = "netrc-rs";
      version = "0.1.2";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-6ilw+7yMeF6CRiNKe9AE7WbNHtGjXsc2aaklReQZuDY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/netrc-rs/0.1.2/download";
      });
      edition = "2018";
    };
    "nom-6.2.2" = {
      pname = "nom";
      version = "6.2.2";
      depKeys = [
        ("bitvec-0.19.6")
        ("funty-1.1.0")
        ("lexical-core-0.7.6")
        ("memchr-2.3.4")
      ];
      src = (final.fetchurl {
        hash = "sha256-xqepZXyE1YFMYZa2i7RCnfCcGLFXOAYln7o5fqStDUQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/nom/6.2.2/download";
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
    "num_cpus-1.16.0" = {
      pname = "num_cpus";
      version = "1.16.0";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-QWH8ttYC1NIIGvfDpFhS2HWgPdM3pr/dbgZAe2E0KkM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/num_cpus/1.16.0/download";
      });
      edition = "2015";
    };
    "object-0.24.0" = {
      pname = "object";
      version = "0.24.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-Gls90cBy7nljcXZx0coSnxBI/aJe3qa3Ur/HGsiFQXA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/object/0.24.0/download";
      });
      edition = "2018";
      features = [
        ("archive")
        ("coff")
        ("elf")
        ("macho")
        ("pe")
        ("read_core")
        ("unaligned")
      ];
    };
    "once_cell-1.18.0" = {
      pname = "once_cell";
      version = "1.18.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-3Ytd0q5e1xRixUAli+3LUZZRI61+fM9LmoyvqkpjV20=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/once_cell/1.18.0/download";
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
      src = (final.fetchurl {
        hash = "sha256-YkqDQMOMG4D9VJCHhi2kukPgiFivAlsjblCbZkn8E9U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/opaque-debug/0.3.0/download";
      });
      edition = "2018";
    };
    "openssl-0.10.56" = {
      pname = "openssl";
      version = "0.10.56";
      depKeys = [
        ("bitflags-1.3.2")
        ("cfg-if-1.0.0")
        ("foreign-types-0.3.2")
        ("libc-0.2.147")
        ("once_cell-1.18.0")
        ("openssl-macros-0.1.1")
        ("openssl-sys-0.9.91")
      ];
      src = (final.fetchurl {
        hash = "sha256-cpt0WtSlV13Qaj4a8UFL0zDuVhwBs4metYS66qje8X4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl/0.10.56/download";
      });
      build = "build.rs";
      crateRenames = {
        openssl-sys = [
          ({
            rename = "ffi";
            version = "0.9.91";
          })
        ];
      };
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "openssl-macros-0.1.1" = {
      pname = "openssl-macros";
      version = "0.1.1";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
      ];
      src = (final.fetchurl {
        hash = "sha256-qUhma2N6D0ZehWTHPonU3eANctTUc8yXLzkPw9zufZw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-macros/0.1.1/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "openssl-probe-0.1.5" = {
      pname = "openssl-probe";
      version = "0.1.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-/wEaMCw5alGXaSQx/BlIAZFUr8F4uvfY43NnRCpGAc8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-probe/0.1.5/download";
      });
      edition = "2015";
    };
    "openssl-sys-0.9.91" = {
      pname = "openssl-sys";
      version = "0.9.91";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-hmtfFvkHdrm7jcHhgCrG8FE946enRlhnv7xWPcc3+qw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-sys/0.9.91/download";
      });
      build = "build/main.rs";
      buildDepKeys = [
        ("cc-1.0.83")
        ("pkg-config-0.3.27")
        ("vcpkg-0.2.15")
      ];
      edition = "2018";
    };
    "os_str_bytes-6.5.1" = {
      pname = "os_str_bytes";
      version = "6.5.1";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-TV2esUsXTumqLvltwrlGN6LUtufLhzx+Fx8MIMbPPqw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/os_str_bytes/6.5.1/download";
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
        ("lock_api-0.4.10")
        ("parking_lot_core-0.9.8")
      ];
      src = (final.fetchurl {
        hash = "sha256-N0KywQO58GvJ//Cjf/SRKTWFG+5tNvPAK8x1W8/sIo8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot/0.12.1/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "parking_lot_core-0.9.8" = {
      pname = "parking_lot_core";
      version = "0.9.8";
      depKeys = [
        ("cfg-if-1.0.0")
        ("libc-0.2.147")
        ("smallvec-1.11.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-k/AMhl/nyr9lAIGv/s04cQcPJnZ+eyBwo/+uFMZUtEc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot_core/0.9.8/download";
      });
      build = "build.rs";
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.3.5";
          })
        ];
      };
      edition = "2018";
    };
    "percent-encoding-2.3.0" = {
      pname = "percent-encoding";
      version = "2.3.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-mypHhylumYlhE5TDPxk/Z2cErxaG5wuPgDOrW6mjWpQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/percent-encoding/2.3.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "pin-project-lite-0.2.13" = {
      pname = "pin-project-lite";
      version = "0.2.13";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-ivtFDwBr9jhcoV70XXHSKIRSvDaDzi4srMDRjkvmC1g=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pin-project-lite/0.2.13/download";
      });
      edition = "2018";
    };
    "pin-utils-0.1.0" = {
      pname = "pin-utils";
      version = "0.1.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-i4cNjBUbby+5PoShMUYTjwXQLtEcfnxU+IJqqvfJ8YQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pin-utils/0.1.0/download";
      });
      edition = "2018";
    };
    "pkg-config-0.3.27" = {
      pname = "pkg-config";
      version = "0.3.27";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-JgcoYLqSTL+pjqOcjBm03WpKJUI9vfIZweypGqDPaWQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pkg-config/0.3.27/download";
      });
      edition = "2015";
    };
    "platforms-1.1.0" = {
      pname = "platforms";
      version = "1.1.0";
      depKeys = [
      ];
      src = (final.fetchurl {
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
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-1.0.109")
      ];
      src = (final.fetchurl {
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
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
      ];
      src = (final.fetchurl {
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
    "proc-macro2-1.0.66" = {
      pname = "proc-macro2";
      version = "1.0.66";
      depKeys = [
        ("unicode-ident-1.0.11")
      ];
      src = (final.fetchurl {
        hash = "sha256-GPsx2z+b3bLqghzeMKn3ARfj8RmTi17mMLdAOqbi6tk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro2/1.0.66/download";
      });
      build = "build.rs";
      edition = "2021";
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
      src = (final.fetchurl {
        hash = "sha256-odAZQdgvoqtQvh555nFCid183njrpMB0vFpDdPZQ3+A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/quick-error/1.2.3/download";
      });
      edition = "2015";
    };
    "quote-1.0.33" = {
      pname = "quote";
      version = "1.0.33";
      depKeys = [
        ("proc-macro2-1.0.66")
      ];
      src = (final.fetchurl {
        hash = "sha256-Umf8pElgKGKKlRYPxCOjPosuavilMCV54yLktSApPK4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/quote/1.0.33/download";
      });
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
      src = (final.fetchurl {
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
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
    "redox_syscall-0.3.5" = {
      pname = "redox_syscall";
      version = "0.3.5";
      depKeys = [
        ("bitflags-1.3.2")
      ];
      src = (final.fetchurl {
        hash = "sha256-VnZk8mJwlHOTCkv55Rvy6/M0jy50jMxQ3qIGRoWPjyk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/redox_syscall/0.3.5/download";
      });
      edition = "2018";
    };
    "regex-1.4.6" = {
      pname = "regex";
      version = "1.4.6";
      depKeys = [
        ("aho-corasick-0.7.15")
        ("memchr-2.3.4")
        ("regex-syntax-0.6.29")
      ];
      src = (final.fetchurl {
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
    "regex-syntax-0.6.29" = {
      pname = "regex-syntax";
      version = "0.6.29";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-8WLG3XsAiYHk1AIQrKILS9D5tgypJxBhsH94U3ci8uE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/regex-syntax/0.6.29/download";
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
      src = (final.fetchurl {
        hash = "sha256-Os0SVmVCKXOjOsnT3S34XtrQ9K6bANr7GgXkOp9e+Oc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/remove_dir_all/0.5.3/download";
      });
      edition = "2015";
    };
    "reqwest-0.11.20" = {
      pname = "reqwest";
      version = "0.11.20";
      depKeys = [
        ("base64-0.21.2")
        ("bytes-1.4.0")
        ("encoding_rs-0.8.33")
        ("futures-core-0.3.28")
        ("futures-util-0.3.28")
        ("h2-0.3.21")
        ("http-0.2.9")
        ("http-body-0.4.5")
        ("hyper-0.14.27")
        ("hyper-tls-0.5.0")
        ("ipnet-2.8.0")
        ("log-0.4.20")
        ("mime-0.3.17")
        ("native-tls-0.2.11")
        ("once_cell-1.18.0")
        ("percent-encoding-2.3.0")
        ("pin-project-lite-0.2.13")
        ("serde-1.0.188")
        ("serde_urlencoded-0.7.1")
        ("tokio-1.32.0")
        ("tokio-native-tls-0.3.1")
        ("tower-service-0.3.2")
        ("url-2.4.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-PprT/nSI1+NFWKIDPUWgyQty2XtPgHBWZv6nFHLi5qE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/reqwest/0.11.20/download";
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
    "rustc-demangle-0.1.23" = {
      pname = "rustc-demangle";
      version = "0.1.23";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-1ia7na534oIZk3rwRcJXwov9P2kzPFElU1B/X5eYy3Y=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rustc-demangle/0.1.23/download";
      });
      edition = "2015";
    };
    "rustix-0.38.9" = {
      pname = "rustix";
      version = "0.38.9";
      depKeys = [
        ("bitflags-2.4.0")
        ("errno-0.3.2")
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-m/4PJYK0kxpF0fpgj4qHIuizx6xU3W1fOzISeR/t70k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rustix/0.38.9/download";
      });
      build = "build.rs";
      crateRenames = {
        errno = [
          ({
            rename = "libc_errno";
            version = "0.3.2";
          })
        ];
      };
      edition = "2021";
      features = [
        ("default")
        ("fs")
        ("std")
        ("use-libc-auxv")
      ];
    };
    "ryu-1.0.15" = {
      pname = "ryu";
      version = "1.0.15";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-GtTMjaTvcj7WC87SARgdg3ka1DMhPYwk7//aHuyF10E=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ryu/1.0.15/download";
      });
      edition = "2018";
    };
    "same-file-1.0.6" = {
      pname = "same-file";
      version = "1.0.6";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-k/wdw6qpv+2V4C5urau0uvfjB4sL0bTXtrC2g3iQBQI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/same-file/1.0.6/download";
      });
      edition = "2018";
    };
    "schannel-0.1.22" = {
      pname = "schannel";
      version = "0.1.22";
      depKeys = [
        ("windows-sys-0.48.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-DDczv0z36giAdU4Zy1pGIAfEqMGRS/83LMyVtGTx34g=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/schannel/0.1.22/download";
      });
      edition = "2018";
    };
    "scopeguard-1.2.0" = {
      pname = "scopeguard";
      version = "1.2.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-lBQ/N3JRCfksJi7Sz15ZvOdJjAG8wVAte5r+Q5pOn0k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/scopeguard/1.2.0/download";
      });
      edition = "2015";
    };
    "security-framework-2.9.2" = {
      pname = "security-framework";
      version = "2.9.2";
      depKeys = [
        ("bitflags-1.3.2")
        ("core-foundation-0.9.3")
        ("core-foundation-sys-0.8.4")
        ("libc-0.2.147")
        ("security-framework-sys-2.9.1")
      ];
      src = (final.fetchurl {
        hash = "sha256-BbZPswNzfZm4GISyxjQz6a4oq+vl61BF3N0XXcLs9N4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/security-framework/2.9.2/download";
      });
      edition = "2021";
      features = [
        ("OSX_10_9")
        ("default")
      ];
    };
    "security-framework-sys-2.9.1" = {
      pname = "security-framework-sys";
      version = "2.9.1";
      depKeys = [
        ("core-foundation-sys-0.8.4")
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-6TKTQlfTtAjtjzDbSdheoWO/50lh8Bf0BbAlrymPDHo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/security-framework-sys/2.9.1/download";
      });
      edition = "2021";
      features = [
        ("OSX_10_9")
        ("default")
      ];
    };
    "semver-1.0.18" = {
      pname = "semver";
      version = "1.0.18";
      depKeys = [
        ("serde-1.0.188")
      ];
      src = (final.fetchurl {
        hash = "sha256-sCk7Synar0hyhFKcwvVnW45Xxh9wFnukFaRjZR/WqRg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/semver/1.0.18/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("serde")
        ("std")
      ];
    };
    "serde-1.0.188" = {
      pname = "serde";
      version = "1.0.188";
      depKeys = [
        ("serde_derive-1.0.188")
      ];
      src = (final.fetchurl {
        hash = "sha256-z54Py6aaNw7tYbzytyhXX3JrULVcungGR1PXCN3HVJ4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde/1.0.188/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("derive")
        ("serde_derive")
        ("std")
      ];
    };
    "serde_derive-1.0.188" = {
      pname = "serde_derive";
      version = "1.0.188";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
      ];
      src = (final.fetchurl {
        hash = "sha256-Tsp6xkLYKqNbYASabsy0vmvnXlmb0umttfh1pzdlSvI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_derive/1.0.188/download";
      });
      edition = "2015";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "serde_json-1.0.105" = {
      pname = "serde_json";
      version = "1.0.105";
      depKeys = [
        ("itoa-1.0.9")
        ("ryu-1.0.15")
        ("serde-1.0.188")
      ];
      src = (final.fetchurl {
        hash = "sha256-aTFR4awnVj1tvOyd7p+9XahTmyD6FK03UrLm02Os42A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_json/1.0.105/download";
      });
      build = "build.rs";
      edition = "2021";
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
        ("form_urlencoded-1.2.0")
        ("itoa-1.0.9")
        ("ryu-1.0.15")
        ("serde-1.0.188")
      ];
      src = (final.fetchurl {
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
        ("indexmap-1.9.3")
        ("ryu-1.0.15")
        ("serde-1.0.188")
        ("yaml-rust-0.4.5")
      ];
      src = (final.fetchurl {
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
        ("cpufeatures-0.2.9")
        ("digest-0.9.0")
        ("opaque-debug-0.3.0")
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-RbtnoY+pEmbMeAcYH2L5F4poc7+tfceIxC5kMNtAGE8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/shell-escape/0.1.5/download";
      });
      edition = "2015";
    };
    "signal-hook-registry-1.4.1" = {
      pname = "signal-hook-registry";
      version = "1.4.1";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-2CKbRzuqWYCscu9DTEQV5wxLXnG0IwQ620ugWficmaE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/signal-hook-registry/1.4.1/download";
      });
      edition = "2015";
    };
    "slab-0.4.9" = {
      pname = "slab";
      version = "0.4.9";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-j5Kklvt2a0F8mWucXlfa8vetOwvr4cz8pIVjkOPTu2c=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/slab/0.4.9/download";
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
    "smallvec-1.11.0" = {
      pname = "smallvec";
      version = "1.11.0";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-YrtP7uSf3Z9wfvgC4iNlo13kt7KZ3kdj1Ev+qJlEL/k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/smallvec/1.11.0/download";
      });
      edition = "2018";
    };
    "socket2-0.4.9" = {
      pname = "socket2";
      version = "0.4.9";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-ZKSpEe7YXa8Yg0z6qGp5t9Jm/5P/W6FABUJiGUgO1mI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/socket2/0.4.9/download";
      });
      edition = "2018";
      features = [
        ("all")
      ];
    };
    "socket2-0.5.3" = {
      pname = "socket2";
      version = "0.5.3";
      depKeys = [
        ("libc-0.2.147")
      ];
      src = (final.fetchurl {
        hash = "sha256-JTixhwF0FoDgMiojAhdtMlOjU4ji5i8XL2T08WYF+Hc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/socket2/0.5.3/download";
      });
      edition = "2021";
      features = [
        ("all")
      ];
    };
    "static_assertions-1.1.0" = {
      pname = "static_assertions";
      version = "1.1.0";
      depKeys = [
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-c0c8Dlnm1YEsXf4qBkpkRJSfCJ4g7smi5VBllklORiM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/strsim/0.10.0/download";
      });
      edition = "2015";
    };
    "syn-1.0.109" = {
      pname = "syn";
      version = "1.0.109";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("unicode-ident-1.0.11")
      ];
      src = (final.fetchurl {
        hash = "sha256-crZBkbJ1tm/+JGnorywc/juvpntSnq15Km0BYIiLQjc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/syn/1.0.109/download";
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
      ];
    };
    "syn-2.0.29" = {
      pname = "syn";
      version = "2.0.29";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("unicode-ident-1.0.11")
      ];
      src = (final.fetchurl {
        hash = "sha256-wyTElOup2SUD5vHvLm33geePancFoCAtmAGxmIB9UYo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/syn/2.0.29/download";
      });
      edition = "2021";
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-FfK1+wDM32ieAUnRsbPAP+rYHCs3c12BL6i9279Bttg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tempdir/0.3.7/download";
      });
      edition = "2015";
    };
    "tempfile-3.8.0" = {
      pname = "tempfile";
      version = "3.8.0";
      depKeys = [
        ("cfg-if-1.0.0")
        ("fastrand-2.0.0")
        ("rustix-0.38.9")
      ];
      src = (final.fetchurl {
        hash = "sha256-y5TS88xTavccqsa2/Ov2WGCzR+fODMnr6PcNPlIQVO8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tempfile/3.8.0/download";
      });
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.3.5";
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
        ("tinyvec_macros-0.1.1")
      ];
      src = (final.fetchurl {
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
    "tinyvec_macros-0.1.1" = {
      pname = "tinyvec_macros";
      version = "0.1.1";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-HzzLrDEf6gX4b2GQS0YrVfs9+IN6Nm38YBoBYdBTLyA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tinyvec_macros/0.1.1/download";
      });
      edition = "2018";
    };
    "tokio-1.32.0" = {
      pname = "tokio";
      version = "1.32.0";
      depKeys = [
        ("bytes-1.4.0")
        ("libc-0.2.147")
        ("mio-0.8.8")
        ("num_cpus-1.16.0")
        ("parking_lot-0.12.1")
        ("pin-project-lite-0.2.13")
        ("signal-hook-registry-1.4.1")
        ("socket2-0.5.3")
        ("tokio-macros-2.1.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-F+1gd+1s1sdHNeIfN+sW3Dk1+Wh4sf6WEHQInMgIk/k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio/1.32.0/download";
      });
      edition = "2021";
      features = [
        ("bytes")
        ("default")
        ("fs")
        ("full")
        ("io-std")
        ("io-util")
        ("libc")
        ("macros")
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
    "tokio-macros-2.1.0" = {
      pname = "tokio-macros";
      version = "2.1.0";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
      ];
      src = (final.fetchurl {
        hash = "sha256-Ywvc8kX3hjfBPsAf+uYYfMo0Yl6MYxUNQktZ5VryZ14=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-macros/2.1.0/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "tokio-native-tls-0.3.1" = {
      pname = "tokio-native-tls";
      version = "0.3.1";
      depKeys = [
        ("native-tls-0.2.11")
        ("tokio-1.32.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-u652q5M8hXdu+ryXFWndYRnFgNj11Eh2newXZL95bvI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-native-tls/0.3.1/download";
      });
      edition = "2018";
    };
    "tokio-util-0.7.8" = {
      pname = "tokio-util";
      version = "0.7.8";
      depKeys = [
        ("bytes-1.4.0")
        ("futures-core-0.3.28")
        ("futures-sink-0.3.28")
        ("pin-project-lite-0.2.13")
        ("tokio-1.32.0")
        ("tracing-0.1.37")
      ];
      src = (final.fetchurl {
        hash = "sha256-gG/owsh+zMizJny64p7Tqy0L03/KcKtiLkaqqTdd230=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-util/0.7.8/download";
      });
      edition = "2021";
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
      src = (final.fetchurl {
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
        ("pin-project-lite-0.2.13")
        ("tracing-core-0.1.31")
      ];
      src = (final.fetchurl {
        hash = "sha256-jOjDOo1IvUXWJKblI0Rf0h7BPTZTzVH2gav2dBj1Trg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing/0.1.37/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "tracing-core-0.1.31" = {
      pname = "tracing-core";
      version = "0.1.31";
      depKeys = [
        ("once_cell-1.18.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-CVW4E3od9vGi6aN9imZWKR/wKXwal8JODYQl/iMS95o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing-core/0.1.31/download";
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-SXlh75PZdOI+tvQz61/ht5MLZZ8G0S3sb8RKj1VMC7o=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/typenum/1.16.0/download";
      });
      build = "build/main.rs";
      edition = "2018";
    };
    "unicode-bidi-0.3.13" = {
      pname = "unicode-bidi";
      version = "0.3.13";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-koiLpVc/8IBzazZIaWtwyvrX0lBVEXWsuqTgOFs+FGA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-bidi/0.3.13/download";
      });
      edition = "2018";
      features = [
        ("hardcoded-data")
        ("std")
      ];
    };
    "unicode-ident-1.0.11" = {
      pname = "unicode-ident";
      version = "1.0.11";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-MBq6rkdaqRaH64JRSzKKtHohGlMwJssl/D5Rm4at/Dw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-ident/1.0.11/download";
      });
      edition = "2018";
    };
    "unicode-normalization-0.1.22" = {
      pname = "unicode-normalization";
      version = "0.1.22";
      depKeys = [
        ("tinyvec-1.6.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-XFcT8PxLXbZooqxjzbe7RGnYyf7QR7HQKSzHsM4rqSE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-normalization/0.1.22/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "unicode-width-0.1.10" = {
      pname = "unicode-width";
      version = "0.1.10";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-wO3R5bFGU/eDdwvOSk2rtKUQilNwpfXYz+hxDDYfbIs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-width/0.1.10/download";
      });
      edition = "2015";
      features = [
        ("default")
      ];
    };
    "url-2.4.0" = {
      pname = "url";
      version = "2.4.0";
      depKeys = [
        ("form_urlencoded-1.2.0")
        ("idna-0.4.0")
        ("percent-encoding-2.3.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-UL/3gx4ZIAqFsXEx0IXCXXgRvE4Ybv2vVLvRMplKiMs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/url/2.4.0/download";
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-SYdLUWe2XXGTuKuhVn9cfZPQAcr8NGAM7gA+2nh+SD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/version_check/0.9.4/download";
      });
      edition = "2015";
    };
    "walkdir-2.3.3" = {
      pname = "walkdir";
      version = "2.3.3";
      depKeys = [
        ("same-file-1.0.6")
      ];
      src = (final.fetchurl {
        hash = "sha256-Nt+UTNpWx9jYt0lq83jmsW3pKEWRkX0wfJtNMTxE5pg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/walkdir/2.3.3/download";
      });
      edition = "2018";
    };
    "want-0.3.1" = {
      pname = "want";
      version = "0.3.1";
      depKeys = [
        ("try-lock-0.2.4")
      ];
      src = (final.fetchurl {
        hash = "sha256-v6d2Cu0Z4QbeLHwLWBtQny8l09rK9zfLgqxhvG12Cw4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/want/0.3.1/download";
      });
      edition = "2018";
    };
    "wasi-0.11.0+wasi-snapshot-preview1" = {
      pname = "wasi";
      version = "0.11.0-wasi-snapshot-preview1";
      depKeys = [
      ];
      src = (final.fetchurl {
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
    "wasm-bindgen-0.2.87" = {
      pname = "wasm-bindgen";
      version = "0.2.87";
      depKeys = [
        ("cfg-if-1.0.0")
        ("wasm-bindgen-macro-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-dwanKrNtjLH4D/vw4HFTOXSmDQowjQGl0Ddb9gSZo0I=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen/0.2.87/download";
      });
      build = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("spans")
        ("std")
      ];
    };
    "wasm-bindgen-backend-0.2.87" = {
      pname = "wasm-bindgen-backend";
      version = "0.2.87";
      depKeys = [
        ("bumpalo-3.13.0")
        ("log-0.4.20")
        ("once_cell-1.18.0")
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
        ("wasm-bindgen-shared-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-XvK208UQ6WJeX+b1CasH1mp2DwiF2FhzZIPDLteAmr0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-backend/0.2.87/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-futures-0.4.37" = {
      pname = "wasm-bindgen-futures";
      version = "0.4.37";
      depKeys = [
        ("cfg-if-1.0.0")
        ("js-sys-0.3.64")
        ("wasm-bindgen-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-wC28IVFvnx8E8YeViJDX5gJt+NFlQLetlJK8NKZ86gM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-futures/0.4.37/download";
      });
      edition = "2018";
    };
    "wasm-bindgen-macro-0.2.87" = {
      pname = "wasm-bindgen-macro";
      version = "0.2.87";
      depKeys = [
        ("quote-1.0.33")
        ("wasm-bindgen-macro-support-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-3uSV5VmCo71IEFp7lH/SqbSorjAQBBueD6qz+c0Cjx0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.87/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
      procMacro = true;
    };
    "wasm-bindgen-macro-support-0.2.87" = {
      pname = "wasm-bindgen-macro-support";
      version = "0.2.87";
      depKeys = [
        ("proc-macro2-1.0.66")
        ("quote-1.0.33")
        ("syn-2.0.29")
        ("wasm-bindgen-backend-0.2.87")
        ("wasm-bindgen-shared-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-VGgbGKRnZfCVdYOI8tDPFuuNQWm2OatXWo9Wk68hDHs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.87/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-shared-0.2.87" = {
      pname = "wasm-bindgen-shared";
      version = "0.2.87";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-ymrQWkhwsr9f6ZURfTcoQ3vSfXzV8G8TwXRD7zaXdaE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.87/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "web-sys-0.3.64" = {
      pname = "web-sys";
      version = "0.3.64";
      depKeys = [
        ("js-sys-0.3.64")
        ("wasm-bindgen-0.2.87")
      ];
      src = (final.fetchurl {
        hash = "sha256-m4XL74wiCmq8Aq79iS38D8I6+xxqQmMW7DMlOjh3JJs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/web-sys/0.3.64/download";
      });
      edition = "2018";
      features = [
        ("AbortController")
        ("AbortSignal")
        ("Blob")
        ("BlobPropertyBag")
        ("Event")
        ("EventTarget")
        ("File")
        ("FormData")
        ("Headers")
        ("MessageEvent")
        ("ReadableStream")
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
      src = (final.fetchurl {
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
        ("winbase")
        ("wincon")
        ("wincrypt")
        ("winerror")
        ("winnt")
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-cS4ieEHQV8HuHNL7Ivp+WlRhro5I+iynnsQs/BkxGD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download";
      });
      build = "build.rs";
      edition = "2015";
    };
    "windows-sys-0.48.0" = {
      pname = "windows-sys";
      version = "0.48.0";
      depKeys = [
        ("windows-targets-0.48.5")
      ];
      src = (final.fetchurl {
        hash = "sha256-Z30kGL7GXjM47bB26Aa8HsFWk8XQEEaD8u/oV/YQVqk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows-sys/0.48.0/download";
      });
      edition = "2018";
      features = [
        ("Win32")
        ("Win32_Foundation")
        ("Win32_NetworkManagement")
        ("Win32_NetworkManagement_IpHelper")
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
        ("Win32_System_Console")
        ("Win32_System_Diagnostics")
        ("Win32_System_Diagnostics_Debug")
        ("Win32_System_IO")
        ("Win32_System_Memory")
        ("Win32_System_Pipes")
        ("Win32_System_Registry")
        ("Win32_System_SystemServices")
        ("Win32_System_Threading")
        ("Win32_System_Time")
        ("Win32_System_WindowsProgramming")
        ("default")
      ];
    };
    "windows-targets-0.48.5" = {
      pname = "windows-targets";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-mi+m4hVdcke+aMCWRWCDFFwYPLu8J2QVDdpFqHGXlAw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows-targets/0.48.5/download";
      });
      edition = "2018";
    };
    "windows_aarch64_gnullvm-0.48.5" = {
      pname = "windows_aarch64_gnullvm";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-KzjjLwq8z5mHpOMHnftn3NeZ+2E2HlPiiCw8uvDZBdg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_aarch64_msvc-0.48.5" = {
      pname = "windows_aarch64_msvc";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-3DUxCXHzstu/PwaQohn0Di2a/PZPmrfMG+cik3wmtLw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_i686_gnu-0.48.5" = {
      pname = "windows_i686_gnu";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-p1kV5972DJTc73IgC5qOWOUJF0SWDaZOxzSmxumzdD4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_i686_gnu/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_i686_msvc-0.48.5" = {
      pname = "windows_i686_msvc";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-j1XCM/cMSyf2bFI1gPePEATotai2WeBaTrSdQWbMpAY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_i686_msvc/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_gnu-0.48.5" = {
      pname = "windows_x86_64_gnu";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-U9QKvSWD0j5HGP3fHr7ITb/4OBwHyuZ/93aLvxnGcY4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_gnullvm-0.48.5" = {
      pname = "windows_x86_64_gnullvm";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-C3tSdnhooj1bq3aOOQ3F9cVYJbbTC4bIRP8tx0FARMw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "windows_x86_64_msvc-0.48.5" = {
      pname = "windows_x86_64_msvc";
      version = "0.48.5";
      depKeys = [
      ];
      src = (final.fetchurl {
        hash = "sha256-7ZT85hVxpABoUrc4mgY6uYPALrG7N7R/gnLOktBtlTg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.48.5/download";
      });
      build = "build.rs";
      edition = "2018";
    };
    "winreg-0.50.0" = {
      pname = "winreg";
      version = "0.50.0";
      depKeys = [
        ("cfg-if-1.0.0")
        ("windows-sys-0.48.0")
      ];
      src = (final.fetchurl {
        hash = "sha256-Uk5XssU3wPmx5p8ZZTEewSGCtBIuRQNbFQjNJNKtrbE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winreg/0.50.0/download";
      });
      edition = "2018";
    };
    "wyz-0.2.0" = {
      pname = "wyz";
      version = "0.2.0";
      depKeys = [
      ];
      src = (final.fetchurl {
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
      src = (final.fetchurl {
        hash = "sha256-VsGTbEzHocmrIaHrtgLrlCuoaMvUSpnLfNxYkjNeHIU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/yaml-rust/0.4.5/download";
      });
      edition = "2018";
    };
  };
}