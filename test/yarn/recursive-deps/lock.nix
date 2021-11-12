final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "yarn";
    version = "1";
    root = "recursive-deps-test@.";
  };
  specs = {
    "ansi-regex@2.1.1" = {
      pname = "ansi-regex";
      version = "2.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dw0pqvijj9q9rfll09g4chszmakl5zr62k3ir9szvk5i0aapf2j";
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-2.1.1.tgz";
      });
      pkgname = "ansi-regex";
    };
    "ansi-styles@2.2.1" = {
      pname = "ansi-styles";
      version = "2.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "07qj2dsg3ydpj79cc8j52hzzylw8jq6xbl4yzq1573p3lnzkqq4d";
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-2.2.1.tgz";
      });
      pkgname = "ansi-styles";
    };
    "babel-code-frame@6.26.0" = {
      pname = "babel-code-frame";
      version = "6.26.0";
      depKeys = [
        ("chalk@1.1.3")
        ("esutils@2.0.3")
        ("js-tokens@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1kxnm3iixrg36bp4zg8hlclgqzs04bzrd3y43r5lir3kfiqyqbyf";
        url = "https://registry.npmjs.org/babel-code-frame/-/babel-code-frame-6.26.0.tgz";
      });
      pkgname = "babel-code-frame";
    };
    "babel-core@6.26.3" = {
      pname = "babel-core";
      version = "6.26.3";
      depKeys = [
        ("babel-code-frame@6.26.0")
        ("babel-generator@6.26.1")
        ("babel-helpers@6.24.1")
        ("babel-messages@6.23.0")
        ("babel-register@6.26.0")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
        ("babylon@6.18.0")
        ("convert-source-map@1.8.0")
        ("debug@2.6.9")
        ("json5@0.5.1")
        ("lodash@4.17.21")
        ("minimatch@3.0.4")
        ("path-is-absolute@1.0.1")
        ("private@0.1.8")
        ("slash@1.0.0")
        ("source-map@0.5.7")
      ];
      src = (pkgs.fetchurl {
        sha256 = "121m0hfhpkdkw6s7mq7v2m3vpf5m9l26drhw1vx9kww0ly1b2iww";
        url = "https://registry.npmjs.org/babel-core/-/babel-core-6.26.3.tgz";
      });
      pkgname = "babel-core";
    };
    "babel-generator@6.26.1" = {
      pname = "babel-generator";
      version = "6.26.1";
      depKeys = [
        ("babel-messages@6.23.0")
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
        ("detect-indent@4.0.0")
        ("jsesc@1.3.0")
        ("lodash@4.17.21")
        ("source-map@0.5.7")
        ("trim-right@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mghh2ry34j83zhjdw29kvzsnxpar9z8360wk7d3mr5kn5idfyim";
        url = "https://registry.npmjs.org/babel-generator/-/babel-generator-6.26.1.tgz";
      });
      pkgname = "babel-generator";
    };
    "babel-helpers@6.24.1" = {
      pname = "babel-helpers";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0zyrm4cb58pw1pi8vrkvgr2knlyg32xql863d9bai67m7bxamkh0";
        url = "https://registry.npmjs.org/babel-helpers/-/babel-helpers-6.24.1.tgz";
      });
      pkgname = "babel-helpers";
    };
    "babel-messages@6.23.0" = {
      pname = "babel-messages";
      version = "6.23.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dnrgmj2d7ai0aw7chd2gv9abphlp6y3ikb97mdgsrb112k4aws8";
        url = "https://registry.npmjs.org/babel-messages/-/babel-messages-6.23.0.tgz";
      });
      pkgname = "babel-messages";
    };
    "babel-register@6.26.0" = {
      pname = "babel-register";
      version = "6.26.0";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("core-js@2.6.12")
        ("home-or-tmp@2.0.0")
        ("lodash@4.17.21")
        ("mkdirp@0.5.5")
        ("source-map-support@0.4.18")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1r0ms90mrkgdaf73bgcmb47hipqdnmnxcs0ilayljh6g9ssvah6f";
        url = "https://registry.npmjs.org/babel-register/-/babel-register-6.26.0.tgz";
      });
      pkgname = "babel-register";
    };
    "babel-runtime@6.26.0" = {
      pname = "babel-runtime";
      version = "6.26.0";
      depKeys = [
        ("core-js@2.6.12")
        ("regenerator-runtime@0.11.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0swl6f8bw62qydhkq6qq53c8afxai4cqpd4rg7270jvl8s4lilhl";
        url = "https://registry.npmjs.org/babel-runtime/-/babel-runtime-6.26.0.tgz";
      });
      pkgname = "babel-runtime";
    };
    "babel-template@6.26.0" = {
      pname = "babel-template";
      version = "6.26.0";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
        ("babylon@6.18.0")
        ("lodash@4.17.21")
      ];
      src = (pkgs.fetchurl {
        sha256 = "10yz6bl4g8vbrj3j5xjix607zm162fyly7m857nibv1f5f3vjq05";
        url = "https://registry.npmjs.org/babel-template/-/babel-template-6.26.0.tgz";
      });
      pkgname = "babel-template";
    };
    "babel-traverse@6.26.0" = {
      pname = "babel-traverse";
      version = "6.26.0";
      depKeys = [
        ("babel-code-frame@6.26.0")
        ("babel-messages@6.23.0")
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
        ("babylon@6.18.0")
        ("debug@2.6.9")
        ("globals@9.18.0")
        ("invariant@2.2.4")
        ("lodash@4.17.21")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j8s7w5v5vkxg8i97gbh65928y0sih6vb4la3yymc2kpq9rnyam3";
        url = "https://registry.npmjs.org/babel-traverse/-/babel-traverse-6.26.0.tgz";
      });
      pkgname = "babel-traverse";
    };
    "babel-types@6.26.0" = {
      pname = "babel-types";
      version = "6.26.0";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("esutils@2.0.3")
        ("lodash@4.17.21")
        ("to-fast-properties@1.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1sbd36x65rzvpi7jikq6a98vnac5hsmpx3kikjfmm8wq1hzl9gl7";
        url = "https://registry.npmjs.org/babel-types/-/babel-types-6.26.0.tgz";
      });
      pkgname = "babel-types";
    };
    "babylon@6.18.0" = {
      pname = "babylon";
      version = "6.18.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "136qg328s73a39zqcpsq0v1wpgmaqlp6swdsiagjg2apdg9q27nf";
        url = "https://registry.npmjs.org/babylon/-/babylon-6.18.0.tgz";
      });
      pkgname = "babylon";
    };
    "balanced-match@1.0.2" = {
      pname = "balanced-match";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1hdwrr7qqb37plj7962xbwjx1jvjz7ahl7iqrwh82yhcvnmzfm6q";
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.2.tgz";
      });
      pkgname = "balanced-match";
    };
    "brace-expansion@1.1.11" = {
      pname = "brace-expansion";
      version = "1.1.11";
      depKeys = [
        ("balanced-match@1.0.2")
        ("concat-map@0.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nlmjvlwlp88knblnayns0brr7a9m2fynrlwq425lrpb4mcn9gc4";
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
      });
      pkgname = "brace-expansion";
    };
    "chalk@1.1.3" = {
      pname = "chalk";
      version = "1.1.3";
      depKeys = [
        ("ansi-styles@2.2.1")
        ("escape-string-regexp@1.0.5")
        ("has-ansi@2.0.0")
        ("strip-ansi@3.0.1")
        ("supports-color@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pa4ajfiq9prr608wldd6y6w7asmgravbbx63qz6yj7s6d49r5rk";
        url = "https://registry.npmjs.org/chalk/-/chalk-1.1.3.tgz";
      });
      pkgname = "chalk";
    };
    "concat-map@0.0.1" = {
      pname = "concat-map";
      version = "0.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0qa2zqn9rrr2fqdki44s4s2dk2d8307i4556kv25h06g43b2v41m";
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
      });
      pkgname = "concat-map";
    };
    "convert-source-map@1.8.0" = {
      pname = "convert-source-map";
      version = "1.8.0";
      depKeys = [
        ("safe-buffer@5.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1apsxhm78hy61ps4scby5d7v6ih7rqk5bf4rba7gw16djq7g7xcg";
        url = "https://registry.npmjs.org/convert-source-map/-/convert-source-map-1.8.0.tgz";
      });
      pkgname = "convert-source-map";
    };
    "core-js@2.6.12" = {
      pname = "core-js";
      version = "2.6.12";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0idawjihpabdgpq1w460phfls3wrmgkl3idll6h68cy48k2z6bw7";
        url = "https://registry.npmjs.org/core-js/-/core-js-2.6.12.tgz";
      });
      pkgname = "core-js";
    };
    "debug@2.6.9" = {
      pname = "debug";
      version = "2.6.9";
      depKeys = [
        ("ms@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "160wvc74r8aypds7pym3hq4qpa786hpk4vif58ggiwcqcv34ibil";
        url = "https://registry.npmjs.org/debug/-/debug-2.6.9.tgz";
      });
      pkgname = "debug";
    };
    "detect-indent@4.0.0" = {
      pname = "detect-indent";
      version = "4.0.0";
      depKeys = [
        ("repeating@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ln333w741rgqmbjx8sm5gns2y1v5d1sjs3rsrlisgi7l2pnqhyl";
        url = "https://registry.npmjs.org/detect-indent/-/detect-indent-4.0.0.tgz";
      });
      pkgname = "detect-indent";
    };
    "escape-string-regexp@1.0.5" = {
      pname = "escape-string-regexp";
      version = "1.0.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0iy3jirnnslnfwk8wa5xkg56fnbmg7bsv5v2a1s0qgbnfqp7j375";
        url = "https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz";
      });
      pkgname = "escape-string-regexp";
    };
    "esutils@2.0.3" = {
      pname = "esutils";
      version = "2.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "03v4y32k50mbxwv70prr7ghwg59vd5gyxsdsbdikqnj919rvvbf5";
        url = "https://registry.npmjs.org/esutils/-/esutils-2.0.3.tgz";
      });
      pkgname = "esutils";
    };
    "globals@9.18.0" = {
      pname = "globals";
      version = "9.18.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ykkbjaci7i4xs42qpmng2jna7bg0947dmx5qj8s2nnl1p0i4yj3";
        url = "https://registry.npmjs.org/globals/-/globals-9.18.0.tgz";
      });
      pkgname = "globals";
    };
    "has-ansi@2.0.0" = {
      pname = "has-ansi";
      version = "2.0.0";
      depKeys = [
        ("ansi-regex@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1va48dv32ighffpqr44dl8l5mm7kc5mylkd6drcd6y0y97mna0p3";
        url = "https://registry.npmjs.org/has-ansi/-/has-ansi-2.0.0.tgz";
      });
      pkgname = "has-ansi";
    };
    "home-or-tmp@2.0.0" = {
      pname = "home-or-tmp";
      version = "2.0.0";
      depKeys = [
        ("os-homedir@1.0.2")
        ("os-tmpdir@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "05wi6v11il5hlqca97kyrmyl7df15svn9skkqi4vn5hx9vpxc1rf";
        url = "https://registry.npmjs.org/home-or-tmp/-/home-or-tmp-2.0.0.tgz";
      });
      pkgname = "home-or-tmp";
    };
    "invariant@2.2.4" = {
      pname = "invariant";
      version = "2.2.4";
      depKeys = [
        ("loose-envify@1.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "10gsxw2r0k3klikn05h6h1fbss9l8cxq0crxnxf1jpl0c7g0ijk8";
        url = "https://registry.npmjs.org/invariant/-/invariant-2.2.4.tgz";
      });
      pkgname = "invariant";
    };
    "is-finite@1.1.0" = {
      pname = "is-finite";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "01ic03rd5zkpqy432gxbq6vxlffdfpyzsa79mplr4vbh6lcp8fby";
        url = "https://registry.npmjs.org/is-finite/-/is-finite-1.1.0.tgz";
      });
      pkgname = "is-finite";
    };
    "js-tokens@3.0.2" = {
      pname = "js-tokens";
      version = "3.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "06bx34y8rvlkhrhffqm5gw5fwc219mnvxnxipj9y0r22fdv7mkl5";
        url = "https://registry.npmjs.org/js-tokens/-/js-tokens-3.0.2.tgz";
      });
      pkgname = "js-tokens";
    };
    "js-tokens@4.0.0" = {
      pname = "js-tokens";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0lrw3qvcfmxrwwi7p7ng4r17yw32ki7jpnbj2a65ddddv2icg16q";
        url = "https://registry.npmjs.org/js-tokens/-/js-tokens-4.0.0.tgz";
      });
      pkgname = "js-tokens";
    };
    "jsesc@1.3.0" = {
      pname = "jsesc";
      version = "1.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1895g0pm7qmm7ajka5zpkk8gqwp794inxwraq99ny3161r0bqjhh";
        url = "https://registry.npmjs.org/jsesc/-/jsesc-1.3.0.tgz";
      });
      pkgname = "jsesc";
    };
    "json5@0.5.1" = {
      pname = "json5";
      version = "0.5.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "07p6zcrl2m92gdp5qmy01h8cqzg3cb7rnmln74qc8fg1xw0ki8sy";
        url = "https://registry.npmjs.org/json5/-/json5-0.5.1.tgz";
      });
      pkgname = "json5";
    };
    "lodash@4.17.21" = {
      pname = "lodash";
      version = "4.17.21";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "017qragyfl5ifajdx48lvz46wr0jc1llikgvc2fhqakhwp4pl23a";
        url = "https://registry.npmjs.org/lodash/-/lodash-4.17.21.tgz";
      });
      pkgname = "lodash";
    };
    "loose-envify@1.4.0" = {
      pname = "loose-envify";
      version = "1.4.0";
      depKeys = [
        ("js-tokens@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1p5b3ca0b2jkxalyg7h9bss6aspa8plkh0ak1mrlz2jkjc58660j";
        url = "https://registry.npmjs.org/loose-envify/-/loose-envify-1.4.0.tgz";
      });
      pkgname = "loose-envify";
    };
    "minimatch@3.0.4" = {
      pname = "minimatch";
      version = "3.0.4";
      depKeys = [
        ("brace-expansion@1.1.11")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wgammjc9myx0k0k3n9r9cjnv0r1j33cwqiy2fxx7w5nkgbj8sj2";
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
        sha256 = "0l23rq2pam1khc06kd7fv0ys2cq0mlgs82dxjxjfjmlksgj0r051";
        url = "https://registry.npmjs.org/minimist/-/minimist-1.2.5.tgz";
      });
      pkgname = "minimist";
    };
    "mkdirp@0.5.5" = {
      pname = "mkdirp";
      version = "0.5.5";
      depKeys = [
        ("minimist@1.2.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "02mvn5hllnsxzli8yy0gkgkkxndbwd3fh302shadsag3c4db0njf";
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.5.tgz";
      });
      pkgname = "mkdirp";
    };
    "ms@2.0.0" = {
      pname = "ms";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jrysw9zx14av3jdvc3kywc3xkjqxh748g4s6p1iy634i2mm489n";
        url = "https://registry.npmjs.org/ms/-/ms-2.0.0.tgz";
      });
      pkgname = "ms";
    };
    "os-homedir@1.0.2" = {
      pname = "os-homedir";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xa4n9ybd93a20faw2f3lj5jz4aawnw7lpxnnxq2ndgcmz48bs0f";
        url = "https://registry.npmjs.org/os-homedir/-/os-homedir-1.0.2.tgz";
      });
      pkgname = "os-homedir";
    };
    "os-tmpdir@1.0.2" = {
      pname = "os-tmpdir";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12ddjb45wq0swr2159wiaxl2balnli8127if7sc89h3psz125rqk";
        url = "https://registry.npmjs.org/os-tmpdir/-/os-tmpdir-1.0.2.tgz";
      });
      pkgname = "os-tmpdir";
    };
    "path-is-absolute@1.0.1" = {
      pname = "path-is-absolute";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0p7p04xxd8q495qhxmxydyjgzcf762dp1hp2wha2b52n3agp0vbf";
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
      });
      pkgname = "path-is-absolute";
    };
    "private@0.1.8" = {
      pname = "private";
      version = "0.1.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "06rwyb4w6cy5rxlnhs2vw6d0sm5j36n98xb9qcl5zzxnd7x11fi2";
        url = "https://registry.npmjs.org/private/-/private-0.1.8.tgz";
      });
      pkgname = "private";
    };
    "recursive-deps-test@." = {
      pname = "recursive-deps-test";
      version = "0.0.0-use.local";
      depKeys = [
        ("babel-core@6.26.3")
        ("babel-register@6.26.0")
      ];
      bin = {
        main = "main.js";
      };
      nodePathDeps = [
        ("babel-core@6.26.3")
      ];
      pkgname = "recursive-deps-test";
    };
    "regenerator-runtime@0.11.1" = {
      pname = "regenerator-runtime";
      version = "0.11.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0frppih4qlrkvl1xgyd9zpgxs3fp0sarpcywwn7v1dmkhidrin6d";
        url = "https://registry.npmjs.org/regenerator-runtime/-/regenerator-runtime-0.11.1.tgz";
      });
      pkgname = "regenerator-runtime";
    };
    "repeating@2.0.1" = {
      pname = "repeating";
      version = "2.0.1";
      depKeys = [
        ("is-finite@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "15w0nan6zgw2c1w0nclbbld80gi12grhssb82dmgrm6zvsjnss1b";
        url = "https://registry.npmjs.org/repeating/-/repeating-2.0.1.tgz";
      });
      pkgname = "repeating";
    };
    "safe-buffer@5.1.2" = {
      pname = "safe-buffer";
      version = "5.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "08ma0a2a9j537bxl7qd2dn6sjcdhrclpdbslr19bkbyc1z30d4p0";
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.1.2.tgz";
      });
      pkgname = "safe-buffer";
    };
    "slash@1.0.0" = {
      pname = "slash";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0cfd5aqizqsd8d7mcf9rrpswdnlky874y3va2bpd0qb135ff9ymj";
        url = "https://registry.npmjs.org/slash/-/slash-1.0.0.tgz";
      });
      pkgname = "slash";
    };
    "source-map-support@0.4.18" = {
      pname = "source-map-support";
      version = "0.4.18";
      depKeys = [
        ("source-map@0.5.7")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1q5dc1x8dmd7vgm898zdlhsvl2vllbp6b3z9jkhv2fahpiqfprw2";
        url = "https://registry.npmjs.org/source-map-support/-/source-map-support-0.4.18.tgz";
      });
      pkgname = "source-map-support";
    };
    "source-map@0.5.7" = {
      pname = "source-map";
      version = "0.5.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0rvb24j4kfib26w3cjyl6yan2dxvw1iy7d0wl404y5ckqjdjipp1";
        url = "https://registry.npmjs.org/source-map/-/source-map-0.5.7.tgz";
      });
      pkgname = "source-map";
    };
    "strip-ansi@3.0.1" = {
      pname = "strip-ansi";
      version = "3.0.1";
      depKeys = [
        ("ansi-regex@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0fkrbfwig3d1i8s01pbj08pq1z6sn9xqvkjdz0a9b58q85d3i78w";
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-3.0.1.tgz";
      });
      pkgname = "strip-ansi";
    };
    "supports-color@2.0.0" = {
      pname = "supports-color";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lwscnhhmxpi3fbclkva5zg411cw9p0mgabbk3mic3sfshjlnpbj";
        url = "https://registry.npmjs.org/supports-color/-/supports-color-2.0.0.tgz";
      });
      pkgname = "supports-color";
    };
    "to-fast-properties@1.0.3" = {
      pname = "to-fast-properties";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "08cc0bwrpdgljjd59jqvywd23ix0spyhb5padhkrffin1crxp9ii";
        url = "https://registry.npmjs.org/to-fast-properties/-/to-fast-properties-1.0.3.tgz";
      });
      pkgname = "to-fast-properties";
    };
    "trim-right@1.0.1" = {
      pname = "trim-right";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "11frpwy0w9xp22r23n02vv21669fzrag3qmasdnzlfw4j61biww9";
        url = "https://registry.npmjs.org/trim-right/-/trim-right-1.0.1.tgz";
      });
      pkgname = "trim-right";
    };
  };
}