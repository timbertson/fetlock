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
    "@isaacs/cliui@8.0.2" = {
      pname = "isaacs-cliui";
      version = "8.0.2";
      depKeys = [
        ("string-width@5.1.2")
        ("string-width@5.1.2")
        ("strip-ansi@7.1.0")
        ("strip-ansi@6.0.1")
        ("wrap-ansi@8.1.0")
        ("wrap-ansi@8.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-O8jcjabXaleOG9DQ0+ARXWZBTfnP4WNAqzuiJK7ll44AmxGKv/J2M4TPjxjY3znBCfvBXFzucm1twdyFybFqEA==";
        url = "https://registry.npmjs.org/@isaacs/cliui/-/cliui-8.0.2.tgz";
      });
      pkgname = "@isaacs/cliui";
    };
    "@npmcli/agent@2.2.0" = {
      pname = "npmcli-agent";
      version = "2.2.0";
      depKeys = [
        ("agent-base@6.0.2")
        ("http-proxy-agent@4.0.1")
        ("https-proxy-agent@5.0.0")
        ("lru-cache@10.2.0")
        ("socks-proxy-agent@5.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-2yThA1Es98orMkpSLVqlDZAMPK3jHJhifP2gnNUdk1754uZ8yI5c+ulCoVG+WlntQA6MzhrURMXjSd9Z7dJ2/Q==";
        url = "https://registry.npmjs.org/@npmcli/agent/-/agent-2.2.0.tgz";
      });
      pkgname = "@npmcli/agent";
    };
    "@npmcli/fs@3.1.0" = {
      pname = "npmcli-fs";
      version = "3.1.0";
      depKeys = [
        ("semver@7.5.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-7kZUAaLscfgbwBQRbvdMYaZOWyMEcPTH/tJjnyAWJ/dvvs9Ef+CERx/qJb9GExJpl1qipaDGn7KqHnFGGixd0w==";
        url = "https://registry.npmjs.org/@npmcli/fs/-/fs-3.1.0.tgz";
      });
      pkgname = "@npmcli/fs";
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
    "@pkgjs/parseargs@0.11.0" = {
      pname = "pkgjs-parseargs";
      version = "0.11.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-+1VkjdD0QBLPodGrJUeqarH8VAIvQODIbwh9XpP5Syisf7YoQgsJKPNFoqqLQlu+VQ/tVSshMR6loPMn8U+dPg==";
        url = "https://registry.npmjs.org/@pkgjs/parseargs/-/parseargs-0.11.0.tgz";
      });
      pkgname = "@pkgjs/parseargs";
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
    "abbrev@2.0.0" = {
      pname = "abbrev";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-6/mh1E2u2YgEsCHdY0Yx5oW+61gZU+1vXaoiHHrpKeuRNNgFvS+/jrwHiQhB5apAf5oB7UB7E19ol2R2LKH8hQ==";
        url = "https://registry.npmjs.org/abbrev/-/abbrev-2.0.0.tgz";
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
    "ansi-regex@6.0.1" = {
      pname = "ansi-regex";
      version = "6.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-n5M855fKb2SsfMIiFFoVrABHJC8QtHwVx+mHWP3QcEqBHYienj5dHSgjbxtC0WEZXYt4wcD6zrQElDPhFuZgfA==";
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-6.0.1.tgz";
      });
      pkgname = "ansi-regex";
    };
    "ansi-styles@4.3.0" = {
      pname = "ansi-styles";
      version = "4.3.0";
      depKeys = [
        ("color-convert@2.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-zbB9rCJAT1rbjiVDb2hqKFHNYLxgtk8NURxZ3IZwD3F6NtxbXZQCnnSi1Lkx+IDohdPlFp222wVALIheZJQSEg==";
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-4.3.0.tgz";
      });
      pkgname = "ansi-styles";
    };
    "ansi-styles@6.2.1" = {
      pname = "ansi-styles";
      version = "6.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-bN798gFfQX+viw3R7yrGWRqnrN2oRkEkUjjl4JNn4E8GxxbjtG3FbrEIIY3l8/hrwUwIeCZvi4QuOTP4MErVug==";
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-6.2.1.tgz";
      });
      pkgname = "ansi-styles";
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
    "brace-expansion@2.0.1" = {
      pname = "brace-expansion";
      version = "2.0.1";
      depKeys = [
        ("balanced-match@1.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-XnAIvQ8eM+kC6aULx6wuQiwVsnzsi9d3WxzV3FpWTGA19F621kwdbsAcFKXgKUHZWsy+mY6iL1sHTxWEFCytDA==";
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-2.0.1.tgz";
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
    "cacache@18.0.2" = {
      pname = "cacache";
      version = "18.0.2";
      depKeys = [
        ("@npmcli/fs@3.1.0")
        ("fs-minipass@3.0.3")
        ("glob@10.3.10")
        ("lru-cache@10.2.0")
        ("minipass@7.0.4")
        ("minipass-collect@2.0.1")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("p-map@4.0.0")
        ("ssri@10.0.5")
        ("tar@6.2.0")
        ("unique-filename@3.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-r3NU8h/P+4lVUHfeRw1dtgQYar3DZMm4/cm2bZgOvrFC/su7budSOeqh52VJIC4U4iG1WWwV6vRW0znqBvxNuw==";
        url = "https://registry.npmjs.org/cacache/-/cacache-18.0.2.tgz";
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
    "color-convert@2.0.1" = {
      pname = "color-convert";
      version = "2.0.1";
      depKeys = [
        ("color-name@1.1.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-RRECPsj7iu/xb5oKYcsFHSppFNnsj/52OVTRKb4zP5onXwVF3zVmmToNcOfGC+CRDpfK/U584fMg38ZHCaElKQ==";
        url = "https://registry.npmjs.org/color-convert/-/color-convert-2.0.1.tgz";
      });
      pkgname = "color-convert";
    };
    "color-name@1.1.4" = {
      pname = "color-name";
      version = "1.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-dOy+3AuW3a2wNbZHIuMZpTcgjGuLU/uBL/ubcZF9OXbDo8ff4O8yVp5Bf0efS8uEoYo5q4Fx7dY9OgQGXgAsQA==";
        url = "https://registry.npmjs.org/color-name/-/color-name-1.1.4.tgz";
      });
      pkgname = "color-name";
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
    "cross-spawn@7.0.3" = {
      pname = "cross-spawn";
      version = "7.0.3";
      depKeys = [
        ("path-key@3.1.1")
        ("shebang-command@2.0.0")
        ("which@2.0.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-iRDPJKUPVEND7dHPO8rkbOnPpyDygcDFtWjpeWNCgy8WP2rXcxXL8TskReQl6OrB2G7+UJrags1q15Fudc7G6w==";
        url = "https://registry.npmjs.org/cross-spawn/-/cross-spawn-7.0.3.tgz";
      });
      pkgname = "cross-spawn";
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
    "eastasianwidth@0.2.0" = {
      pname = "eastasianwidth";
      version = "0.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-I88TYZWc9XiYHRQ4/3c5rjjfgkjhLyW2luGIheGERbNQ6OY7yTybanSpDXZa8y7VUP9YmDcYa+eyq4ca7iLqWA==";
        url = "https://registry.npmjs.org/eastasianwidth/-/eastasianwidth-0.2.0.tgz";
      });
      pkgname = "eastasianwidth";
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
    "emoji-regex@9.2.2" = {
      pname = "emoji-regex";
      version = "9.2.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-L18DaJsXSUk2+42pv8mLs5jJT2hqFkFE4j21wOmgbUqsZ2hL72NsUU785g9RXgo3s0ZNgVl42TiHp3ZtOv/Vyg==";
        url = "https://registry.npmjs.org/emoji-regex/-/emoji-regex-9.2.2.tgz";
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
    "exponential-backoff@3.1.1" = {
      pname = "exponential-backoff";
      version = "3.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-dX7e/LHVJ6W3DE1MHWi9S1EYzDESENfLrYohG2G++ovZrYOkm4Knwa0mc1cn84xJOR4KEU0WSchhLbd0UklbHw==";
        url = "https://registry.npmjs.org/exponential-backoff/-/exponential-backoff-3.1.1.tgz";
      });
      pkgname = "exponential-backoff";
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
    "foreground-child@3.1.1" = {
      pname = "foreground-child";
      version = "3.1.1";
      depKeys = [
        ("cross-spawn@7.0.3")
        ("signal-exit@4.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-TMKDUnIte6bfb5nWv7V/caI169OHgvwjb7V4WkeUvbQQdjr5rWKqHFiKWb/fcOwB+CzBT+qbWjvj+DVwRskpIg==";
        url = "https://registry.npmjs.org/foreground-child/-/foreground-child-3.1.1.tgz";
      });
      pkgname = "foreground-child";
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
        ("minipass@3.3.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-V/JgOLFCS+R6Vcq0slCuaeWEdNC3ouDlJMNIsacH2VtALiu9mV4LPrHc5cDl8k5aw6J8jwgWWpiTo5RYhmIzvg==";
        url = "https://registry.npmjs.org/fs-minipass/-/fs-minipass-2.1.0.tgz";
      });
      pkgname = "fs-minipass";
    };
    "fs-minipass@3.0.3" = {
      pname = "fs-minipass";
      version = "3.0.3";
      depKeys = [
        ("minipass@7.0.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-XUBA9XClHbnJWSfBzjkm6RvPsyg3sryZt06BEQoXcF7EK/xpGaQYJgQKDJSUH5SGZ76Y7pFx1QBnXz09rU5Fbw==";
        url = "https://registry.npmjs.org/fs-minipass/-/fs-minipass-3.0.3.tgz";
      });
      pkgname = "fs-minipass";
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
    "glob@10.3.10" = {
      pname = "glob";
      version = "10.3.10";
      depKeys = [
        ("foreground-child@3.1.1")
        ("jackspeak@2.3.6")
        ("minimatch@9.0.3")
        ("minipass@7.0.4")
        ("path-scurry@1.10.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-fa46+tv1Ak0UPK1TOy/pZrIybNNt4HCv7SDzwyfiOZkvZLEbjsZkJBPtDHVshZjbecAoAGSC20MjLDG/qr679g==";
        url = "https://registry.npmjs.org/glob/-/glob-10.3.10.tgz";
      });
      bin = {
        "./dist/esm/bin.mjs" = "./dist/esm/bin.mjs";
      };
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
    "http-cache-semantics@4.1.1" = {
      pname = "http-cache-semantics";
      version = "4.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-er295DKPVsV82j5kw1Gjt+ADA/XYHsajl82cGNQG2eyoPkvgUhX+nDIyelzhIWbbsXP39EHcI6l5tYs2FYqYXQ==";
        url = "https://registry.npmjs.org/http-cache-semantics/-/http-cache-semantics-4.1.1.tgz";
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
    "isexe@3.1.1" = {
      pname = "isexe";
      version = "3.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-LpB/54B+/2J5hqQ7imZHfdU31OlgQqx7ZicVlkm9kzg9/w8GKLEcFfJl/t7DCEDueOyBAD6zCCwTO6Fzs0NoEQ==";
        url = "https://registry.npmjs.org/isexe/-/isexe-3.1.1.tgz";
      });
      pkgname = "isexe";
    };
    "jackspeak@2.3.6" = {
      pname = "jackspeak";
      version = "2.3.6";
      depKeys = [
        ("@isaacs/cliui@8.0.2")
        ("@pkgjs/parseargs@0.11.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-N3yCS/NegsOBokc8GAdM8UcmfsKiSS8cipheD/nivzr700H+nsMOxJjQnvwOcRYVuFkdH0wGUvW2WbXGmrZGbQ==";
        url = "https://registry.npmjs.org/jackspeak/-/jackspeak-2.3.6.tgz";
      });
      pkgname = "jackspeak";
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
    "lru-cache@10.2.0" = {
      pname = "lru-cache";
      version = "10.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-2bIM8x+VAf6JT4bKAljS1qUWgMsqZRPGJS6FSahIMPVvctcNhyVp7AJu7quxOW9jwkryBReKZY5tY5JYv2n/7Q==";
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-10.2.0.tgz";
      });
      pkgname = "lru-cache";
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
    "make-fetch-happen@13.0.0" = {
      pname = "make-fetch-happen";
      version = "13.0.0";
      depKeys = [
        ("@npmcli/agent@2.2.0")
        ("cacache@18.0.2")
        ("http-cache-semantics@4.1.1")
        ("is-lambda@1.0.1")
        ("minipass@7.0.4")
        ("minipass-fetch@3.0.4")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("negotiator@0.6.3")
        ("promise-retry@2.0.1")
        ("ssri@10.0.5")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-7ThobcL8brtGo9CavByQrQi+23aIfgYU++wg4B87AIS8Rb2ZBt/MEaDqzA00Xwv/jUjAjYkLHjVolYuTLKda2A==";
        url = "https://registry.npmjs.org/make-fetch-happen/-/make-fetch-happen-13.0.0.tgz";
      });
      pkgname = "make-fetch-happen";
    };
    "minimatch@9.0.3" = {
      pname = "minimatch";
      version = "9.0.3";
      depKeys = [
        ("brace-expansion@2.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-RHiac9mvaRw0x3AYRgDC1CxAP7HTcNrrECeA8YYJeWnpo+2Q5CegtZjaotWTWxDG3UeGA1coE05iH1mPjT/2mg==";
        url = "https://registry.npmjs.org/minimatch/-/minimatch-9.0.3.tgz";
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
    "minipass-collect@2.0.1" = {
      pname = "minipass-collect";
      version = "2.0.1";
      depKeys = [
        ("minipass@7.0.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-D7V8PO9oaz7PWGLbCACuI1qEOsq7UKfLotx/C0Aet43fCUB/wfQ7DYeq2oR/svFJGYDHPr38SHATeaj/ZoKHKw==";
        url = "https://registry.npmjs.org/minipass-collect/-/minipass-collect-2.0.1.tgz";
      });
      pkgname = "minipass-collect";
    };
    "minipass-fetch@3.0.4" = {
      pname = "minipass-fetch";
      version = "3.0.4";
      depKeys = [
        ("encoding@0.1.13")
        ("minipass@7.0.4")
        ("minipass-sized@1.0.3")
        ("minizlib@2.1.2")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-jHAqnA728uUpIaFm7NWsCnqKT6UqZz7GcI/bDpPATuwYyKwJwW0remxSCxUlKiEty+eopHGa3oc8WxgQ1FFJqg==";
        url = "https://registry.npmjs.org/minipass-fetch/-/minipass-fetch-3.0.4.tgz";
      });
      pkgname = "minipass-fetch";
    };
    "minipass-flush@1.0.5" = {
      pname = "minipass-flush";
      version = "1.0.5";
      depKeys = [
        ("minipass@3.3.6")
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
        ("minipass@3.3.6")
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
        ("minipass@3.3.6")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-MbkQQ2CTiBMlA2Dm/5cY+9SWFEN8pzzOXi6rlM5Xxq0Yqbda5ZQy9sU75a673FE9ZK0Zsbr6Y5iP6u9nktfg2g==";
        url = "https://registry.npmjs.org/minipass-sized/-/minipass-sized-1.0.3.tgz";
      });
      pkgname = "minipass-sized";
    };
    "minipass@3.3.6" = {
      pname = "minipass";
      version = "3.3.6";
      depKeys = [
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-DxiNidxSEK+tHG6zOIklvNOwm3hvCrbUrdtzY74U6HKTJxvIDfOUL5W5P2Ghd3DTkhhKPYGqeNUIh5qcM4YBfw==";
        url = "https://registry.npmjs.org/minipass/-/minipass-3.3.6.tgz";
      });
      pkgname = "minipass";
    };
    "minipass@5.0.0" = {
      pname = "minipass";
      version = "5.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-3FnjYuehv9k6ovOEbyOswadCDPX1piCfhV8ncmYtHOjuPwylVWsghTLo7rabjC3Rx5xD4HDx8Wm1xnMF7S5qFQ==";
        url = "https://registry.npmjs.org/minipass/-/minipass-5.0.0.tgz";
      });
      pkgname = "minipass";
    };
    "minipass@7.0.4" = {
      pname = "minipass";
      version = "7.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-jYofLM5Dam9279rdkWzqHozUo4ybjdZmCsDHePy5V/PbBcVMiSZR97gmAy45aqi8CK1lG2ECd356FU86avfwUQ==";
        url = "https://registry.npmjs.org/minipass/-/minipass-7.0.4.tgz";
      });
      pkgname = "minipass";
    };
    "minizlib@2.1.2" = {
      pname = "minizlib";
      version = "2.1.2";
      depKeys = [
        ("minipass@3.3.6")
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
      bin = {
        "bin/cmd.js" = "bin/cmd.js";
      };
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
      bin = {
        "bin/cmd.js" = "bin/cmd.js";
      };
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
        ("node-gyp@10.0.1")
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
        ("node-gyp@10.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-WOjGRNGkYZ5MXsntcvCYrKtSYMaewlbCFplbcUVo9bE80LPVt8TAVFHYWB8+a6fWCGYheq21+Wtt6CJrUaCJhw==";
        url = "https://registry.npmjs.org/native-watchdog/-/native-watchdog-1.3.0.tgz";
      });
      pkgname = "native-watchdog";
    };
    "negotiator@0.6.3" = {
      pname = "negotiator";
      version = "0.6.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-+EUsqGPLsM+j/zdChZjsnX51g4XrHFOIXwfnCVPGlQk/k5giakcKsuxCObBRu6DSm9opw/O6slWbJdghQM4bBg==";
        url = "https://registry.npmjs.org/negotiator/-/negotiator-0.6.3.tgz";
      });
      pkgname = "negotiator";
    };
    "node-addon-api@3.1.0" = {
      pname = "node-addon-api";
      version = "3.1.0";
      depKeys = [
        ("node-gyp@10.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-flmrDNB06LIl5lywUz7YlNGZH/5p0M7W28k8hzd9Lshtdh1wshD2Y+U4h9LD6KObOy1f+fEVdgprPrEymjM5uw==";
        url = "https://registry.npmjs.org/node-addon-api/-/node-addon-api-3.1.0.tgz";
      });
      pkgname = "node-addon-api";
    };
    "node-gyp@10.0.1" = {
      pname = "node-gyp";
      version = "10.0.1";
      depKeys = [
        ("env-paths@2.2.1")
        ("exponential-backoff@3.1.1")
        ("glob@10.3.10")
        ("graceful-fs@4.2.4")
        ("make-fetch-happen@13.0.0")
        ("nopt@7.2.0")
        ("proc-log@3.0.0")
        ("semver@7.5.4")
        ("tar@6.2.0")
        ("which@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-gg3/bHehQfZivQVfqIyy8wTdSymF9yTyP4CJifK73imyNMU8AIGQE2pUa7dNWfmMeG9cDVF2eehiRMv0LC1iAg==";
        url = "https://registry.npmjs.org/node-gyp/-/node-gyp-10.0.1.tgz";
      });
      bin = {
        "./bin/node-gyp.js" = "./bin/node-gyp.js";
      };
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
    "nopt@7.2.0" = {
      pname = "nopt";
      version = "7.2.0";
      depKeys = [
        ("abbrev@2.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-CVDtwCdhYIvnAzFoJ6NJ6dX3oga9/HyciQDnG1vQDjSLMeKLJ4A93ZqYKDrgYSr1FBY5/hMYC+2VCi24pgpkGA==";
        url = "https://registry.npmjs.org/nopt/-/nopt-7.2.0.tgz";
      });
      bin = {
        nopt = "bin/nopt.js";
      };
      pkgname = "nopt";
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
      src = (final.pathSrc ../../esy);
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
    "path-key@3.1.1" = {
      pname = "path-key";
      version = "3.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-ojmeN0qd+y0jszEtoY48r0Peq5dwMEkIlCOu6Q5f41lfkswXuKtYrhgoTpLnyIcHm24Uhqx+5Tqm2InSwLhE6Q==";
        url = "https://registry.npmjs.org/path-key/-/path-key-3.1.1.tgz";
      });
      pkgname = "path-key";
    };
    "path-scurry@1.10.1" = {
      pname = "path-scurry";
      version = "1.10.1";
      depKeys = [
        ("lru-cache@10.2.0")
        ("minipass@7.0.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-MkhCqzzBEpPvxxQ71Md0b1Kk51W01lrYvlMzSUaIzNsODdd7mqhiimSZlr+VegAz5Z6Vzt9Xg2ttE//XBhH3EQ==";
        url = "https://registry.npmjs.org/path-scurry/-/path-scurry-1.10.1.tgz";
      });
      pkgname = "path-scurry";
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
    "proc-log@3.0.0" = {
      pname = "proc-log";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-++Vn7NS4Xf9NacaU9Xq3URUuqZETPsf8L4j5/ckhaRYsfPeRyzGw+iDjFhV/Jr3uNmTvvddEJFWh5R1gRgUH8A==";
        url = "https://registry.npmjs.org/proc-log/-/proc-log-3.0.0.tgz";
      });
      pkgname = "proc-log";
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
    "semver@7.5.4" = {
      pname = "semver";
      version = "7.5.4";
      depKeys = [
        ("lru-cache@6.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-1bCSESV6Pv+i21Hvpxp3Dx+pSD8lIPt8uVjRrxAUt/nbswYc+tK6Y2btiULjd4+fnq15PX+nqQDC7Oft7WkwcA==";
        url = "https://registry.npmjs.org/semver/-/semver-7.5.4.tgz";
      });
      bin = {
        semver = "bin/semver.js";
      };
      pkgname = "semver";
    };
    "shebang-command@2.0.0" = {
      pname = "shebang-command";
      version = "2.0.0";
      depKeys = [
        ("shebang-regex@3.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-kHxr2zZpYtdmrN1qDjrrX/Z1rR1kG8Dx+gkpK1G4eXmvXswmcE1hTWBWYUzlraYw1/yZp6YuDY77YtvbN0dmDA==";
        url = "https://registry.npmjs.org/shebang-command/-/shebang-command-2.0.0.tgz";
      });
      pkgname = "shebang-command";
    };
    "shebang-regex@3.0.0" = {
      pname = "shebang-regex";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-7++dFhtcx3353uBaq8DDR4NuxBetBzC7ZQOhmTQInHEd6bSrXdiEyzCvG07Z44UYdLShWUyXt5M/yhz8ekcb1A==";
        url = "https://registry.npmjs.org/shebang-regex/-/shebang-regex-3.0.0.tgz";
      });
      pkgname = "shebang-regex";
    };
    "signal-exit@4.1.0" = {
      pname = "signal-exit";
      version = "4.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-bzyZ1e88w9O1iNJbKnOlvYTrWPDl46O1bG0D3XInv+9tkPrxrN8jUUTiFlDkkmKWgn1M6CfIA13SuGqOa9Korw==";
        url = "https://registry.npmjs.org/signal-exit/-/signal-exit-4.1.0.tgz";
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
        ("node-gyp@10.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-iGqDoA88G3Rv3lkbVQglTulp3nv12FzND6LDC7cOZ+OoFvWnXVb3+Ebhed60oZ6+IWWGwDtjXK6ympwr7C1XmQ==";
        url = "https://registry.npmjs.org/spdlog/-/spdlog-0.13.6.tgz";
      });
      pkgname = "spdlog";
    };
    "ssri@10.0.5" = {
      pname = "ssri";
      version = "10.0.5";
      depKeys = [
        ("minipass@7.0.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-bSf16tAFkGeRlUNDjXu8FzaMQt6g2HZJrun7mtMbIPOddxt3GLMSz5VWUWcqTJUPfLEaDIepGxv+bYQW49596A==";
        url = "https://registry.npmjs.org/ssri/-/ssri-10.0.5.tgz";
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
    "string-width@5.1.2" = {
      pname = "string-width";
      version = "5.1.2";
      depKeys = [
        ("eastasianwidth@0.2.0")
        ("emoji-regex@9.2.2")
        ("strip-ansi@7.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-HnLOCR3vjcY8beoNLtcjZ5/nxn2afmME6lhrDrebokqMap+XbeW8n9TXpPDOqdGK5qcI3oT0GKTW6wC7EMiVqA==";
        url = "https://registry.npmjs.org/string-width/-/string-width-5.1.2.tgz";
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
    "strip-ansi@7.1.0" = {
      pname = "strip-ansi";
      version = "7.1.0";
      depKeys = [
        ("ansi-regex@6.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-iq6eVVI64nQQTRYq2KtEg2d2uU7LElhTJwsH4YzIHZshxlgZms/wIc4VoDQTlG/IvVIrBKG06CrZnp0qv7hkcQ==";
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-7.1.0.tgz";
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
    "tar@6.2.0" = {
      pname = "tar";
      version = "6.2.0";
      depKeys = [
        ("chownr@2.0.0")
        ("fs-minipass@2.1.0")
        ("minipass@5.0.0")
        ("minizlib@2.1.2")
        ("mkdirp@1.0.4")
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-/Wo7DcT0u5HUV486xg675HtjNd3BXZ6xDbzsCUZPt5iw8bTQ63bP0Raut3mvro9u+CUyq7YQd8Cx55fsZXxqLQ==";
        url = "https://registry.npmjs.org/tar/-/tar-6.2.0.tgz";
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
      bin = {
        tsc = "./bin/tsc";
        tsserver = "./bin/tsserver";
      };
      pkgname = "typescript";
    };
    "typescript@typescript@npm%3A3.9.10#optional!builtin<compat/typescript>::version=3.9.10&hash=3bd3d3" = {
      pname = "typescript";
      version = "3.9.10";
      depKeys = [
      ];
      pkgname = "typescript";
    };
    "unique-filename@3.0.0" = {
      pname = "unique-filename";
      version = "3.0.0";
      depKeys = [
        ("unique-slug@4.0.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-afXhuC55wkAmZ0P18QsVE6kp8JaxrEokN2HGIoIVv2ijHQd419H0+6EigAFcIzXeMIkcIkNBpB3L/DXB3cTS/g==";
        url = "https://registry.npmjs.org/unique-filename/-/unique-filename-3.0.0.tgz";
      });
      pkgname = "unique-filename";
    };
    "unique-slug@4.0.0" = {
      pname = "unique-slug";
      version = "4.0.0";
      depKeys = [
        ("imurmurhash@0.1.4")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-WrcA6AyEfqDX5bWige/4NQfPZMtASNVxdmWR76WESYQVAACSgWcR6e9i0mofqqBxYFtL4oAxPIptY73/0YE1DQ==";
        url = "https://registry.npmjs.org/unique-slug/-/unique-slug-4.0.0.tgz";
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
        ("node-gyp@10.0.1")
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
      bin = {
        node-which = "./bin/node-which";
      };
      pkgname = "which";
    };
    "which@4.0.0" = {
      pname = "which";
      version = "4.0.0";
      depKeys = [
        ("isexe@3.1.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-GlaYyEb07DPxYCKhKzplCWBJtvxZcZMrL+4UkrTSJHHPyZU4mYYTv3qaOe77H7EODLSSopAUFAc6W8U4yqvscg==";
        url = "https://registry.npmjs.org/which/-/which-4.0.0.tgz";
      });
      bin = {
        node-which = "./bin/which.js";
      };
      pkgname = "which";
    };
    "wrap-ansi@7.0.0" = {
      pname = "wrap-ansi";
      version = "7.0.0";
      depKeys = [
        ("ansi-styles@4.3.0")
        ("string-width@4.2.3")
        ("strip-ansi@6.0.1")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-YVGIj2kamLSTxw6NsZjoBxfSwsn0ycdesmc4p+Q21c5zPuZ1pl+NfxVdxPtdHvmNVOQ6XSYG4AUtyt/Fi7D16Q==";
        url = "https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-7.0.0.tgz";
      });
      pkgname = "wrap-ansi";
    };
    "wrap-ansi@8.1.0" = {
      pname = "wrap-ansi";
      version = "8.1.0";
      depKeys = [
        ("ansi-styles@6.2.1")
        ("string-width@5.1.2")
        ("strip-ansi@7.1.0")
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-si7QWI6zUMq56bESFvagtmzMdGOtoxfR+Sez11Mobfc7tm+VkUckk9bW2UeffTGVUbOksxmSw0AA2gs8g71NCQ==";
        url = "https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-8.1.0.tgz";
      });
      pkgname = "wrap-ansi";
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