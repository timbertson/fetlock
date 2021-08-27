final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "yarn";
    version = "1";
    root = "_virtual_root";
  };
  specs = {
    "@npmcli/move-file@1.1.2" = {
      pname = "npmcli-move-file";
      version = "1.1.2";
      depKeys = [
        ("mkdirp@1.0.4")
        ("rimraf@3.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@npmcli/move-file/-/move-file-1.1.2.tgz";
        sha256 = "0cp0p47drhfbi8xx8hc33kca930wfdia81p6wqfbmyxhn559rnn6";
      };
      pkgname = "@npmcli/move-file";
    };
    "@onivim/vscode-exthost@1.53.0" = {
      pname = "onivim-vscode-exthost";
      version = "1.53.0";
      depKeys = [
        ("graceful-fs@4.1.11")
        ("iconv-lite-umd@0.6.8")
        ("minimist@1.2.5")
        ("native-watchdog@1.3.0")
        ("node-pty@0.10.1")
        ("semver-umd@5.5.7")
        ("spdlog@0.11.1")
        ("vscode-proxy-agent@0.5.2")
        ("vscode-regexpp@3.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@onivim/vscode-exthost/-/vscode-exthost-1.53.0.tgz";
        sha256 = "1aff6f245pfdqfxw9j70bcf9a0ki1mpmy1bbgm9wh9s64f91f5b5";
      };
      pkgname = "@onivim/vscode-exthost";
    };
    "@tootallnate/once@1.1.2" = {
      pname = "tootallnate-once";
      version = "1.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@tootallnate/once/-/once-1.1.2.tgz";
        sha256 = "0b5fjhh1hq6hraacjch4dybc4blaf16l430w0mfsycnibm4g7r6p";
      };
      pkgname = "@tootallnate/once";
    };
    "@types/node@11.15.54" = {
      pname = "types-node";
      version = "11.15.54";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@types/node/-/node-11.15.54.tgz";
        sha256 = "1mbhbb6q5q9xd8ijgm35hcrw5kalkg0gakg8ry96qi5sxk0lpw78";
      };
      pkgname = "@types/node";
    };
    _virtual_root = {
      pname = "fetlock-virtual-root";
      version = "dev";
      depKeys = [
      ];
      pkgname = "virtual-root";
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
    "agentkeepalive@4.1.4" = {
      pname = "agentkeepalive";
      version = "4.1.4";
      depKeys = [
        ("debug@3.2.6")
        ("depd@1.1.2")
        ("humanize-ms@1.2.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/agentkeepalive/-/agentkeepalive-4.1.4.tgz";
        sha256 = "0918w95j5987jj3yblf2gwa2mjrwd25f4szh6b7j5vraiayq12aa";
      };
      pkgname = "agentkeepalive";
    };
    "aggregate-error@3.1.0" = {
      pname = "aggregate-error";
      version = "3.1.0";
      depKeys = [
        ("clean-stack@2.2.0")
        ("indent-string@4.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/aggregate-error/-/aggregate-error-3.1.0.tgz";
        sha256 = "0nr0ig4k5d5n019cjj4h4027316ppdjy8wnykv32b95bnnw0qdh3";
      };
      pkgname = "aggregate-error";
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
    "balanced-match@1.0.2" = {
      pname = "balanced-match";
      version = "1.0.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz";
        sha256 = "1hdwrr7qqb37plj7962xbwjx1jvjz7ahl7iqrwh82yhcvnmzfm6q";
      };
      pkgname = "balanced-match";
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
        ("balanced-match@1.0.2")
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
    "cacache@15.2.0" = {
      pname = "cacache";
      version = "15.2.0";
      depKeys = [
        ("@npmcli/move-file@1.1.2")
        ("chownr@2.0.0")
        ("fs-minipass@2.1.0")
        ("glob@7.1.7")
        ("infer-owner@1.0.4")
        ("lru-cache@6.0.0")
        ("minipass@3.1.3")
        ("minipass-collect@1.0.2")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("mkdirp@1.0.4")
        ("p-map@4.0.0")
        ("promise-inflight@1.0.1")
        ("rimraf@3.0.2")
        ("ssri@8.0.1")
        ("tar@6.1.0")
        ("unique-filename@1.1.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/cacache/-/cacache-15.2.0.tgz";
        sha256 = "1gihi04yzga61cg68zrbrcsclgn77i3szxyfis9hz2nkahf6z07i";
      };
      pkgname = "cacache";
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
    "clean-stack@2.2.0" = {
      pname = "clean-stack";
      version = "2.2.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/clean-stack/-/clean-stack-2.2.0.tgz";
        sha256 = "0manylf8kgqm9knb26lwxs7lfdf384r8hnxjwmhgzimq19k3fv05";
      };
      pkgname = "clean-stack";
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
    "depd@1.1.2" = {
      pname = "depd";
      version = "1.1.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/depd/-/depd-1.1.2.tgz";
        sha256 = "07645ghplj1qy8z6g3vz1855xjy2j217q90bib3m44c2npk6pql3";
      };
      pkgname = "depd";
    };
    "encoding@0.1.13" = {
      pname = "encoding";
      version = "0.1.13";
      depKeys = [
        ("iconv-lite@0.6.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/encoding/-/encoding-0.1.13.tgz";
        sha256 = "116gipr1y0hc9zvflsvd39psbbf2j62zvpnw099pqf7fl0nb5xbc";
      };
      pkgname = "encoding";
    };
    "env-paths@2.2.1" = {
      pname = "env-paths";
      version = "2.2.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/env-paths/-/env-paths-2.2.1.tgz";
        sha256 = "17knwv8glmap1vcgca11h1r48hyards94slc83y9z02q857qj2ss";
      };
      pkgname = "env-paths";
    };
    "err-code@2.0.3" = {
      pname = "err-code";
      version = "2.0.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/err-code/-/err-code-2.0.3.tgz";
        sha256 = "1qj8n8paszjn4w39wgd19885wp49hj98fd8hlp7isbqm0i54yrm5";
      };
      pkgname = "err-code";
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
    "follow-redirects@1.13.2" = {
      pname = "follow-redirects";
      version = "1.13.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/follow-redirects/-/follow-redirects-1.13.2.tgz";
        sha256 = "1qdlsxfzbkha1vp9f2lsxpgd47v9vm5p2032wl5q7vc0556qcay1";
      };
      pkgname = "follow-redirects";
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
    "glob@7.1.7" = {
      pname = "glob";
      version = "7.1.7";
      depKeys = [
        ("fs.realpath@1.0.0")
        ("inflight@1.0.6")
        ("inherits@2.0.4")
        ("minimatch@3.0.4")
        ("once@1.4.0")
        ("path-is-absolute@1.0.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.7.tgz";
        sha256 = "1vlv5r0ipznrq1c7ikqpbzgk7q31zz6m1wcy9cxsklb8vvfv6105";
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
    "http-cache-semantics@4.1.0" = {
      pname = "http-cache-semantics";
      version = "4.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/http-cache-semantics/-/http-cache-semantics-4.1.0.tgz";
        sha256 = "1j18fxbpdb6f43w7ndmqlmf7r0l9wv2m837mvvqi3y122xig0c0g";
      };
      pkgname = "http-cache-semantics";
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
    "http-proxy-agent@4.0.1" = {
      pname = "http-proxy-agent";
      version = "4.0.1";
      depKeys = [
        ("@tootallnate/once@1.1.2")
        ("agent-base@4.3.0")
        ("debug@3.2.6")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/http-proxy-agent/-/http-proxy-agent-4.0.1.tgz";
        sha256 = "0xa8vidkb3w7876sl6h149mg95dbx21phm9s1d21122ixaxpy50w";
      };
      pkgname = "http-proxy-agent";
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
    "https-proxy-agent@5.0.0" = {
      pname = "https-proxy-agent";
      version = "5.0.0";
      depKeys = [
        ("agent-base@4.3.0")
        ("debug@3.2.6")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/https-proxy-agent/-/https-proxy-agent-5.0.0.tgz";
        sha256 = "1a7mbscj5g23bcprp7psn5f82dhqz09sdris931dwkazq8gfparq";
      };
      pkgname = "https-proxy-agent";
    };
    "humanize-ms@1.2.1" = {
      pname = "humanize-ms";
      version = "1.2.1";
      depKeys = [
        ("ms@2.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/humanize-ms/-/humanize-ms-1.2.1.tgz";
        sha256 = "09sy84kkmvq1la85iws84w2jv1phdsf5jswg7mk7qjbr47dyc3sl";
      };
      pkgname = "humanize-ms";
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
    "iconv-lite@0.6.3" = {
      pname = "iconv-lite";
      version = "0.6.3";
      depKeys = [
        ("safer-buffer@2.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.6.3.tgz";
        sha256 = "1x681ziwavjjn09j4858fl3h3xi90vf512k5zwg06kwriwafq9vi";
      };
      pkgname = "iconv-lite";
    };
    "imurmurhash@0.1.4" = {
      pname = "imurmurhash";
      version = "0.1.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/imurmurhash/-/imurmurhash-0.1.4.tgz";
        sha256 = "0q6bf91h2g5dhvcdss74sjvp5irimd97hp73jb8p2wvajqqs08xc";
      };
      pkgname = "imurmurhash";
    };
    "indent-string@4.0.0" = {
      pname = "indent-string";
      version = "4.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/indent-string/-/indent-string-4.0.0.tgz";
        sha256 = "1822k378f65ipx6v9i132bywcnfjzk3rgilhnp443csfsz9p8sxw";
      };
      pkgname = "indent-string";
    };
    "infer-owner@1.0.4" = {
      pname = "infer-owner";
      version = "1.0.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/infer-owner/-/infer-owner-1.0.4.tgz";
        sha256 = "0rc7is18a3558rkjkwc48a750f6zr44sgnpdzvpmgk8xhl2plyz5";
      };
      pkgname = "infer-owner";
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
    "is-lambda@1.0.1" = {
      pname = "is-lambda";
      version = "1.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/is-lambda/-/is-lambda-1.0.1.tgz";
        sha256 = "0hfdf0cspr2gkqgdiry39ykddh62y6hglzsxsmq3q0y4kw7in54l";
      };
      pkgname = "is-lambda";
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
    "make-fetch-happen@8.0.14" = {
      pname = "make-fetch-happen";
      version = "8.0.14";
      depKeys = [
        ("agentkeepalive@4.1.4")
        ("cacache@15.2.0")
        ("http-cache-semantics@4.1.0")
        ("http-proxy-agent@4.0.1")
        ("https-proxy-agent@5.0.0")
        ("is-lambda@1.0.1")
        ("lru-cache@6.0.0")
        ("minipass@3.1.3")
        ("minipass-collect@1.0.2")
        ("minipass-fetch@1.3.3")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("promise-retry@2.0.1")
        ("socks-proxy-agent@5.0.0")
        ("ssri@8.0.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/make-fetch-happen/-/make-fetch-happen-8.0.14.tgz";
        sha256 = "1sismcyzah1hgv5zq8mbjsglcdqx9v5vciycggkj3rayqznisnzp";
      };
      pkgname = "make-fetch-happen";
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
    "minipass-collect@1.0.2" = {
      pname = "minipass-collect";
      version = "1.0.2";
      depKeys = [
        ("minipass@3.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minipass-collect/-/minipass-collect-1.0.2.tgz";
        sha256 = "1m50q2isnw0xr4hyb3v38pxrgzl0zsy4lj3nldydcyx2l1d6bbx5";
      };
      pkgname = "minipass-collect";
    };
    "minipass-fetch@1.3.3" = {
      pname = "minipass-fetch";
      version = "1.3.3";
      depKeys = [
        ("encoding@0.1.13")
        ("minipass@3.1.3")
        ("minipass-sized@1.0.3")
        ("minizlib@2.1.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minipass-fetch/-/minipass-fetch-1.3.3.tgz";
        sha256 = "11nqipj469xri6dkrq7i75ph04md57yhb9szdgand69azvnqh94m";
      };
      pkgname = "minipass-fetch";
    };
    "minipass-flush@1.0.5" = {
      pname = "minipass-flush";
      version = "1.0.5";
      depKeys = [
        ("minipass@3.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minipass-flush/-/minipass-flush-1.0.5.tgz";
        sha256 = "1rh40nh1wan1h01iszhi6bpjd7vr4b4phi9d39krqlzvym689psj";
      };
      pkgname = "minipass-flush";
    };
    "minipass-pipeline@1.2.4" = {
      pname = "minipass-pipeline";
      version = "1.2.4";
      depKeys = [
        ("minipass@3.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minipass-pipeline/-/minipass-pipeline-1.2.4.tgz";
        sha256 = "13q7asqh62g3cdypm8rgvyq72crns331a9hqg6w92qzx68wg4r0b";
      };
      pkgname = "minipass-pipeline";
    };
    "minipass-sized@1.0.3" = {
      pname = "minipass-sized";
      version = "1.0.3";
      depKeys = [
        ("minipass@3.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/minipass-sized/-/minipass-sized-1.0.3.tgz";
        sha256 = "1d9h3h6pnyr09381zyax0jr0k0wmx75qrfqdzbirrmhmcp5xiqjw";
      };
      pkgname = "minipass-sized";
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
        ("node-gyp@8.1.0")
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
        ("node-gyp@8.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/native-watchdog/-/native-watchdog-1.3.0.tgz";
        sha256 = "11jnapq0i8xdjldcwylrb17addgl2m1ilql3rjkfsj0zjk14n1vj";
      };
      pkgname = "native-watchdog";
    };
    "node-gyp@8.1.0" = {
      pname = "node-gyp";
      version = "8.1.0";
      depKeys = [
        ("env-paths@2.2.1")
        ("glob@7.1.7")
        ("graceful-fs@4.1.11")
        ("make-fetch-happen@8.0.14")
        ("nopt@5.0.0")
        ("npmlog@4.1.2")
        ("rimraf@3.0.2")
        ("semver@7.3.5")
        ("tar@6.1.0")
        ("which@2.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/node-gyp/-/node-gyp-8.1.0.tgz";
        sha256 = "0204khp5xzvdpmaa6gwawxdbkwjlkjy6rlr71807r8h7irw6xs43";
      };
      pkgname = "node-gyp";
    };
    "node-pty@0.10.1" = {
      pname = "node-pty";
      version = "0.10.1";
      depKeys = [
        ("nan@2.14.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/node-pty/-/node-pty-0.10.1.tgz";
        sha256 = "0ybzs3c56vbi3c1bh6yi9pijbj6ni2zj31z665mi198jz2cj33bx";
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
        ("@onivim/vscode-exthost@1.53.0")
        ("@types/node@11.15.54")
        ("follow-redirects@1.13.2")
        ("fs-extra@8.1.0")
        ("node-gyp@8.1.0")
        ("sudo-prompt@9.2.1")
        ("typescript@3.9.9")
        ("yauzl@2.10.0")
      ];
      pkgname = "onivim2-node";
    };
    "p-map@4.0.0" = {
      pname = "p-map";
      version = "4.0.0";
      depKeys = [
        ("aggregate-error@3.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/p-map/-/p-map-4.0.0.tgz";
        sha256 = "147z64sp0ifrix961cr3f6sw2fs2wqx225d24mdbgvn3c5sj6c51";
      };
      pkgname = "p-map";
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
    "promise-inflight@1.0.1" = {
      pname = "promise-inflight";
      version = "1.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/promise-inflight/-/promise-inflight-1.0.1.tgz";
        sha256 = "02ibq6bvxhmyx3lh4bz1ikrlb5n728nj0gshgf5bgqxjpijkphwl";
      };
      pkgname = "promise-inflight";
    };
    "promise-retry@2.0.1" = {
      pname = "promise-retry";
      version = "2.0.1";
      depKeys = [
        ("err-code@2.0.3")
        ("retry@0.12.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/promise-retry/-/promise-retry-2.0.1.tgz";
        sha256 = "1k2mdc2jbw2h3ykxcgvh2wv20gdb6m1siacllr7dy2x4rlk3g5jq";
      };
      pkgname = "promise-retry";
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
    "retry@0.12.0" = {
      pname = "retry";
      version = "0.12.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/retry/-/retry-0.12.0.tgz";
        sha256 = "0a5l61f1aqn124j25m2q6m0j60mv7d9h74a8gfqnmp5ajz8wcqfz";
      };
      pkgname = "retry";
    };
    "rimraf@3.0.2" = {
      pname = "rimraf";
      version = "3.0.2";
      depKeys = [
        ("glob@7.1.7")
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
    "semver@7.3.5" = {
      pname = "semver";
      version = "7.3.5";
      depKeys = [
        ("lru-cache@6.0.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-7.3.5.tgz";
        sha256 = "17jrlrwq1fm80pl54lmra4zpj8crr3y7kj031fhq02g274j807xg";
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
    "socks-proxy-agent@5.0.0" = {
      pname = "socks-proxy-agent";
      version = "5.0.0";
      depKeys = [
        ("agent-base@4.3.0")
        ("debug@3.2.6")
        ("socks@2.6.1")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/socks-proxy-agent/-/socks-proxy-agent-5.0.0.tgz";
        sha256 = "0l4j8z7c2bz6mgxnp8jiiyqgvhg7agl3pqk980rynrsws6867b5z";
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
    "socks@2.6.1" = {
      pname = "socks";
      version = "2.6.1";
      depKeys = [
        ("ip@1.1.5")
        ("smart-buffer@4.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/socks/-/socks-2.6.1.tgz";
        sha256 = "02ffxfykmdjcp2hs0p83gvybb8c07l8pp19lpmrgmh6h6jm2xii5";
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
        ("node-gyp@8.1.0")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/spdlog/-/spdlog-0.11.1.tgz";
        sha256 = "1cpaaxvwwwhlq4rcjdd9pmp1l330xlv4qrij28vbbmvyhvf70mck";
      };
      pkgname = "spdlog";
    };
    "ssri@8.0.1" = {
      pname = "ssri";
      version = "8.0.1";
      depKeys = [
        ("minipass@3.1.3")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/ssri/-/ssri-8.0.1.tgz";
        sha256 = "1bibhxd1mhhvvrq80281fv6rwir5p7zkhwwga01gwf1x3kp6zia9";
      };
      pkgname = "ssri";
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
    "typescript@3.9.9" = {
      pname = "typescript";
      version = "3.9.9";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/typescript/-/typescript-3.9.9.tgz";
        sha256 = "0jbb1rz83lpm18jqqn7ijp3nscdaivp7x0pyfhp8604assd5ig6g";
      };
      pkgname = "typescript";
    };
    "typescript@typescript@npm%3A3.9.9#builtin<compat/typescript>::version=3.9.9&hash=a45b0e" = {
      pname = "typescript";
      version = "3.9.9";
      depKeys = [
      ];
      pkgname = "typescript";
    };
    "unique-filename@1.1.1" = {
      pname = "unique-filename";
      version = "1.1.1";
      depKeys = [
        ("unique-slug@2.0.2")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/unique-filename/-/unique-filename-1.1.1.tgz";
        sha256 = "1dcfh15m1cjiqm4fapjws8inzydklx3jhbaflma2qcx7s9ax14av";
      };
      pkgname = "unique-filename";
    };
    "unique-slug@2.0.2" = {
      pname = "unique-slug";
      version = "2.0.2";
      depKeys = [
        ("imurmurhash@0.1.4")
      ];
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/unique-slug/-/unique-slug-2.0.2.tgz";
        sha256 = "1z85ywz4zz0g8b8l2mkcn70yli30w7zj424hlikdymxb5k6ifvxl";
      };
      pkgname = "unique-slug";
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