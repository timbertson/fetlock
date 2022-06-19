final:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "yarn";
    version = "1";
    root = "onivim2-node@.";
  };
  specs = {
    "@gar/promisify@1.1.2" = {
      pname = "gar-promisify";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-82cpyJyKRoQoRi+14ibCeGPu0CwypgtBAdBhq1WfvagpCZNKqwXbKwXllYSMG91DhmG4jt9gN8eP6lGOtozuaw==";
        url = "https://registry.npmjs.org/@gar/promisify/-/promisify-1.1.2.tgz";
      });
      pkgname = "@gar/promisify";
    };
    "@npmcli/fs@1.0.0" = {
      pname = "npmcli-fs";
      version = "1.0.0";
      depKeys = [
        ("@gar/promisify@1.1.2")
        ("semver@7.3.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-8ltnOpRR/oJbOp8vaGUnipOi3bqkcW+sLHFlyXIr08OGHmVJLB1Hn7QtGXbYcpVtH1gAYZTlmDXtE4YV0+AMMQ==";
        url = "https://registry.npmjs.org/@npmcli/fs/-/fs-1.0.0.tgz";
      });
      pkgname = "@npmcli/fs";
    };
    "@npmcli/move-file@1.1.2" = {
      pname = "npmcli-move-file";
      version = "1.1.2";
      depKeys = [
        ("mkdirp@1.0.4")
        ("rimraf@3.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-1SUf/Cg2GzGDyaf15aR9St9TWlb+XvbZXWpDx8YKs7MLzMH/BCeopv+y9vzrzgkfykCGuWOlSu3mZhj2+FQcrg==";
        url = "https://registry.npmjs.org/@npmcli/move-file/-/move-file-1.1.2.tgz";
      });
      pkgname = "@npmcli/move-file";
    };
    "@onivim/request-light@0.4.1" = {
      pname = "onivim-request-light";
      version = "0.4.1";
      depKeys = [
        ("http-proxy-agent@4.0.1")
        ("https-proxy-agent@5.0.0")
        ("vscode-nls@4.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-C3gamHhT0aPZWpHK/7bVCgFa0RhkuRGZrM4Bl3yTdtaZd4kbjIVOmPiOz6hgNpqZm0YwSXv1+q8LhDuZF9+oXg==";
        url = "https://registry.npmjs.org/@onivim/request-light/-/request-light-0.4.1.tgz";
      });
      pkgname = "@onivim/request-light";
    };
    "@onivim/vscode-exthost@1.58.2001" = {
      pname = "onivim-vscode-exthost";
      version = "1.58.2001";
      depKeys = [
        ("graceful-fs@4.2.4")
        ("iconv-lite-umd@0.6.8")
        ("minimist@1.2.5")
        ("native-watchdog@1.3.0")
        ("node-pty@0.11.0-beta5")
        ("spdlog@0.13.6")
        ("vscode-proxy-agent@0.11.0")
        ("vscode-regexpp@3.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-vCuy7qWdoriMSKSXiRexBiSfUqPuvMKeSe3fh10jH12JN6m8qzMO9E3SFg3YpBrfjrR2qzBoMcT+V2RtWHUJdw==";
        url = "https://registry.npmjs.org/@onivim/vscode-exthost/-/vscode-exthost-1.58.2001.tgz";
      });
      pkgname = "@onivim/vscode-exthost";
    };
    "@tootallnate/once@1.1.2" = {
      pname = "tootallnate-once";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-RbzJvlNzmRq5c3O09UipeuXno4tA1FE6ikOjxZK0tuxVv3412l64l5t1W5pj4+rJq9vpkm/kwiR07aZXnsKPxw==";
        url = "https://registry.npmjs.org/@tootallnate/once/-/once-1.1.2.tgz";
      });
      pkgname = "@tootallnate/once";
    };
    "@types/node@11.15.54" = {
      pname = "types-node";
      version = "11.15.54";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-1RWYiq+5UfozGsU6MwJyFX6BtktcT10XRjvcAQmskCtMcW3tPske88lM/nHv7BQG1w9KBXI1zPGuu5PnNCX14g==";
        url = "https://registry.npmjs.org/@types/node/-/node-11.15.54.tgz";
      });
      pkgname = "@types/node";
    };
    "abbrev@1.1.1" = {
      pname = "abbrev";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-nne9/IiQ/hzIhY6pdDnbBtz7DjPTKrY00P/zvPSm5pOFkl6xuGrGnXn/VtTNNfNtAfZ9/1RtehkszU9qcTii0Q==";
        url = "https://registry.npmjs.org/abbrev/-/abbrev-1.1.1.tgz";
      });
      pkgname = "abbrev";
    };
    "agent-base@6.0.2" = {
      pname = "agent-base";
      version = "6.0.2";
      depKeys = [
        ("debug@3.2.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-RZNwNclF7+MS/8bDg70amg32dyeZGZxiDuQmZxKLAlQjr3jGyLx+4Kkk58UO7D2QdgFIQCovuSuZESne6RG6XQ==";
        url = "https://registry.npmjs.org/agent-base/-/agent-base-6.0.2.tgz";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha512-+V/rGa3EuU74H6wR04plBb7Ks10FbtUQgRj/FQOG7uUIEuaINI+AiqJR1k6t3SVNs7o7ZjIdus6706qqzVq8jQ==";
        url = "https://registry.npmjs.org/agentkeepalive/-/agentkeepalive-4.1.4.tgz";
      });
      pkgname = "agentkeepalive";
    };
    "aggregate-error@3.1.0" = {
      pname = "aggregate-error";
      version = "3.1.0";
      depKeys = [
        ("clean-stack@2.2.0")
        ("indent-string@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-4I7Td01quW/RpocfNayFdFVk1qSuoh0E7JrbRJ16nH01HhKFQ88INq9Sd+nd72zqRySlr9BmDA8xlEJ6vJMrYA==";
        url = "https://registry.npmjs.org/aggregate-error/-/aggregate-error-3.1.0.tgz";
      });
      pkgname = "aggregate-error";
    };
    "ansi-regex@5.0.1" = {
      pname = "ansi-regex";
      version = "5.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-quJQXlTSUGL2LH9SUXo8VwsY4soanhgo6LNSm84E1LBcE8s3O0wpdiRzyR9z/ZZJMlMWv37qOOb9pdJlMUEKFQ==";
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-5.0.1.tgz";
      });
      pkgname = "ansi-regex";
    };
    "aproba@2.0.0" = {
      pname = "aproba";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-lYe4Gx7QT+MKGbDsA+Z+he/Wtef0BiwDOlK/XkBrdfsh9J/jPPXbX0tE9x9cl27Tmu5gg3QUbUrQYa/y+KOHPQ==";
        url = "https://registry.npmjs.org/aproba/-/aproba-2.0.0.tgz";
      });
      pkgname = "aproba";
    };
    "are-we-there-yet@2.0.0" = {
      pname = "are-we-there-yet";
      version = "2.0.0";
      depKeys = [
        ("delegates@1.0.0")
        ("readable-stream@3.6.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Ci/qENmwHnsYo9xKIcUJN5LeDKdJ6R1Z1j9V/J5wyq8nh/mYPEpIKJbBZXtZjG04HiK7zV/p6Vs9952MrMeUIw==";
        url = "https://registry.npmjs.org/are-we-there-yet/-/are-we-there-yet-2.0.0.tgz";
      });
      pkgname = "are-we-there-yet";
    };
    "balanced-match@1.0.2" = {
      pname = "balanced-match";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-3oSeUO0TMV67hN1AmbXsK4yaqU7tjiHlbxRDZOpH0KW9+CeX4bRAaX0Anxt0tx2MrpRpWwQaPwIlISEJhYU5Pw==";
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz";
      });
      pkgname = "balanced-match";
    };
    "bindings@1.5.0" = {
      pname = "bindings";
      version = "1.5.0";
      depKeys = [
        ("file-uri-to-path@2.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-p2q/t/mhvuOj/UeLlV6566GD/guowlr0hHxClI0W9m7MWYkL1F0hLo+0Aexs9HSPCtR1SXQ0TD3MMKrXZajbiQ==";
        url = "https://registry.npmjs.org/bindings/-/bindings-1.5.0.tgz";
      });
      pkgname = "bindings";
    };
    "brace-expansion@1.1.11" = {
      pname = "brace-expansion";
      version = "1.1.11";
      depKeys = [
        ("balanced-match@1.0.2")
        ("concat-map@0.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-iCuPHDFgrHX7H2vEI/5xpz07zSHB00TpugqhmYtVmMO6518mCuRMoOYFldEBl0g187ufozdaHgWKcYFb61qGiA==";
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
      });
      pkgname = "brace-expansion";
    };
    "buffer-crc32@0.2.13" = {
      pname = "buffer-crc32";
      version = "0.2.13";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-VO9Ht/+p3SN7SKWqcrgEzjGbRSJYTx+Q1pTQC0wrWqHx0vpJraQ6GtHx8tvcg1rlK1byhU5gccxgOgj7B0TDkQ==";
        url = "https://registry.npmjs.org/buffer-crc32/-/buffer-crc32-0.2.13.tgz";
      });
      pkgname = "buffer-crc32";
    };
    "cacache@15.3.0" = {
      pname = "cacache";
      version = "15.3.0";
      depKeys = [
        ("@npmcli/fs@1.0.0")
        ("@npmcli/move-file@1.1.2")
        ("chownr@2.0.0")
        ("fs-minipass@2.1.0")
        ("glob@7.2.0")
        ("infer-owner@1.0.4")
        ("lru-cache@6.0.0")
        ("minipass@3.1.6")
        ("minipass-collect@1.0.2")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("mkdirp@1.0.4")
        ("p-map@4.0.0")
        ("promise-inflight@1.0.1")
        ("rimraf@3.0.2")
        ("ssri@8.0.1")
        ("tar@6.1.11")
        ("unique-filename@1.1.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-VVdYzXEn+cnbXpFgWs5hTT7OScegHVmLhJIR8Ufqk3iFD6A6j5iSX1KuBTfNEv4tdJWE2PzA6IVFtcLC7fN9wQ==";
        url = "https://registry.npmjs.org/cacache/-/cacache-15.3.0.tgz";
      });
      pkgname = "cacache";
    };
    "chownr@2.0.0" = {
      pname = "chownr";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-bIomtDF5KGpdogkLd9VspvFzk9KfpyyGlS8YFVZl7TGPBHL5snIOnxeshwVgPteQ9b4Eydl+pVbIyE1DcvCWgQ==";
        url = "https://registry.npmjs.org/chownr/-/chownr-2.0.0.tgz";
      });
      pkgname = "chownr";
    };
    "clean-stack@2.2.0" = {
      pname = "clean-stack";
      version = "2.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-4diC9HaTE+KRAMWhDhrGOECgWZxoevMc5TlkObMqNSsVU62PYzXZ/SMTjzyGAFF1YusgxGcSWTEXBhp0CPwQ1A==";
        url = "https://registry.npmjs.org/clean-stack/-/clean-stack-2.2.0.tgz";
      });
      pkgname = "clean-stack";
    };
    "color-support@1.1.3" = {
      pname = "color-support";
      version = "1.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-qiBjkpbMLO/HL68y+lh4q0/O1MZFj2RX6X/KmMa3+gJD3z+WwI1ZzDHysvqHGS3mP6mznPckpXmw1nI9cJjyRg==";
        url = "https://registry.npmjs.org/color-support/-/color-support-1.1.3.tgz";
      });
      pkgname = "color-support";
    };
    "concat-map@0.0.1" = {
      pname = "concat-map";
      version = "0.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-/Srv4dswyQNBfohGpz9o6Yb3Gz3SrUDqBH5rTuhGR7ahtlbYKnVxw2bCFMRljaA7EXHaXZ8wsHdodFvbkhKmqg==";
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
      });
      pkgname = "concat-map";
    };
    "console-control-strings@1.1.0" = {
      pname = "console-control-strings";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-ty/fTekppD2fIwRvnZAVdeOiGd1c7YXEixbgJTNzqcxJWKQnjJ/V1bNEEE6hygpM3WjwHFUVK6HTjWSzV4a8sQ==";
        url = "https://registry.npmjs.org/console-control-strings/-/console-control-strings-1.1.0.tgz";
      });
      pkgname = "console-control-strings";
    };
    "core-util-is@1.0.2" = {
      pname = "core-util-is";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-3lqz5YjWTYnW6dlDa5TLaTCcShfar1e40rmcJVwCBJC6mWlFuj0eCHIElmG1g5kyuJ/GD+8Wn4FFCcz4gJPfaQ==";
        url = "https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.2.tgz";
      });
      pkgname = "core-util-is";
    };
    "data-uri-to-buffer@3.0.1" = {
      pname = "data-uri-to-buffer";
      version = "3.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-WboRycPNsVw3B3TL559F7kuBUM4d8CgMEvk6xEJlOp7OBPjt6G7z8WMWlD2rOFZLk6OYfFIUGsCOWzcQH9K2og==";
        url = "https://registry.npmjs.org/data-uri-to-buffer/-/data-uri-to-buffer-3.0.1.tgz";
      });
      pkgname = "data-uri-to-buffer";
    };
    "debug@3.2.6" = {
      pname = "debug";
      version = "3.2.6";
      depKeys = [
        ("ms@2.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-mel+jf7nrtEl5Pn1Qx46zARXKDpBbvzezse7p7LqINmdoIk8PYP5SySaxEmYv6TZ0JyEKA1hsCId6DIhgITtWQ==";
        url = "https://registry.npmjs.org/debug/-/debug-3.2.6.tgz";
      });
      pkgname = "debug";
    };
    "delegates@1.0.0" = {
      pname = "delegates";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-bd2L678uiWATM6m5Z1VzNCErI3jiGzt6HGY8OVICs40JQq/HALfbyNJmp0UDakEY4pMMaN0Ly5om/B1VI/+xfQ==";
        url = "https://registry.npmjs.org/delegates/-/delegates-1.0.0.tgz";
      });
      pkgname = "delegates";
    };
    "depd@1.1.2" = {
      pname = "depd";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-7emPTl6Dpo6JRXOXjLRxck+FlLRX5847cLKEn00PLAgc3g2hTZZgr+e4c2v6QpSmLeFP3n5yUo7ft6avBK/5jQ==";
        url = "https://registry.npmjs.org/depd/-/depd-1.1.2.tgz";
      });
      pkgname = "depd";
    };
    "emoji-regex@8.0.0" = {
      pname = "emoji-regex";
      version = "8.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-MSjYzcWNOA0ewAHpz0MxpYFvwg6yjy1NG3xteoqz644VCo/RPgnr1/GGt+ic3iJTzQ8Eu3TdM14SawnVUmGE6A==";
        url = "https://registry.npmjs.org/emoji-regex/-/emoji-regex-8.0.0.tgz";
      });
      pkgname = "emoji-regex";
    };
    "encoding@0.1.13" = {
      pname = "encoding";
      version = "0.1.13";
      depKeys = [
        ("iconv-lite@0.6.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-ETBauow1T35Y/WZMkio9jiM0Z5xjHHmJ4XmjZOq1l/dXz3lr2sRn87nJy20RupqSh1F2m3HHPSp8ShIPQJrJ3A==";
        url = "https://registry.npmjs.org/encoding/-/encoding-0.1.13.tgz";
      });
      pkgname = "encoding";
    };
    "env-paths@2.2.1" = {
      pname = "env-paths";
      version = "2.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-+h1lkLKhZMTYjog1VEpJNG7NZJWcuc2DDk/qsqSTRRCOXiLjeQ1d1/udrUGhqMxUgAlwKNZ0cf2uqan5GLuS2A==";
        url = "https://registry.npmjs.org/env-paths/-/env-paths-2.2.1.tgz";
      });
      pkgname = "env-paths";
    };
    "err-code@2.0.3" = {
      pname = "err-code";
      version = "2.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-2bmlRpNKBxT/CRmPOlyISQpNj+qSeYvcym/uT0Jx2bMOlKLtSy1ZmLuVxSEKKyor/N5yhvp/ZiG1oE3DEYMSFA==";
        url = "https://registry.npmjs.org/err-code/-/err-code-2.0.3.tgz";
      });
      pkgname = "err-code";
    };
    "fd-slicer@1.1.0" = {
      pname = "fd-slicer";
      version = "1.1.0";
      depKeys = [
        ("pend@1.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-cE1qsB/VwyQozZ+q1dGxR8LBYNZeofhEdUNGSMbQD3Gw2lAzX9Zb3uIU6Ebc/Fmyjo9AWWfnn0AUCHqtevs/8g==";
        url = "https://registry.npmjs.org/fd-slicer/-/fd-slicer-1.1.0.tgz";
      });
      pkgname = "fd-slicer";
    };
    "file-uri-to-path@2.0.0" = {
      pname = "file-uri-to-path";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-hjPFI8oE/2iQPVe4gbrJ73Pp+Xfub2+WI2LlXDbsaJBwT5wuMh35WNWVYYTpnz895shtwfyutMFLFywpQAFdLg==";
        url = "https://registry.npmjs.org/file-uri-to-path/-/file-uri-to-path-2.0.0.tgz";
      });
      pkgname = "file-uri-to-path";
    };
    "fs-extra@8.1.0" = {
      pname = "fs-extra";
      version = "8.1.0";
      depKeys = [
        ("graceful-fs@4.2.4")
        ("jsonfile@4.0.0")
        ("universalify@0.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-yhlQgA6mnOJUKOsRUFsgJdQCvkKhcz8tlZG5HBQfReYZy46OwLcY+Zia0mtdHsOo9y/hP+CxMN0TU9QxoOtG4g==";
        url = "https://registry.npmjs.org/fs-extra/-/fs-extra-8.1.0.tgz";
      });
      pkgname = "fs-extra";
    };
    "fs-minipass@2.1.0" = {
      pname = "fs-minipass";
      version = "2.1.0";
      depKeys = [
        ("minipass@3.1.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-V/JgOLFCS+R6Vcq0slCuaeWEdNC3ouDlJMNIsacH2VtALiu9mV4LPrHc5cDl8k5aw6J8jwgWWpiTo5RYhmIzvg==";
        url = "https://registry.npmjs.org/fs-minipass/-/fs-minipass-2.1.0.tgz";
      });
      pkgname = "fs-minipass";
    };
    "fs.realpath@1.0.0" = {
      pname = "fs.realpath";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-OO0pH2lK6a0hZnAdau5ItzHPI6pUlvI7jMVnxUQRtw4owF2wk8lOSabtGDCTP4Ggrg2MbGnWO9X8K1t4+fGMDw==";
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
      });
      pkgname = "fs.realpath";
    };
    "ftp@0.3.10" = {
      pname = "ftp";
      version = "0.3.10";
      depKeys = [
        ("readable-stream@1.1.14")
        ("xregexp@2.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-faFVML1aBx2UoDStmLwv2Wptt4vw5x03xxX172nhA5Y5HBshW5JweqQ2W4xL4dezQTG8inJsuYcpPHHU3X5OTQ==";
        url = "https://registry.npmjs.org/ftp/-/ftp-0.3.10.tgz";
      });
      pkgname = "ftp";
    };
    "gauge@4.0.0" = {
      pname = "gauge";
      version = "4.0.0";
      depKeys = [
        ("ansi-regex@5.0.1")
        ("aproba@2.0.0")
        ("color-support@1.1.3")
        ("console-control-strings@1.1.0")
        ("has-unicode@2.0.1")
        ("signal-exit@3.0.6")
        ("string-width@4.2.3")
        ("strip-ansi@6.0.1")
        ("wide-align@1.1.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-F8sU45yQpjQjxKkm1UOAhf0U/O0aFt//Fl7hsrNVto+patMHjs7dPI9mFOGUKbhrgKm0S3EjW3scMFuQmWSROw==";
        url = "https://registry.npmjs.org/gauge/-/gauge-4.0.0.tgz";
      });
      pkgname = "gauge";
    };
    "get-uri@3.0.2" = {
      pname = "get-uri";
      version = "3.0.2";
      depKeys = [
        ("@tootallnate/once@1.1.2")
        ("data-uri-to-buffer@3.0.1")
        ("debug@3.2.6")
        ("file-uri-to-path@2.0.0")
        ("fs-extra@8.1.0")
        ("ftp@0.3.10")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-+5s0SJbGoyiJTZZ2JTpFPLMPSch72KEqGOTvQsBqg0RBWvwhWUSYZFAtz3TPW0GXJuLBJPts1E241iHg+VRfhg==";
        url = "https://registry.npmjs.org/get-uri/-/get-uri-3.0.2.tgz";
      });
      pkgname = "get-uri";
    };
    "glob@7.2.0" = {
      pname = "glob";
      version = "7.2.0";
      depKeys = [
        ("fs.realpath@1.0.0")
        ("inflight@1.0.6")
        ("inherits@2.0.4")
        ("minimatch@3.0.4")
        ("once@1.4.0")
        ("path-is-absolute@1.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-lmLf6gtyrPq8tTjSmrO94wBeQbFR3HbLHbuyD69wuyQkImp2hWqMGB47OX65FBkPffO641IP9jWa1z4ivqG26Q==";
        url = "https://registry.npmjs.org/glob/-/glob-7.2.0.tgz";
      });
      pkgname = "glob";
    };
    "graceful-fs@4.2.4" = {
      pname = "graceful-fs";
      version = "4.2.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-WjKPNJF79dtJAVniUlGGWHYGz2jWxT6VhN/4m1NdkbZ2nOsEF+cI1Edgql5zCRhs/VsQYRvrXctxktVXZUkixw==";
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.4.tgz";
      });
      pkgname = "graceful-fs";
    };
    "has-unicode@2.0.1" = {
      pname = "has-unicode";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-8Rf9Y83NBReMnx0gFzA8JImQACstCYWUplepDa9xprwwtmgEZUF0h/i5xSA625zB/I37EtrswSST6OXxwaaIJQ==";
        url = "https://registry.npmjs.org/has-unicode/-/has-unicode-2.0.1.tgz";
      });
      pkgname = "has-unicode";
    };
    "http-cache-semantics@4.1.0" = {
      pname = "http-cache-semantics";
      version = "4.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-carPklcUh7ROWRK7Cv27RPtdhYhUsela/ue5/jKzjegVvXDqM2ILE9Q2BGn9JZJh1g87cp56su/FgQSzcWS8cQ==";
        url = "https://registry.npmjs.org/http-cache-semantics/-/http-cache-semantics-4.1.0.tgz";
      });
      pkgname = "http-cache-semantics";
    };
    "http-proxy-agent@4.0.1" = {
      pname = "http-proxy-agent";
      version = "4.0.1";
      depKeys = [
        ("@tootallnate/once@1.1.2")
        ("agent-base@6.0.2")
        ("debug@3.2.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-k0zdNgqWTGA6aeIRVpvfVob4fL52dTfaehylg0Y4UvSySvOq/Y+BOyPrgpUrA7HylqvU8vIZGsRuXmspskV0Tg==";
        url = "https://registry.npmjs.org/http-proxy-agent/-/http-proxy-agent-4.0.1.tgz";
      });
      pkgname = "http-proxy-agent";
    };
    "https-proxy-agent@5.0.0" = {
      pname = "https-proxy-agent";
      version = "5.0.0";
      depKeys = [
        ("agent-base@6.0.2")
        ("debug@3.2.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-EkYm5BcKUGiduxzSt3Eppko+PiNWNEpa4ySk9vTC6wDsQJW9rHSa+UhGNJoRYp7bz6Ht1eaRIa6QaJqO5rCFbA==";
        url = "https://registry.npmjs.org/https-proxy-agent/-/https-proxy-agent-5.0.0.tgz";
      });
      pkgname = "https-proxy-agent";
    };
    "humanize-ms@1.2.1" = {
      pname = "humanize-ms";
      version = "1.2.1";
      depKeys = [
        ("ms@2.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Fl70vYtsAFb/C06PTS9dZBo7ihau+Tu/DNCk/OyHhea07S+aeMWpFFkUaXRa8fI+ScZbEI8dfSxwY7gxZ9SAVQ==";
        url = "https://registry.npmjs.org/humanize-ms/-/humanize-ms-1.2.1.tgz";
      });
      pkgname = "humanize-ms";
    };
    "iconv-lite-umd@0.6.8" = {
      pname = "iconv-lite-umd";
      version = "0.6.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-zvXJ5gSwMC9JD3wDzH8CoZGc1pbiJn12Tqjk8BXYCnYz3hYL5GRjHW8LEykjXhV9WgNGI4rgpgHcbIiBfrRq6A==";
        url = "https://registry.npmjs.org/iconv-lite-umd/-/iconv-lite-umd-0.6.8.tgz";
      });
      pkgname = "iconv-lite-umd";
    };
    "iconv-lite@0.6.3" = {
      pname = "iconv-lite";
      version = "0.6.3";
      depKeys = [
        ("safer-buffer@2.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-4fCk79wshMdzMp2rH06qWrJE4iolqLhCUH+OiuIgU++RB0+94NlDL81atO7GX55uUKueo0txHNtvEyI6D7WdMw==";
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.6.3.tgz";
      });
      pkgname = "iconv-lite";
    };
    "imurmurhash@0.1.4" = {
      pname = "imurmurhash";
      version = "0.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-JmXMZ6wuvDmLiHEml9ykzqO6lwFbof0GG4IkcGaENdCRDDmMVnny7s5HsIgHCbaq0w2MyPhDqkhTUgS2LU2PHA==";
        url = "https://registry.npmjs.org/imurmurhash/-/imurmurhash-0.1.4.tgz";
      });
      pkgname = "imurmurhash";
    };
    "indent-string@4.0.0" = {
      pname = "indent-string";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-EdDDZu4A2OyIK7Lr/2zG+w5jmbuk1DVBnEwREQvBzspBJkCEbRa8GxU1lghYcaGJCnRWibjDXlq779X1/y5xwg==";
        url = "https://registry.npmjs.org/indent-string/-/indent-string-4.0.0.tgz";
      });
      pkgname = "indent-string";
    };
    "infer-owner@1.0.4" = {
      pname = "infer-owner";
      version = "1.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-IClj+Xz94+d7irH5qRyfJonOdfTzuDaifE6ZPWfx0N0+/ATZCbuTPq2prFl526urkQd90WyUKIh1DfBQ2hMz9A==";
        url = "https://registry.npmjs.org/infer-owner/-/infer-owner-1.0.4.tgz";
      });
      pkgname = "infer-owner";
    };
    "inflight@1.0.6" = {
      pname = "inflight";
      version = "1.0.6";
      depKeys = [
        ("once@1.4.0")
        ("wrappy@1.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-k92I/b08q4wvFscXCLvqfsHCrjrF7yiXsQuIVvVE7N82W3+aqpzuUdBbfhWcy/FZR3/4IgflMgKLOsvPDrGCJA==";
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
      });
      pkgname = "inflight";
    };
    "inherits@2.0.4" = {
      pname = "inherits";
      version = "2.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-k/vGaX4/Yla3WzyMCvTQOXYeIHvqOKtnqBduzTHpzpQZzAskKMhZ2K+EnBiSM9zGSoIFeMpXKxa4dYeZIQqewQ==";
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
      });
      pkgname = "inherits";
    };
    "ip@1.1.5" = {
      pname = "ip";
      version = "1.1.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-rBtCAQAJm8A110nbwn6YdveUnuZH3WrC36IwkRXxDnq53JvXA2NVQvB7IHyKomxK1MJ4VDNw3UtFDdXQ+AvLYA==";
        url = "https://registry.npmjs.org/ip/-/ip-1.1.5.tgz";
      });
      pkgname = "ip";
    };
    "is-fullwidth-code-point@3.0.0" = {
      pname = "is-fullwidth-code-point";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-zymm5+u+sCsSWyD9qNaejV3DFvhCKclKdizYaJUuHA83RLjb7nSuGnddCHGv0hk+KY7BMAlsWeK4Ueg6EV6XQg==";
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz";
      });
      pkgname = "is-fullwidth-code-point";
    };
    "is-lambda@1.0.1" = {
      pname = "is-lambda";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-z7CMFGNrENq5iFB9Bqo64Xk6Y9sg+epq1myIcdHaGnbMTYOxvzsEtdYqQUylB7LxfkvgrrjP32T6Ywciio9UIQ==";
        url = "https://registry.npmjs.org/is-lambda/-/is-lambda-1.0.1.tgz";
      });
      pkgname = "is-lambda";
    };
    "isarray@0.0.1" = {
      pname = "isarray";
      version = "0.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-D2S+3GLxWH+uhrNEcoh/fnmYeP8E8/zHl644d/jdA0g2uyXvy3sb0qxotE+ne0LtccHknQzWwZEzhak7oJ0COQ==";
        url = "https://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz";
      });
      pkgname = "isarray";
    };
    "isexe@2.0.0" = {
      pname = "isexe";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-RHxMLp9lnKHGHRng9QFhRCMbYAcVpn69smSGcq3f36xjgVVWThj4qqLbTLlq7Ssj8B+fIQ1EuCEGI2lKsyQeIw==";
        url = "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz";
      });
      pkgname = "isexe";
    };
    "jsonfile@4.0.0" = {
      pname = "jsonfile";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-m6F1R3z8jjlf2imQHS2Qez5sjKWQzbuuhuJ/FKYFRZvPE3PuHcSMVZzfsLhGVOkfd20obL5SWEBew5ShlquNxg==";
        url = "https://registry.npmjs.org/jsonfile/-/jsonfile-4.0.0.tgz";
      });
      pkgname = "jsonfile";
    };
    "lru-cache@6.0.0" = {
      pname = "lru-cache";
      version = "6.0.0";
      depKeys = [
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Jo6dJ04CmSjuznwJSS3pUeWmd/H0ffTlkXXgwZi+eq1UCmqQwCh+eLsYOYCwY991i2Fah4h1BEMCx4qThGbsiA==";
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz";
      });
      pkgname = "lru-cache";
    };
    "make-fetch-happen@9.1.0" = {
      pname = "make-fetch-happen";
      version = "9.1.0";
      depKeys = [
        ("agentkeepalive@4.1.4")
        ("cacache@15.3.0")
        ("http-cache-semantics@4.1.0")
        ("http-proxy-agent@4.0.1")
        ("https-proxy-agent@5.0.0")
        ("is-lambda@1.0.1")
        ("lru-cache@6.0.0")
        ("minipass@3.1.6")
        ("minipass-collect@1.0.2")
        ("minipass-fetch@1.4.1")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("negotiator@0.6.2")
        ("promise-retry@2.0.1")
        ("socks-proxy-agent@5.0.0")
        ("ssri@8.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-+zopwDy7DNknmwPQplem5lAZX/eCOzSvSNNcSKm5eVwTkOBzoktEfXsa9L23J/GIRhxRsaxzkPEhrJEpE2F4Gg==";
        url = "https://registry.npmjs.org/make-fetch-happen/-/make-fetch-happen-9.1.0.tgz";
      });
      pkgname = "make-fetch-happen";
    };
    "minimatch@3.0.4" = {
      pname = "minimatch";
      version = "3.0.4";
      depKeys = [
        ("brace-expansion@1.1.11")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-yJHVQEhyqPLUTgt9B83PXu6W3rx4MvvHvSUvToogpwoGDOUQ+yDrR0HRot+yOCdCO7u4hX3pWft6kWBBcqh0UA==";
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
      });
      pkgname = "minimatch";
    };
    "minimist@1.2.5" = {
      pname = "minimist";
      version = "1.2.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-FM9nNUYrRBAELZQT3xeZQ7fmMOBg6nWNmJKTcgsJeaLstP/UODVpGsr5OhXhhXg6f+qtJ8uiZ+PUxkDWcgIXLw==";
        url = "https://registry.npmjs.org/minimist/-/minimist-1.2.5.tgz";
      });
      pkgname = "minimist";
    };
    "minipass-collect@1.0.2" = {
      pname = "minipass-collect";
      version = "1.0.2";
      depKeys = [
        ("minipass@3.1.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-6T6lH0H8OG9kITm/Jm6tdooIbogG9e0tLgpY6mphXSm/A9u8Nq1ryBG+Qspiub9LjWlBPsPS3tWQ/Botq4FdxA==";
        url = "https://registry.npmjs.org/minipass-collect/-/minipass-collect-1.0.2.tgz";
      });
      pkgname = "minipass-collect";
    };
    "minipass-fetch@1.4.1" = {
      pname = "minipass-fetch";
      version = "1.4.1";
      depKeys = [
        ("encoding@0.1.13")
        ("minipass@3.1.6")
        ("minipass-sized@1.0.3")
        ("minizlib@2.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-CGH1eblLq26Y15+Azk7ey4xh0J/XfJfrCox5LDJiKqI2Q2iwOLOKrlmIaODiSQS8d18jalF6y2K2ePUm0CmShw==";
        url = "https://registry.npmjs.org/minipass-fetch/-/minipass-fetch-1.4.1.tgz";
      });
      pkgname = "minipass-fetch";
    };
    "minipass-flush@1.0.5" = {
      pname = "minipass-flush";
      version = "1.0.5";
      depKeys = [
        ("minipass@3.1.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-JmQSYYpPUqX5Jyn1mXaRwOda1uQ8HP5KAT/oDSLCzt1BYRhQU0/hDtsB1ufZfEEzMZ9aAVmsBw8+FWsIXlClWw==";
        url = "https://registry.npmjs.org/minipass-flush/-/minipass-flush-1.0.5.tgz";
      });
      pkgname = "minipass-flush";
    };
    "minipass-pipeline@1.2.4" = {
      pname = "minipass-pipeline";
      version = "1.2.4";
      depKeys = [
        ("minipass@3.1.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-xuIq7cIOt09RPRJ19gdi4b+RiNvDFYe5JH+ggNvBqGqpQXcru3PcRmOZuHBKWK1Txf9+cQ+HMVN4d6z46LZP7A==";
        url = "https://registry.npmjs.org/minipass-pipeline/-/minipass-pipeline-1.2.4.tgz";
      });
      pkgname = "minipass-pipeline";
    };
    "minipass-sized@1.0.3" = {
      pname = "minipass-sized";
      version = "1.0.3";
      depKeys = [
        ("minipass@3.1.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-MbkQQ2CTiBMlA2Dm/5cY+9SWFEN8pzzOXi6rlM5Xxq0Yqbda5ZQy9sU75a673FE9ZK0Zsbr6Y5iP6u9nktfg2g==";
        url = "https://registry.npmjs.org/minipass-sized/-/minipass-sized-1.0.3.tgz";
      });
      pkgname = "minipass-sized";
    };
    "minipass@3.1.6" = {
      pname = "minipass";
      version = "3.1.6";
      depKeys = [
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-rty5kpw9/z8SX9dmxblFA6edItUmwJgMeYDZRrwlIVN27i8gysGbznJwUggw2V/FVqFSDdWy040ZPS811DYAqQ==";
        url = "https://registry.npmjs.org/minipass/-/minipass-3.1.6.tgz";
      });
      pkgname = "minipass";
    };
    "minizlib@2.1.2" = {
      pname = "minizlib";
      version = "2.1.2";
      depKeys = [
        ("minipass@3.1.6")
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-bAxsR8BVfj60DWXHE3u30oHzfl4G7khkSuPW+qvpd7jFRHm7dLxOjUk1EHACJ/hxLY8phGJ0YhYHZo7jil7Qdg==";
        url = "https://registry.npmjs.org/minizlib/-/minizlib-2.1.2.tgz";
      });
      pkgname = "minizlib";
    };
    "mkdirp@0.5.5" = {
      pname = "mkdirp";
      version = "0.5.5";
      depKeys = [
        ("minimist@1.2.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-NKmAlESf6jMGym1++R0Ra7wvhV+wFW63FaSOFPwRahvea0gMUcGUhVeAg/0BC0wiv9ih5NYPB1Wn1UEI1/L+xQ==";
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.5.tgz";
      });
      pkgname = "mkdirp";
    };
    "mkdirp@1.0.4" = {
      pname = "mkdirp";
      version = "1.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-vVqVZQyf3WLx2Shd0qJ9xuvqgAyKPLAiqITEtqW0oIUjzo3PePDd6fW9iFz30ef7Ysp/oiWqbhszeGWW2T6Gzw==";
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-1.0.4.tgz";
      });
      pkgname = "mkdirp";
    };
    "ms@2.1.2" = {
      pname = "ms";
      version = "2.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-sGkPx+VjMtmA6MX27oA4FBFELFCZZ4S4XqeGOXCv68tT+jb3vk/RyaKWP0PTKyWtmLSM0b+adUTEvbs1PEaH2w==";
        url = "https://registry.npmjs.org/ms/-/ms-2.1.2.tgz";
      });
      pkgname = "ms";
    };
    "nan@2.14.1" = {
      pname = "nan";
      version = "2.14.1";
      depKeys = [
        ("node-gyp@8.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-isWHgVjnFjh2x2yuJ/tj3JbwoHu3UC2dX5G/88Cm24yB6YopVgxvBObDY7n5xW6ExmFhJpSEQqFPvq9zaXc8Jw==";
        url = "https://registry.npmjs.org/nan/-/nan-2.14.1.tgz";
      });
      pkgname = "nan";
    };
    "native-watchdog@1.3.0" = {
      pname = "native-watchdog";
      version = "1.3.0";
      depKeys = [
        ("node-gyp@8.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-WOjGRNGkYZ5MXsntcvCYrKtSYMaewlbCFplbcUVo9bE80LPVt8TAVFHYWB8+a6fWCGYheq21+Wtt6CJrUaCJhw==";
        url = "https://registry.npmjs.org/native-watchdog/-/native-watchdog-1.3.0.tgz";
      });
      pkgname = "native-watchdog";
    };
    "negotiator@0.6.2" = {
      pname = "negotiator";
      version = "0.6.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-hZXc7K2e+PgeI1eDBe/10Ard4ekbfrrqG8Ep+8Jmf4JID2bNg7NvCPOZN+kfF574pFQI7mum2AUqDidoKqcTOw==";
        url = "https://registry.npmjs.org/negotiator/-/negotiator-0.6.2.tgz";
      });
      pkgname = "negotiator";
    };
    "node-addon-api@3.1.0" = {
      pname = "node-addon-api";
      version = "3.1.0";
      depKeys = [
        ("node-gyp@8.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-flmrDNB06LIl5lywUz7YlNGZH/5p0M7W28k8hzd9Lshtdh1wshD2Y+U4h9LD6KObOy1f+fEVdgprPrEymjM5uw==";
        url = "https://registry.npmjs.org/node-addon-api/-/node-addon-api-3.1.0.tgz";
      });
      pkgname = "node-addon-api";
    };
    "node-gyp@8.4.1" = {
      pname = "node-gyp";
      version = "8.4.1";
      depKeys = [
        ("env-paths@2.2.1")
        ("glob@7.2.0")
        ("graceful-fs@4.2.4")
        ("make-fetch-happen@9.1.0")
        ("nopt@5.0.0")
        ("npmlog@6.0.0")
        ("rimraf@3.0.2")
        ("semver@7.3.5")
        ("tar@6.1.11")
        ("which@2.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-olTJRgUtAb/hOXG0E93wZDs5YiJlgbXxTwQAFHyNlRsXQnYzUaF2aGgujZbw+hR8aF4ZG/rST57bWMWD16jr9w==";
        url = "https://registry.npmjs.org/node-gyp/-/node-gyp-8.4.1.tgz";
      });
      pkgname = "node-gyp";
    };
    "node-pty@0.11.0-beta5" = {
      pname = "node-pty";
      version = "0.11.0-beta5";
      depKeys = [
        ("nan@2.14.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-ZwBo5TviKYOBeUZvE+twH5negddJW9Ml03o5wLPr1WX+OzXkq6GXhPSOJm4zcXcuC/j0hn+lorvTzEyliDcsPA==";
        url = "https://registry.npmjs.org/node-pty/-/node-pty-0.11.0-beta5.tgz";
      });
      pkgname = "node-pty";
    };
    "nopt@5.0.0" = {
      pname = "nopt";
      version = "5.0.0";
      depKeys = [
        ("abbrev@1.1.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Tbj67rffqceeLpcRXrT7vKAN8CwfPeIBgM7E6iBkmKLV7bEMwpGgYLGv0jACUsECaa/vuxP0IjEont6umdMgtQ==";
        url = "https://registry.npmjs.org/nopt/-/nopt-5.0.0.tgz";
      });
      pkgname = "nopt";
    };
    "npmlog@6.0.0" = {
      pname = "npmlog";
      version = "6.0.0";
      depKeys = [
        ("are-we-there-yet@2.0.0")
        ("console-control-strings@1.1.0")
        ("gauge@4.0.0")
        ("set-blocking@2.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-03ppFRGlsyUaQFbGC2C8QWJN/C/K7PsfyD9aQdhVKAQIH4sQBc8WASqFBP7O+Ut4d2oo5LoeoboB3cGdBZSp6Q==";
        url = "https://registry.npmjs.org/npmlog/-/npmlog-6.0.0.tgz";
      });
      pkgname = "npmlog";
    };
    "once@1.4.0" = {
      pname = "once";
      version = "1.4.0";
      depKeys = [
        ("wrappy@1.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-lNaJgI+2Q5URQBkccEKHTQOPaXdUxnZZElQTZY0MFUAuaEqe1E+Nyvgdz/aIyNi6Z9MzO5dv1H8n58/GELp3+w==";
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
      });
      pkgname = "once";
    };
    "onivim2-node@." = {
      pname = "onivim2-node";
      version = "0.0.0-use.local";
      depKeys = [
        ("@onivim/request-light@0.4.1")
        ("@onivim/vscode-exthost@1.58.2001")
        ("@types/node@11.15.54")
        ("fs-extra@8.1.0")
        ("sudo-prompt@9.0.0")
        ("typescript@3.9.10")
        ("vscode-proxy-agent@0.11.0")
        ("yauzl@2.10.0")
      ];
      src = (final.pathSrc ../esy/.);
      nodePathDeps = [
      ];
      pkgname = "onivim2-node";
    };
    "p-map@4.0.0" = {
      pname = "p-map";
      version = "4.0.0";
      depKeys = [
        ("aggregate-error@3.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-/bjOqmgETBYB5BoEeGVea8dmvHb2m9GLy1E9W43yeyfP6QQCZGFNa+XRceJEuDB6zqr+gKpIAmlLebMpykw/MQ==";
        url = "https://registry.npmjs.org/p-map/-/p-map-4.0.0.tgz";
      });
      pkgname = "p-map";
    };
    "path-is-absolute@1.0.1" = {
      pname = "path-is-absolute";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-AVbw3UJ2e9bq64vSaS9Am0fje1Pa8pbGqTTsmXfaIiMpnr5DlDhfJOuLj9Sf95ZPVDAUerDfEk88MPmPe7UCQg==";
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
      });
      pkgname = "path-is-absolute";
    };
    "pend@1.2.0" = {
      pname = "pend";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-F3asv42UuXchdzt+xXqfW1OGlVBe+mxa2mqI0pg5yAHZPvFmY3Y6drSf/GQ1A86WgWEN9Kzh/WrgKa6iGcHXLg==";
        url = "https://registry.npmjs.org/pend/-/pend-1.2.0.tgz";
      });
      pkgname = "pend";
    };
    "promise-inflight@1.0.1" = {
      pname = "promise-inflight";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-6zWPyEOFaQBJYcGMHBKTKJ3u6TBsnMFOIZSa6ce1e/ZrrsOlnHRHbabMjLiBYKp+n44X9eUI6VUPaukCXHuG4g==";
        url = "https://registry.npmjs.org/promise-inflight/-/promise-inflight-1.0.1.tgz";
      });
      pkgname = "promise-inflight";
    };
    "promise-retry@2.0.1" = {
      pname = "promise-retry";
      version = "2.0.1";
      depKeys = [
        ("err-code@2.0.3")
        ("retry@0.12.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-y+WKFlBR8BGXnsNlIHFGPZmyDf3DFMoLhaflAnyZgV6rG6xu+JwesTo2Q9R6XwYmtmwAFCkAk3e35jEdoeh/3g==";
        url = "https://registry.npmjs.org/promise-retry/-/promise-retry-2.0.1.tgz";
      });
      pkgname = "promise-retry";
    };
    "readable-stream@1.1.14" = {
      pname = "readable-stream";
      version = "1.1.14";
      depKeys = [
        ("core-util-is@1.0.2")
        ("inherits@2.0.4")
        ("isarray@0.0.1")
        ("string_decoder@0.10.31")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-+MeVjFf4L44XUkhM1eYbD8fyEsxcV81pqMSR5gblfcLCHfZvbrqy4/qYHE+/R5HoBUT11WV5O08Cr1n3YXkWVQ==";
        url = "https://registry.npmjs.org/readable-stream/-/readable-stream-1.1.14.tgz";
      });
      pkgname = "readable-stream";
    };
    "readable-stream@3.6.0" = {
      pname = "readable-stream";
      version = "3.6.0";
      depKeys = [
        ("inherits@2.0.4")
        ("string_decoder@1.3.0")
        ("util-deprecate@1.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-BViHy7LKeTz4oNnkcLJ+lVSL6vpiFeX6/d3oSH8zCW7UxP2onchk+vTGB143xuFjHS3deTgkKoXXymXqymiIdA==";
        url = "https://registry.npmjs.org/readable-stream/-/readable-stream-3.6.0.tgz";
      });
      pkgname = "readable-stream";
    };
    "retry@0.12.0" = {
      pname = "retry";
      version = "0.12.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-9LkiTwjUh6rT555DtE9rTX+BKByPfrMzEAtnlEtdEwr3Nkffwiihqe2bWADg+OQRjt9gl6ICdmB/ZFDCGAtSow==";
        url = "https://registry.npmjs.org/retry/-/retry-0.12.0.tgz";
      });
      pkgname = "retry";
    };
    "rimraf@3.0.2" = {
      pname = "rimraf";
      version = "3.0.2";
      depKeys = [
        ("glob@7.2.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-JZkJMZkAGFFPP2YqXZXPbMlMBgsxzE8ILs4lMIX/2o0L9UBw9O/Y3o6wFw/i9YLapcUJWwqbi3kdxIPdC62TIA==";
        url = "https://registry.npmjs.org/rimraf/-/rimraf-3.0.2.tgz";
      });
      pkgname = "rimraf";
    };
    "safe-buffer@5.2.1" = {
      pname = "safe-buffer";
      version = "5.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-rp3So07KcdmmKbGvgaNxQSJr7bGVSVk5S9Eq1F+ppbRo70+YeaDxkw5Dd8NPN+GD6bjnYm2VuPuCXmpuYvmCXQ==";
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.2.1.tgz";
      });
      pkgname = "safe-buffer";
    };
    "safer-buffer@2.1.2" = {
      pname = "safer-buffer";
      version = "2.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-YZo3K82SD7Riyi0E1EQPojLz7kpepnSQI9IyPbHHg1XXXevb5dJI7tpyN2ADxGcQbHG7vcyRHk0cbwqcQriUtg==";
        url = "https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz";
      });
      pkgname = "safer-buffer";
    };
    "semver@7.3.5" = {
      pname = "semver";
      version = "7.3.5";
      depKeys = [
        ("lru-cache@6.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-PoeGJYh8HK4BTO/a9Tf6ZG3veo/A7ZVsYrSA6J8ny9nb3B1VrpkuN+z9OE5wfE5p6H4LchYZsegiQgbJD94ZFQ==";
        url = "https://registry.npmjs.org/semver/-/semver-7.3.5.tgz";
      });
      pkgname = "semver";
    };
    "set-blocking@2.0.0" = {
      pname = "set-blocking";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-KiKBS8AnWGEyLzofFfmvKwpdPzqiy16LvQfK3yv/fVH7Bj13/wl3JSR1J+rfgRE9q7xUJK4qvgS8raSOeLUehw==";
        url = "https://registry.npmjs.org/set-blocking/-/set-blocking-2.0.0.tgz";
      });
      pkgname = "set-blocking";
    };
    "signal-exit@3.0.6" = {
      pname = "signal-exit";
      version = "3.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-sDl4qMFpijcGw22U5w63KmD3cZJfBuFlVNbVMKje2keoKML7X2UzWbc4XrmEbDwg0NXJc3yv4/ox7b+JWb57kQ==";
        url = "https://registry.npmjs.org/signal-exit/-/signal-exit-3.0.6.tgz";
      });
      pkgname = "signal-exit";
    };
    "smart-buffer@4.1.0" = {
      pname = "smart-buffer";
      version = "4.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-iVICrxOzCynf/SNaBQCw34eM9jROU/s5rzIhpOvzhzuYHfJR/DhZfDkXiZSgKXfgv26HT3Yni3AV/DGw0cGnnw==";
        url = "https://registry.npmjs.org/smart-buffer/-/smart-buffer-4.1.0.tgz";
      });
      pkgname = "smart-buffer";
    };
    "socks-proxy-agent@5.0.0" = {
      pname = "socks-proxy-agent";
      version = "5.0.0";
      depKeys = [
        ("agent-base@6.0.2")
        ("debug@3.2.6")
        ("socks@2.6.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-lEpa1zsWCChxiynk+lCycKuC502RxDWLKJZoIhnxrWNjLSDGYRFflHA1/228VkRcnv9TIb8w98derGbpKxJRgA==";
        url = "https://registry.npmjs.org/socks-proxy-agent/-/socks-proxy-agent-5.0.0.tgz";
      });
      pkgname = "socks-proxy-agent";
    };
    "socks@2.6.1" = {
      pname = "socks";
      version = "2.6.1";
      depKeys = [
        ("ip@1.1.5")
        ("smart-buffer@4.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-kLQ9N5ucj8uIcxrDwjm0Jsqk06xdpBjGNQtpXy4Q8/QY2k+fY7nZH8CARy+hkbG+SGAovmzzuauCpBlb8FrnBA==";
        url = "https://registry.npmjs.org/socks/-/socks-2.6.1.tgz";
      });
      pkgname = "socks";
    };
    "spdlog@0.13.6" = {
      pname = "spdlog";
      version = "0.13.6";
      depKeys = [
        ("bindings@1.5.0")
        ("mkdirp@0.5.5")
        ("nan@2.14.1")
        ("node-gyp@8.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-iGqDoA88G3Rv3lkbVQglTulp3nv12FzND6LDC7cOZ+OoFvWnXVb3+Ebhed60oZ6+IWWGwDtjXK6ympwr7C1XmQ==";
        url = "https://registry.npmjs.org/spdlog/-/spdlog-0.13.6.tgz";
      });
      pkgname = "spdlog";
    };
    "ssri@8.0.1" = {
      pname = "ssri";
      version = "8.0.1";
      depKeys = [
        ("minipass@3.1.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-97qShzy1AiyxvPNIkLWoGua7xoQzzPjQ0HAH4B0rWKo7SZ6USuPcrUiAFrws0UH8RrbWmgq3LMTObhPIHbbBeQ==";
        url = "https://registry.npmjs.org/ssri/-/ssri-8.0.1.tgz";
      });
      pkgname = "ssri";
    };
    "string-width@4.2.3" = {
      pname = "string-width";
      version = "4.2.3";
      depKeys = [
        ("emoji-regex@8.0.0")
        ("is-fullwidth-code-point@3.0.0")
        ("strip-ansi@6.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-wKyQRQpjJ0sIp62ErSZdGsjMJWsap5oRNihHhu6G7JVO/9jIB6UyevL+tXuOqrng8j/cxKTWyWUwvSTriiZz/g==";
        url = "https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz";
      });
      pkgname = "string-width";
    };
    "string_decoder@0.10.31" = {
      pname = "string_decoder";
      version = "0.10.31";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-ev2QzSzWPYmy9GuqfIVildA4OdcGLeFZQrq5ys6RtiuF+RQQiZWr8TZNyAcuVXyQRYfEO+MsoB/1BuQVhOJuoQ==";
        url = "https://registry.npmjs.org/string_decoder/-/string_decoder-0.10.31.tgz";
      });
      pkgname = "string_decoder";
    };
    "string_decoder@1.3.0" = {
      pname = "string_decoder";
      version = "1.3.0";
      depKeys = [
        ("safe-buffer@5.2.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-hkRX8U1WjJFd8LsDJ2yQ/wWWxaopEsABU1XfkM8A+j0+85JAGppt16cr1Whg6KIbb4okU6Mql6BOj+uup/wKeA==";
        url = "https://registry.npmjs.org/string_decoder/-/string_decoder-1.3.0.tgz";
      });
      pkgname = "string_decoder";
    };
    "strip-ansi@6.0.1" = {
      pname = "strip-ansi";
      version = "6.0.1";
      depKeys = [
        ("ansi-regex@5.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Y38VPSHcqkFrCpFnQ9vuSXmquuv5oXOKpGeT6aGrr3o3Gc9AlVa6JBfUSOCnbxGGZF+/0ooI7KrPuUSztUdU5A==";
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz";
      });
      pkgname = "strip-ansi";
    };
    "sudo-prompt@9.0.0" = {
      pname = "sudo-prompt";
      version = "9.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-kUn5fiOk0nhY2oKD9onIkcNCE4Zt85WTsvOfSmqCplmlEvXCcPOmp1npH5YWuf8Bmyy9wLWkIxx+D+8cThBORQ==";
        url = "https://registry.npmjs.org/sudo-prompt/-/sudo-prompt-9.0.0.tgz";
      });
      pkgname = "sudo-prompt";
    };
    "tar@6.1.11" = {
      pname = "tar";
      version = "6.1.11";
      depKeys = [
        ("chownr@2.0.0")
        ("fs-minipass@2.1.0")
        ("minipass@3.1.6")
        ("minizlib@2.1.2")
        ("mkdirp@1.0.4")
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-an/KZQzQUkZCkuoAA64hM92X0Urb6VpRhAFllDzz44U2mcD5scmT3zBc4VgVpkugF580+DQn8eAFSyoQt0tznA==";
        url = "https://registry.npmjs.org/tar/-/tar-6.1.11.tgz";
      });
      pkgname = "tar";
    };
    "typescript@3.9.10" = {
      pname = "typescript";
      version = "3.9.10";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-w6fIxVE/H1PkLKcCPsFqKE7Kv7QUwhU8qQY2MueZXWx5cPZdwFupLgKK3vntcK98BtNHZtAF4LA/yl2a7k8R6Q==";
        url = "https://registry.npmjs.org/typescript/-/typescript-3.9.10.tgz";
      });
      pkgname = "typescript";
    };
    "typescript@typescript@npm%3A3.9.10#~builtin<compat/typescript>::version=3.9.10&hash=493e53" = {
      pname = "typescript";
      version = "3.9.10";
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
      src = (pkgs.fetchurl {
        hash = "sha512-Vmp0jIp2ln35UTXuryvjzkjGdRyf9b2lTXuSYUiPmzRcl3FDtYqAwOnTJkAngD9SWhnoJzDbTKwaOrZ+STtxNQ==";
        url = "https://registry.npmjs.org/unique-filename/-/unique-filename-1.1.1.tgz";
      });
      pkgname = "unique-filename";
    };
    "unique-slug@2.0.2" = {
      pname = "unique-slug";
      version = "2.0.2";
      depKeys = [
        ("imurmurhash@0.1.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-zoWr9ObaxALD3DOPfjPSqxt4fnZiWblxHIgeWqW8x7UqDzEtHEQLzji2cuJYQFCU6KmoJikOYAZlrTHHebjx2w==";
        url = "https://registry.npmjs.org/unique-slug/-/unique-slug-2.0.2.tgz";
      });
      pkgname = "unique-slug";
    };
    "universalify@0.1.2" = {
      pname = "universalify";
      version = "0.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-rBJeI5CXAlmy1pV+617WB9J63U6XcazHHF2f2dbJix4XzpUF0RS3Zbj0FGIOCAva5P/d/GBOYaACQ1w+0azUkg==";
        url = "https://registry.npmjs.org/universalify/-/universalify-0.1.2.tgz";
      });
      pkgname = "universalify";
    };
    "util-deprecate@1.0.2" = {
      pname = "util-deprecate";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-EPD5q1uXyFxJpCrLnCc1nHnq3gOa6DZBocAIiI2TaSCA7VCJ1UJDMagCzIkXNsUYfD1daK//LTEQ8xiIbrHtcw==";
        url = "https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz";
      });
      pkgname = "util-deprecate";
    };
    "vscode-nls@4.1.2" = {
      pname = "vscode-nls";
      version = "4.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-7bOHxPsfyuCqmP+hZXscLhiHwe7CSuFE4hyhbs22xPIhQ4jv99FcR4eBzfYYVLP356HNFpdvz63FFb/xw6T4Iw==";
        url = "https://registry.npmjs.org/vscode-nls/-/vscode-nls-4.1.2.tgz";
      });
      pkgname = "vscode-nls";
    };
    "vscode-proxy-agent@0.11.0" = {
      pname = "vscode-proxy-agent";
      version = "0.11.0";
      depKeys = [
        ("@tootallnate/once@1.1.2")
        ("agent-base@6.0.2")
        ("debug@3.2.6")
        ("get-uri@3.0.2")
        ("http-proxy-agent@4.0.1")
        ("https-proxy-agent@5.0.0")
        ("socks-proxy-agent@5.0.0")
        ("vscode-windows-ca-certs@0.3.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Y5mHjDGq/OKOvKG0IwCYfj25cvQ2cLEil8ce8n55IZHRAP9RF3e1sKU4ZUNDB8X2NIpKwyltrWpK9tFFE/kc3g==";
        url = "https://registry.npmjs.org/vscode-proxy-agent/-/vscode-proxy-agent-0.11.0.tgz";
      });
      pkgname = "vscode-proxy-agent";
    };
    "vscode-regexpp@3.1.0" = {
      pname = "vscode-regexpp";
      version = "3.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-pqtN65VC1jRLawfluX4Y80MMG0DHJydWhe5ZwMHewZD6sys4LbU6lHwFAHxeuaVE6Y6+xZOtAw+9hvq7/0ejkg==";
        url = "https://registry.npmjs.org/vscode-regexpp/-/vscode-regexpp-3.1.0.tgz";
      });
      pkgname = "vscode-regexpp";
    };
    "vscode-windows-ca-certs@0.3.0" = {
      pname = "vscode-windows-ca-certs";
      version = "0.3.0";
      depKeys = [
        ("node-addon-api@3.1.0")
        ("node-gyp@8.4.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-CYrpCEKmAFQJoZNReOrelNL+VKyebOVRCqL9evrBlVcpWQDliliJgU5RggGS8FPGtQ3jAKLQt9frF0qlxYYPKA==";
        url = "https://registry.npmjs.org/vscode-windows-ca-certs/-/vscode-windows-ca-certs-0.3.0.tgz";
      });
      pkgname = "vscode-windows-ca-certs";
    };
    "which@2.0.2" = {
      pname = "which";
      version = "2.0.2";
      depKeys = [
        ("isexe@2.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-BLI3Tl1TW3Pvl70l3yq3Y64i+awpwXqsGBYWkkqMtnbXgrMD+yj7rhW0kuEDxzJaYXGjEW5ogapKNMEKNMjibA==";
        url = "https://registry.npmjs.org/which/-/which-2.0.2.tgz";
      });
      pkgname = "which";
    };
    "wide-align@1.1.5" = {
      pname = "wide-align";
      version = "1.1.5";
      depKeys = [
        ("string-width@4.2.3")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-eDMORYaPNZ4sQIuuYPDHdQvf4gyCF9rEEV/yPxGfwPkRodwEgiMUUXTx/dex+Me0wxx53S+NgUHaP7y3MGlDmg==";
        url = "https://registry.npmjs.org/wide-align/-/wide-align-1.1.5.tgz";
      });
      pkgname = "wide-align";
    };
    "wrappy@1.0.2" = {
      pname = "wrappy";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-l4Sp/DRseor9wL6EvV2+TuQn63dMkPjZ/sp9XkghTEbV9KlPS1xUsZ3u7/IQO4wxtcFB4bgpQPRcR3QCvezPcQ==";
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
      });
      pkgname = "wrappy";
    };
    "xregexp@2.0.0" = {
      pname = "xregexp";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-xl/50/Cf32VsGq/1R8jJE5ajH1yMCQkpmoS10QbFZWl2Oor4H0Me64Pu2yxvsRWK3m6soJbmGfzSR7BYmDcWAA==";
        url = "https://registry.npmjs.org/xregexp/-/xregexp-2.0.0.tgz";
      });
      pkgname = "xregexp";
    };
    "yallist@4.0.0" = {
      pname = "yallist";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-3wdGidZyq5PB084XLES5TpOSRA3wjXAlIWMhum2kRcv/41Sn2emQ0dycQW4uZXLejwKvg6EsvbdlVL+FYEct7A==";
        url = "https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz";
      });
      pkgname = "yallist";
    };
    "yauzl@2.10.0" = {
      pname = "yauzl";
      version = "2.10.0";
      depKeys = [
        ("buffer-crc32@0.2.13")
        ("fd-slicer@1.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-p4a9I6X6nu6IhoGmBqAcbJy1mlC4j27vEPZX9F4L4/vZT3Lyq1VkFHw/V/PUcB9Buo+DG3iHkT0x3Qya58zc3g==";
        url = "https://registry.npmjs.org/yauzl/-/yauzl-2.10.0.tgz";
      });
      pkgname = "yauzl";
    };
  };
}