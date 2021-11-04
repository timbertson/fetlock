final: prev:
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
    "aho-corasick 0.7.15" = {
      pname = "aho-corasick";
      version = "0.7.15";
      depKeys = [
        ("memchr 2.3.4")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1rb8gzhljl8r87dpf2n5pnqnkl694casgns4ma0sqzd4zazzw13l";
        url = "https://crates.io/api/v1/crates/aho-corasick/0.7.15/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "anyhow 1.0.45" = {
      pname = "anyhow";
      version = "1.0.45";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1izmq8kmjgx8sjlrv78r32z57r8r2zd2lkhxb6iw0lx8whxf847f";
        url = "https://crates.io/api/v1/crates/anyhow/1.0.45/download";
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
        name = "crate.tar.gz";
        sha256 = "12q6hn01x5435bprwlb7w9m7817dyfq55yrl4psygr78bp32zdi3";
        url = "https://crates.io/api/v1/crates/arrayvec/0.5.2/download";
      });
      edition = "2018";
      features = [
        ("array-sizes-33-128")
      ];
    };
    "async-trait 0.1.51" = {
      pname = "async-trait";
      version = "0.1.51";
      depKeys = [
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("syn 1.0.81")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0pis4f9k7nhphp24rkm5lkbnhcz5p78qz6nyh6l1b0gndmvqwca4";
        url = "https://crates.io/api/v1/crates/async-trait/0.1.51/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
      procMacro = true;
    };
    "atty 0.2.14" = {
      pname = "atty";
      version = "0.2.14";
      depKeys = [
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1s7yslcs6a28c5vz7jwj63lkfgyx8mx99fdirlhi9lbhhzhrpcyr";
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
        name = "crate.tar.gz";
        sha256 = "0jj6i9zn4gjl03kjvziqdji6rwx8ykz8zk2ngpc331z2g3fk3c6d";
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
        name = "crate.tar.gz";
        sha256 = "1z82g23mbzjgijkpcrilc7nljpxpvpf7zxf6iyiapkgka2ngwkch";
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
        name = "crate.tar.gz";
        sha256 = "12ki6w8gn1ldq7yz9y680llwk5gmrhrzszaa17g1sbrw2r2qvwxy";
        url = "https://crates.io/api/v1/crates/bitflags/1.3.2/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "bitvec 0.19.5" = {
      pname = "bitvec";
      version = "0.19.5";
      depKeys = [
        ("funty 1.1.0")
        ("radium 0.5.3")
        ("tap 1.0.1")
        ("wyz 0.2.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "08a3rfly22mky5y1881a4gr6wsapnqmcmc50vp4kh65fab9whhl9";
        url = "https://crates.io/api/v1/crates/bitvec/0.19.5/download";
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
        name = "crate.tar.gz";
        sha256 = "1r4pf90s7d7lj1wdjhlnqa26vvbm6pnc33z138lxpnp9srpi2lj1";
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
        name = "crate.tar.gz";
        sha256 = "0v5vck40wmz95d48gq0z3al32vy1yic8fihjkb0sfh4h7862c7lg";
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
        name = "crate.tar.gz";
        sha256 = "1y70b249m02lfp0j6565b29kviapj4xsl9whamcqwddnp9kjv1y4";
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
        ("serde 1.0.130")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0avbz0vh6l9ggf1hd6l4q3zxgw5qni0ni94a43i48sdzv5h45msj";
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
        ("serde 1.0.130")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "09zsf76b9yr02jh17xq925xp1w824w2bwvb78fd0gpx5m1fq5nyb";
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
        ("serde 1.0.130")
        ("serde_json 1.0.68")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "04kfzvmh80pq0bw1cwzlz71wfrign2k7792mc4gi8hs1jkgfcams";
        url = "https://crates.io/api/v1/crates/cargo_metadata/0.14.1/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "cc 1.0.71" = {
      pname = "cc";
      version = "1.0.71";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1pgflzb5dc9pli1lfwfv5jksmz57j15iqqxqpdbnjq4lclfnihkr";
        url = "https://crates.io/api/v1/crates/cc/1.0.71/download";
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
        name = "crate.tar.gz";
        sha256 = "1za0vb97n4brpzpv8lsbnzmq5r8f2b0cpqqr0sy8h5bn751xxwds";
        url = "https://crates.io/api/v1/crates/cfg-if/1.0.0/download";
      });
      edition = "2018";
    };
    "core-foundation 0.9.2" = {
      pname = "core-foundation";
      version = "0.9.2";
      depKeys = [
        ("core-foundation-sys 0.8.3")
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1cs7dya58xf4px4b1953040fpz5lm3qhf7fzv0jf94xva42y3238";
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
        name = "crate.tar.gz";
        sha256 = "1p5r2wckarkpkyc4z83q08dwpvcafrb1h6fxfa3qnikh8szww9sq";
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
        name = "crate.tar.gz";
        sha256 = "0sgllzsvs8hinylaiigmd9c908gd8wclxnqz8dinpxbdyql981cm";
        url = "https://crates.io/api/v1/crates/cpufeatures/0.2.1/download";
      });
      edition = "2018";
    };
    "digest 0.9.0" = {
      pname = "digest";
      version = "0.9.0";
      depKeys = [
        ("generic-array 0.14.4")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0rmhvk33rgvd6ll71z8sng91a52rw14p0drjn1da0mqa138n1pfk";
        url = "https://crates.io/api/v1/crates/digest/0.9.0/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("std")
      ];
    };
    "dtoa 0.4.8" = {
      pname = "dtoa";
      version = "0.4.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1c5j0wz118dhrczx6spc5za7dnbfxablr4adyahg9aknrsc9i2an";
        url = "https://crates.io/api/v1/crates/dtoa/0.4.8/download";
      });
      edition = "2015";
    };
    "either 1.6.1" = {
      pname = "either";
      version = "1.6.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0mwl9vngqf5jvrhmhn9x60kr5hivxyjxbmby2pybncxfqhf4z3g7";
        url = "https://crates.io/api/v1/crates/either/1.6.1/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("use_std")
      ];
    };
    "encoding_rs 0.8.29" = {
      pname = "encoding_rs";
      version = "0.8.29";
      depKeys = [
        ("cfg-if 1.0.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0in7l50j06qmzzwk0h6bs5kdlyj5zyx9ab745lrzd60v1adahkm7";
        url = "https://crates.io/api/v1/crates/encoding_rs/0.8.29/download";
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
        ("regex 1.4.6")
        ("termcolor 1.1.2")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0djx8h8xfib43g5w94r1m1mkky5spcw4wblzgnhiyg5vnfxknls4";
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
        ("anyhow 1.0.45")
        ("async-trait 0.1.51")
        ("cargo-platform 0.1.2")
        ("cargo_metadata 0.14.1")
        ("either 1.6.1")
        ("env_logger 0.7.1")
        ("fs2 0.4.3")
        ("futures 0.3.17")
        ("getopts 0.2.21")
        ("hex 0.4.3")
        ("lazy_static 1.4.0")
        ("log 0.4.14")
        ("nom 6.2.1")
        ("platforms 1.1.0")
        ("regex 1.4.6")
        ("reqwest 0.11.6")
        ("serde 1.0.130")
        ("serde_json 1.0.68")
        ("serde_yaml 0.8.21")
        ("sha2 0.9.8")
        ("tempdir 0.3.7")
        ("tokio 1.13.0")
      ];
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
        name = "crate.tar.gz";
        sha256 = "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz";
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
        name = "crate.tar.gz";
        sha256 = "1cgk0vyd7r45cj769jym4a6s7vwshvd0z4bqrb92q1fwibmkkwzn";
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
        name = "crate.tar.gz";
        sha256 = "0jxgzd04ra4imjv8jgkmdq59kj8fsz6w4zxsbmlai34h26225c00";
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
        name = "crate.tar.gz";
        sha256 = "1491fmakavcmsjbm3q6iy0bhmn9l422jasdhzx5hkljgza3mmhjz";
        url = "https://crates.io/api/v1/crates/form_urlencoded/1.0.1/download";
      });
      edition = "2018";
    };
    "fs2 0.4.3" = {
      pname = "fs2";
      version = "0.4.3";
      depKeys = [
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "04v2hwk7035c088f19mfl5b1lz84gnvv2hv6m935n0hmirszqr4m";
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
        name = "crate.tar.gz";
        sha256 = "1fnkqrbz7ixxzsb04bsz9p0zzazanma8znfdqjvh39n14vapfvx0";
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
        name = "crate.tar.gz";
        sha256 = "19wx3p3jmv863y0mjb56sr4qf1kvqhl3fsyslkd92zli0p8lrlzy";
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
        name = "crate.tar.gz";
        sha256 = "1jk6znbqrmb6xkgs4g0s7ivv1djq7dyaci9d7xfdb04hagms0am1";
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
        name = "crate.tar.gz";
        sha256 = "121q4y5c10vihzgcb6fvp0gwzyh4hg6c37riqz9nbhdk7f6bm9jx";
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
        name = "crate.tar.gz";
        sha256 = "0gd5hfxcy5fqc3wm55a4yhcbh921wvzv09nkbhwh6dpjaxlw5lc8";
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
        name = "crate.tar.gz";
        sha256 = "0p3lv18dr90c032yrr4k833npp23a0spykvq4lq7d7cn63h5n0j5";
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
        name = "crate.tar.gz";
        sha256 = "0xrk0xsrmhxrndhby79j31mkzbwg21s09fkpqldhyf1yzshf4baj";
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
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("syn 1.0.81")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1fvriw31ippggp8496dpbvkykr2fgk57amhwrz5lqjzabjws9r0q";
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
        name = "crate.tar.gz";
        sha256 = "04dwqbcwxil6iyv7fif2xjncz849mm63sghbb60f8kq22cy1bsin";
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
        name = "crate.tar.gz";
        sha256 = "169fi44d8sbfpkkyhncj0pgkp1amrllg5523lncf8wyvxps00g8x";
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
        ("memchr 2.3.4")
        ("pin-project-lite 0.2.7")
        ("pin-utils 0.1.0")
        ("proc-macro-hack 0.5.19")
        ("proc-macro-nested 0.1.7")
        ("slab 0.4.5")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "10al5ci74s6rk2d2wqqya0d4fwc6sqv525hzbvj6wfha45jq8min";
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
        name = "crate.tar.gz";
        sha256 = "05qqwm9v5asbil9z28wjkmpfvs1c5c99n8n9gwxis3d3r3n6c52h";
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
        name = "crate.tar.gz";
        sha256 = "1mgb3qvivi26gs6ihqqhh8iyhp3vgxri6vwyrwg28w0xqzavznql";
        url = "https://crates.io/api/v1/crates/getopts/0.2.21/download";
      });
      edition = "2015";
    };
    "getrandom 0.2.3" = {
      pname = "getrandom";
      version = "0.2.3";
      depKeys = [
        ("cfg-if 1.0.0")
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0lr7mnkvnzdh1xxmwmhhbm4gwg29k3m2rzhpjmjm4k2jcfa9kkbz";
        url = "https://crates.io/api/v1/crates/getrandom/0.2.3/download";
      });
      edition = "2018";
      features = [
        ("std")
      ];
    };
    "h2 0.3.7" = {
      pname = "h2";
      version = "0.3.7";
      depKeys = [
        ("bytes 1.1.0")
        ("fnv 1.0.7")
        ("futures-core 0.3.17")
        ("futures-sink 0.3.17")
        ("futures-util 0.3.17")
        ("http 0.2.5")
        ("indexmap 1.7.0")
        ("slab 0.4.5")
        ("tokio 1.13.0")
        ("tokio-util 0.6.9")
        ("tracing 0.1.29")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0mdf0x3cxj4rhx2zrm0gnx02i43gqcz3q4awzidargff5xb1kn3z";
        url = "https://crates.io/api/v1/crates/h2/0.3.7/download";
      });
      edition = "2018";
    };
    "hashbrown 0.11.2" = {
      pname = "hashbrown";
      version = "0.11.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0vkjsf5nzs7qcia5ya79j9sq2p1caz4crrncr1675wwyj3ag0pmb";
        url = "https://crates.io/api/v1/crates/hashbrown/0.11.2/download";
      });
      edition = "2018";
      features = [
        ("raw")
      ];
    };
    "hermit-abi 0.1.19" = {
      pname = "hermit-abi";
      version = "0.1.19";
      depKeys = [
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0cxcm8093nf5fyn114w8vxbrbcyvv91d4015rdnlgfll7cs6gd32";
        url = "https://crates.io/api/v1/crates/hermit-abi/0.1.19/download";
      });
      edition = "2018";
      features = [
        ("default")
      ];
    };
    "hex 0.4.3" = {
      pname = "hex";
      version = "0.4.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z";
        url = "https://crates.io/api/v1/crates/hex/0.4.3/download";
      });
      edition = "2018";
      features = [
        ("alloc")
        ("default")
        ("std")
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
        name = "crate.tar.gz";
        sha256 = "0sqqidxilz83h3nr9g3hwsa0z34mh6clrrdfvvd2f66l0mmhj8qk";
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
        name = "crate.tar.gz";
        sha256 = "1imjszmk34603m7chfnhd3rq263bxbdlaxhlbzd06wv7354zix0z";
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
        name = "crate.tar.gz";
        sha256 = "00smbrgb9vyzbbj3j5d66iarjl5x2wpfwkmhcy5nizylw7dlzndc";
        url = "https://crates.io/api/v1/crates/httparse/1.5.1/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "httpdate 1.0.1" = {
      pname = "httpdate";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0h240ck2xlp62dqfhfp6g45984avsmh1pkcgjmyywgzkr2kbhmk4";
        url = "https://crates.io/api/v1/crates/httpdate/1.0.1/download";
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
        name = "crate.tar.gz";
        sha256 = "0krwgbf35pd46xvkqg14j070vircsndabahahlv3rwhflpy4q06z";
        url = "https://crates.io/api/v1/crates/humantime/1.3.0/download";
      });
      edition = "2015";
    };
    "hyper 0.14.14" = {
      pname = "hyper";
      version = "0.14.14";
      depKeys = [
        ("bytes 1.1.0")
        ("futures-channel 0.3.17")
        ("futures-core 0.3.17")
        ("futures-util 0.3.17")
        ("h2 0.3.7")
        ("http 0.2.5")
        ("http-body 0.4.4")
        ("httparse 1.5.1")
        ("httpdate 1.0.1")
        ("itoa 0.4.8")
        ("pin-project-lite 0.2.7")
        ("socket2 0.4.2")
        ("tokio 1.13.0")
        ("tower-service 0.3.1")
        ("tracing 0.1.29")
        ("want 0.3.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0syjjbxp6xy0a2s72ngvq9s8fx201yvic4ipwkqs2vhv48gvp49b";
        url = "https://crates.io/api/v1/crates/hyper/0.14.14/download";
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
        ("hyper 0.14.14")
        ("native-tls 0.2.8")
        ("tokio 1.13.0")
        ("tokio-native-tls 0.3.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "01crgy13102iagakf6q4mb75dprzr7ps1gj0l5hxm1cvm7gks66n";
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
        name = "crate.tar.gz";
        sha256 = "1y7ca2w5qp9msgl57n03zqp78gq1bk2crqzg6kv7a542mdphm2j1";
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
        name = "crate.tar.gz";
        sha256 = "19b2zwfajhsfcgny0clv8y4jppy704znfhv8nv2dw9a18l2kcqxw";
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
        name = "crate.tar.gz";
        sha256 = "0b2bx5qdlwayriidhrag8vhy10kdfimfhmb3jnjmsz2h9j1bwnvs";
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
        name = "crate.tar.gz";
        sha256 = "1ad32j3kkbb0bgf5whzfkdw6843ywr48245dhk7c9gny5r7xdwk8";
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
        name = "crate.tar.gz";
        sha256 = "1m1dairwyx8kfxi7ab3b5jc71z1vigh9w4shnhiajji9avzr26dp";
        url = "https://crates.io/api/v1/crates/itoa/0.4.8/download";
      });
      edition = "2015";
      features = [
        ("default")
        ("std")
      ];
    };
    "js-sys 0.3.55" = {
      pname = "js-sys";
      version = "0.3.55";
      depKeys = [
        ("wasm-bindgen 0.2.78")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "116cg9vn62cl3vifbs6cjdsg7hz98kr7sr8kpy31liccsg6gzjbw";
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
        name = "crate.tar.gz";
        sha256 = "0in6ikhw8mgl33wjv6q6xfrb5b9jr16q8ygjy803fay4zcisvaz2";
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
        ("ryu 1.0.5")
        ("static_assertions 1.1.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1zjzab1fnaw4kj6ixyrskp4dyz761gdcab07m4bkvlk1l4mcc1v6";
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
    "libc 0.2.106" = {
      pname = "libc";
      version = "0.2.106";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0wynaqs2ix4fqk603qhi7axw1fg9p5rhbcp9nhrs6fg0m7wm61d6";
        url = "https://crates.io/api/v1/crates/libc/0.2.106/download";
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
        name = "crate.tar.gz";
        sha256 = "1ww8zsraqnvrsknd315481185igwkx5n14xnhq5i8216z65b7fbz";
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
        name = "crate.tar.gz";
        sha256 = "028izfyraynijd9h9x5miv1vmg6sjnw1v95wgm7f4xlr7h4lsaki";
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
        name = "crate.tar.gz";
        sha256 = "04175hv0v62shd82qydq58a48k3bjijmk54v38zgqlbxqkkbpfai";
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
        name = "crate.tar.gz";
        sha256 = "0gw5ib38jfgyyah8nyyxr036grqv1arkf1srgfa4h386dav7iqx3";
        url = "https://crates.io/api/v1/crates/matches/0.1.9/download";
      });
      edition = "2015";
      libPath = "lib.rs";
    };
    "memchr 2.3.4" = {
      pname = "memchr";
      version = "2.3.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "098m9clfs495illlw00hv2gg67mhm7jflld3msyclvi5m9xc9q8f";
        url = "https://crates.io/api/v1/crates/memchr/2.3.4/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
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
        name = "crate.tar.gz";
        sha256 = "13dcm9lh01hdwfjcg74ppljyjfj1c6w3a3cwkhxf0w8wa37cfq1a";
        url = "https://crates.io/api/v1/crates/mime/0.3.16/download";
      });
      edition = "2015";
    };
    "mio 0.7.14" = {
      pname = "mio";
      version = "0.7.14";
      depKeys = [
        ("libc 0.2.106")
        ("log 0.4.14")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1k05cah6zdww6i2qc7gaxbbja4ppyjycipl2y0lhiiwpzq2b8rw0";
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
        name = "crate.tar.gz";
        sha256 = "08afp2xfpxmdw003111lxz6g9jgbj4zi2fpldvv7da6d4nqcbwdr";
        url = "https://crates.io/api/v1/crates/miow/0.3.7/download";
      });
      edition = "2018";
    };
    "native-tls 0.2.8" = {
      pname = "native-tls";
      version = "0.2.8";
      depKeys = [
        ("lazy_static 1.4.0")
        ("libc 0.2.106")
        ("security-framework 2.4.2")
        ("security-framework-sys 2.4.2")
        ("tempfile 3.2.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0kdj0drgp8cqk3v430c5ac7dfpzvhm1621w96cpz985m35vrzfj8";
        url = "https://crates.io/api/v1/crates/native-tls/0.2.8/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "nom 6.2.1" = {
      pname = "nom";
      version = "6.2.1";
      depKeys = [
        ("bitvec 0.19.5")
        ("funty 1.1.0")
        ("lexical-core 0.7.6")
        ("memchr 2.3.4")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "19h3l5hajpcszwl6nzcmgs4mpng73ifn6akslq7n4g1s12wm2p4w";
        url = "https://crates.io/api/v1/crates/nom/6.2.1/download";
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
        name = "crate.tar.gz";
        sha256 = "0i5daj9sr8wyi5jkpwpybln2jqpn59z0mqfc0dpdidipwh1bjsrz";
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
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1cv6yxhz2zbnwn8pn1yn8grg7zsnd523947fby41a737aqvryj85";
        url = "https://crates.io/api/v1/crates/num_cpus/1.13.0/download";
      });
      edition = "2015";
    };
    "once_cell 1.8.0" = {
      pname = "once_cell";
      version = "1.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0mkbbxg6416z11r2yzsq91cqrkj9w1iyx5hakq15h5sbnriwnbv9";
        url = "https://crates.io/api/v1/crates/once_cell/1.8.0/download";
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
        name = "crate.tar.gz";
        sha256 = "1m8kzi4nd6shdqimn0mgb24f0hxslhnqd1whakyq06wcqd086jk2";
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
        ("libc 0.2.106")
        ("once_cell 1.8.0")
        ("openssl-sys 0.9.70")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "15baqlphisr1f7ddq11jnrrzz4shdh35kwal24adyc2c4cif4yhc";
        url = "https://crates.io/api/v1/crates/openssl/0.10.38/download";
      });
      buildSrc = "build.rs";
      crateRenames = {
        openssl-sys = [
          ({
            rename = "ffi";
            version = "0.9.70";
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
        name = "crate.tar.gz";
        sha256 = "0nmrvlrza9ya23kgzmsgfc17f9pxajdxk25cwsk9aq5p5a3qv618";
        url = "https://crates.io/api/v1/crates/openssl-probe/0.1.4/download";
      });
      edition = "2015";
    };
    "openssl-sys 0.9.70" = {
      pname = "openssl-sys";
      version = "0.9.70";
      depKeys = [
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1pryvrgwc7qrr8rq7smmkz2hqc3zzxjss7b6ldfnn8pqnf3pjlf6";
        url = "https://crates.io/api/v1/crates/openssl-sys/0.9.70/download";
      });
      buildDepKeys = [
        ("autocfg 1.0.1")
        ("cc 1.0.71")
        ("pkg-config 0.3.22")
      ];
      buildSrc = "build/main.rs";
      edition = "2015";
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
        name = "crate.tar.gz";
        sha256 = "16gzf41bxmm10x82bla8d6wfppy9ym3fxsmdjyvn61m66s0bf5vx";
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
        ("libc 0.2.106")
        ("smallvec 1.7.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "05ij4zxsylx99srbq8qd1k2wiwaq8krkf9y4cqkhvb5wjca8wvnp";
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
        name = "crate.tar.gz";
        sha256 = "0bp3zrsk3kr47fbpipyczidbbx4g54lzxdm77ni1i3qws10mdzfl";
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
        name = "crate.tar.gz";
        sha256 = "0hwl8iyx3h9i3i3jr2vqj07nf4ay1v1w1ga29cbjmdd6d4fd2ccd";
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
        name = "crate.tar.gz";
        sha256 = "117ir7vslsl2z1a7qzhws4pd01cg2d3338c47swjyvqv2n60v1wb";
        url = "https://crates.io/api/v1/crates/pin-utils/0.1.0/download";
      });
      edition = "2018";
    };
    "pkg-config 0.3.22" = {
      pname = "pkg-config";
      version = "0.3.22";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "07vy6mn0q6k2adrs7min3rpy999q7kprph0vb1414iwlybs5sa8j";
        url = "https://crates.io/api/v1/crates/pkg-config/0.3.22/download";
      });
      edition = "2015";
    };
    "platforms 1.1.0" = {
      pname = "platforms";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "09fkncjyjgxljv2wwrywz43k42hsd6175ih74nhc989c5q0l77cq";
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
        name = "crate.tar.gz";
        sha256 = "1fimwnyyh3wx33r5s77lw5g5vcxhw1p5j60pdvbbwr8l374gn37d";
        url = "https://crates.io/api/v1/crates/ppv-lite86/0.2.15/download";
      });
      edition = "2018";
      features = [
        ("simd")
        ("std")
      ];
    };
    "proc-macro-hack 0.5.19" = {
      pname = "proc-macro-hack";
      version = "0.5.19";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1rg0kzsj7lj00qj602d3h77spwfz48vixn1wbjp7a4yrq65w9w6v";
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
        name = "crate.tar.gz";
        sha256 = "11hh1jynh62f3m1ii0f9gf1l3y0fhkwpmr40lz3704v848n1p25w";
        url = "https://crates.io/api/v1/crates/proc-macro-nested/0.1.7/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
    };
    "proc-macro2 1.0.32" = {
      pname = "proc-macro2";
      version = "1.0.32";
      depKeys = [
        ("unicode-xid 0.2.2")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0hqbxlvhiaybakl1gai3mgps1dxsmxricxsr2rfdrh222z0qql5s";
        url = "https://crates.io/api/v1/crates/proc-macro2/1.0.32/download";
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
        name = "crate.tar.gz";
        sha256 = "1q6za3v78hsspisc197bg3g7rpc989qycy8ypr8ap8igv10ikl51";
        url = "https://crates.io/api/v1/crates/quick-error/1.2.3/download";
      });
      edition = "2015";
    };
    "quote 1.0.10" = {
      pname = "quote";
      version = "1.0.10";
      depKeys = [
        ("proc-macro2 1.0.32")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "01ff7a76f871ggnby57iagw6499vci4bihcr11g6bqzjlp38rg1q";
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
        name = "crate.tar.gz";
        sha256 = "1f5vj5zy4kcsw8p87y976dm5pln6v6jfw5f0fkj7qbwfipbsj6wl";
        url = "https://crates.io/api/v1/crates/radium/0.5.3/download";
      });
      buildSrc = "build.rs";
      edition = "2018";
    };
    "rand 0.4.6" = {
      pname = "rand";
      version = "0.4.6";
      depKeys = [
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "14qjfv3gggzhnma20k0sc1jf8y6pplsaq7n1j9ls5c8kf2wl0a2m";
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
        ("libc 0.2.106")
        ("rand_chacha 0.3.1")
        ("rand_core 0.6.3")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1n5wska2fbfj4dsfz8mc0pd0dgjlrb6c9anpk5mwym345rip6x9f";
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
        name = "crate.tar.gz";
        sha256 = "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6";
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
        name = "crate.tar.gz";
        sha256 = "0jzdgszfa4bliigiy4hi66k7fs3gfwi2qxn8vik84ph77fwdwvvs";
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
        name = "crate.tar.gz";
        sha256 = "1p09ynysrq1vcdlmcqnapq4qakl2yd1ng3kxh3qscpx09k2a6cww";
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
        name = "crate.tar.gz";
        sha256 = "1rxlxc3bpzgwphcg9c9yasvv9idipcg2z2y4j0vlb52jyl418kyk";
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
        name = "crate.tar.gz";
        sha256 = "1rwpykyvhkxs4jvqdja3mzp9dqaqamzn113cxaigs9z2dmcry7nm";
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
        name = "crate.tar.gz";
        sha256 = "1cjq0kwx1bk7jx3kzyciiish5gqsj7620dm43dc52sr8fzmm9037";
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
        name = "crate.tar.gz";
        sha256 = "1zq36bhw4c6xig340ja1jmr36iy0d3djp8smsabxx71676bg70w3";
        url = "https://crates.io/api/v1/crates/redox_syscall/0.2.10/download";
      });
      edition = "2018";
    };
    "regex 1.4.6" = {
      pname = "regex";
      version = "1.4.6";
      depKeys = [
        ("aho-corasick 0.7.15")
        ("memchr 2.3.4")
        ("regex-syntax 0.6.25")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0nf7gj6b7qzrq8b11srnwva2amx6b4v3lnrki1jxajspid0sy9ia";
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
    "regex-syntax 0.6.25" = {
      pname = "regex-syntax";
      version = "0.6.25";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "16y87hz1bxmmz6kk360cxwfm3jnbsxb3x4zw9x1gzz7khic2i5zl";
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
        name = "crate.tar.gz";
        sha256 = "1rzqbsgkmr053bxxl04vmvsd1njyz0nxvly97aip6aa2cmb15k9s";
        url = "https://crates.io/api/v1/crates/remove_dir_all/0.5.3/download";
      });
      edition = "2015";
    };
    "reqwest 0.11.6" = {
      pname = "reqwest";
      version = "0.11.6";
      depKeys = [
        ("base64 0.13.0")
        ("bytes 1.1.0")
        ("encoding_rs 0.8.29")
        ("futures-core 0.3.17")
        ("futures-util 0.3.17")
        ("http 0.2.5")
        ("http-body 0.4.4")
        ("hyper 0.14.14")
        ("hyper-tls 0.5.0")
        ("ipnet 2.3.1")
        ("lazy_static 1.4.0")
        ("log 0.4.14")
        ("mime 0.3.16")
        ("native-tls 0.2.8")
        ("percent-encoding 2.1.0")
        ("pin-project-lite 0.2.7")
        ("serde 1.0.130")
        ("serde_urlencoded 0.7.0")
        ("tokio 1.13.0")
        ("tokio-native-tls 0.3.0")
        ("url 2.2.2")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1072nlhfybl1yl8dsfhmpdx9xllh8s1w82k2zkqgm1gnl9y95lk6";
        url = "https://crates.io/api/v1/crates/reqwest/0.11.6/download";
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
    "ryu 1.0.5" = {
      pname = "ryu";
      version = "1.0.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0vpqv1dj7fksa6hm3zpk5rbsjs0ifbfy7xwzsyyil0rx37a03lvi";
        url = "https://crates.io/api/v1/crates/ryu/1.0.5/download";
      });
      buildSrc = "build.rs";
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
        name = "crate.tar.gz";
        sha256 = "0xdwr3clrylywpv2r5hw7mrxmsf7ljagwiymw2z60ki3kihbl1cg";
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
        name = "crate.tar.gz";
        sha256 = "1kbqm85v43rq92vx7hfiay6pmcga03vrjbbfwqpyj3pwsg3b16nj";
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
        ("libc 0.2.106")
        ("security-framework-sys 2.4.2")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "11vwvw2qnrf1z8i0ncbj9456vxwnwq9wyi9c2n6rkqd2znmw2nsj";
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
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0zlwc46mb7zkm4ngq5qv52zczvvk0l8kjr6npyvjidb067c19pd9";
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
        ("serde 1.0.130")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "04l00sn8y7lv1a8j11a6r7vwcm5qmlsdh7zqb0rw2cxab1i8x2jn";
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
    "serde 1.0.130" = {
      pname = "serde";
      version = "1.0.130";
      depKeys = [
        ("serde_derive 1.0.130")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "04y9s1mxcxakg9bhfdiff9w4zzprk6m6dazcpmpi8nfg6zg0cbgi";
        url = "https://crates.io/api/v1/crates/serde/1.0.130/download";
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
    "serde_derive 1.0.130" = {
      pname = "serde_derive";
      version = "1.0.130";
      depKeys = [
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("syn 1.0.81")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "12shxhi47db54i4j44ic2nl299x5p89ngna0w3m6854nn4d1mg6p";
        url = "https://crates.io/api/v1/crates/serde_derive/1.0.130/download";
      });
      buildSrc = "build.rs";
      edition = "2015";
      features = [
        ("default")
      ];
      procMacro = true;
    };
    "serde_json 1.0.68" = {
      pname = "serde_json";
      version = "1.0.68";
      depKeys = [
        ("itoa 0.4.8")
        ("ryu 1.0.5")
        ("serde 1.0.130")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1n2jg9cf14lrxasj63rlrwxlw5v79m851gycw6zy20jnjx9hhs8g";
        url = "https://crates.io/api/v1/crates/serde_json/1.0.68/download";
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
        ("ryu 1.0.5")
        ("serde 1.0.130")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1s9wnjrak5a0igfhcghhz51kvi7n010j5rs9lmhd5hfrz2kmgypd";
        url = "https://crates.io/api/v1/crates/serde_urlencoded/0.7.0/download";
      });
      edition = "2018";
    };
    "serde_yaml 0.8.21" = {
      pname = "serde_yaml";
      version = "0.8.21";
      depKeys = [
        ("dtoa 0.4.8")
        ("indexmap 1.7.0")
        ("serde 1.0.130")
        ("yaml-rust 0.4.5")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1br0kf7qkpq6jgj37s7q46wk9zs7fqa07r7vr76x7985ayihiinq";
        url = "https://crates.io/api/v1/crates/serde_yaml/0.8.21/download";
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
        name = "crate.tar.gz";
        sha256 = "1ypm6d7536j0l868x5cai84ahpsjz53yblizm9dlrms0jx69m7xn";
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
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1c2mhijg54y6c1zi4630yki1vpq3z96ljfnsrdy0rb64ilr767p5";
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
        name = "crate.tar.gz";
        sha256 = "1ddg01hf8h4bpfm027h0snhb7jfcs1jzi497083y13q13vyr3vwx";
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
        name = "crate.tar.gz";
        sha256 = "02gka690j8l12gl50ifg7axqnx1m6v6d1byaq0wl3fx66p3vdjhy";
        url = "https://crates.io/api/v1/crates/smallvec/1.7.0/download";
      });
      edition = "2018";
    };
    "socket2 0.4.2" = {
      pname = "socket2";
      version = "0.4.2";
      depKeys = [
        ("libc 0.2.106")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "05imvybc86slkbg6sj9rd1xy9a8ydn1v2bcqjqr346myqzk0zjax";
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
        name = "crate.tar.gz";
        sha256 = "0gsl6xmw10gvn3zs1rv99laj5ig7ylffnh71f9l34js4nr4r7sx2";
        url = "https://crates.io/api/v1/crates/static_assertions/1.1.0/download";
      });
      edition = "2015";
    };
    "syn 1.0.81" = {
      pname = "syn";
      version = "1.0.81";
      depKeys = [
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("unicode-xid 0.2.2")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0rh9hvwy75j3krmi4d4x76xb86f753hxr8mlxjbabddyp0cfxbzj";
        url = "https://crates.io/api/v1/crates/syn/1.0.81/download";
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
        name = "crate.tar.gz";
        sha256 = "0sc3gl4nldqpvyhqi3bbd0l9k7fngrcl4zs47n314nqqk4bpx4sm";
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
        name = "crate.tar.gz";
        sha256 = "1n5n86zxpgd85y0mswrp5cfdisizq2rv3la906g6ipyc03xvbwhm";
        url = "https://crates.io/api/v1/crates/tempdir/0.3.7/download";
      });
      edition = "2015";
    };
    "tempfile 3.2.0" = {
      pname = "tempfile";
      version = "3.2.0";
      depKeys = [
        ("cfg-if 1.0.0")
        ("libc 0.2.106")
        ("rand 0.8.4")
        ("remove_dir_all 0.5.3")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "08pbf3c1i42382dc44dil5bgiawcsi0qk6zdibw10f69rxiwdhfs";
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
        name = "crate.tar.gz";
        sha256 = "1x65i1ny4m6z1by62ra6wdcrd557p2ysm866x0pg60zby2cxizid";
        url = "https://crates.io/api/v1/crates/termcolor/1.1.2/download";
      });
      edition = "2018";
    };
    "tinyvec 1.5.0" = {
      pname = "tinyvec";
      version = "1.5.0";
      depKeys = [
        ("tinyvec_macros 0.1.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1xwiycwfl80737i952adpn1qawdi20kxr97bsymx14ch9lyjlfzq";
        url = "https://crates.io/api/v1/crates/tinyvec/1.5.0/download";
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
        name = "crate.tar.gz";
        sha256 = "0p5zvgbas5nh403fbxica819mf3g83n8g2hzpfazfr56w6klv9yd";
        url = "https://crates.io/api/v1/crates/tinyvec_macros/0.1.0/download";
      });
      edition = "2018";
    };
    "tokio 1.13.0" = {
      pname = "tokio";
      version = "1.13.0";
      depKeys = [
        ("bytes 1.1.0")
        ("libc 0.2.106")
        ("memchr 2.3.4")
        ("mio 0.7.14")
        ("num_cpus 1.13.0")
        ("once_cell 1.8.0")
        ("parking_lot 0.11.2")
        ("pin-project-lite 0.2.7")
        ("signal-hook-registry 1.4.0")
        ("tokio-macros 1.5.1")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1vi9dswv8m6h5h9zh42923i67d0libxxhz2nfzc5ininlc82v2sq";
        url = "https://crates.io/api/v1/crates/tokio/1.13.0/download";
      });
      buildDepKeys = [
        ("autocfg 1.0.1")
      ];
      buildSrc = "build.rs";
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
    "tokio-macros 1.5.1" = {
      pname = "tokio-macros";
      version = "1.5.1";
      depKeys = [
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("syn 1.0.81")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "15chrgc62ydsq05i0dp0imqx1ggvfl0glyj6g72i4qma86q86hqi";
        url = "https://crates.io/api/v1/crates/tokio-macros/1.5.1/download";
      });
      edition = "2018";
      procMacro = true;
    };
    "tokio-native-tls 0.3.0" = {
      pname = "tokio-native-tls";
      version = "0.3.0";
      depKeys = [
        ("native-tls 0.2.8")
        ("tokio 1.13.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0yvikgmph2qjq0ni2h2wfaxkzhbnc09c2544av0zidyj1dk9bngp";
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
        ("tokio 1.13.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1h2cc3ickn6wj5c0bhw8v5drzrwr5r6n0rjbxgc6qdsx7scf36cy";
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
        name = "crate.tar.gz";
        sha256 = "1iih764s3f6vlkspfmr72fkrs2lw1v3wiqmc6bd5zq1hdlfzs39n";
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
        name = "crate.tar.gz";
        sha256 = "0191zcbnkn8wy0b7xbz7jd9m2xf3sjr8k3cfqzghxwya6a966nip";
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
        name = "crate.tar.gz";
        sha256 = "1r262wskhm6wmc5i2bxz44nglyzqaq3x50s0h5q0ffdq6xbdckhz";
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
        name = "crate.tar.gz";
        sha256 = "0hkn1ksmg5hdqgqdw1ahy5qk69f4crh2psf0v61qphyrf777nm2r";
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
        name = "crate.tar.gz";
        sha256 = "1v2r349b2dr0pknpjk3nkrbi3mhaa3wl7zi7bdbla4zmcni0hdxn";
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
        name = "crate.tar.gz";
        sha256 = "13v7v8pp7mdqqf0ypk73va78c3b4xzpryvbls9p47nz3cd34008s";
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
        ("tinyvec 1.5.0")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1yabhmg8zlcksda3ajly9hpbzqgbhknxwch8dwkfkaa1569r0ifm";
        url = "https://crates.io/api/v1/crates/unicode-normalization/0.1.19/download";
      });
      edition = "2018";
      features = [
        ("default")
        ("std")
      ];
    };
    "unicode-width 0.1.9" = {
      pname = "unicode-width";
      version = "0.1.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0wq9wl69wlp6zwlxp660g9p4hm5gk91chwk14dp1gl9bxba45mry";
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
        name = "crate.tar.gz";
        sha256 = "1wrkgcw557v311dkdb6n2hrix9dm2qdsb1zpw7pn79l03zb85jwc";
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
        name = "crate.tar.gz";
        sha256 = "132pzpvfvpw33gjlzqd55n5iag9qddzffq8qbp1myfykna1w61x5";
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
        name = "crate.tar.gz";
        sha256 = "09i4nf5y8lig6xgj3f7fyrvzd3nlaw4znrihw8psidvv5yk4xkdc";
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
        name = "crate.tar.gz";
        sha256 = "1zmkcgj2m0pq0l4wnhrp1wl1lygf7x2h5p7pvjwc4719lnlxrv2z";
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
        name = "crate.tar.gz";
        sha256 = "181b2zmwfq389x9n2g1n37cvcvvdand832zz6v8i1l8wrdlaks0w";
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
        name = "crate.tar.gz";
        sha256 = "1ii7nff4y1mpcrxzzvbpgxm7a1nn3szjf1n21jnx37c2g6dbsvzx";
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
        name = "crate.tar.gz";
        sha256 = "1kkzwj24z9ad7lq8c5ynlnpxpx8hwra6w6brl871a6dj6vi76bv3";
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
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("syn 1.0.81")
        ("wasm-bindgen-shared 0.2.78")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "0yw3ma0ahd1cz3afxpqcgwy9rwwgmz2g8pn8nas7c95sky7vy5x3";
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
        name = "crate.tar.gz";
        sha256 = "0fax7x0iysa64iqmzq0lri8llw8v0f8acz1iq6b4qahzrcipb3cf";
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
        name = "crate.tar.gz";
        sha256 = "1ydcppds5qbj77c7kdinkg9qidcf7ahvwqvnb3v8nllmqkklcqfm";
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
        ("proc-macro2 1.0.32")
        ("quote 1.0.10")
        ("syn 1.0.81")
        ("wasm-bindgen-backend 0.2.78")
        ("wasm-bindgen-shared 0.2.78")
      ];
      src = (pkgs.fetchurl {
        name = "crate.tar.gz";
        sha256 = "1ay5qmbqh8hbsgf2dqkg7ia13srx3c1d6p2qvjmzhdaqlbpf00vq";
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
        name = "crate.tar.gz";
        sha256 = "1k27dc57h0brx5ish4dwmzibyif7m9lfagvph1a7s0ygi4kj6dq2";
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
        name = "crate.tar.gz";
        sha256 = "1yz9dym9y9f9s1f99q5j5kl2dfc5kn2jpjfdnnkfmnar3igi1srq";
        url = "https://crates.io/api/v1/crates/web-sys/0.3.55/download";
      });
      edition = "2018";
      features = [
        ("Blob")
        ("BlobPropertyBag")
        ("Event")
        ("EventTarget")
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
        name = "crate.tar.gz";
        sha256 = "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw";
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
        name = "crate.tar.gz";
        sha256 = "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc";
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
        name = "crate.tar.gz";
        sha256 = "0y71bp7f6d536czj40dhqk0d55wfbbwqfp2ymqf1an5ibgl6rv3h";
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
        name = "crate.tar.gz";
        sha256 = "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki";
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
        name = "crate.tar.gz";
        sha256 = "0sdxcyvda4v1v6a0k1j2v1400z3ng323k9a56gxvkq51x21dn801";
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
        name = "crate.tar.gz";
        sha256 = "05028bk49b2ix1lz22sj65fnlxr0f29j2klkaqjxp6az3c6hprl5";
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
        name = "crate.tar.gz";
        sha256 = "118wbqrr4n6wgk5rjjnlrdlahawlxc1bdsx146mwk8f79in97han";
        url = "https://crates.io/api/v1/crates/yaml-rust/0.4.5/download";
      });
      edition = "2018";
    };
  };
}