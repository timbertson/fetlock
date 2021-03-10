final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "yarn";
    version = "1";
    toplevel = [
      ("@onivim/vscode-exthost@1.52.1000")
    ];
  };
  specs = {
    "@onivim/vscode-exthost@1.52.1000" = {
      pname = "onivim-vscode-exthost";
      version = "1.52.1000";
      depKeys = [
        ("graceful-fs@4.1.11")
        ("iconv-lite-umd@0.6.8")
        ("minimist@1.2.5")
        ("native-watchdog@1.3.0")
        ("node-pty@0.10.0")
        ("semver-umd@5.5.7")
        ("spdlog@0.11.1")
        ("vscode-proxy-agent@0.5.2")
        ("vscode-regexpp@3.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@onivim/vscode-exthost/-/vscode-exthost-1.52.1000.tgz";
        sha256 = "1m2m6zlkfzc7adlrbwfnvvnscm4d8wxiqr9p26v4pj3g0kyyyqhn";
      };
      pkgname = "@onivim/vscode-exthost";
    };
    "abbrev@1.1.1" = {
      pname = "abbrev";
      version = "1.1.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/abbrev/-/abbrev-1.1.1.tgz";
        sha256 = "0vdsff38rgn0qylyj6x42n13bnxfqxb9ql34bzs4z9grlli9vh8c";
      };
      pkgname = "abbrev";
    };
    "agent-base@4.3.0" = {
      pname = "agent-base";
      version = "4.3.0";
      depKeys = [
        ("es6-promisify@5.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/agent-base/-/agent-base-4.3.0.tgz";
        sha256 = "1501wss9h7g3hkid6zg2w3kqlj93bffqyvbh4g1pjdwqyhispavn";
      };
      pkgname = "agent-base";
    };
    "ajv@6.12.6" = {
      pname = "ajv";
      version = "6.12.6";
      depKeys = [
        ("fast-deep-equal@3.1.3")
        ("fast-json-stable-stringify@2.1.0")
        ("json-schema-traverse@0.4.1")
        ("uri-js@4.4.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ajv/-/ajv-6.12.6.tgz";
        sha256 = "0jhk2dnzrk188p3micnkh7126lhdbkj9iip0pywhky6vh1dk8xcr";
      };
      pkgname = "ajv";
    };
    "ansi-regex@2.1.1" = {
      pname = "ansi-regex";
      version = "2.1.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-2.1.1.tgz";
        sha256 = "0dw0pqvijj9q9rfll09g4chszmakl5zr62k3ir9szvk5i0aapf2j";
      };
      pkgname = "ansi-regex";
    };
    "ansi-regex@3.0.0" = {
      pname = "ansi-regex";
      version = "3.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-3.0.0.tgz";
        sha256 = "0d9xwkpwak84xixi7f21bxvrbdgdpwm4pna73jkm8pfk6v8b1bdx";
      };
      pkgname = "ansi-regex";
    };
    "aproba@1.2.0" = {
      pname = "aproba";
      version = "1.2.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/aproba/-/aproba-1.2.0.tgz";
        sha256 = "17g0x3q0jy73db7n9x7aw9dazv7adhar5y7pyilkznq53v3niwss";
      };
      pkgname = "aproba";
    };
    "are-we-there-yet@1.1.5" = {
      pname = "are-we-there-yet";
      version = "1.1.5";
      depKeys = [
        ("delegates@1.0.0")
        ("readable-stream@2.3.7")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/are-we-there-yet/-/are-we-there-yet-1.1.5.tgz";
        sha256 = "1ib2m739sxwmxqb6cnpj6mwghrkjs3mga1xsfi00vgs6540vdhf5";
      };
      pkgname = "are-we-there-yet";
    };
    "asn1@0.2.4" = {
      pname = "asn1";
      version = "0.2.4";
      depKeys = [
        ("safer-buffer@2.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/asn1/-/asn1-0.2.4.tgz";
        sha256 = "0fymjdkmd7kg4kyga0hssiwdz9jz5nv8fyndl3l1dr9q9jbl9971";
      };
      pkgname = "asn1";
    };
    "assert-plus@1.0.0" = {
      pname = "assert-plus";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/assert-plus/-/assert-plus-1.0.0.tgz";
        sha256 = "1srkj0nyslz3rbfncj59sqbsllavmwik8gphd7jxwjshf52mras7";
      };
      pkgname = "assert-plus";
    };
    "asynckit@0.4.0" = {
      pname = "asynckit";
      version = "0.4.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/asynckit/-/asynckit-0.4.0.tgz";
        sha256 = "1kvxnmjbjwqc8gvp4ms7d8w8x7y41rcizmz4898694h7ywq4y9cc";
      };
      pkgname = "asynckit";
    };
    "aws-sign2@0.7.0" = {
      pname = "aws-sign2";
      version = "0.7.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.7.0.tgz";
        sha256 = "12bjw01pgh0nfyxi7vw6lvsapyvnazrnyn4qf87lclardjaz9yd8";
      };
      pkgname = "aws-sign2";
    };
    "aws4@1.11.0" = {
      pname = "aws4";
      version = "1.11.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/aws4/-/aws4-1.11.0.tgz";
        sha256 = "1a9gd1wyx3k9agcprmgpfhp63w9v6cvf2kxfnijk77k6zcqqqjnd";
      };
      pkgname = "aws4";
    };
    "balanced-match@1.0.0" = {
      pname = "balanced-match";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha256 = "1bgzp9jp8ws0kdfgq8h6w3qz8cljyzgcrmxypxkgbknk28n615i8";
      };
      pkgname = "balanced-match";
    };
    "bcrypt-pbkdf@1.0.2" = {
      pname = "bcrypt-pbkdf";
      version = "1.0.2";
      depKeys = [
        ("tweetnacl@0.14.5")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/bcrypt-pbkdf/-/bcrypt-pbkdf-1.0.2.tgz";
        sha256 = "09kqy1rjj0b1aavdssglrjj8ayf9vxvnnvlh5ah270j3bngrwgp1";
      };
      pkgname = "bcrypt-pbkdf";
    };
    "bindings@1.5.0" = {
      pname = "bindings";
      version = "1.5.0";
      depKeys = [
        ("file-uri-to-path@1.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/bindings/-/bindings-1.5.0.tgz";
        sha256 = "01q9xfgc5jl9h6ny44zb4xcin6sirmm5bignn68rmn2vihbq2xyp";
      };
      pkgname = "bindings";
    };
    "brace-expansion@1.1.11" = {
      pname = "brace-expansion";
      version = "1.1.11";
      depKeys = [
        ("balanced-match@1.0.0")
        ("concat-map@0.0.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha256 = "1nlmjvlwlp88knblnayns0brr7a9m2fynrlwq425lrpb4mcn9gc4";
      };
      pkgname = "brace-expansion";
    };
    "buffer-crc32@0.2.13" = {
      pname = "buffer-crc32";
      version = "0.2.13";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/buffer-crc32/-/buffer-crc32-0.2.13.tgz";
        sha256 = "0vf6adpqimbz921y729mf91pvghihj44js2ck5ci44zh4x21bl97";
      };
      pkgname = "buffer-crc32";
    };
    "caseless@0.12.0" = {
      pname = "caseless";
      version = "0.12.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/caseless/-/caseless-0.12.0.tgz";
        sha256 = "165fzm8s6qxapxk8xlb548q58xjav55k5nnychr234282irb2zjd";
      };
      pkgname = "caseless";
    };
    "chownr@2.0.0" = {
      pname = "chownr";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/chownr/-/chownr-2.0.0.tgz";
        sha256 = "177wsdfmn1d2f12wy8m875b5y9a74ibfdh33jarlv3a0zrbmvqlv";
      };
      pkgname = "chownr";
    };
    "code-point-at@1.1.0" = {
      pname = "code-point-at";
      version = "1.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/code-point-at/-/code-point-at-1.1.0.tgz";
        sha256 = "0g8bfw3l2mfpl654na0pjfbwri9dms92bc615a2q2qvdk1wclyaj";
      };
      pkgname = "code-point-at";
    };
    "combined-stream@1.0.8" = {
      pname = "combined-stream";
      version = "1.0.8";
      depKeys = [
        ("delayed-stream@1.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/combined-stream/-/combined-stream-1.0.8.tgz";
        sha256 = "04hm5rrkwda2qgy1afwhrz42asmflw5hxkbpxddn741ywnmmmgmn";
      };
      pkgname = "combined-stream";
    };
    "concat-map@0.0.1" = {
      pname = "concat-map";
      version = "0.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha256 = "0qa2zqn9rrr2fqdki44s4s2dk2d8307i4556kv25h06g43b2v41m";
      };
      pkgname = "concat-map";
    };
    "console-control-strings@1.1.0" = {
      pname = "console-control-strings";
      version = "1.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/console-control-strings/-/console-control-strings-1.1.0.tgz";
        sha256 = "0dl328x4g2dqhf4lbfajf4c7vlb6m7ff8adpk1ngig7s1i49pm7h";
      };
      pkgname = "console-control-strings";
    };
    "core-util-is@1.0.2" = {
      pname = "core-util-is";
      version = "1.0.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.2.tgz";
        sha256 = "164k94d9bdzw1335kzakj7hflhnnixpx4n6ydbhf7vbrcnmlv954";
      };
      pkgname = "core-util-is";
    };
    "dashdash@1.14.1" = {
      pname = "dashdash";
      version = "1.14.1";
      depKeys = [
        ("assert-plus@1.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/dashdash/-/dashdash-1.14.1.tgz";
        sha256 = "0h2kaml5wgx5x430wlbnjz3j6q1ppvndqckylfmi13xa33gfnycb";
      };
      pkgname = "dashdash";
    };
    "debug@3.2.6" = {
      pname = "debug";
      version = "3.2.6";
      depKeys = [
        ("ms@2.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-3.2.6.tgz";
        sha256 = "0l9b6y3syggfrif720i2sa8v6sd4sasfg64vw16l601a0yqzha1r";
      };
      pkgname = "debug";
    };
    "delayed-stream@1.0.0" = {
      pname = "delayed-stream";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/delayed-stream/-/delayed-stream-1.0.0.tgz";
        sha256 = "1lr98585rayrc5xfj599hg6mxqvks38diir74ivivyvx47jgqf5c";
      };
      pkgname = "delayed-stream";
    };
    "delegates@1.0.0" = {
      pname = "delegates";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/delegates/-/delegates-1.0.0.tgz";
        sha256 = "0qb4rw56fbxcpc2iwj1x0qxzakwwqigxgggggd6ajl7d27sdpvxz";
      };
      pkgname = "delegates";
    };
    "ecc-jsbn@0.1.2" = {
      pname = "ecc-jsbn";
      version = "0.1.2";
      depKeys = [
        ("jsbn@0.1.1")
        ("safer-buffer@2.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ecc-jsbn/-/ecc-jsbn-0.1.2.tgz";
        sha256 = "0x39lihzphr0h1fvh9p65k86vx3p7z6jrxgv4b402lvdrifd56k0";
      };
      pkgname = "ecc-jsbn";
    };
    "env-paths@2.2.0" = {
      pname = "env-paths";
      version = "2.2.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/env-paths/-/env-paths-2.2.0.tgz";
        sha256 = "0k2b4s540pzm84jiqrsdxfwlcqprdm32862br0fsh3m6pi7kk2qn";
      };
      pkgname = "env-paths";
    };
    "es6-promise@4.2.8" = {
      pname = "es6-promise";
      version = "4.2.8";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/es6-promise/-/es6-promise-4.2.8.tgz";
        sha256 = "19v6k3c1035x0ba9qpfjjp14qicd86s8amfz0nsxf9w3dx0xqfpa";
      };
      pkgname = "es6-promise";
    };
    "es6-promisify@5.0.0" = {
      pname = "es6-promisify";
      version = "5.0.0";
      depKeys = [
        ("es6-promise@4.2.8")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/es6-promisify/-/es6-promisify-5.0.0.tgz";
        sha256 = "1p87k4ny1ccbs1r92fzskc6hgrp6n7gfqxia888vzkq2w5g9dkbc";
      };
      pkgname = "es6-promisify";
    };
    "extend@3.0.2" = {
      pname = "extend";
      version = "3.0.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/extend/-/extend-3.0.2.tgz";
        sha256 = "1ckjrzapv4awrafybcvq3n5rcqm6ljswfdx97wibl355zaqd148x";
      };
      pkgname = "extend";
    };
    "extsprintf@1.3.0" = {
      pname = "extsprintf";
      version = "1.3.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/extsprintf/-/extsprintf-1.3.0.tgz";
        sha256 = "0i6hmr7mkg76rgrxs7f0xny48kha2xi03wj43mfik77m0lk3k6yg";
      };
      pkgname = "extsprintf";
    };
    "extsprintf@1.4.0" = {
      pname = "extsprintf";
      version = "1.4.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/extsprintf/-/extsprintf-1.4.0.tgz";
        sha256 = "1lphcbxrq7x1gz84f71hx7z4fkick5knxbif1cxim53ifn5cwrxm";
      };
      pkgname = "extsprintf";
    };
    "fast-deep-equal@3.1.3" = {
      pname = "fast-deep-equal";
      version = "3.1.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz";
        sha256 = "13vvwib6za4zh7054n3fg86y127ig3jb0djqz31qsqr71yca06dh";
      };
      pkgname = "fast-deep-equal";
    };
    "fast-json-stable-stringify@2.1.0" = {
      pname = "fast-json-stable-stringify";
      version = "2.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fast-json-stable-stringify/-/fast-json-stable-stringify-2.1.0.tgz";
        sha256 = "11qnzlan5yd2hg9nqi9hdv48bq6kwvw9pxsxir22n2iyqhighb8y";
      };
      pkgname = "fast-json-stable-stringify";
    };
    "fd-slicer@1.1.0" = {
      pname = "fd-slicer";
      version = "1.1.0";
      depKeys = [
        ("pend@1.2.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fd-slicer/-/fd-slicer-1.1.0.tgz";
        sha256 = "08w8mwdkaadagyhh61cppma7a4l9z13rlbrxz14ys6r7xfp26s6c";
      };
      pkgname = "fd-slicer";
    };
    "file-uri-to-path@1.0.0" = {
      pname = "file-uri-to-path";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/file-uri-to-path/-/file-uri-to-path-1.0.0.tgz";
        sha256 = "1cvgn3xfpkzy20vjfw093mdjam1x9hfkrrkbdbrrdavmgvvcsh2l";
      };
      pkgname = "file-uri-to-path";
    };
    "follow-redirects@1.13.0" = {
      pname = "follow-redirects";
      version = "1.13.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/follow-redirects/-/follow-redirects-1.13.0.tgz";
        sha256 = "1r0315afpvimak4rhpk71v70jqbjdgjz9xg9cdprkcbxwx0lj7d8";
      };
      pkgname = "follow-redirects";
    };
    "forever-agent@0.6.1" = {
      pname = "forever-agent";
      version = "0.6.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/forever-agent/-/forever-agent-0.6.1.tgz";
        sha256 = "1i86r2ip6ryrnpg3v7pf0ywddhsdlr809xycd3zm9gq7zphn5a7c";
      };
      pkgname = "forever-agent";
    };
    "form-data@2.3.3" = {
      pname = "form-data";
      version = "2.3.3";
      depKeys = [
        ("asynckit@0.4.0")
        ("combined-stream@1.0.8")
        ("mime-types@2.1.29")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/form-data/-/form-data-2.3.3.tgz";
        sha256 = "1j1ka178syqqaycr1m3vqahbb3bi7qsks0mp0iqbd6y7yj1wz7p3";
      };
      pkgname = "form-data";
    };
    "fs-extra@8.1.0" = {
      pname = "fs-extra";
      version = "8.1.0";
      depKeys = [
        ("graceful-fs@4.1.11")
        ("jsonfile@4.0.0")
        ("universalify@0.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fs-extra/-/fs-extra-8.1.0.tgz";
        sha256 = "0n5ibswj8njpw8w8igfqxklyips6m1y8cyk1zrd9llv9rirlgv00";
      };
      pkgname = "fs-extra";
    };
    "fs-minipass@2.1.0" = {
      pname = "fs-minipass";
      version = "2.1.0";
      depKeys = [
        ("minipass@3.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fs-minipass/-/fs-minipass-2.1.0.tgz";
        sha256 = "029kdjb6h8gp0gfx7rx6yzwbv7pnd7i119gn563ynv0dqx02p5gx";
      };
      pkgname = "fs-minipass";
    };
    "fs.realpath@1.0.0" = {
      pname = "fs.realpath";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha256 = "174g5vay9jnd7h5q8hfdw6dnmwl1gdpn4a8sz0ysanhj2f3wp04y";
      };
      pkgname = "fs.realpath";
    };
    "gauge@2.7.4" = {
      pname = "gauge";
      version = "2.7.4";
      depKeys = [
        ("aproba@1.2.0")
        ("console-control-strings@1.1.0")
        ("has-unicode@2.0.1")
        ("object-assign@4.1.1")
        ("signal-exit@3.0.3")
        ("string-width@1.0.2")
        ("strip-ansi@3.0.1")
        ("wide-align@1.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/gauge/-/gauge-2.7.4.tgz";
        sha256 = "0xk6970l7f0jd7xy8xbxicxbkgc19j9k7q2cypsg0z4qs3ah9ncq";
      };
      pkgname = "gauge";
    };
    "getpass@0.1.7" = {
      pname = "getpass";
      version = "0.1.7";
      depKeys = [
        ("assert-plus@1.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/getpass/-/getpass-0.1.7.tgz";
        sha256 = "0ifl7rdzhkbwzb2pmi6mxvv92qd2ihbfbfkipw9nqvbn22x140wg";
      };
      pkgname = "getpass";
    };
    "glob@7.1.6" = {
      pname = "glob";
      version = "7.1.6";
      depKeys = [
        ("fs.realpath@1.0.0")
        ("inflight@1.0.6")
        ("inherits@2.0.4")
        ("minimatch@3.0.4")
        ("once@1.4.0")
        ("path-is-absolute@1.0.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.6.tgz";
        sha256 = "1hm62p225wxx15k5kw9b5byif2rdi4ivn2a595lfvv26niq53c2l";
      };
      pkgname = "glob";
    };
    "graceful-fs@4.1.11" = {
      pname = "graceful-fs";
      version = "4.1.11";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.1.11.tgz";
        sha256 = "1f5nqasrrfssgxw30pvyvj8i1lwyh8jp9y3d8kfqxpgq1qkp1c3a";
      };
      pkgname = "graceful-fs";
    };
    "har-schema@2.0.0" = {
      pname = "har-schema";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/har-schema/-/har-schema-2.0.0.tgz";
        sha256 = "09myh5q5225c53v39mw9n3a2kgf2pk0z9dfwbmm7rbb70npq8yrf";
      };
      pkgname = "har-schema";
    };
    "har-validator@5.1.5" = {
      pname = "har-validator";
      version = "5.1.5";
      depKeys = [
        ("ajv@6.12.6")
        ("har-schema@2.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/har-validator/-/har-validator-5.1.5.tgz";
        sha256 = "02vymdr8s3x1cbsv15m9fq6bnbiajyjy8vdz0hl9vrv8xi5ay27f";
      };
      pkgname = "har-validator";
    };
    "has-unicode@2.0.1" = {
      pname = "has-unicode";
      version = "2.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/has-unicode/-/has-unicode-2.0.1.tgz";
        sha256 = "1b7c6mrpncz2x7s6r1v9kcmqw6hix039kbkbzqz0czma56gxsqfh";
      };
      pkgname = "has-unicode";
    };
    "http-proxy-agent@2.1.0" = {
      pname = "http-proxy-agent";
      version = "2.1.0";
      depKeys = [
        ("agent-base@4.3.0")
        ("debug@3.2.6")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/http-proxy-agent/-/http-proxy-agent-2.1.0.tgz";
        sha256 = "0il9qg7cvb0l6fz516vzkq2cm4nda32q0ik224hzdjqp6718d1zs";
      };
      pkgname = "http-proxy-agent";
    };
    "http-signature@1.2.0" = {
      pname = "http-signature";
      version = "1.2.0";
      depKeys = [
        ("assert-plus@1.0.0")
        ("jsprim@1.4.1")
        ("sshpk@1.16.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/http-signature/-/http-signature-1.2.0.tgz";
        sha256 = "1y856b84kxhq6wc9yiqcfhd4187nizr7lhxi9z69mwzavmpnvgk6";
      };
      pkgname = "http-signature";
    };
    "https-proxy-agent@2.2.4" = {
      pname = "https-proxy-agent";
      version = "2.2.4";
      depKeys = [
        ("agent-base@4.3.0")
        ("debug@3.2.6")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/https-proxy-agent/-/https-proxy-agent-2.2.4.tgz";
        sha256 = "1b1vvfkhxvjgxjhpb80fg5ql59r2inaiwvdabpj0mvqh7jvjfz6f";
      };
      pkgname = "https-proxy-agent";
    };
    "iconv-lite-umd@0.6.8" = {
      pname = "iconv-lite-umd";
      version = "0.6.8";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/iconv-lite-umd/-/iconv-lite-umd-0.6.8.tgz";
        sha256 = "1vrvcg3i82arvhpav5qpwrc8r2klfwaar9mrvcs7f3x7g38wc94y";
      };
      pkgname = "iconv-lite-umd";
    };
    "inflight@1.0.6" = {
      pname = "inflight";
      version = "1.0.6";
      depKeys = [
        ("once@1.4.0")
        ("wrappy@1.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha256 = "16w864087xsh3q7f5gm3754s7bpsb9fq3dhknk9nmbvlk3sxr7ss";
      };
      pkgname = "inflight";
    };
    "inherits@2.0.4" = {
      pname = "inherits";
      version = "2.0.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
        sha256 = "1bxg4igfni2hymabg8bkw86wd3qhhzhsswran47sridk3dnbqkfr";
      };
      pkgname = "inherits";
    };
    "ip@1.1.5" = {
      pname = "ip";
      version = "1.1.5";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ip/-/ip-1.1.5.tgz";
        sha256 = "0na248rdqaxsdx2q582vq6z0mspizl1q2q1cfzpriia29kd8ixm8";
      };
      pkgname = "ip";
    };
    "is-fullwidth-code-point@1.0.0" = {
      pname = "is-fullwidth-code-point";
      version = "1.0.0";
      depKeys = [
        ("number-is-nan@1.0.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-1.0.0.tgz";
        sha256 = "0v38ngwaag3h6zggqljmc9ax6jpwy3ldm3qx9j0cqiqd2dm6bvbp";
      };
      pkgname = "is-fullwidth-code-point";
    };
    "is-fullwidth-code-point@2.0.0" = {
      pname = "is-fullwidth-code-point";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz";
        sha256 = "0sx0mg720hlpxdcg3rpf5ck93bwzkvb5883686v2iwvbxvnx1l2c";
      };
      pkgname = "is-fullwidth-code-point";
    };
    "is-typedarray@1.0.0" = {
      pname = "is-typedarray";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/is-typedarray/-/is-typedarray-1.0.0.tgz";
        sha256 = "0i9qr2b79d0chhvpd1fc5pcp9bvirpg37f99d40alciqffmrfp0d";
      };
      pkgname = "is-typedarray";
    };
    "isarray@1.0.0" = {
      pname = "isarray";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/isarray/-/isarray-1.0.0.tgz";
        sha256 = "11qcjpdzigcwcprhv7nyarlzjcwf3sv5i66q75zf08jj9zqpcg72";
      };
      pkgname = "isarray";
    };
    "isexe@2.0.0" = {
      pname = "isexe";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz";
        sha256 = "0nc3rcqjgyb9yyqajwlzzhfcqmsb682z7zinnx9qrql8w1rfiks7";
      };
      pkgname = "isexe";
    };
    "isstream@0.1.2" = {
      pname = "isstream";
      version = "0.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/isstream/-/isstream-0.1.2.tgz";
        sha256 = "0i0br6synccpj2ian2z5fnnna99qq4w73dbp46vnyi53l9w47bkr";
      };
      pkgname = "isstream";
    };
    "jsbn@0.1.1" = {
      pname = "jsbn";
      version = "0.1.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/jsbn/-/jsbn-0.1.1.tgz";
        sha256 = "08r3wxx18yixax4w9rs18ya1ggw6kgzjhw5vbsj7sb8a974lpi2s";
      };
      pkgname = "jsbn";
    };
    "json-schema-traverse@0.4.1" = {
      pname = "json-schema-traverse";
      version = "0.4.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz";
        sha256 = "0rf0pvm62k8g81vs7n7zx080p6sfylwk52vc149jx1216vcssdgp";
      };
      pkgname = "json-schema-traverse";
    };
    "json-schema@0.2.3" = {
      pname = "json-schema";
      version = "0.2.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/json-schema/-/json-schema-0.2.3.tgz";
        sha256 = "0gwkxqmwlwb5nffgxsjf1rcd1lv21br555mxr5mcnc60zd9kq5p3";
      };
      pkgname = "json-schema";
    };
    "json-stringify-safe@5.0.1" = {
      pname = "json-stringify-safe";
      version = "5.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz";
        sha256 = "12ljc7ipy7cprz5zxzzds20ykw6z5616763ca5zx9xmzq1jvzyxp";
      };
      pkgname = "json-stringify-safe";
    };
    "jsonfile@4.0.0" = {
      pname = "jsonfile";
      version = "4.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/jsonfile/-/jsonfile-4.0.0.tgz";
        sha256 = "1s701cy3mlbvgyhhyy2ypqcy064w5990sk8x81gv0200yybrbfaz";
      };
      pkgname = "jsonfile";
    };
    "jsprim@1.4.1" = {
      pname = "jsprim";
      version = "1.4.1";
      depKeys = [
        ("assert-plus@1.0.0")
        ("extsprintf@1.3.0")
        ("json-schema@0.2.3")
        ("verror@1.10.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/jsprim/-/jsprim-1.4.1.tgz";
        sha256 = "0ipc481jham9q4ayfl335zjdfmnxc1wcixx5qibfwl2ncz60gwqx";
      };
      pkgname = "jsprim";
    };
    "lru-cache@6.0.0" = {
      pname = "lru-cache";
      version = "6.0.0";
      depKeys = [
        ("yallist@4.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz";
        sha256 = "0pnziizgv8jpg708ykywcjby0syjz1l2ll1j727rdxhw0gmhvr2w";
      };
      pkgname = "lru-cache";
    };
    "mime-db@1.46.0" = {
      pname = "mime-db";
      version = "1.46.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/mime-db/-/mime-db-1.46.0.tgz";
        sha256 = "0z4yi9y4ysdspi7as0w8v2s2zhz33d47z7dzbd0andq57361j1f9";
      };
      pkgname = "mime-db";
    };
    "mime-types@2.1.29" = {
      pname = "mime-types";
      version = "2.1.29";
      depKeys = [
        ("mime-db@1.46.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/mime-types/-/mime-types-2.1.29.tgz";
        sha256 = "1s92rzampch9zdqpj352sy4j6qwxbnvm8fv39k34r25cilkl5mj1";
      };
      pkgname = "mime-types";
    };
    "minimatch@3.0.4" = {
      pname = "minimatch";
      version = "3.0.4";
      depKeys = [
        ("brace-expansion@1.1.11")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha256 = "0wgammjc9myx0k0k3n9r9cjnv0r1j33cwqiy2fxx7w5nkgbj8sj2";
      };
      pkgname = "minimatch";
    };
    "minimist@1.2.5" = {
      pname = "minimist";
      version = "1.2.5";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minimist/-/minimist-1.2.5.tgz";
        sha256 = "0l23rq2pam1khc06kd7fv0ys2cq0mlgs82dxjxjfjmlksgj0r051";
      };
      pkgname = "minimist";
    };
    "minipass@3.1.3" = {
      pname = "minipass";
      version = "3.1.3";
      depKeys = [
        ("yallist@4.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minipass/-/minipass-3.1.3.tgz";
        sha256 = "09dn1bj9wrv5xyd8z0imkhrs75qc6bi5ficgwbk46ri6yc2rz936";
      };
      pkgname = "minipass";
    };
    "minizlib@2.1.2" = {
      pname = "minizlib";
      version = "2.1.2";
      depKeys = [
        ("minipass@3.1.3")
        ("yallist@4.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minizlib/-/minizlib-2.1.2.tgz";
        sha256 = "1vffn3i5ys3w74s8m8n4l7vvzijddi44flpaxdfv96q85n513va4";
      };
      pkgname = "minizlib";
    };
    "mkdirp@0.5.5" = {
      pname = "mkdirp";
      version = "0.5.5";
      depKeys = [
        ("minimist@1.2.5")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.5.tgz";
        sha256 = "02mvn5hllnsxzli8yy0gkgkkxndbwd3fh302shadsag3c4db0njf";
      };
      pkgname = "mkdirp";
    };
    "mkdirp@1.0.4" = {
      pname = "mkdirp";
      version = "1.0.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-1.0.4.tgz";
        sha256 = "06nqac14zbpar89jc7s574l1qpmamr1kzy0dr3qyhvxg8570f5qx";
      };
      pkgname = "mkdirp";
    };
    "ms@2.1.2" = {
      pname = "ms";
      version = "2.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.1.2.tgz";
        sha256 = "0j7vrqxzg2fxip3q0cws360wk3cz2nprr8zkragipziz1piscmqi";
      };
      pkgname = "ms";
    };
    "nan@2.14.2" = {
      pname = "nan";
      version = "2.14.2";
      depKeys = [
        ("node-gyp@7.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/nan/-/nan-2.14.2.tgz";
        sha256 = "0092x43h4ysm9zsxrxhkba1m2m1ybmnsn7dq58ppfgmd02hi98m9";
      };
      pkgname = "nan";
    };
    "native-watchdog@1.3.0" = {
      pname = "native-watchdog";
      version = "1.3.0";
      depKeys = [
        ("node-gyp@7.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/native-watchdog/-/native-watchdog-1.3.0.tgz";
        sha256 = "11jnapq0i8xdjldcwylrb17addgl2m1ilql3rjkfsj0zjk14n1vj";
      };
      pkgname = "native-watchdog";
    };
    "node-gyp@7.1.2" = {
      pname = "node-gyp";
      version = "7.1.2";
      depKeys = [
        ("env-paths@2.2.0")
        ("glob@7.1.6")
        ("graceful-fs@4.1.11")
        ("nopt@5.0.0")
        ("npmlog@4.1.2")
        ("request@2.88.2")
        ("rimraf@3.0.2")
        ("semver@7.3.4")
        ("tar@6.1.0")
        ("which@2.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/node-gyp/-/node-gyp-7.1.2.tgz";
        sha256 = "0lq1hcx5kayhc591q0wnm22vzmwgrk4i4gam2347riz8xkkd8mwz";
      };
      pkgname = "node-gyp";
    };
    "node-pty@0.10.0" = {
      pname = "node-pty";
      version = "0.10.0";
      depKeys = [
        ("nan@2.14.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/node-pty/-/node-pty-0.10.0.tgz";
        sha256 = "0sdz0r99k9fbjlnp6wrjccnq4kknzvdnpa12p051ci450qq9vd83";
      };
      pkgname = "node-pty";
    };
    "nopt@5.0.0" = {
      pname = "nopt";
      version = "5.0.0";
      depKeys = [
        ("abbrev@1.1.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/nopt/-/nopt-5.0.0.tgz";
        sha256 = "1h4pv5dd3yd8zvf4z61sg9ydqvwimdws1w2dm581kj93j35sxivz";
      };
      pkgname = "nopt";
    };
    "npmlog@4.1.2" = {
      pname = "npmlog";
      version = "4.1.2";
      depKeys = [
        ("are-we-there-yet@1.1.5")
        ("console-control-strings@1.1.0")
        ("gauge@2.7.4")
        ("set-blocking@2.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/npmlog/-/npmlog-4.1.2.tgz";
        sha256 = "0n87fxjxjw958xgk4xz73sm6plhrlfplj2ahaxyrqdy14i3sj4k8";
      };
      pkgname = "npmlog";
    };
    "number-is-nan@1.0.1" = {
      pname = "number-is-nan";
      version = "1.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/number-is-nan/-/number-is-nan-1.0.1.tgz";
        sha256 = "0g4zc4nr2jw5g1h1brgi90bgvk9jam5x4vg4n0cz58394bfwavl9";
      };
      pkgname = "number-is-nan";
    };
    "oauth-sign@0.9.0" = {
      pname = "oauth-sign";
      version = "0.9.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.9.0.tgz";
        sha256 = "1g6rl2pv86pxcx4mv25qqv0w265mc5ardp3vxd2hqg80c4bsy5h0";
      };
      pkgname = "oauth-sign";
    };
    "object-assign@4.1.1" = {
      pname = "object-assign";
      version = "4.1.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/object-assign/-/object-assign-4.1.1.tgz";
        sha256 = "1v999sycxcp74j2pikdhyinm2d80p2bsy4nnrrnb59rv4rm74bbq";
      };
      pkgname = "object-assign";
    };
    "once@1.4.0" = {
      pname = "once";
      version = "1.4.0";
      depKeys = [
        ("wrappy@1.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha256 = "1kygzk36kdcfiqz01dhql2dk75rl256m2vlpigv9iikhlc5lclfg";
      };
      pkgname = "once";
    };
    "onivim2-node@." = {
      pname = "onivim2-node";
      version = "0.0.0-use.local";
      depKeys = [
        ("@onivim/vscode-exthost@1.52.1000")
        ("follow-redirects@1.13.0")
        ("fs-extra@8.1.0")
        ("node-gyp@7.1.2")
        ("sudo-prompt@9.2.1")
        ("yauzl@2.10.0")
      ];
      pkgname = "onivim2-node";
    };
    "path-is-absolute@1.0.1" = {
      pname = "path-is-absolute";
      version = "1.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha256 = "0p7p04xxd8q495qhxmxydyjgzcf762dp1hp2wha2b52n3agp0vbf";
      };
      pkgname = "path-is-absolute";
    };
    "pend@1.2.0" = {
      pname = "pend";
      version = "1.2.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/pend/-/pend-1.2.0.tgz";
        sha256 = "0zvd8cli24vpvgsf9ldmm5ibivmx02njp2d9a85p3px94ndjfbx1";
      };
      pkgname = "pend";
    };
    "performance-now@2.1.0" = {
      pname = "performance-now";
      version = "2.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/performance-now/-/performance-now-2.1.0.tgz";
        sha256 = "0ich517fgk1nhmcjs2mfv4dp70ppqvj3xgmv3syl25zixzfrk3q6";
      };
      pkgname = "performance-now";
    };
    "process-nextick-args@2.0.1" = {
      pname = "process-nextick-args";
      version = "2.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/process-nextick-args/-/process-nextick-args-2.0.1.tgz";
        sha256 = "16w8m2ycy5s4ykgdfg97qxa67gfvkh6x3vdwfsncafyj4p3zhns2";
      };
      pkgname = "process-nextick-args";
    };
    "psl@1.8.0" = {
      pname = "psl";
      version = "1.8.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/psl/-/psl-1.8.0.tgz";
        sha256 = "03jj0mly8g6hrjaj8h77q0w02z3awgvy6ld051ph2k38fji3zdgb";
      };
      pkgname = "psl";
    };
    "punycode@2.1.1" = {
      pname = "punycode";
      version = "2.1.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/punycode/-/punycode-2.1.1.tgz";
        sha256 = "0g7z0kdxs15jrcijwbka2jajgr4b7bvpa6xmrcs0wf82pxwx1k75";
      };
      pkgname = "punycode";
    };
    "qs@6.5.2" = {
      pname = "qs";
      version = "6.5.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/qs/-/qs-6.5.2.tgz";
        sha256 = "1w0n5rg0w76b97ds80svkhmcqzcn76c3g5z81sblvii89ww4k4sk";
      };
      pkgname = "qs";
    };
    "readable-stream@2.3.7" = {
      pname = "readable-stream";
      version = "2.3.7";
      depKeys = [
        ("core-util-is@1.0.2")
        ("inherits@2.0.4")
        ("isarray@1.0.0")
        ("process-nextick-args@2.0.1")
        ("safe-buffer@5.1.2")
        ("string_decoder@1.1.1")
        ("util-deprecate@1.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/readable-stream/-/readable-stream-2.3.7.tgz";
        sha256 = "1ivp6i6kf0li6ak443prb3h8bjsznymjaaclmmmy5p55gb7px809";
      };
      pkgname = "readable-stream";
    };
    "request@2.88.2" = {
      pname = "request";
      version = "2.88.2";
      depKeys = [
        ("aws-sign2@0.7.0")
        ("aws4@1.11.0")
        ("caseless@0.12.0")
        ("combined-stream@1.0.8")
        ("extend@3.0.2")
        ("forever-agent@0.6.1")
        ("form-data@2.3.3")
        ("har-validator@5.1.5")
        ("http-signature@1.2.0")
        ("is-typedarray@1.0.0")
        ("isstream@0.1.2")
        ("json-stringify-safe@5.0.1")
        ("mime-types@2.1.29")
        ("oauth-sign@0.9.0")
        ("performance-now@2.1.0")
        ("qs@6.5.2")
        ("safe-buffer@5.2.1")
        ("tough-cookie@2.5.0")
        ("tunnel-agent@0.6.0")
        ("uuid@3.4.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/request/-/request-2.88.2.tgz";
        sha256 = "0hj2f9qqn3hpzpvhsnbwhzjyn5f8aicjz5wn00q0mfc4824awvg8";
      };
      pkgname = "request";
    };
    "rimraf@3.0.2" = {
      pname = "rimraf";
      version = "3.0.2";
      depKeys = [
        ("glob@7.1.6")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/rimraf/-/rimraf-3.0.2.tgz";
        sha256 = "0lkzjyxjij6ssh5h2l3ncp0zx00ylzhww766dq2vf1s7v07w4xjq";
      };
      pkgname = "rimraf";
    };
    "safe-buffer@5.1.2" = {
      pname = "safe-buffer";
      version = "5.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.1.2.tgz";
        sha256 = "08ma0a2a9j537bxl7qd2dn6sjcdhrclpdbslr19bkbyc1z30d4p0";
      };
      pkgname = "safe-buffer";
    };
    "safe-buffer@5.2.1" = {
      pname = "safe-buffer";
      version = "5.2.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.2.1.tgz";
        sha256 = "1s5kvjpwqsc682zcy71h9c6pxla21sysfwj270x6jjkca421h62x";
      };
      pkgname = "safe-buffer";
    };
    "safer-buffer@2.1.2" = {
      pname = "safer-buffer";
      version = "2.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz";
        sha256 = "1cx383s7vchfac8jlg3mnb820hkgcvhcpfn9w4f0g61vmrjjz0bq";
      };
      pkgname = "safer-buffer";
    };
    "semver-umd@5.5.7" = {
      pname = "semver-umd";
      version = "5.5.7";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/semver-umd/-/semver-umd-5.5.7.tgz";
        sha256 = "0p5dss6lh2d3cbgwky1dbp07apkfa28p9rdsav4hyr64dyby8bvx";
      };
      pkgname = "semver-umd";
    };
    "semver@7.3.4" = {
      pname = "semver";
      version = "7.3.4";
      depKeys = [
        ("lru-cache@6.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-7.3.4.tgz";
        sha256 = "1jzj2cila9n3fr0kr35idxlb4fhpkjdjwc6h80m4xydn064x77na";
      };
      pkgname = "semver";
    };
    "set-blocking@2.0.0" = {
      pname = "set-blocking";
      version = "2.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/set-blocking/-/set-blocking-2.0.0.tgz";
        sha256 = "0gb9mvv8bjfavsxlzq56189qis7z2lrp893px04xl2cyvgkswd6r";
      };
      pkgname = "set-blocking";
    };
    "signal-exit@3.0.3" = {
      pname = "signal-exit";
      version = "3.0.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/signal-exit/-/signal-exit-3.0.3.tgz";
        sha256 = "1iq1f7vb12fl4i2gjg9qmr9580axaypc0dvhx9xjzj0jssxckvqm";
      };
      pkgname = "signal-exit";
    };
    "smart-buffer@4.1.0" = {
      pname = "smart-buffer";
      version = "4.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/smart-buffer/-/smart-buffer-4.1.0.tgz";
        sha256 = "1sil9plgy3aa0bwc0vq52n189bv3hr3fpca812ipjl1k8gbydx2c";
      };
      pkgname = "smart-buffer";
    };
    "socks-proxy-agent@4.0.2" = {
      pname = "socks-proxy-agent";
      version = "4.0.2";
      depKeys = [
        ("agent-base@4.3.0")
        ("socks@2.3.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/socks-proxy-agent/-/socks-proxy-agent-4.0.2.tgz";
        sha256 = "1c3b99vrgjdynsimh4gn2jpalkh6q64xbwj6bagkvxi29gdfa5x5";
      };
      pkgname = "socks-proxy-agent";
    };
    "socks@2.3.3" = {
      pname = "socks";
      version = "2.3.3";
      depKeys = [
        ("ip@1.1.5")
        ("smart-buffer@4.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/socks/-/socks-2.3.3.tgz";
        sha256 = "178xr3c3l8jlfk68ihlid0wnsbp4x8a5is643g6xmsc1a9skkyf9";
      };
      pkgname = "socks";
    };
    "spdlog@0.11.1" = {
      pname = "spdlog";
      version = "0.11.1";
      depKeys = [
        ("bindings@1.5.0")
        ("mkdirp@0.5.5")
        ("nan@2.14.2")
        ("node-gyp@7.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/spdlog/-/spdlog-0.11.1.tgz";
        sha256 = "1cpaaxvwwwhlq4rcjdd9pmp1l330xlv4qrij28vbbmvyhvf70mck";
      };
      pkgname = "spdlog";
    };
    "sshpk@1.16.1" = {
      pname = "sshpk";
      version = "1.16.1";
      depKeys = [
        ("asn1@0.2.4")
        ("assert-plus@1.0.0")
        ("bcrypt-pbkdf@1.0.2")
        ("dashdash@1.14.1")
        ("ecc-jsbn@0.1.2")
        ("getpass@0.1.7")
        ("jsbn@0.1.1")
        ("safer-buffer@2.1.2")
        ("tweetnacl@0.14.5")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/sshpk/-/sshpk-1.16.1.tgz";
        sha256 = "0f885dfxv4nhpgsin60z0iflnbr9wfax9lwbcv4i9j3s7shxsjjw";
      };
      pkgname = "sshpk";
    };
    "string-width@1.0.2" = {
      pname = "string-width";
      version = "1.0.2";
      depKeys = [
        ("code-point-at@1.1.0")
        ("is-fullwidth-code-point@1.0.0")
        ("strip-ansi@3.0.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/string-width/-/string-width-1.0.2.tgz";
        sha256 = "0pg2b50g5l2adc9ph82ci6a41yw0zvy501ldisjj8vfaiknlvrcp";
      };
      pkgname = "string-width";
    };
    "string-width@2.1.1" = {
      pname = "string-width";
      version = "2.1.1";
      depKeys = [
        ("is-fullwidth-code-point@2.0.0")
        ("strip-ansi@4.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/string-width/-/string-width-2.1.1.tgz";
        sha256 = "0b3rb6pbkyg411hvnzb5v5w2vckasgxvslwwijh0p410x46dqz12";
      };
      pkgname = "string-width";
    };
    "string_decoder@1.1.1" = {
      pname = "string_decoder";
      version = "1.1.1";
      depKeys = [
        ("safe-buffer@5.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/string_decoder/-/string_decoder-1.1.1.tgz";
        sha256 = "0fln2r91b8gj845j7jl76fvsp7nij13fyzvz82985yh88m1n50mg";
      };
      pkgname = "string_decoder";
    };
    "strip-ansi@3.0.1" = {
      pname = "strip-ansi";
      version = "3.0.1";
      depKeys = [
        ("ansi-regex@2.1.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-3.0.1.tgz";
        sha256 = "0fkrbfwig3d1i8s01pbj08pq1z6sn9xqvkjdz0a9b58q85d3i78w";
      };
      pkgname = "strip-ansi";
    };
    "strip-ansi@4.0.0" = {
      pname = "strip-ansi";
      version = "4.0.0";
      depKeys = [
        ("ansi-regex@3.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-4.0.0.tgz";
        sha256 = "0b90ys7pxxbavph56rhfmlymla8f8vaq7fy2pa91dq4r6r3sic5a";
      };
      pkgname = "strip-ansi";
    };
    "sudo-prompt@9.2.1" = {
      pname = "sudo-prompt";
      version = "9.2.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/sudo-prompt/-/sudo-prompt-9.2.1.tgz";
        sha256 = "1s5w0idb0lqc04c13fvg988qjw87bq0rq0m4pscryfn2k6bj0vpd";
      };
      pkgname = "sudo-prompt";
    };
    "tar@6.1.0" = {
      pname = "tar";
      version = "6.1.0";
      depKeys = [
        ("chownr@2.0.0")
        ("fs-minipass@2.1.0")
        ("minipass@3.1.3")
        ("minizlib@2.1.2")
        ("mkdirp@1.0.4")
        ("yallist@4.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/tar/-/tar-6.1.0.tgz";
        sha256 = "1pfm3q7v041fs5zlihb4nmxm1zlghkcv3zi2byq09mcd3wll9iip";
      };
      pkgname = "tar";
    };
    "tough-cookie@2.5.0" = {
      pname = "tough-cookie";
      version = "2.5.0";
      depKeys = [
        ("psl@1.8.0")
        ("punycode@2.1.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/tough-cookie/-/tough-cookie-2.5.0.tgz";
        sha256 = "0knsdm6l5mn88rh78hajzr2rrydal6wf97l2pbpqjq8ws4w8gazh";
      };
      pkgname = "tough-cookie";
    };
    "tunnel-agent@0.6.0" = {
      pname = "tunnel-agent";
      version = "0.6.0";
      depKeys = [
        ("safe-buffer@5.2.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.6.0.tgz";
        sha256 = "04jhbjld99zavh1rvik2bayrgxwj2zx69xsbcm0gmlnna15c1qyk";
      };
      pkgname = "tunnel-agent";
    };
    "tweetnacl@0.14.5" = {
      pname = "tweetnacl";
      version = "0.14.5";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/tweetnacl/-/tweetnacl-0.14.5.tgz";
        sha256 = "1mnzrxlww1sqwv493gn6ph9ak7n8l9w5qrahsa5kzn4vgbb37skc";
      };
      pkgname = "tweetnacl";
    };
    "universalify@0.1.2" = {
      pname = "universalify";
      version = "0.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/universalify/-/universalify-0.1.2.tgz";
        sha256 = "0lykbpkmvjkjg0sqngrn086rxlyddgjkfnsi22r8hgixxzxb2alc";
      };
      pkgname = "universalify";
    };
    "uri-js@4.4.1" = {
      pname = "uri-js";
      version = "4.4.1";
      depKeys = [
        ("punycode@2.1.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/uri-js/-/uri-js-4.4.1.tgz";
        sha256 = "0bcdxkngap84iv7hpfa4r18i3a3allxfh6dmcqzafgg8mx9dw4jn";
      };
      pkgname = "uri-js";
    };
    "util-deprecate@1.0.2" = {
      pname = "util-deprecate";
      version = "1.0.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz";
        sha256 = "1rd3qbgdrwkmcrf7vqx61sh7icma7jvxcmklqj032f8v7jcdx8br";
      };
      pkgname = "util-deprecate";
    };
    "uuid@3.4.0" = {
      pname = "uuid";
      version = "3.4.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/uuid/-/uuid-3.4.0.tgz";
        sha256 = "1pgldpxvxyy2a9h437v0mflqxyc4w91b37iya2pcfd5wdlqcjxxs";
      };
      pkgname = "uuid";
    };
    "verror@1.10.0" = {
      pname = "verror";
      version = "1.10.0";
      depKeys = [
        ("assert-plus@1.0.0")
        ("core-util-is@1.0.2")
        ("extsprintf@1.4.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/verror/-/verror-1.10.0.tgz";
        sha256 = "0swyg46nvq95xlrrjjbhhmhjrdxg19yrc1aj69zipck0vi24b6q1";
      };
      pkgname = "verror";
    };
    "vscode-proxy-agent@0.5.2" = {
      pname = "vscode-proxy-agent";
      version = "0.5.2";
      depKeys = [
        ("debug@3.2.6")
        ("http-proxy-agent@2.1.0")
        ("https-proxy-agent@2.2.4")
        ("socks-proxy-agent@4.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/vscode-proxy-agent/-/vscode-proxy-agent-0.5.2.tgz";
        sha256 = "1xnr3qgddlhscxi4pkf02b9cnqgxmbv1skqz2p8asy81iiyaw08r";
      };
      pkgname = "vscode-proxy-agent";
    };
    "vscode-regexpp@3.1.0" = {
      pname = "vscode-regexpp";
      version = "3.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/vscode-regexpp/-/vscode-regexpp-3.1.0.tgz";
        sha256 = "0f7psrqw6xybz08vdnbndzqfa0iq2fzd5xzvzv574dwmcslpmvnk";
      };
      pkgname = "vscode-regexpp";
    };
    "which@2.0.2" = {
      pname = "which";
      version = "2.0.2";
      depKeys = [
        ("isexe@2.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/which/-/which-2.0.2.tgz";
        sha256 = "1p2fkm4lr36s85gdjxmyr6wh86dizf0iwmffxmarcxpbvmgxyfm1";
      };
      pkgname = "which";
    };
    "wide-align@1.1.3" = {
      pname = "wide-align";
      version = "1.1.3";
      depKeys = [
        ("string-width@2.1.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/wide-align/-/wide-align-1.1.3.tgz";
        sha256 = "1xdhvcq22hfnfll6fvc7j9brqhr45p4h2b3zw58df7925cdh99vx";
      };
      pkgname = "wide-align";
    };
    "wrappy@1.0.2" = {
      pname = "wrappy";
      version = "1.0.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha256 = "1yzx63jf27yz0bk0m78vy4y1cqzm113d2mi9h91y3cdpj46p7wxg";
      };
      pkgname = "wrappy";
    };
    "yallist@4.0.0" = {
      pname = "yallist";
      version = "4.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz";
        sha256 = "0jadz9mh1lzfk19bvqqlrg40ggfk2yyfyrpgj5c62dk54ym7h358";
      };
      pkgname = "yallist";
    };
    "yauzl@2.10.0" = {
      pname = "yauzl";
      version = "2.10.0";
      depKeys = [
        ("buffer-crc32@0.2.13")
        ("fd-slicer@1.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/yauzl/-/yauzl-2.10.0.tgz";
        sha256 = "1cbcq82bafcifhliglwjzp6b898qawrzng8315rh0r3vbn1k23sm";
      };
      pkgname = "yauzl";
    };
  };
}