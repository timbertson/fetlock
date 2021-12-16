final:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "cargo";
    version = "1";
    root = "fetlock 0.1.0";
  };
  specs = {
    "aho-corasick 0.7.18" = {
      pname = "aho-corasick";
      version = "0.7.18";
      depKeys = [
        ("memchr 2.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HjfP1edletpF90LW6ZyleIWAtcUp3Hj68R7ObccCZW8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/aho-corasick/0.7.18/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "anyhow 1.0.48" = {
      pname = "anyhow";
      version = "1.0.48";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YuH0f33AQiAnpONw3UVI1NZrJnguUT6Y3KHmieBYqA4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/anyhow/1.0.48/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "arrayvec 0.5.2" = {
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
    "async-trait 0.1.52" = {
      pname = "async-trait";
      version = "0.1.52";
      depKeys = [
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Bhp6zMqihsAR3cMJcFILmPpA4AydZEYz+ya1/GOiZeM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/async-trait/0.1.52/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "atty 0.2.14" = {
      pname = "atty";
      version = "0.2.14";
      depKeys = [
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2bOb4Ydw0RQhzbG5lHpF3T836TCSy/N3YUgooxnV/ug=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/atty/0.2.14/download";
      });
      edition = "2015";
    };
    "autocfg 1.0.1" = {
      pname = "autocfg";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-zbAx3XjihzHYfVbMj/70qPNsomw4/i3nAFQ+Yn+KRko=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/autocfg/1.0.1/download";
      });
      edition = "2015";
    };
    "base64 0.13.0" = {
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
    "bitflags 1.3.2" = {
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
    "bitvec 0.19.6" = {
      pname = "bitvec";
      version = "0.19.6";
      depKeys = [
        ("funty 1.1.0")
        ("radium 0.5.3")
        ("tap 1.0.1")
        ("wyz 0.2.0")
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
    "block-buffer 0.9.0" = {
      pname = "block-buffer";
      version = "0.9.0";
      depKeys = [
        ("generic-array 0.14.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-QVIRb9bp2tspGuGPwew1de1thMKWQtl4kPS0o0Fyl+Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/block-buffer/0.9.0/download";
      });
      edition = "2018";
    };
    "bumpalo 3.8.0" = {
      pname = "bumpalo";
      version = "3.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jx4mDDqQQKfBmhJGh1j0wW8xqBof4IdIK+lXDshku2w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bumpalo/3.8.0/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "bytes 1.1.0" = {
      pname = "bytes";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-xIctZ7q2NY5ZVZAnqjuRV8U9k1jFFCPBdVSAmohY4Pg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/bytes/1.1.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "camino 1.0.5" = {
      pname = "camino";
      version = "1.0.5";
      depKeys = [
        ("serde 1.0.131")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-UtdCYNm/aUTiIIqkaEG0uPDX/8CEmgaDey9RAzf4ays=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/camino/1.0.5/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("serde")
        ("serde1")
      ];
    };
    "cargo-platform 0.1.2" = {
      pname = "cargo-platform";
      version = "0.1.2";
      depKeys = [
        ("serde 1.0.131")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-y9uCXail3weaQ2dtvgQnAvFwexEJ9xOgFCD7tMxx+ic=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo-platform/0.1.2/download";
      });
      edition = "2018";
    };
    "cargo_metadata 0.14.1" = {
      pname = "cargo_metadata";
      version = "0.14.1";
      depKeys = [
        ("camino 1.0.5")
        ("cargo-platform 0.1.2")
        ("semver 1.0.4")
        ("serde 1.0.131")
        ("serde_json 1.0.73")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-uirm3pRBQxQfYVWkc6awL2bHw/n0cxb4AvgCBOv+bhI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cargo_metadata/0.14.1/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "cc 1.0.72" = {
      pname = "cc";
      version = "1.0.72";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-IqkTe5XqBoZOAYN1tyrft9tub2jPyN9aBNACiAUEhe4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cc/1.0.72/download";
      });
      crateBin = [
        ({
          name = "gcc-shim";
          path = "src/bin/gcc-shim.rs";
        })
      ];
      edition = "2018";
    };
    "cfg-if 1.0.0" = {
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
    "clap 3.0.0-rc.5" = {
      pname = "clap";
      version = "3.0.0-rc.5";
      depKeys = [
        ("atty 0.2.14")
        ("bitflags 1.3.2")
        ("clap_derive 3.0.0-rc.5")
        ("indexmap 1.7.0")
        ("lazy_static 1.4.0")
        ("os_str_bytes 6.0.0")
        ("strsim 0.10.0")
        ("termcolor 1.1.2")
        ("textwrap 0.14.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-nTWNXc0nRpLmDfd1vUUvZjQaSauQzGzBCExDUKP5FNk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap/3.0.0-rc.5/download";
      });
      edition = "2018";
      features = [
        ("atty")
        ("clap_derive")
        ("color")
        ("default")
        ("derive")
        ("lazy_static")
        ("std")
        ("strsim")
        ("suggestions")
        ("termcolor")
      ];
    };
    "clap_derive 3.0.0-rc.5" = {
      pname = "clap_derive";
      version = "3.0.0-rc.5";
      depKeys = [
        ("heck 0.3.3")
        ("proc-macro-error 1.0.4")
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-aggjgC7DKTCnsiEz3DqLfPKXKX6K9BPlnS+7+GTHvWM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/clap_derive/3.0.0-rc.5/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "core-foundation 0.9.2" = {
      pname = "core-foundation";
      version = "0.9.2";
      depKeys = [
        ("core-foundation-sys 0.8.3")
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-aIjhBVG7k+Qk2N8dB/GotPzrAAGjpLBIv8R1VJRvR7M=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/core-foundation/0.9.2/download";
      });
      edition = "2015";
    };
    "core-foundation-sys 0.8.3" = {
      pname = "core-foundation-sys";
      version = "0.8.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WCfOv0ZwRouHct0ZGFZ2iu3LGwJ4oE+Yn3dmNRkXudw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/core-foundation-sys/0.8.3/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "cpufeatures 0.2.1" = {
      pname = "cpufeatures";
      version = "0.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lQWUKPZt9WtjQx/bThlH7SGQWGr1xaiotxEivfWn9Gk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/cpufeatures/0.2.1/download";
      });
      edition = "2018";
    };
    "data-encoding 2.3.2" = {
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
    "digest 0.9.0" = {
      pname = "digest";
      version = "0.9.0";
      depKeys = [
        ("generic-array 0.14.4")
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
    "either 1.6.1" = {
      pname = "either";
      version = "1.6.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-541PHMSuM7v8FX7V1aXvO8KSJzA9WVhh3rI4/OxOlFc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/either/1.6.1/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("use_std")
      ];
    };
    "encoding_rs 0.8.30" = {
      pname = "encoding_rs";
      version = "0.8.30";
      depKeys = [
        ("cfg-if 1.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-eJbcirslD/3aM5ElUPqlTIjsi5mN7AssVasiSSHOEd8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/encoding_rs/0.8.30/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
      ];
    };
    "env_logger 0.7.1" = {
      pname = "env_logger";
      version = "0.7.1";
      depKeys = [
        ("atty 0.2.14")
        ("humantime 1.3.0")
        ("log 0.4.14")
        ("regex 1.5.4")
        ("termcolor 1.1.2")
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
    "fetlock 0.1.0" = {
      pname = "fetlock";
      version = "0.1.0";
      depKeys = [
        ("anyhow 1.0.48")
        ("async-trait 0.1.52")
        ("cargo-platform 0.1.2")
        ("cargo_metadata 0.14.1")
        ("clap 3.0.0-rc.5")
        ("data-encoding 2.3.2")
        ("either 1.6.1")
        ("env_logger 0.7.1")
        ("fs2 0.4.3")
        ("futures 0.3.17")
        ("getopts 0.2.21")
        ("lazy_static 1.4.0")
        ("log 0.4.14")
        ("nom 6.1.2")
        ("platforms 1.1.0")
        ("regex 1.5.4")
        ("reqwest 0.11.7")
        ("serde 1.0.131")
        ("serde_json 1.0.73")
        ("serde_yaml 0.8.23")
        ("sha2 0.9.8")
        ("tempdir 0.3.7")
        ("tokio 1.15.0")
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
    "fnv 1.0.7" = {
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
    "foreign-types 0.3.2" = {
      pname = "foreign-types";
      version = "0.3.2";
      depKeys = [
        ("foreign-types-shared 0.1.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-9vM564rcBSzSyniRD9qGmu+jjSLVy2SOZIXk0/wG87E=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/foreign-types/0.3.2/download";
      });
      edition = "2015";
    };
    "foreign-types-shared 0.1.1" = {
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
    "form_urlencoded 1.0.1" = {
      pname = "form_urlencoded";
      version = "1.0.1";
      depKeys = [
        ("matches 0.1.9")
        ("percent-encoding 2.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-X8Jah/pP0glL/7BpJYUgNNkKF/DR4FGX1JVtNVV1IZE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/form_urlencoded/1.0.1/download";
      });
      edition = "2018";
    };
    "fs2 0.4.3" = {
      pname = "fs2";
      version = "0.4.3";
      depKeys = [
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lWT8dY4VAltGqmZDsbd9BH0aVqGupuAQAqwMcCaHYhM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/fs2/0.4.3/download";
      });
      edition = "2015";
    };
    "fuchsia-cprng 0.1.1" = {
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
    "funty 1.1.0" = {
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
    "futures 0.3.17" = {
      pname = "futures";
      version = "0.3.17";
      depKeys = [
        ("futures-channel 0.3.17")
        ("futures-core 0.3.17")
        ("futures-executor 0.3.17")
        ("futures-io 0.3.17")
        ("futures-sink 0.3.17")
        ("futures-task 0.3.17")
        ("futures-util 0.3.17")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-oSqg61OQgNVcPy1Fpnw7WLawdzwaPKLf7GbVjJf9Zso=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures/0.3.17/download";
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
    "futures-channel 0.3.17" = {
      pname = "futures-channel";
      version = "0.3.17";
      depKeys = [
        ("futures-core 0.3.17")
        ("futures-sink 0.3.17")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Xaa6jDuzwWXTxzGfwcyDBPrPH7jbmcXeh3GDwIonOIg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-channel/0.3.17/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("futures-sink")
        ("sink")
        ("std")
      ];
    };
    "futures-core 0.3.17" = {
      pname = "futures-core";
      version = "0.3.17";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-iNHCaVfyNgM5XNMmsP/mQSS4GPRElVL5YNgVz7qDpT0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-core/0.3.17/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-executor 0.3.17" = {
      pname = "futures-executor";
      version = "0.3.17";
      depKeys = [
        ("futures-core 0.3.17")
        ("futures-task 0.3.17")
        ("futures-util 0.3.17")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-RQJb4DCWnXYwJXhPfzVQQ9xrx0CT5OzFAAyk3FDYdFw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-executor/0.3.17/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-io 0.3.17" = {
      pname = "futures-io";
      version = "0.3.17";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Ui3ioP4+OA8bxXe6BHQQj68/axgyHb9gs7nDmnUHM3c=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-io/0.3.17/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "futures-macro 0.3.17" = {
      pname = "futures-macro";
      version = "0.3.17";
      depKeys = [
        ("proc-macro-hack 0.5.19")
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GOSkuVzqS0zLzxxWdcp8TuTp5163mUTQfe/eGAaPebs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-macro/0.3.17/download";
      });
      buildDepKeys = [
        ("autocfg 1.0.1")
      ];
      buildSrc = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "futures-sink 0.3.17" = {
      pname = "futures-sink";
      version = "0.3.17";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-NuoVPBMCT+SAWQs+PUytiaDPrOzCRXe2j4bGztnCvBE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-sink/0.3.17/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
      ];
    };
    "futures-task 0.3.17" = {
      pname = "futures-task";
      version = "0.3.17";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HT0A9O3bc+SYpUOU8ijNVYU73wWSWejnvG5p1AiJLpk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-task/0.3.17/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "futures-util 0.3.17" = {
      pname = "futures-util";
      version = "0.3.17";
      depKeys = [
        ("futures-channel 0.3.17")
        ("futures-core 0.3.17")
        ("futures-io 0.3.17")
        ("futures-macro 0.3.17")
        ("futures-sink 0.3.17")
        ("futures-task 0.3.17")
        ("memchr 2.4.1")
        ("pin-project-lite 0.2.7")
        ("pin-utils 0.1.0")
        ("proc-macro-hack 0.5.19")
        ("proc-macro-nested 0.1.7")
        ("slab 0.4.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-NlaEZSEKOm7kXh8WUTbWhnFHGlAeYy6amNlociIrVIE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/futures-util/0.3.17/download";
      });
      buildDepKeys = [
        ("autocfg 1.0.1")
      ];
      buildSrc = "build.rs";
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
        ("proc-macro-hack")
        ("proc-macro-nested")
        ("sink")
        ("slab")
        ("std")
      ];
    };
    "generic-array 0.14.4" = {
      pname = "generic-array";
      version = "0.14.4";
      depKeys = [
        ("typenum 1.14.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-UBRm7MijDR07f8kimxIrLOjtbp2SI/ETjUurslPlGBc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/generic-array/0.14.4/download";
      });
      buildDepKeys = [
        ("version_check 0.9.3")
      ];
      buildSrc = "build.rs";
      edition = "2015";
    };
    "getopts 0.2.21" = {
      pname = "getopts";
      version = "0.2.21";
      depKeys = [
        ("unicode-width 0.1.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FNu/1ccdcCQez55vE3N/e1zoI4IQYxiNfkbEHTce69U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/getopts/0.2.21/download";
      });
      edition = "2015";
    };
    "getrandom 0.2.3" = {
      pname = "getrandom";
      version = "0.2.3";
      depKeys = [
        ("cfg-if 1.0.0")
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-f82ZlGNSTFJllRf+LOqYSTz+SF0QVl57D7B9u6etJ1M=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/getrandom/0.2.3/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "h2 0.3.9" = {
      pname = "h2";
      version = "0.3.9";
      depKeys = [
        ("bytes 1.1.0")
        ("fnv 1.0.7")
        ("futures-core 0.3.17")
        ("futures-sink 0.3.17")
        ("futures-util 0.3.17")
        ("http 0.2.5")
        ("indexmap 1.7.0")
        ("slab 0.4.5")
        ("tokio 1.15.0")
        ("tokio-util 0.6.9")
        ("tracing 0.1.29")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jwckE9Em5XmRRV4Kkisx5Mi6fC/76/a3i0+FITl9Zc0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/h2/0.3.9/download";
      });
      edition = "2018";
    };
    "hashbrown 0.11.2" = {
      pname = "hashbrown";
      version = "0.11.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-q17w1JCe83JMyMzmzMhXLFyBdZLpKF9UZPjob4vTcm4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hashbrown/0.11.2/download";
      });
      edition = "2018";
      features = [
        ("raw")
      ];
    };
    "heck 0.3.3" = {
      pname = "heck";
      version = "0.3.3";
      depKeys = [
        ("unicode-segmentation 1.8.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-bWIe+yaGPw6ZJMasV36CdeXmt3RV22T/psZckE6eEyw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/heck/0.3.3/download";
      });
      edition = "2018";
    };
    "hermit-abi 0.1.19" = {
      pname = "hermit-abi";
      version = "0.1.19";
      depKeys = [
        ("libc 0.2.112")
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
    "http 0.2.5" = {
      pname = "http";
      version = "0.2.5";
      depKeys = [
        ("bytes 1.1.0")
        ("fnv 1.0.7")
        ("itoa 0.4.8")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-EyMJawXUGCfa3q7lTJmBlYwPlOZwvJTtgAN9GnuLGGs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/http/0.2.5/download";
      });
      edition = "2018";
    };
    "http-body 0.4.4" = {
      pname = "http-body";
      version = "0.4.4";
      depKeys = [
        ("bytes 1.1.0")
        ("http 0.2.5")
        ("pin-project-lite 0.2.7")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-H/T4SRlncwPaXxR2RdvqaxiB82jQOshOHcCQMevXssY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/http-body/0.4.4/download";
      });
      edition = "2018";
    };
    "httparse 1.5.1" = {
      pname = "httparse";
      version = "1.5.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-rNlP2+HU/2iLZ7BO7i4XvVCZVTSmFTnkWt/vtF5eVQM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/httparse/1.5.1/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "httpdate 1.0.2" = {
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
    "humantime 1.3.0" = {
      pname = "humantime";
      version = "1.3.0";
      depKeys = [
        ("quick-error 1.2.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-3wBM/KUO8jw2hQqqpZrVLMcNDpAkPDx3N6TdMtx6PE8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/humantime/1.3.0/download";
      });
      edition = "2015";
    };
    "hyper 0.14.16" = {
      pname = "hyper";
      version = "0.14.16";
      depKeys = [
        ("bytes 1.1.0")
        ("futures-channel 0.3.17")
        ("futures-core 0.3.17")
        ("futures-util 0.3.17")
        ("h2 0.3.9")
        ("http 0.2.5")
        ("http-body 0.4.4")
        ("httparse 1.5.1")
        ("httpdate 1.0.2")
        ("itoa 0.4.8")
        ("pin-project-lite 0.2.7")
        ("socket2 0.4.2")
        ("tokio 1.15.0")
        ("tower-service 0.3.1")
        ("tracing 0.1.29")
        ("want 0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-t+w+Yr3Jii8Dk6UEjkww72WUQOpuDlcpZRA+cr2Db1U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper/0.14.16/download";
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
    "hyper-tls 0.5.0" = {
      pname = "hyper-tls";
      version = "0.5.0";
      depKeys = [
        ("bytes 1.1.0")
        ("hyper 0.14.16")
        ("native-tls 0.2.8")
        ("tokio 1.15.0")
        ("tokio-native-tls 0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1hg936mbhdphoUC+oO/JP99WzqoEGzfVU1GAMIJ/mQU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/hyper-tls/0.5.0/download";
      });
      edition = "2018";
    };
    "idna 0.2.3" = {
      pname = "idna";
      version = "0.2.3";
      depKeys = [
        ("matches 0.1.9")
        ("unicode-bidi 0.3.7")
        ("unicode-normalization 0.1.19")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-QYoKb6uCFHX2NO/jzMRcAT90Lv4D2FPo0zVdXLhQ7Pg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/idna/0.2.3/download";
      });
      edition = "2018";
    };
    "indexmap 1.7.0" = {
      pname = "indexmap";
      version = "1.7.0";
      depKeys = [
        ("hashbrown 0.11.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vGM2BUVBJd7EtmhDZz8Bx98riUebMuDtY05DqRz/YqU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/indexmap/1.7.0/download";
      });
      buildDepKeys = [
        ("autocfg 1.0.1")
      ];
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "instant 0.1.12" = {
      pname = "instant";
      version = "0.1.12";
      depKeys = [
        ("cfg-if 1.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-elu+gkxQfF2llWNV6Gp0bYLg4UZPZdhizF5x2nDpSyw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/instant/0.1.12/download";
      });
      edition = "2018";
    };
    "ipnet 2.3.1" = {
      pname = "ipnet";
      version = "2.3.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-aPLWTy7evsTOhK0QgUjmfhBkeJvuQ17cW2CtOYcUo6k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ipnet/2.3.1/download";
      });
      edition = "2015";
    };
    "itoa 0.4.8" = {
      pname = "itoa";
      version = "0.4.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-txmR/1YpSqkitFATnuCLO/xwmCxrLHVidxN1z3NULdQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/itoa/0.4.8/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "itoa 1.0.1" = {
      pname = "itoa";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GquPw2dYi4nc7oOrD9ZrcrULcvoZBNcJUEWs4rDIHDU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/itoa/1.0.1/download";
      });
      edition = "2018";
    };
    "js-sys 0.3.55" = {
      pname = "js-sys";
      version = "0.3.55";
      depKeys = [
        ("wasm-bindgen 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-fMn/zNOMRRqGvxNlffJE6cPzdJPM6OXiHpQJY3d6zIQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/js-sys/0.3.55/download";
      });
      edition = "2018";
    };
    "lazy_static 1.4.0" = {
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
    "lexical-core 0.7.6" = {
      pname = "lexical-core";
      version = "0.7.6";
      depKeys = [
        ("arrayvec 0.5.2")
        ("bitflags 1.3.2")
        ("cfg-if 1.0.0")
        ("ryu 1.0.9")
        ("static_assertions 1.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ZgfGKqFh0j0XqQcsxdoL5nzfyJ06+x6NnIQr68JSX/4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lexical-core/0.7.6/download";
      });
      buildSrc = "build.rs";
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
    "libc 0.2.112" = {
      pname = "libc";
      version = "0.2.112";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GwPRfzZKOgQtXl1GsFO7v4LJLJQwxZLdTAZNxu6ZcSU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/libc/0.2.112/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "linked-hash-map 0.5.4" = {
      pname = "linked-hash-map";
      version = "0.5.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-f7mzivkmCBQLhraTYEuf/MWCQkCkhNHs1HlbrLL+iPM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/linked-hash-map/0.5.4/download";
      });
      edition = "2015";
    };
    "lock_api 0.4.5" = {
      pname = "lock_api";
      version = "0.4.5";
      depKeys = [
        ("scopeguard 1.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cSpNCTyZduJOfbykHbiV2ry6w4619ARTk9F6lb37EQk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/lock_api/0.4.5/download";
      });
      edition = "2018";
    };
    "log 0.4.14" = {
      pname = "log";
      version = "0.4.14";
      depKeys = [
        ("cfg-if 1.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Ubm75sR9Ufw+GpuUWWWUa0xEFCq4eSxQg1qYDTYsJxA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/log/0.4.14/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("std")
      ];
    };
    "matches 0.1.9" = {
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
    "memchr 2.4.1" = {
      pname = "memchr";
      version = "2.4.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-MIzDm+Abc9DRj4Kg57Kj34UkX4Svlv3dxdIC0n5HuGo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/memchr/2.4.1/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
        ("use_std")
      ];
    };
    "mime 0.3.16" = {
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
    "mio 0.7.14" = {
      pname = "mio";
      version = "0.7.14";
      depKeys = [
        ("libc 0.2.112")
        ("log 0.4.14")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-gGe0BP6Xxwgp8ILeyLz09xIl1+rqHYZFNJy3b6BiBcw=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/mio/0.7.14/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("net")
        ("os-ext")
        ("os-poll")
        ("os-util")
        ("tcp")
        ("udp")
        ("uds")
      ];
    };
    "miow 0.3.7" = {
      pname = "miow";
      version = "0.3.7";
      depKeys = [
        ("winapi 0.3.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ufHFsCXNqHb2bvQ6ET+R68n0zO80hDAA4K3267q4TiE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/miow/0.3.7/download";
      });
      edition = "2018";
    };
    "native-tls 0.2.8" = {
      pname = "native-tls";
      version = "0.2.8";
      depKeys = [
        ("lazy_static 1.4.0")
        ("libc 0.2.112")
        ("security-framework 2.4.2")
        ("security-framework-sys 2.4.2")
        ("tempfile 3.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-SLqfdxm1oPQvM4kHYUKF+1/XDlOFgUH2mJih+3IDsk0=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/native-tls/0.2.8/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "nom 6.1.2" = {
      pname = "nom";
      version = "6.1.2";
      depKeys = [
        ("bitvec 0.19.6")
        ("funty 1.1.0")
        ("lexical-core 0.7.6")
        ("memchr 2.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-50E/mZZxvUdFp7YkvTcKVp+2vFdLI8g6PF7S5FPz1eI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/nom/6.1.2/download";
      });
      buildDepKeys = [
        ("version_check 0.9.3")
      ];
      buildSrc = "build.rs";
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
    "ntapi 0.3.6" = {
      pname = "ntapi";
      version = "0.3.6";
      depKeys = [
        ("winapi 0.3.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-P2u5AuQ3tthuA8zhCn4q9mIpLF3+8jtliZ6jrJNUrUQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ntapi/0.3.6/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("user")
      ];
    };
    "num_cpus 1.13.0" = {
      pname = "num_cpus";
      version = "1.13.0";
      depKeys = [
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-BUmfN1ZnHBWIX+6QNERpVv/z8kPWB3uR5XZ98WH3ZrM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/num_cpus/1.13.0/download";
      });
      edition = "2015";
    };
    "once_cell 1.9.0" = {
      pname = "once_cell";
      version = "1.9.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2jJRXZ9ubkide8nYTHGwYNtyR9wDW75E6siM+HSG2NU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/once_cell/1.9.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("race")
        ("std")
      ];
    };
    "opaque-debug 0.3.0" = {
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
    "openssl 0.10.38" = {
      pname = "openssl";
      version = "0.10.38";
      depKeys = [
        ("bitflags 1.3.2")
        ("cfg-if 1.0.0")
        ("foreign-types 0.3.2")
        ("libc 0.2.112")
        ("once_cell 1.9.0")
        ("openssl-sys 0.9.72")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-DHriIiNMMN8UEVTxWQZsUJP/c7YyBNzacSHrCC/FapU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl/0.10.38/download";
      });
      buildSrc = "build.rs";
      crateRenames = {
        openssl-sys = [
          ({
            rename = "ffi";
            version = "0.9.72";
          })
        ];
      };
      edition = "2018";
    };
    "openssl-probe 0.1.4" = {
      pname = "openssl-probe";
      version = "0.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-KJiNhyq3YJWm5qyI2ZtU/SZ3AnNP1//mEMon9TPduVo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-probe/0.1.4/download";
      });
      edition = "2015";
    };
    "openssl-sys 0.9.72" = {
      pname = "openssl-sys";
      version = "0.9.72";
      depKeys = [
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-fkYQnDg2AnNfoKLkjdK3yJKwSOG/aeXDsdgEt9nCA8s=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/openssl-sys/0.9.72/download";
      });
      buildDepKeys = [
        ("autocfg 1.0.1")
        ("cc 1.0.72")
        ("pkg-config 0.3.24")
      ];
      buildSrc = "build/main.rs";
      edition = "2015";
    };
    "os_str_bytes 6.0.0" = {
      pname = "os_str_bytes";
      version = "6.0.0";
      depKeys = [
        ("memchr 2.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jiJEPRZDqQRgJZW6HNj32Jav5W0mcSUxxf9zoVsvv2Q=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/os_str_bytes/6.0.0/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("memchr")
        ("raw_os_str")
      ];
    };
    "parking_lot 0.11.2" = {
      pname = "parking_lot";
      version = "0.11.2";
      depKeys = [
        ("instant 0.1.12")
        ("lock_api 0.4.5")
        ("parking_lot_core 0.8.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-fRe3gDamBmO3l63q7kb1yd/ruGlI0SVQB6HWvgJx/5k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot/0.11.2/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "parking_lot_core 0.8.5" = {
      pname = "parking_lot_core";
      version = "0.8.5";
      depKeys = [
        ("cfg-if 1.0.0")
        ("instant 0.1.12")
        ("libc 0.2.112")
        ("smallvec 1.7.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-126OFJO8rA0nZsQnN/NEWPHIxQwNI7yyTqlTr/snMhY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/parking_lot_core/0.8.5/download";
      });
      buildSrc = "build.rs";
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.2.10";
          })
        ];
      };
      edition = "2018";
    };
    "percent-encoding 2.1.0" = {
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
    "pin-project-lite 0.2.7" = {
      pname = "pin-project-lite";
      version = "0.2.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jTHRHGmmtSoXS0K9wMMOXhFnD5B4iyxHHDHB0X1ElEM=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pin-project-lite/0.2.7/download";
      });
      edition = "2018";
    };
    "pin-utils 0.1.0" = {
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
    "pkg-config 0.3.24" = {
      pname = "pkg-config";
      version = "0.3.24";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WIk/dRybBBKHGgmr1i7NKgApjGyDvvoiPvmMUq70DL4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/pkg-config/0.3.24/download";
      });
      edition = "2015";
    };
    "platforms 1.1.0" = {
      pname = "platforms";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-mJ1DAS4socSgJQfGcoJpGgoyB/ncZ87FlrQ/6SWz0yU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/platforms/1.1.0/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "ppv-lite86 0.2.15" = {
      pname = "ppv-lite86";
      version = "0.2.15";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-7Qz7yBkUZb7WbhcYWW7gsLNdXuH0HF3yGJ0P6L3lNbo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ppv-lite86/0.2.15/download";
      });
      edition = "2018";
      features = [
        ("simd")
        ("std")
      ];
    };
    "proc-macro-error 1.0.4" = {
      pname = "proc-macro-error";
      version = "1.0.4";
      depKeys = [
        ("proc-macro-error-attr 1.0.4")
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2iVJD/mJKqs/z3w28Iz7kC3T5xyg+flRe+oCpzpc44w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download";
      });
      buildDepKeys = [
        ("version_check 0.9.3")
      ];
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("syn")
        ("syn-error")
      ];
    };
    "proc-macro-error-attr 1.0.4" = {
      pname = "proc-macro-error-attr";
      version = "1.0.4";
      depKeys = [
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ob5AGA5S7MmK2AsYSTS689DSn5eVdOQ5r1pVJ0s1+Gk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download";
      });
      buildDepKeys = [
        ("version_check 0.9.3")
      ];
      buildSrc = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "proc-macro-hack 0.5.19" = {
      pname = "proc-macro-hack";
      version = "0.5.19";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2/DEi8HZE3WuXDzYHjci3/Grz4GjCWAkBkDSI/Wf4OU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro-hack/0.5.19/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "proc-macro-nested 0.1.7" = {
      pname = "proc-macro-nested";
      version = "0.1.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vIgbLCJoE3DGp4DkevmEDvhBg3vJgRhDHU4YaL0MEIY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro-nested/0.1.7/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "proc-macro2 1.0.34" = {
      pname = "proc-macro2";
      version = "1.0.34";
      depKeys = [
        ("unicode-xid 0.2.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-L4TpLA98nVgyi4WnhVeBPkvYRRMNto1xhGNTRDmUI7E=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/proc-macro2/1.0.34/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("proc-macro")
      ];
    };
    "quick-error 1.2.3" = {
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
    "quote 1.0.10" = {
      pname = "quote";
      version = "1.0.10";
      depKeys = [
        ("proc-macro2 1.0.34")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-OLyMxqXy42VeCJnBuEhkOyVi+FPxFL/se+EgZ446zgU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/quote/1.0.10/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("proc-macro")
      ];
    };
    "radium 0.5.3" = {
      pname = "radium";
      version = "0.5.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-lBup142OL3zkdMAV7qTZxtJbajMn+YMu4ppN4n+Ru7g=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/radium/0.5.3/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
    };
    "rand 0.4.6" = {
      pname = "rand";
      version = "0.4.6";
      depKeys = [
        ("libc 0.2.112")
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
    "rand 0.8.4" = {
      pname = "rand";
      version = "0.8.4";
      depKeys = [
        ("libc 0.2.112")
        ("rand_chacha 0.3.1")
        ("rand_core 0.6.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-LnVzYy5kVM9rmdeqxMzKVL4G2gWsou90I9ItJ9TUvNg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand/0.8.4/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("getrandom")
        ("libc")
        ("rand_chacha")
        ("rand_hc")
        ("std")
        ("std_rng")
      ];
    };
    "rand_chacha 0.3.1" = {
      pname = "rand_chacha";
      version = "0.3.1";
      depKeys = [
        ("ppv-lite86 0.2.15")
        ("rand_core 0.6.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5sEKY6D6MiUr5J0h53CdTUuvjSMcLbzh6qgUG5sSfYg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand_chacha/0.3.1/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "rand_core 0.3.1" = {
      pname = "rand_core";
      version = "0.3.1";
      depKeys = [
        ("rand_core 0.4.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-em/euDsHXoJm3Mh2LCJ3b2h3pjEREh9fjHQR5b5+7Us=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand_core/0.3.1/download";
      });
      edition = "2015";
    };
    "rand_core 0.4.2" = {
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
    "rand_core 0.6.3" = {
      pname = "rand_core";
      version = "0.6.3";
      depKeys = [
        ("getrandom 0.2.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-008UCPVSlEU3kMSLLx67scW0t1Y+sfQYvPz9uwbrtOc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand_core/0.6.3/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("getrandom")
        ("std")
      ];
    };
    "rand_hc 0.3.1" = {
      pname = "rand_hc";
      version = "0.3.1";
      depKeys = [
        ("rand_core 0.6.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1R6fWW3iJ/2i6myEYH9VWOGW7q9DyYa3JLpPuP30l+c=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/rand_hc/0.3.1/download";
      });
      edition = "2018";
    };
    "rdrand 0.4.0" = {
      pname = "rdrand";
      version = "0.4.0";
      depKeys = [
        ("rand_core 0.3.1")
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
    "redox_syscall 0.2.10" = {
      pname = "redox_syscall";
      version = "0.2.10";
      depKeys = [
        ("bitflags 1.3.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-g4PzljkmnN6X0lWjK9towEczcpVBSUDGi90wwuEyA/8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/redox_syscall/0.2.10/download";
      });
      edition = "2018";
    };
    "regex 1.5.4" = {
      pname = "regex";
      version = "1.5.4";
      depKeys = [
        ("aho-corasick 0.7.18")
        ("memchr 2.4.1")
        ("regex-syntax 0.6.25")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-0HqGKTWetW8eL7FlK7BCEsByqHumhUagQGXVJWc6xGE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/regex/1.5.4/download";
      });
      edition = "2018";
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
    "regex-syntax 0.6.25" = {
      pname = "regex-syntax";
      version = "0.6.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-9JcoWITz/P9CT/yTPlbXy8pRHe8MmDGn+bX2FT48yJs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/regex-syntax/0.6.25/download";
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
    "remove_dir_all 0.5.3" = {
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
    "reqwest 0.11.7" = {
      pname = "reqwest";
      version = "0.11.7";
      depKeys = [
        ("base64 0.13.0")
        ("bytes 1.1.0")
        ("encoding_rs 0.8.30")
        ("futures-core 0.3.17")
        ("futures-util 0.3.17")
        ("http 0.2.5")
        ("http-body 0.4.4")
        ("hyper 0.14.16")
        ("hyper-tls 0.5.0")
        ("ipnet 2.3.1")
        ("lazy_static 1.4.0")
        ("log 0.4.14")
        ("mime 0.3.16")
        ("native-tls 0.2.8")
        ("percent-encoding 2.1.0")
        ("pin-project-lite 0.2.7")
        ("serde 1.0.131")
        ("serde_urlencoded 0.7.0")
        ("tokio 1.15.0")
        ("tokio-native-tls 0.3.0")
        ("url 2.2.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-B76ne8cIr6EOWZBcPUr3yP1DySFCUWcwlf+LFDRfy8U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/reqwest/0.11.7/download";
      });
      crateRenames = {
        native-tls = [
          ({
            rename = "native_tls_crate";
            version = "0.2.8";
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
    "ryu 1.0.9" = {
      pname = "ryu";
      version = "1.0.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-c7S3UMeCllwhG0LwIvWa8fvOq90CZiNxTxBBUvHsFJ8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/ryu/1.0.9/download";
      });
      edition = "2018";
    };
    "schannel 0.1.19" = {
      pname = "schannel";
      version = "0.1.19";
      depKeys = [
        ("lazy_static 1.4.0")
        ("winapi 0.3.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jwW6YJwjTmC+4NVH/pSkx+nacz0cliz25Z76TNnIvHU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/schannel/0.1.19/download";
      });
      edition = "2015";
    };
    "scopeguard 1.1.0" = {
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
    "security-framework 2.4.2" = {
      pname = "security-framework";
      version = "2.4.2";
      depKeys = [
        ("bitflags 1.3.2")
        ("core-foundation 0.9.2")
        ("core-foundation-sys 0.8.3")
        ("libc 0.2.112")
        ("security-framework-sys 2.4.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-UlvBq/2i4ZmNFSxFzxPmlvdtCklyMQsi+sFliwXffIc=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/security-framework/2.4.2/download";
      });
      edition = "2018";
      features = [
        ("OSX_10_9")
        ("default")
      ];
    };
    "security-framework-sys 2.4.2" = {
      pname = "security-framework-sys";
      version = "2.4.2";
      depKeys = [
        ("core-foundation-sys 0.8.3")
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-qd0U2DFgtSi3v9ZkOREFc+/PvigbF/wsqfOfVQ1hnH4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/security-framework-sys/2.4.2/download";
      });
      edition = "2018";
      features = [
        ("OSX_10_9")
        ("default")
      ];
    };
    "semver 1.0.4" = {
      pname = "semver";
      version = "1.0.4";
      depKeys = [
        ("serde 1.0.131")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-VoqOYliqM8EzWPgf2DStuFTG98lGhSCRCpsej6wGgBI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/semver/1.0.4/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("serde")
        ("std")
      ];
    };
    "serde 1.0.131" = {
      pname = "serde";
      version = "1.0.131";
      depKeys = [
        ("serde_derive 1.0.131")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-tK1p370+RTaRMsxk5nSMLWXN+wAaKxwjLRKLStYFYcE=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde/1.0.131/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("derive")
        ("serde_derive")
        ("std")
      ];
    };
    "serde_derive 1.0.131" = {
      pname = "serde_derive";
      version = "1.0.131";
      depKeys = [
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-txCoPE4N/2o9URlGuVJ0rZyp5dOuSXtj/ahmrJVTWNI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_derive/1.0.131/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "serde_json 1.0.73" = {
      pname = "serde_json";
      version = "1.0.73";
      depKeys = [
        ("itoa 1.0.1")
        ("ryu 1.0.9")
        ("serde 1.0.131")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-vL0DRLxlM7x+xW3xHUL7cPG5EjUcCCXMtyEbWdivfPU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_json/1.0.73/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("std")
        ("unbounded_depth")
      ];
    };
    "serde_urlencoded 0.7.0" = {
      pname = "serde_urlencoded";
      version = "0.7.0";
      depKeys = [
        ("form_urlencoded 1.0.1")
        ("itoa 0.4.8")
        ("ryu 1.0.9")
        ("serde 1.0.131")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-7fpXp/jZwdJgpUnnIkEA9sQ9Q/kQPgbdi0CVqbK0POk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_urlencoded/0.7.0/download";
      });
      edition = "2018";
    };
    "serde_yaml 0.8.23" = {
      pname = "serde_yaml";
      version = "0.8.23";
      depKeys = [
        ("indexmap 1.7.0")
        ("ryu 1.0.9")
        ("serde 1.0.131")
        ("yaml-rust 0.4.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-pKUh8pQDhcFlok7ihqqFmWM9FiB3pUvcripv1ae/p6A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/serde_yaml/0.8.23/download";
      });
      edition = "2018";
    };
    "sha2 0.9.8" = {
      pname = "sha2";
      version = "0.9.8";
      depKeys = [
        ("block-buffer 0.9.0")
        ("cfg-if 1.0.0")
        ("cpufeatures 0.2.1")
        ("digest 0.9.0")
        ("opaque-debug 0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-tp+aTJdA10xbqj/S5Uf5Ul+oCIqKlY4MokCaUU4z9fo=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/sha2/0.9.8/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "signal-hook-registry 1.4.0" = {
      pname = "signal-hook-registry";
      version = "1.4.0";
      depKeys = [
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-5R5zMo3ErAx8y9o6SU36A98d4vRgGBJ/YMaT8mSEVbA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/signal-hook-registry/1.4.0/download";
      });
      edition = "2015";
    };
    "slab 0.4.5" = {
      pname = "slab";
      version = "0.4.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ne+R/R4Bj+AHAieR+GXQzMmzoNUAHgGqu4tA5GAAr7U=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/slab/0.4.5/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "smallvec 1.7.0" = {
      pname = "smallvec";
      version = "1.7.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Hsq2xzWmu0E5wMqv0Mw2NXSLuzrPRVDoE4EiCZJR8wk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/smallvec/1.7.0/download";
      });
      edition = "2018";
    };
    "socket2 0.4.2" = {
      pname = "socket2";
      version = "0.4.2";
      depKeys = [
        ("libc 0.2.112")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-XckP5se+GjIylpgtsYNtHqnke2g5SW3emlQbxJbfNRY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/socket2/0.4.2/download";
      });
      edition = "2018";
    };
    "static_assertions 1.1.0" = {
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
    "strsim 0.10.0" = {
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
    "syn 1.0.82" = {
      pname = "syn";
      version = "1.0.82";
      depKeys = [
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("unicode-xid 0.2.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ja9d0Ltgy9QTextYfS/ArnKbwHzwHNcLNqHtWt47nVk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/syn/1.0.82/download";
      });
      buildSrc = "build.rs";
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
    "tap 1.0.1" = {
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
    "tempdir 0.3.7" = {
      pname = "tempdir";
      version = "0.3.7";
      depKeys = [
        ("rand 0.4.6")
        ("remove_dir_all 0.5.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FfK1+wDM32ieAUnRsbPAP+rYHCs3c12BL6i9279Bttg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tempdir/0.3.7/download";
      });
      edition = "2015";
    };
    "tempfile 3.2.0" = {
      pname = "tempfile";
      version = "3.2.0";
      depKeys = [
        ("cfg-if 1.0.0")
        ("libc 0.2.112")
        ("rand 0.8.4")
        ("remove_dir_all 0.5.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-2sHGY8/JOBD4iu2biUHUjKv4VqGxEcKaQEOQGNhw6yI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tempfile/3.2.0/download";
      });
      crateRenames = {
        redox_syscall = [
          ({
            rename = "syscall";
            version = "0.2.10";
          })
        ];
      };
      edition = "2018";
    };
    "termcolor 1.1.2" = {
      pname = "termcolor";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Lf7YmfDrA/Mu6Magqr24p5SWWeNGZWH8Ct9U4m2IxfQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/termcolor/1.1.2/download";
      });
      edition = "2018";
    };
    "textwrap 0.14.2" = {
      pname = "textwrap";
      version = "0.14.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-AGbI0Sr4tazSHgBUfDeX/eToZ3JUp+5CkXbM676T3YA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/textwrap/0.14.2/download";
      });
      edition = "2018";
    };
    "tinyvec 1.5.1" = {
      pname = "tinyvec";
      version = "1.5.1";
      depKeys = [
        ("tinyvec_macros 0.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-LBwdWkK2JFUgwklUnsJnGAvq/8wGFUAayOMYU9S22NI=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tinyvec/1.5.1/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("tinyvec_macros")
      ];
    };
    "tinyvec_macros 0.1.0" = {
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
    "tokio 1.15.0" = {
      pname = "tokio";
      version = "1.15.0";
      depKeys = [
        ("bytes 1.1.0")
        ("libc 0.2.112")
        ("memchr 2.4.1")
        ("mio 0.7.14")
        ("num_cpus 1.13.0")
        ("once_cell 1.9.0")
        ("parking_lot 0.11.2")
        ("pin-project-lite 0.2.7")
        ("signal-hook-registry 1.4.0")
        ("tokio-macros 1.7.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-+78cd47CBnhWNc6K1X/lKzAJrp4Mn1dKco8wSdPlWDg=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio/1.15.0/download";
      });
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
        ("sync")
        ("time")
        ("tokio-macros")
        ("winapi")
      ];
    };
    "tokio-macros 1.7.0" = {
      pname = "tokio-macros";
      version = "1.7.0";
      depKeys = [
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-tVf3L0SMURqXniVk5V105sRDL8lv9PYkG8a97TQmQ7c=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-macros/1.7.0/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "tokio-native-tls 0.3.0" = {
      pname = "tokio-native-tls";
      version = "0.3.0";
      depKeys = [
        ("native-tls 0.2.8")
        ("tokio 1.15.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-99mVZgvSt/jBVoQUwRJgdsE/u3JcQBEtwBILeOubcXs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-native-tls/0.3.0/download";
      });
      edition = "2018";
    };
    "tokio-util 0.6.9" = {
      pname = "tokio-util";
      version = "0.6.9";
      depKeys = [
        ("bytes 1.1.0")
        ("futures-core 0.3.17")
        ("futures-sink 0.3.17")
        ("log 0.4.14")
        ("pin-project-lite 0.2.7")
        ("tokio 1.15.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-npnhmD5dN2zY60tmYE0umeefW9mIwwVYkdzYyeJgTMA=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tokio-util/0.6.9/download";
      });
      edition = "2018";
      features = [
        ("codec")
        ("default")
      ];
    };
    "tower-service 0.3.1" = {
      pname = "tower-service";
      version = "0.3.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Ng39HW0w4F/aMqziyMcOnAqdpxMnV3f1pNu4oYk5MMY=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tower-service/0.3.1/download";
      });
      edition = "2018";
    };
    "tracing 0.1.29" = {
      pname = "tracing";
      version = "0.1.29";
      depKeys = [
        ("cfg-if 1.0.0")
        ("pin-project-lite 0.2.7")
        ("tracing-core 0.1.21")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-N1pjkjLK8w7fx46NibLUw3VRU5Pnr34W8BzZaRf7IQU=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing/0.1.29/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "tracing-core 0.1.21" = {
      pname = "tracing-core";
      version = "0.1.21";
      depKeys = [
        ("lazy_static 1.4.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-H07WVje4OQdwgUCD0gdW+Hv6LCG/LxELq9xUODUXRuQ=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/tracing-core/0.1.21/download";
      });
      edition = "2018";
      features = [
        ("lazy_static")
        ("std")
      ];
    };
    "try-lock 0.2.3" = {
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
    "typenum 1.14.0" = {
      pname = "typenum";
      version = "1.14.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-tjcIomX1E0VXWyf+Q/lQCtYRV552THntvCA3sRIZWew=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/typenum/1.14.0/download";
      });
      buildSrc = "build/main.rs";
      edition = "2018";
    };
    "unicode-bidi 0.3.7" = {
      pname = "unicode-bidi";
      version = "0.3.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-GgFARmPj20Nu0nRtn+/vZA2GjtrjzOuBw7jVcy/aZ48=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-bidi/0.3.7/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "unicode-normalization 0.1.19" = {
      pname = "unicode-normalization";
      version = "0.1.19";
      depKeys = [
        ("tinyvec 1.5.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1UWQkylBqekmbwgy3u2E6+G/LkyeSjVU05PRj16FS/k=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-normalization/0.1.19/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "unicode-segmentation 1.8.0" = {
      pname = "unicode-segmentation";
      version = "1.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-iJWEmpSeeEXga9bcGqUXMaEDxCcHAQpbWRwAOPtzOFs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-segmentation/1.8.0/download";
      });
      edition = "2018";
    };
    "unicode-width 0.1.9" = {
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
    "unicode-xid 0.2.2" = {
      pname = "unicode-xid";
      version = "0.2.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jMuC1h+ApmPv4feHpRsWtaUeMxTWrDZbCGOfUjh7M/M=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/unicode-xid/0.2.2/download";
      });
      edition = "2015";
      features = [
        ("default")
      ];
    };
    "url 2.2.2" = {
      pname = "url";
      version = "2.2.2";
      depKeys = [
        ("form_urlencoded 1.0.1")
        ("idna 0.2.3")
        ("matches 0.1.9")
        ("percent-encoding 2.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-pQfDg7LTO1/DXRhh535rOD0Viy2l4U/lG4Pf7fb9V4w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/url/2.2.2/download";
      });
      edition = "2018";
    };
    "vcpkg 0.2.15" = {
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
    "version_check 0.9.3" = {
      pname = "version_check";
      version = "0.9.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-X+zcqaUpHMK43PfcAkU/7nkaKA83Q8sJBfiCKuRjs/4=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/version_check/0.9.3/download";
      });
      edition = "2015";
    };
    "want 0.3.0" = {
      pname = "want";
      version = "0.3.0";
      depKeys = [
        ("log 0.4.14")
        ("try-lock 0.2.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HOipaMsc0RDRNv+LgZpVbW+22Rk2PGFTT2hgx+sXK6A=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/want/0.3.0/download";
      });
      edition = "2018";
    };
    "wasi 0.10.2+wasi-snapshot-preview1" = {
      pname = "wasi";
      version = "0.10.2-wasi-snapshot-preview1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-/W+9mnmCndGtDMIGJ78e1gZ1an937f97ZrcGT5yzJ8Y=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasi/0.10.2+wasi-snapshot-preview1/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "wasm-bindgen 0.2.78" = {
      pname = "wasm-bindgen";
      version = "0.2.78";
      depKeys = [
        ("cfg-if 1.0.0")
        ("wasm-bindgen-macro 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Yy9z4jayGRUOonkZblTmEPXbr6XWF4YwPU2lT4Tkf84=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen/0.2.78/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      features = [
        ("default")
        ("spans")
        ("std")
      ];
    };
    "wasm-bindgen-backend 0.2.78" = {
      pname = "wasm-bindgen-backend";
      version = "0.2.78";
      depKeys = [
        ("bumpalo 3.8.0")
        ("lazy_static 1.4.0")
        ("log 0.4.14")
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
        ("wasm-bindgen-shared 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-oxe/j5+6JHa0sshe9MSvj/OcPH8M3+7U+Cw0qICqg3s=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-backend/0.2.78/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-futures 0.4.28" = {
      pname = "wasm-bindgen-futures";
      version = "0.4.28";
      depKeys = [
        ("cfg-if 1.0.0")
        ("js-sys 0.3.55")
        ("wasm-bindgen 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jo11I8sfKkyWwTF8ppADG3FKUcwU4F9xJEZpH0E/XTk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-futures/0.4.28/download";
      });
      edition = "2018";
    };
    "wasm-bindgen-macro 0.2.78" = {
      pname = "wasm-bindgen-macro";
      version = "0.2.78";
      depKeys = [
        ("quote 1.0.10")
        ("wasm-bindgen-macro-support 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-1WFG58SVUov2WHZjvqE6jrWI05s2tnnYOXLhotu9rPk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.78/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
      procMacro = true;
    };
    "wasm-bindgen-macro-support 0.2.78" = {
      pname = "wasm-bindgen-macro-support";
      version = "0.2.78";
      depKeys = [
        ("proc-macro2 1.0.34")
        ("quote 1.0.10")
        ("syn 1.0.82")
        ("wasm-bindgen-backend 0.2.78")
        ("wasm-bindgen-shared 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-eAPg7qJYNfir3Fhc0wIbPesRVDxv4ibc0wsiiFfFxas=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.78/download";
      });
      edition = "2018";
      features = [
        ("spans")
      ];
    };
    "wasm-bindgen-shared 0.2.78" = {
      pname = "wasm-bindgen-shared";
      version = "0.2.78";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-AjcjJ4nPA31UgHc/5Wiqx0W/4q+8Eahj6XkBeAprR8w=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.78/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
    };
    "web-sys 0.3.55" = {
      pname = "web-sys";
      version = "0.3.55";
      depKeys = [
        ("js-sys 0.3.55")
        ("wasm-bindgen 0.2.78")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-OOsQXxxZ2eqmtc3JK4Wdhbkm6Cyy4JRc0Mkln6pv6fs=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/web-sys/0.3.55/download";
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
    "winapi 0.3.9" = {
      pname = "winapi";
      version = "0.3.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-XIOaZ0/NepiVLlkyQupACr6TmSdGdh44ZBQF0osA9Bk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi/0.3.9/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("cfg")
        ("consoleapi")
        ("errhandlingapi")
        ("evntrace")
        ("fileapi")
        ("handleapi")
        ("impl-debug")
        ("impl-default")
        ("in6addr")
        ("inaddr")
        ("ioapiset")
        ("lmcons")
        ("minschannel")
        ("minwinbase")
        ("minwindef")
        ("mstcpip")
        ("mswsock")
        ("namedpipeapi")
        ("ntdef")
        ("ntsecapi")
        ("ntstatus")
        ("processenv")
        ("processthreadsapi")
        ("profileapi")
        ("schannel")
        ("securitybaseapi")
        ("sspi")
        ("std")
        ("synchapi")
        ("sysinfoapi")
        ("threadpoollegacyapiset")
        ("timezoneapi")
        ("winbase")
        ("wincon")
        ("wincrypt")
        ("windef")
        ("winerror")
        ("winioctl")
        ("winnt")
        ("winreg")
        ("winsock2")
        ("ws2def")
        ("ws2ipdef")
        ("ws2tcpip")
      ];
    };
    "winapi-i686-pc-windows-gnu 0.4.0" = {
      pname = "winapi-i686-pc-windows-gnu";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-rDuHxjYgQm3ZuZHlzgMp7/VFvMu7NPO+Cf9vtqtRt7Y=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "winapi-util 0.1.5" = {
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
    "winapi-x86_64-pc-windows-gnu 0.4.0" = {
      pname = "winapi-x86_64-pc-windows-gnu";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-cS4ieEHQV8HuHNL7Ivp+WlRhro5I+iynnsQs/BkxGD8=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "winreg 0.7.0" = {
      pname = "winreg";
      version = "0.7.0";
      depKeys = [
        ("winapi 0.3.9")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ASDbguih4Ln7M0WlOcR4dnwASNhChgmU2WET1bZnvWk=";
        name = "crate.tar.gz";
        url = "https://crates.io/api/v1/crates/winreg/0.7.0/download";
      });
      edition = "2015";
    };
    "wyz 0.2.0" = {
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
    "yaml-rust 0.4.5" = {
      pname = "yaml-rust";
      version = "0.4.5";
      depKeys = [
        ("linked-hash-map 0.5.4")
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