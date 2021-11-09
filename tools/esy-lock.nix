final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "yarn";
    version = "1";
    root = "esy@.";
  };
  specs = {
    "@babel/code-frame@7.5.5" = {
      pname = "babel-code-frame";
      version = "7.5.5";
      depKeys = [
        ("@babel/highlight@7.5.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "161qqphf6rq2g0mbshxq97jbkax3fzakk3ks2qi7md9wj495sy2j";
        url = "https://registry.npmjs.org/@babel/code-frame/-/code-frame-7.5.5.tgz";
      });
      pkgname = "@babel/code-frame";
    };
    "@babel/highlight@7.5.0" = {
      pname = "babel-highlight";
      version = "7.5.0";
      depKeys = [
        ("chalk@2.4.2")
        ("esutils@2.0.2")
        ("js-tokens@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0djk41h2j8q4b3yfwvikvcmp461k20ak8s7c9jb2cbjf45n842gl";
        url = "https://registry.npmjs.org/@babel/highlight/-/highlight-7.5.0.tgz";
      });
      pkgname = "@babel/highlight";
    };
    "@gar/promisify@1.1.2" = {
      pname = "gar-promisify";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1g6blv5d6gxsk48f1ww71amws0h4sj5k3mdc9gsbnzn2dbk9nj5v";
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
        sha256 = "1rbqb4dkb62jjf7lzsc2bd4k7h0aigdwqbklragq1sain1rv2qv7";
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
        sha256 = "0cp0p47drhfbi8xx8hc33kca930wfdia81p6wqfbmyxhn559rnn6";
        url = "https://registry.npmjs.org/@npmcli/move-file/-/move-file-1.1.2.tgz";
      });
      pkgname = "@npmcli/move-file";
    };
    "@tootallnate/once@1.1.2" = {
      pname = "tootallnate-once";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0b5fjhh1hq6hraacjch4dybc4blaf16l430w0mfsycnibm4g7r6p";
        url = "https://registry.npmjs.org/@tootallnate/once/-/once-1.1.2.tgz";
      });
      pkgname = "@tootallnate/once";
    };
    "abab@2.0.0" = {
      pname = "abab";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x3fd25z5dw8xh1v0flkj019gq0mr814pv992r8i91m2skj17jj7";
        url = "https://registry.npmjs.org/abab/-/abab-2.0.0.tgz";
      });
      pkgname = "abab";
    };
    "abbrev@1.1.1" = {
      pname = "abbrev";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0vdsff38rgn0qylyj6x42n13bnxfqxb9ql34bzs4z9grlli9vh8c";
        url = "https://registry.npmjs.org/abbrev/-/abbrev-1.1.1.tgz";
      });
      pkgname = "abbrev";
    };
    "acorn-globals@4.3.2" = {
      pname = "acorn-globals";
      version = "4.3.2";
      depKeys = [
        ("acorn@6.2.1")
        ("acorn-walk@6.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pll1saa6n09zqjpc4wqg1pabl4p8cqqdgj4pm5b69ihdlkciw4l";
        url = "https://registry.npmjs.org/acorn-globals/-/acorn-globals-4.3.2.tgz";
      });
      pkgname = "acorn-globals";
    };
    "acorn-walk@6.2.0" = {
      pname = "acorn-walk";
      version = "6.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "187n11kv5f6qnv5d13ww64jpmzq6cznfjvifkfw5389ixn1m44v0";
        url = "https://registry.npmjs.org/acorn-walk/-/acorn-walk-6.2.0.tgz";
      });
      pkgname = "acorn-walk";
    };
    "acorn@5.7.3" = {
      pname = "acorn";
      version = "5.7.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "122113cbpv2glwd1sa2jkas1qci3lx5s7h06j3i0mcrgkkg74n91";
        url = "https://registry.npmjs.org/acorn/-/acorn-5.7.3.tgz";
      });
      pkgname = "acorn";
    };
    "acorn@6.2.1" = {
      pname = "acorn";
      version = "6.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dn0g6brp7kqgn1vbab69whs5gf811pyhpb7h0k9yz4cq9vcjlkl";
        url = "https://registry.npmjs.org/acorn/-/acorn-6.2.1.tgz";
      });
      pkgname = "acorn";
    };
    "agent-base@6.0.2" = {
      pname = "agent-base";
      version = "6.0.2";
      depKeys = [
        ("debug@4.3.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0cg85gngrap12xzz8ibdjw98hcfhgcidg2w7ll7whsrf59ps0vdw";
        url = "https://registry.npmjs.org/agent-base/-/agent-base-6.0.2.tgz";
      });
      pkgname = "agent-base";
    };
    "agentkeepalive@4.1.4" = {
      pname = "agentkeepalive";
      version = "4.1.4";
      depKeys = [
        ("debug@4.3.2")
        ("depd@1.1.2")
        ("humanize-ms@1.2.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0918w95j5987jj3yblf2gwa2mjrwd25f4szh6b7j5vraiayq12aa";
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
        sha256 = "0nr0ig4k5d5n019cjj4h4027316ppdjy8wnykv32b95bnnw0qdh3";
        url = "https://registry.npmjs.org/aggregate-error/-/aggregate-error-3.1.0.tgz";
      });
      pkgname = "aggregate-error";
    };
    "ajv@6.10.2" = {
      pname = "ajv";
      version = "6.10.2";
      depKeys = [
        ("fast-deep-equal@2.0.1")
        ("fast-json-stable-stringify@2.0.0")
        ("json-schema-traverse@0.4.1")
        ("uri-js@4.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "00wy11l53sn0rd4p7b12dp9iqia72jvj9rxc2vg91aghs3z03ln1";
        url = "https://registry.npmjs.org/ajv/-/ajv-6.10.2.tgz";
      });
      pkgname = "ajv";
    };
    "ansi-escapes@3.2.0" = {
      pname = "ansi-escapes";
      version = "3.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "13ags8v3fa8ijgkhajaqf6nc5s5xhhxkkn9c44npgnwhdcx93v1f";
        url = "https://registry.npmjs.org/ansi-escapes/-/ansi-escapes-3.2.0.tgz";
      });
      pkgname = "ansi-escapes";
    };
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
    "ansi-regex@3.0.0" = {
      pname = "ansi-regex";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0d9xwkpwak84xixi7f21bxvrbdgdpwm4pna73jkm8pfk6v8b1bdx";
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-3.0.0.tgz";
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
    "ansi-styles@3.2.1" = {
      pname = "ansi-styles";
      version = "3.2.1";
      depKeys = [
        ("color-convert@1.9.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1wqd08glq159q724kvpi6nnf87biajr749a7r9c84xm639g6463k";
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-3.2.1.tgz";
      });
      pkgname = "ansi-styles";
    };
    "anymatch@2.0.0" = {
      pname = "anymatch";
      version = "2.0.0";
      depKeys = [
        ("micromatch@3.1.10")
        ("normalize-path@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1cj8jwy1k9mg7pmscs4dl6id8wg62fx3vfhw8snjbmbivzh9p7a0";
        url = "https://registry.npmjs.org/anymatch/-/anymatch-2.0.0.tgz";
      });
      pkgname = "anymatch";
    };
    "append-transform@0.4.0" = {
      pname = "append-transform";
      version = "0.4.0";
      depKeys = [
        ("default-require-extensions@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1x498jsfyqlys1m9wmbvm5n0z5zf2vzpw0ja700nw6qf795mlfx2";
        url = "https://registry.npmjs.org/append-transform/-/append-transform-0.4.0.tgz";
      });
      pkgname = "append-transform";
    };
    "aproba@1.2.0" = {
      pname = "aproba";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "17g0x3q0jy73db7n9x7aw9dazv7adhar5y7pyilkznq53v3niwss";
        url = "https://registry.npmjs.org/aproba/-/aproba-1.2.0.tgz";
      });
      pkgname = "aproba";
    };
    "are-we-there-yet@1.1.5" = {
      pname = "are-we-there-yet";
      version = "1.1.5";
      depKeys = [
        ("delegates@1.0.0")
        ("readable-stream@2.3.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ib2m739sxwmxqb6cnpj6mwghrkjs3mga1xsfi00vgs6540vdhf5";
        url = "https://registry.npmjs.org/are-we-there-yet/-/are-we-there-yet-1.1.5.tgz";
      });
      pkgname = "are-we-there-yet";
    };
    "argparse@1.0.10" = {
      pname = "argparse";
      version = "1.0.10";
      depKeys = [
        ("sprintf-js@1.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "03dc2n1i08nwyyl1l8pq0a5fckcw9rpdqlw3zh8pw6w1syf19akz";
        url = "https://registry.npmjs.org/argparse/-/argparse-1.0.10.tgz";
      });
      pkgname = "argparse";
    };
    "arr-diff@2.0.0" = {
      pname = "arr-diff";
      version = "2.0.0";
      depKeys = [
        ("arr-flatten@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "180fm2zz2qqygr715i4dwdpqypvf2gap4wds1crdhpdlbc3c2wpd";
        url = "https://registry.npmjs.org/arr-diff/-/arr-diff-2.0.0.tgz";
      });
      pkgname = "arr-diff";
    };
    "arr-diff@4.0.0" = {
      pname = "arr-diff";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1735byq6vmrvqkv9n5400494mh9vd6x4knzkybgr55km5dgpdcyx";
        url = "https://registry.npmjs.org/arr-diff/-/arr-diff-4.0.0.tgz";
      });
      pkgname = "arr-diff";
    };
    "arr-flatten@1.1.0" = {
      pname = "arr-flatten";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0amnq01y6y8j49rdcib9yh8n95wk2ajs3qcckccvv1x6bf6nfvay";
        url = "https://registry.npmjs.org/arr-flatten/-/arr-flatten-1.1.0.tgz";
      });
      pkgname = "arr-flatten";
    };
    "arr-union@3.1.0" = {
      pname = "arr-union";
      version = "3.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jrcfq6xnx3lbvnpl9pzfvc2v3bcgyir1vwcc7p0slhf6gglzd3p";
        url = "https://registry.npmjs.org/arr-union/-/arr-union-3.1.0.tgz";
      });
      pkgname = "arr-union";
    };
    "array-equal@1.0.0" = {
      pname = "array-equal";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "06bagyibk80gv8mlvp0ya8ryj2fgiyrj16jdql1myx5jlw582rqa";
        url = "https://registry.npmjs.org/array-equal/-/array-equal-1.0.0.tgz";
      });
      pkgname = "array-equal";
    };
    "array-foreach@1.0.2" = {
      pname = "array-foreach";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "04rfb9w1y6kxk7wxwr5inc0c7npzzgiqrnjyg2dcznk3jwab5y7d";
        url = "https://registry.npmjs.org/array-foreach/-/array-foreach-1.0.2.tgz";
      });
      pkgname = "array-foreach";
    };
    "array-map@0.0.0" = {
      pname = "array-map";
      version = "0.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1mmvcsy88wnzb3gg34cln9qizqcda4bam6cgxf8vib5pnizk2zj5";
        url = "https://registry.npmjs.org/array-map/-/array-map-0.0.0.tgz";
      });
      pkgname = "array-map";
    };
    "array-union@1.0.2" = {
      pname = "array-union";
      version = "1.0.2";
      depKeys = [
        ("array-uniq@1.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ivr7ywdj40hdsqcnwyhdayx37sbrs0hdfjmf35b0x6qddqgm8w8";
        url = "https://registry.npmjs.org/array-union/-/array-union-1.0.2.tgz";
      });
      pkgname = "array-union";
    };
    "array-uniq@1.0.3" = {
      pname = "array-uniq";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1r3jdy6pw004czvcbamr08wh7g2nmwwlskdzf1wa6rbm63gbqnng";
        url = "https://registry.npmjs.org/array-uniq/-/array-uniq-1.0.3.tgz";
      });
      pkgname = "array-uniq";
    };
    "array-unique@0.2.1" = {
      pname = "array-unique";
      version = "0.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12j74kq24w0xpj6zxdqj0zlgr97ls02yqph2vbbk05q7bgbkckvy";
        url = "https://registry.npmjs.org/array-unique/-/array-unique-0.2.1.tgz";
      });
      pkgname = "array-unique";
    };
    "array-unique@0.3.2" = {
      pname = "array-unique";
      version = "0.3.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0bkrb481qri7qad5h4bzw9hq161wfqgxdj5g11a5bnlfylqczg9g";
        url = "https://registry.npmjs.org/array-unique/-/array-unique-0.3.2.tgz";
      });
      pkgname = "array-unique";
    };
    "arrify@1.0.1" = {
      pname = "arrify";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dw9ha2mwzfg0d5h0b8r3rkwqy0iz8qhsrz5br0wkw96yafxvblp";
        url = "https://registry.npmjs.org/arrify/-/arrify-1.0.1.tgz";
      });
      pkgname = "arrify";
    };
    "asn1@0.2.4" = {
      pname = "asn1";
      version = "0.2.4";
      depKeys = [
        ("safer-buffer@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0fymjdkmd7kg4kyga0hssiwdz9jz5nv8fyndl3l1dr9q9jbl9971";
        url = "https://registry.npmjs.org/asn1/-/asn1-0.2.4.tgz";
      });
      pkgname = "asn1";
    };
    "assert-plus@1.0.0" = {
      pname = "assert-plus";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1srkj0nyslz3rbfncj59sqbsllavmwik8gphd7jxwjshf52mras7";
        url = "https://registry.npmjs.org/assert-plus/-/assert-plus-1.0.0.tgz";
      });
      pkgname = "assert-plus";
    };
    "assign-symbols@1.0.0" = {
      pname = "assign-symbols";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lpcb6gzhdl4l9843kifsz9z48qwpk5gw6b1h6f6n7h5d8qp2xab";
        url = "https://registry.npmjs.org/assign-symbols/-/assign-symbols-1.0.0.tgz";
      });
      pkgname = "assign-symbols";
    };
    "astral-regex@1.0.0" = {
      pname = "astral-regex";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dfsyvplajlv45f9dk9h778vkggxl4lrl3p5i7b890amqrwkmaji";
        url = "https://registry.npmjs.org/astral-regex/-/astral-regex-1.0.0.tgz";
      });
      pkgname = "astral-regex";
    };
    "async-limiter@1.0.0" = {
      pname = "async-limiter";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0spgqbcg5x88z1ffqdl6s2adwygl1c98hxwqbdnq94n9xxsk4hny";
        url = "https://registry.npmjs.org/async-limiter/-/async-limiter-1.0.0.tgz";
      });
      pkgname = "async-limiter";
    };
    "async@2.6.3" = {
      pname = "async";
      version = "2.6.3";
      depKeys = [
        ("lodash@4.17.15")
      ];
      src = (pkgs.fetchurl {
        sha256 = "06dyis2y9ai5if7jpnnjs1pikpiyawxh4pchv4zgaaprlm3nfnxb";
        url = "https://registry.npmjs.org/async/-/async-2.6.3.tgz";
      });
      pkgname = "async";
    };
    "asynckit@0.4.0" = {
      pname = "asynckit";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1kvxnmjbjwqc8gvp4ms7d8w8x7y41rcizmz4898694h7ywq4y9cc";
        url = "https://registry.npmjs.org/asynckit/-/asynckit-0.4.0.tgz";
      });
      pkgname = "asynckit";
    };
    "atob@2.1.2" = {
      pname = "atob";
      version = "2.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nmrnfpzg9a99i4p88knw3470d5vcqmm3hyhavlln96wnza2lbg5";
        url = "https://registry.npmjs.org/atob/-/atob-2.1.2.tgz";
      });
      pkgname = "atob";
    };
    "aws-sign2@0.7.0" = {
      pname = "aws-sign2";
      version = "0.7.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12bjw01pgh0nfyxi7vw6lvsapyvnazrnyn4qf87lclardjaz9yd8";
        url = "https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.7.0.tgz";
      });
      pkgname = "aws-sign2";
    };
    "aws4@1.8.0" = {
      pname = "aws4";
      version = "1.8.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "024d48fqgvp1a7v1ln9xp17arvxn967y73yk6z6x0cjgmz0hq4dn";
        url = "https://registry.npmjs.org/aws4/-/aws4-1.8.0.tgz";
      });
      pkgname = "aws4";
    };
    "babel-code-frame@6.26.0" = {
      pname = "babel-code-frame";
      version = "6.26.0";
      depKeys = [
        ("chalk@1.1.3")
        ("esutils@2.0.2")
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
        ("convert-source-map@1.6.0")
        ("debug@2.6.9")
        ("json5@0.5.1")
        ("lodash@4.17.15")
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
        ("lodash@4.17.15")
        ("source-map@0.5.7")
        ("trim-right@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mghh2ry34j83zhjdw29kvzsnxpar9z8360wk7d3mr5kn5idfyim";
        url = "https://registry.npmjs.org/babel-generator/-/babel-generator-6.26.1.tgz";
      });
      pkgname = "babel-generator";
    };
    "babel-helper-builder-binary-assignment-operator-visitor@6.24.1" = {
      pname = "babel-helper-builder-binary-assignment-operator-visitor";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-explode-assignable-expression@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xb6qbcv3nwd40ss86xvjinx58j7drpnivn2jpraqvac4sacv4am";
        url = "https://registry.npmjs.org/babel-helper-builder-binary-assignment-operator-visitor/-/babel-helper-builder-binary-assignment-operator-visitor-6.24.1.tgz";
      });
      pkgname = "babel-helper-builder-binary-assignment-operator-visitor";
    };
    "babel-helper-call-delegate@6.24.1" = {
      pname = "babel-helper-call-delegate";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-hoist-variables@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1h747k5knbry0y3ar072mn1c2lbv88lwvryl3z1jn4ljazf60lzm";
        url = "https://registry.npmjs.org/babel-helper-call-delegate/-/babel-helper-call-delegate-6.24.1.tgz";
      });
      pkgname = "babel-helper-call-delegate";
    };
    "babel-helper-define-map@6.26.0" = {
      pname = "babel-helper-define-map";
      version = "6.26.0";
      depKeys = [
        ("babel-helper-function-name@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
        ("lodash@4.17.15")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j512smbfli9ss73v6ksispp5jyh0gybsnc93lzfs4ymb008lpdz";
        url = "https://registry.npmjs.org/babel-helper-define-map/-/babel-helper-define-map-6.26.0.tgz";
      });
      pkgname = "babel-helper-define-map";
    };
    "babel-helper-explode-assignable-expression@6.24.1" = {
      pname = "babel-helper-explode-assignable-expression";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1k6g0hpaajzxgxvv8q3kbiql309wgamw2iq7bnv7gp4hflvhan69";
        url = "https://registry.npmjs.org/babel-helper-explode-assignable-expression/-/babel-helper-explode-assignable-expression-6.24.1.tgz";
      });
      pkgname = "babel-helper-explode-assignable-expression";
    };
    "babel-helper-function-name@6.24.1" = {
      pname = "babel-helper-function-name";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-get-function-arity@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1s3dxblvy2m5kxf1pl163q8pj10yifpbhrsm9im8xihjwlsdv0wc";
        url = "https://registry.npmjs.org/babel-helper-function-name/-/babel-helper-function-name-6.24.1.tgz";
      });
      pkgname = "babel-helper-function-name";
    };
    "babel-helper-get-function-arity@6.24.1" = {
      pname = "babel-helper-get-function-arity";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "198sa2kf5il61y3ga9bs7a48cxikz2rmbl6j72x34h33g042f1bb";
        url = "https://registry.npmjs.org/babel-helper-get-function-arity/-/babel-helper-get-function-arity-6.24.1.tgz";
      });
      pkgname = "babel-helper-get-function-arity";
    };
    "babel-helper-hoist-variables@6.24.1" = {
      pname = "babel-helper-hoist-variables";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lwba91g0x193gwmc8z47kgsi8260acix5cv24vlk5x6b8hhzr9q";
        url = "https://registry.npmjs.org/babel-helper-hoist-variables/-/babel-helper-hoist-variables-6.24.1.tgz";
      });
      pkgname = "babel-helper-hoist-variables";
    };
    "babel-helper-optimise-call-expression@6.24.1" = {
      pname = "babel-helper-optimise-call-expression";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0a31giba3dzc0jh3z5vjwwihf8smwhpjnacxl71f40400v5vpk07";
        url = "https://registry.npmjs.org/babel-helper-optimise-call-expression/-/babel-helper-optimise-call-expression-6.24.1.tgz";
      });
      pkgname = "babel-helper-optimise-call-expression";
    };
    "babel-helper-regex@6.26.0" = {
      pname = "babel-helper-regex";
      version = "6.26.0";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
        ("lodash@4.17.15")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1i6q21bc2gi7pi9g5l2x9wcwxxdx9mnwq2d4qrfmr2cnnzxy58mm";
        url = "https://registry.npmjs.org/babel-helper-regex/-/babel-helper-regex-6.26.0.tgz";
      });
      pkgname = "babel-helper-regex";
    };
    "babel-helper-remap-async-to-generator@6.24.1" = {
      pname = "babel-helper-remap-async-to-generator";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-function-name@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0gqrjk15q6n6r61r5q853qa6nw724s6lp32xr8cksbi3zavwhcpg";
        url = "https://registry.npmjs.org/babel-helper-remap-async-to-generator/-/babel-helper-remap-async-to-generator-6.24.1.tgz";
      });
      pkgname = "babel-helper-remap-async-to-generator";
    };
    "babel-helper-replace-supers@6.24.1" = {
      pname = "babel-helper-replace-supers";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-optimise-call-expression@6.24.1")
        ("babel-messages@6.23.0")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1xyjshgcv968ip4kwgj6ck09jydmrgcdv2xdkbksbifyw676v5dq";
        url = "https://registry.npmjs.org/babel-helper-replace-supers/-/babel-helper-replace-supers-6.24.1.tgz";
      });
      pkgname = "babel-helper-replace-supers";
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
    "babel-jest@23.6.0" = {
      pname = "babel-jest";
      version = "23.6.0";
      depKeys = [
        ("babel-plugin-istanbul@4.1.6")
        ("babel-preset-jest@23.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0rajcr83kqy3djjxgf3wzmrc5y0hscvhkfm0bxqh2j1dicnisra0";
        url = "https://registry.npmjs.org/babel-jest/-/babel-jest-23.6.0.tgz";
      });
      pkgname = "babel-jest";
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
    "babel-plugin-check-es2015-constants@6.22.0" = {
      pname = "babel-plugin-check-es2015-constants";
      version = "6.22.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1f0k062ix0nacjjd76dcsddfsnf0p5hkn6ad2w0wir9l6r2zyfyc";
        url = "https://registry.npmjs.org/babel-plugin-check-es2015-constants/-/babel-plugin-check-es2015-constants-6.22.0.tgz";
      });
      pkgname = "babel-plugin-check-es2015-constants";
    };
    "babel-plugin-istanbul@4.1.6" = {
      pname = "babel-plugin-istanbul";
      version = "4.1.6";
      depKeys = [
        ("babel-plugin-syntax-object-rest-spread@6.13.0")
        ("find-up@2.1.0")
        ("istanbul-lib-instrument@1.10.2")
        ("test-exclude@4.2.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "12zks4vhvvwh9hvxkd4rdn9zw4vnbc50vxdbj3mjn5i69c55xjaf";
        url = "https://registry.npmjs.org/babel-plugin-istanbul/-/babel-plugin-istanbul-4.1.6.tgz";
      });
      pkgname = "babel-plugin-istanbul";
    };
    "babel-plugin-jest-hoist@23.2.0" = {
      pname = "babel-plugin-jest-hoist";
      version = "23.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1grrnsvf4hbdrakgfhg6rbfwz65q17sxrv1cbw7j5pmfng8kd9s1";
        url = "https://registry.npmjs.org/babel-plugin-jest-hoist/-/babel-plugin-jest-hoist-23.2.0.tgz";
      });
      pkgname = "babel-plugin-jest-hoist";
    };
    "babel-plugin-syntax-async-functions@6.13.0" = {
      pname = "babel-plugin-syntax-async-functions";
      version = "6.13.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0z065jygjgkxa54ma2yc334k9a1r7dkrvnq1qcwf30p7x9p69qni";
        url = "https://registry.npmjs.org/babel-plugin-syntax-async-functions/-/babel-plugin-syntax-async-functions-6.13.0.tgz";
      });
      pkgname = "babel-plugin-syntax-async-functions";
    };
    "babel-plugin-syntax-exponentiation-operator@6.13.0" = {
      pname = "babel-plugin-syntax-exponentiation-operator";
      version = "6.13.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1gsw4p20n1lxr77xlkqdgc2hjf5m4klr2mz6iy8wryd43wmrlc0p";
        url = "https://registry.npmjs.org/babel-plugin-syntax-exponentiation-operator/-/babel-plugin-syntax-exponentiation-operator-6.13.0.tgz";
      });
      pkgname = "babel-plugin-syntax-exponentiation-operator";
    };
    "babel-plugin-syntax-flow@6.18.0" = {
      pname = "babel-plugin-syntax-flow";
      version = "6.18.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1v4zbmgm2wkzw6njdqlgxvhap1amv60by50wpfbkm76p9rh54jvd";
        url = "https://registry.npmjs.org/babel-plugin-syntax-flow/-/babel-plugin-syntax-flow-6.18.0.tgz";
      });
      pkgname = "babel-plugin-syntax-flow";
    };
    "babel-plugin-syntax-object-rest-spread@6.13.0" = {
      pname = "babel-plugin-syntax-object-rest-spread";
      version = "6.13.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mh8b39qd8klrczd1byxa1fzng0qwrknnc6plww78k9pn83s2fsw";
        url = "https://registry.npmjs.org/babel-plugin-syntax-object-rest-spread/-/babel-plugin-syntax-object-rest-spread-6.13.0.tgz";
      });
      pkgname = "babel-plugin-syntax-object-rest-spread";
    };
    "babel-plugin-syntax-trailing-function-commas@6.22.0" = {
      pname = "babel-plugin-syntax-trailing-function-commas";
      version = "6.22.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0s9cqq5ypc9ggmxjkwxca9inikz404ra0vhhs9vwbwfx75hcnbir";
        url = "https://registry.npmjs.org/babel-plugin-syntax-trailing-function-commas/-/babel-plugin-syntax-trailing-function-commas-6.22.0.tgz";
      });
      pkgname = "babel-plugin-syntax-trailing-function-commas";
    };
    "babel-plugin-transform-async-to-generator@6.24.1" = {
      pname = "babel-plugin-transform-async-to-generator";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-remap-async-to-generator@6.24.1")
        ("babel-plugin-syntax-async-functions@6.13.0")
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g2sxx8559bh15ymj1xdv1lpha9wgzrajl78717nhz8n632kd041";
        url = "https://registry.npmjs.org/babel-plugin-transform-async-to-generator/-/babel-plugin-transform-async-to-generator-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-async-to-generator";
    };
    "babel-plugin-transform-es2015-arrow-functions@6.22.0" = {
      pname = "babel-plugin-transform-es2015-arrow-functions";
      version = "6.22.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mqx8rix5zgx3lrpna1sbznkkirvk9gmq244s0hsdqxckmx812sk";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-arrow-functions/-/babel-plugin-transform-es2015-arrow-functions-6.22.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-arrow-functions";
    };
    "babel-plugin-transform-es2015-block-scoped-functions@6.22.0" = {
      pname = "babel-plugin-transform-es2015-block-scoped-functions";
      version = "6.22.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jbpw6vnmicyrps3di2ri5ig93cmibzdczy7bwq2d1rj0qnkf8br";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-block-scoped-functions/-/babel-plugin-transform-es2015-block-scoped-functions-6.22.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-block-scoped-functions";
    };
    "babel-plugin-transform-es2015-block-scoping@6.26.0" = {
      pname = "babel-plugin-transform-es2015-block-scoping";
      version = "6.26.0";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
        ("lodash@4.17.15")
      ];
      src = (pkgs.fetchurl {
        sha256 = "01xppfadsvw38wd8y4y9glfds8rbzhi4h5f0vkfql5z8f9v24867";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-block-scoping/-/babel-plugin-transform-es2015-block-scoping-6.26.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-block-scoping";
    };
    "babel-plugin-transform-es2015-classes@6.24.1" = {
      pname = "babel-plugin-transform-es2015-classes";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-define-map@6.26.0")
        ("babel-helper-function-name@6.24.1")
        ("babel-helper-optimise-call-expression@6.24.1")
        ("babel-helper-replace-supers@6.24.1")
        ("babel-messages@6.23.0")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "019dmxhmd53wr8kcswp1fbngpjsqjcpy81dxsiljlapas57cip9b";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-classes/-/babel-plugin-transform-es2015-classes-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-classes";
    };
    "babel-plugin-transform-es2015-computed-properties@6.24.1" = {
      pname = "babel-plugin-transform-es2015-computed-properties";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ay0r27sia4g6s0718lyv4mpklj5ij6pj3lmvhwaj0al911x120x";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-computed-properties/-/babel-plugin-transform-es2015-computed-properties-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-computed-properties";
    };
    "babel-plugin-transform-es2015-destructuring@6.23.0" = {
      pname = "babel-plugin-transform-es2015-destructuring";
      version = "6.23.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "145q894jv5bgfkkjm7mm1fzi6nadasqf8y1l4qgswvpwjg5alh12";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-destructuring/-/babel-plugin-transform-es2015-destructuring-6.23.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-destructuring";
    };
    "babel-plugin-transform-es2015-duplicate-keys@6.24.1" = {
      pname = "babel-plugin-transform-es2015-duplicate-keys";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "11sqbrc930v4hd203ipw9ccr0bbk3qjmcvy4312nzlz8waaj7y76";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-duplicate-keys/-/babel-plugin-transform-es2015-duplicate-keys-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-duplicate-keys";
    };
    "babel-plugin-transform-es2015-for-of@6.23.0" = {
      pname = "babel-plugin-transform-es2015-for-of";
      version = "6.23.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1w1ay7lgmvjnbhckx17fb17dm8f2k8h4qyfwbaziwmj8jdbvan0a";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-for-of/-/babel-plugin-transform-es2015-for-of-6.23.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-for-of";
    };
    "babel-plugin-transform-es2015-function-name@6.24.1" = {
      pname = "babel-plugin-transform-es2015-function-name";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-function-name@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1845cwr2ls2fx96a5mf8g51knd7m8nsib4fhkdnv1lplbbhgspp3";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-function-name/-/babel-plugin-transform-es2015-function-name-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-function-name";
    };
    "babel-plugin-transform-es2015-literals@6.22.0" = {
      pname = "babel-plugin-transform-es2015-literals";
      version = "6.22.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "14a3dvqpxqlm1qa2jnlb0kj9czn58kwhqs8ngl1g30x559nayc2l";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-literals/-/babel-plugin-transform-es2015-literals-6.22.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-literals";
    };
    "babel-plugin-transform-es2015-modules-amd@6.24.1" = {
      pname = "babel-plugin-transform-es2015-modules-amd";
      version = "6.24.1";
      depKeys = [
        ("babel-plugin-transform-es2015-modules-commonjs@6.26.2")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19l5hkw6xir0fzphy3y17gfrag7mjgwhqd8kbg07f1npynzyy4a3";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-amd/-/babel-plugin-transform-es2015-modules-amd-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-modules-amd";
    };
    "babel-plugin-transform-es2015-modules-commonjs@6.26.2" = {
      pname = "babel-plugin-transform-es2015-modules-commonjs";
      version = "6.26.2";
      depKeys = [
        ("babel-plugin-transform-strict-mode@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ag0990zk991lpxqif4hx7wi4y5n2jhs0254ysswizdcja4gypqc";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-commonjs/-/babel-plugin-transform-es2015-modules-commonjs-6.26.2.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-modules-commonjs";
    };
    "babel-plugin-transform-es2015-modules-systemjs@6.24.1" = {
      pname = "babel-plugin-transform-es2015-modules-systemjs";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-hoist-variables@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "16gmgh1m1krslb4wpvypwa2w71k1nywgarhpj5k5gpf2bhfgkpxp";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-systemjs/-/babel-plugin-transform-es2015-modules-systemjs-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-modules-systemjs";
    };
    "babel-plugin-transform-es2015-modules-umd@6.24.1" = {
      pname = "babel-plugin-transform-es2015-modules-umd";
      version = "6.24.1";
      depKeys = [
        ("babel-plugin-transform-es2015-modules-amd@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "15i2gnwbmifv8icj8qj9wfj20jz4k9bvakm22000682wyml3y25r";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-umd/-/babel-plugin-transform-es2015-modules-umd-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-modules-umd";
    };
    "babel-plugin-transform-es2015-object-super@6.24.1" = {
      pname = "babel-plugin-transform-es2015-object-super";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-replace-supers@6.24.1")
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "06mq3hgma4w3q81gzw6l94rcky98m03wwk8g05amisnin8y2c8dr";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-object-super/-/babel-plugin-transform-es2015-object-super-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-object-super";
    };
    "babel-plugin-transform-es2015-parameters@6.24.1" = {
      pname = "babel-plugin-transform-es2015-parameters";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-call-delegate@6.24.1")
        ("babel-helper-get-function-arity@6.24.1")
        ("babel-runtime@6.26.0")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mxi1k1qxkycl5ida4gsynca5i7f0xdn6rmw70kd5an2s9rdmzgf";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-parameters/-/babel-plugin-transform-es2015-parameters-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-parameters";
    };
    "babel-plugin-transform-es2015-shorthand-properties@6.24.1" = {
      pname = "babel-plugin-transform-es2015-shorthand-properties";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1i4hvmwmhhgyl8vs7vslrn4j46zwlx02s402lvpwad4qihlpym8f";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-shorthand-properties/-/babel-plugin-transform-es2015-shorthand-properties-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-shorthand-properties";
    };
    "babel-plugin-transform-es2015-spread@6.22.0" = {
      pname = "babel-plugin-transform-es2015-spread";
      version = "6.22.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19zh74wqczy72dzswmdb0wy7s746qrwyq3b212vpmf4h6n1b5361";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-spread/-/babel-plugin-transform-es2015-spread-6.22.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-spread";
    };
    "babel-plugin-transform-es2015-sticky-regex@6.24.1" = {
      pname = "babel-plugin-transform-es2015-sticky-regex";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-regex@6.26.0")
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0bsqq7y16qiqvi2x4a77y2jrkkyzbylnmyimi3q7cb9z154vqzmi";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-sticky-regex/-/babel-plugin-transform-es2015-sticky-regex-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-sticky-regex";
    };
    "babel-plugin-transform-es2015-template-literals@6.22.0" = {
      pname = "babel-plugin-transform-es2015-template-literals";
      version = "6.22.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wq32r86l41xi2fqwqiais69mf9z9mc474n6gl0kxi2fzv09n634";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-template-literals/-/babel-plugin-transform-es2015-template-literals-6.22.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-template-literals";
    };
    "babel-plugin-transform-es2015-typeof-symbol@6.23.0" = {
      pname = "babel-plugin-transform-es2015-typeof-symbol";
      version = "6.23.0";
      depKeys = [
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1xnx1v3628c3m30fbf8cvis00qq6mzq23lxp1ml9cc0c8g03625f";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-typeof-symbol/-/babel-plugin-transform-es2015-typeof-symbol-6.23.0.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-typeof-symbol";
    };
    "babel-plugin-transform-es2015-unicode-regex@6.24.1" = {
      pname = "babel-plugin-transform-es2015-unicode-regex";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-regex@6.26.0")
        ("babel-runtime@6.26.0")
        ("regexpu-core@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1fikzfjia0m1yhiwx4q76f2kri0rw10slj5slc7qqrifppk6nn3a";
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-unicode-regex/-/babel-plugin-transform-es2015-unicode-regex-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-es2015-unicode-regex";
    };
    "babel-plugin-transform-exponentiation-operator@6.24.1" = {
      pname = "babel-plugin-transform-exponentiation-operator";
      version = "6.24.1";
      depKeys = [
        ("babel-helper-builder-binary-assignment-operator-visitor@6.24.1")
        ("babel-plugin-syntax-exponentiation-operator@6.13.0")
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1sdr6z62zrz86hqss527ka5s5ksas2manjkgg92hnfy9ynvaxxkj";
        url = "https://registry.npmjs.org/babel-plugin-transform-exponentiation-operator/-/babel-plugin-transform-exponentiation-operator-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-exponentiation-operator";
    };
    "babel-plugin-transform-flow-strip-types@6.22.0" = {
      pname = "babel-plugin-transform-flow-strip-types";
      version = "6.22.0";
      depKeys = [
        ("babel-plugin-syntax-flow@6.18.0")
        ("babel-runtime@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0zim49i0bcy7awbh4xhh81k1ayxawx34gyz7yxndx0iys3gi2yk6";
        url = "https://registry.npmjs.org/babel-plugin-transform-flow-strip-types/-/babel-plugin-transform-flow-strip-types-6.22.0.tgz";
      });
      pkgname = "babel-plugin-transform-flow-strip-types";
    };
    "babel-plugin-transform-regenerator@6.26.0" = {
      pname = "babel-plugin-transform-regenerator";
      version = "6.26.0";
      depKeys = [
        ("regenerator-transform@0.10.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0gxssjh7l3i5aww78bkslaidkkl6qvzvd1cr52g4jasgiz440bl3";
        url = "https://registry.npmjs.org/babel-plugin-transform-regenerator/-/babel-plugin-transform-regenerator-6.26.0.tgz";
      });
      pkgname = "babel-plugin-transform-regenerator";
    };
    "babel-plugin-transform-strict-mode@6.24.1" = {
      pname = "babel-plugin-transform-strict-mode";
      version = "6.24.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "14bjm8crrs74ksw8rg4dhci32bg3ag5grwd4yk7ncazlr65rn01z";
        url = "https://registry.npmjs.org/babel-plugin-transform-strict-mode/-/babel-plugin-transform-strict-mode-6.24.1.tgz";
      });
      pkgname = "babel-plugin-transform-strict-mode";
    };
    "babel-preset-env@1.7.0" = {
      pname = "babel-preset-env";
      version = "1.7.0";
      depKeys = [
        ("babel-plugin-check-es2015-constants@6.22.0")
        ("babel-plugin-syntax-trailing-function-commas@6.22.0")
        ("babel-plugin-transform-async-to-generator@6.24.1")
        ("babel-plugin-transform-es2015-arrow-functions@6.22.0")
        ("babel-plugin-transform-es2015-block-scoped-functions@6.22.0")
        ("babel-plugin-transform-es2015-block-scoping@6.26.0")
        ("babel-plugin-transform-es2015-classes@6.24.1")
        ("babel-plugin-transform-es2015-computed-properties@6.24.1")
        ("babel-plugin-transform-es2015-destructuring@6.23.0")
        ("babel-plugin-transform-es2015-duplicate-keys@6.24.1")
        ("babel-plugin-transform-es2015-for-of@6.23.0")
        ("babel-plugin-transform-es2015-function-name@6.24.1")
        ("babel-plugin-transform-es2015-literals@6.22.0")
        ("babel-plugin-transform-es2015-modules-amd@6.24.1")
        ("babel-plugin-transform-es2015-modules-commonjs@6.26.2")
        ("babel-plugin-transform-es2015-modules-systemjs@6.24.1")
        ("babel-plugin-transform-es2015-modules-umd@6.24.1")
        ("babel-plugin-transform-es2015-object-super@6.24.1")
        ("babel-plugin-transform-es2015-parameters@6.24.1")
        ("babel-plugin-transform-es2015-shorthand-properties@6.24.1")
        ("babel-plugin-transform-es2015-spread@6.22.0")
        ("babel-plugin-transform-es2015-sticky-regex@6.24.1")
        ("babel-plugin-transform-es2015-template-literals@6.22.0")
        ("babel-plugin-transform-es2015-typeof-symbol@6.23.0")
        ("babel-plugin-transform-es2015-unicode-regex@6.24.1")
        ("babel-plugin-transform-exponentiation-operator@6.24.1")
        ("babel-plugin-transform-regenerator@6.26.0")
        ("browserslist@3.2.8")
        ("invariant@2.2.4")
        ("semver@5.7.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0izm4f34anch1g2rpza1s0w3h69pgya1bdbdv6wf4p0p9gq90nr2";
        url = "https://registry.npmjs.org/babel-preset-env/-/babel-preset-env-1.7.0.tgz";
      });
      pkgname = "babel-preset-env";
    };
    "babel-preset-flow@6.23.0" = {
      pname = "babel-preset-flow";
      version = "6.23.0";
      depKeys = [
        ("babel-plugin-transform-flow-strip-types@6.22.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jvy9hg8a0ak52v62vcc989llw61pg18m3jbc521za5h753yqkxs";
        url = "https://registry.npmjs.org/babel-preset-flow/-/babel-preset-flow-6.23.0.tgz";
      });
      pkgname = "babel-preset-flow";
    };
    "babel-preset-jest@23.2.0" = {
      pname = "babel-preset-jest";
      version = "23.2.0";
      depKeys = [
        ("babel-plugin-jest-hoist@23.2.0")
        ("babel-plugin-syntax-object-rest-spread@6.13.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "10m1kz2g64123w1gss9dna9sakd4bh93ijs7madyzwmninvbqrmh";
        url = "https://registry.npmjs.org/babel-preset-jest/-/babel-preset-jest-23.2.0.tgz";
      });
      pkgname = "babel-preset-jest";
    };
    "babel-register@6.26.0" = {
      pname = "babel-register";
      version = "6.26.0";
      depKeys = [
        ("babel-core@6.26.3")
        ("babel-runtime@6.26.0")
        ("core-js@2.6.9")
        ("home-or-tmp@2.0.0")
        ("lodash@4.17.15")
        ("mkdirp@0.5.1")
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
        ("core-js@2.6.9")
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
        ("lodash@4.17.15")
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
        ("lodash@4.17.15")
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
        ("esutils@2.0.2")
        ("lodash@4.17.15")
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
    "balanced-match@1.0.0" = {
      pname = "balanced-match";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bgzp9jp8ws0kdfgq8h6w3qz8cljyzgcrmxypxkgbknk28n615i8";
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
      });
      pkgname = "balanced-match";
    };
    "base@0.11.2" = {
      pname = "base";
      version = "0.11.2";
      depKeys = [
        ("cache-base@1.0.1")
        ("class-utils@0.3.6")
        ("component-emitter@1.3.0")
        ("define-property@1.0.0")
        ("isobject@3.0.1")
        ("mixin-deep@1.3.2")
        ("pascalcase@0.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wh3b37238q4x15diq4vp2vx6d6zqh9z0559p0kk6xh0v9b95ca0";
        url = "https://registry.npmjs.org/base/-/base-0.11.2.tgz";
      });
      pkgname = "base";
    };
    "bcrypt-pbkdf@1.0.2" = {
      pname = "bcrypt-pbkdf";
      version = "1.0.2";
      depKeys = [
        ("tweetnacl@0.14.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09kqy1rjj0b1aavdssglrjj8ayf9vxvnnvlh5ah270j3bngrwgp1";
        url = "https://registry.npmjs.org/bcrypt-pbkdf/-/bcrypt-pbkdf-1.0.2.tgz";
      });
      pkgname = "bcrypt-pbkdf";
    };
    "bl@1.2.2" = {
      pname = "bl";
      version = "1.2.2";
      depKeys = [
        ("readable-stream@2.3.6")
        ("safe-buffer@5.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1b4g79yf03w4i8vsa8gazp9ma77ymsrm4djdjpxymm8ga08cgcya";
        url = "https://registry.npmjs.org/bl/-/bl-1.2.2.tgz";
      });
      pkgname = "bl";
    };
    "brace-expansion@1.1.11" = {
      pname = "brace-expansion";
      version = "1.1.11";
      depKeys = [
        ("balanced-match@1.0.0")
        ("concat-map@0.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nlmjvlwlp88knblnayns0brr7a9m2fynrlwq425lrpb4mcn9gc4";
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
      });
      pkgname = "brace-expansion";
    };
    "braces@1.8.5" = {
      pname = "braces";
      version = "1.8.5";
      depKeys = [
        ("expand-range@1.8.2")
        ("preserve@0.2.0")
        ("repeat-element@1.1.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1593ijg9gjm1sgyk1cpqc71ac57md8izkhg4n5p18vnbri0xqzww";
        url = "https://registry.npmjs.org/braces/-/braces-1.8.5.tgz";
      });
      pkgname = "braces";
    };
    "braces@2.3.2" = {
      pname = "braces";
      version = "2.3.2";
      depKeys = [
        ("arr-flatten@1.1.0")
        ("array-unique@0.3.2")
        ("extend-shallow@2.0.1")
        ("fill-range@4.0.0")
        ("isobject@3.0.1")
        ("repeat-element@1.1.3")
        ("snapdragon@0.8.2")
        ("snapdragon-node@2.1.1")
        ("split-string@3.1.0")
        ("to-regex@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "10608dfl1pxajw0nwrsh69769q659yjyw88b0mrlprnn0z1wya1l";
        url = "https://registry.npmjs.org/braces/-/braces-2.3.2.tgz";
      });
      pkgname = "braces";
    };
    "browser-process-hrtime@0.1.3" = {
      pname = "browser-process-hrtime";
      version = "0.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1iyl5pf0j4n7xn29dm87yr9v2aa22r5k9ggnws19cjryj4g34nrc";
        url = "https://registry.npmjs.org/browser-process-hrtime/-/browser-process-hrtime-0.1.3.tgz";
      });
      pkgname = "browser-process-hrtime";
    };
    "browser-resolve@1.11.3" = {
      pname = "browser-resolve";
      version = "1.11.3";
      depKeys = [
        ("resolve@1.1.7")
      ];
      src = (pkgs.fetchurl {
        sha256 = "12i3s0qynfznapd4f9l9ql2nss58hc1kph6k1mvd8ck5y7hfmqrv";
        url = "https://registry.npmjs.org/browser-resolve/-/browser-resolve-1.11.3.tgz";
      });
      pkgname = "browser-resolve";
    };
    "browserslist@3.2.8" = {
      pname = "browserslist";
      version = "3.2.8";
      depKeys = [
        ("caniuse-lite@1.0.30000985")
        ("electron-to-chromium@1.3.200")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vr191nyqhhp7b7891dbi9ncnxpzdv1zsdcr3s0c7xafj1sa4226";
        url = "https://registry.npmjs.org/browserslist/-/browserslist-3.2.8.tgz";
      });
      pkgname = "browserslist";
    };
    "bser@2.1.0" = {
      pname = "bser";
      version = "2.1.0";
      depKeys = [
        ("node-int64@0.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dfkm9xdb7645c7d7r657050m2bjixirc6i0gsfy7yix88784hig";
        url = "https://registry.npmjs.org/bser/-/bser-2.1.0.tgz";
      });
      pkgname = "bser";
    };
    "buffer-alloc-unsafe@1.1.0" = {
      pname = "buffer-alloc-unsafe";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "14l0bpm970llw74akvhv2v5gqxxcw3dlfkycvbc4c3ix0qzmkpby";
        url = "https://registry.npmjs.org/buffer-alloc-unsafe/-/buffer-alloc-unsafe-1.1.0.tgz";
      });
      pkgname = "buffer-alloc-unsafe";
    };
    "buffer-alloc@1.2.0" = {
      pname = "buffer-alloc";
      version = "1.2.0";
      depKeys = [
        ("buffer-alloc-unsafe@1.1.0")
        ("buffer-fill@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "134xb4b3vfvwa7w0akrdz1yd6vlbxai1biyb1vbg2x9krznvzgcq";
        url = "https://registry.npmjs.org/buffer-alloc/-/buffer-alloc-1.2.0.tgz";
      });
      pkgname = "buffer-alloc";
    };
    "buffer-fill@1.0.0" = {
      pname = "buffer-fill";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vlpgfqr5d25y3fdalway4gk9mrx0q61718cvf1by8mi3q3y6xw1";
        url = "https://registry.npmjs.org/buffer-fill/-/buffer-fill-1.0.0.tgz";
      });
      pkgname = "buffer-fill";
    };
    "buffer-from@1.1.1" = {
      pname = "buffer-from";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "17drzww1pyrh2m1c46i02090gvwhriq00qqy66yh3bcjwz0mh3hr";
        url = "https://registry.npmjs.org/buffer-from/-/buffer-from-1.1.1.tgz";
      });
      pkgname = "buffer-from";
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
        ("minipass@3.1.5")
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
        sha256 = "12i3hjf4i27qawi6x70drxjb6jvyqznv81clmcw9jar3svwznbw2";
        url = "https://registry.npmjs.org/cacache/-/cacache-15.3.0.tgz";
      });
      pkgname = "cacache";
    };
    "cache-base@1.0.1" = {
      pname = "cache-base";
      version = "1.0.1";
      depKeys = [
        ("collection-visit@1.0.0")
        ("component-emitter@1.3.0")
        ("get-value@2.0.6")
        ("has-value@1.0.0")
        ("isobject@3.0.1")
        ("set-value@2.0.1")
        ("to-object-path@0.3.0")
        ("union-value@1.0.1")
        ("unset-value@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1iny3winp8x5ac39hx52baq60g2hsp4pcx95a634c83klawdaw78";
        url = "https://registry.npmjs.org/cache-base/-/cache-base-1.0.1.tgz";
      });
      pkgname = "cache-base";
    };
    "callsites@2.0.0" = {
      pname = "callsites";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qpqxzywgm2h5ay8wn7j58njbjlr5a17fda49sm65m28ji2ky5yp";
        url = "https://registry.npmjs.org/callsites/-/callsites-2.0.0.tgz";
      });
      pkgname = "callsites";
    };
    "camelcase@4.1.0" = {
      pname = "camelcase";
      version = "4.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1xcjfpd0w5rcg282ksk7h42mp5k7fb51xa4nipsvff55020gcfws";
        url = "https://registry.npmjs.org/camelcase/-/camelcase-4.1.0.tgz";
      });
      pkgname = "camelcase";
    };
    "caniuse-lite@1.0.30000985" = {
      pname = "caniuse-lite";
      version = "1.0.30000985";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jsy2yddg3wq23c349q4n2rqqg3avj53dpxzgps6d1j47hd9x4j2";
        url = "https://registry.npmjs.org/caniuse-lite/-/caniuse-lite-1.0.30000985.tgz";
      });
      pkgname = "caniuse-lite";
    };
    "capture-exit@1.2.0" = {
      pname = "capture-exit";
      version = "1.2.0";
      depKeys = [
        ("rsvp@3.6.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "10lqdwz5ykgnghbsda3h2ri1z5vdxisp3dhyr8kp9bzzlaxdknqh";
        url = "https://registry.npmjs.org/capture-exit/-/capture-exit-1.2.0.tgz";
      });
      pkgname = "capture-exit";
    };
    "caseless@0.12.0" = {
      pname = "caseless";
      version = "0.12.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "165fzm8s6qxapxk8xlb548q58xjav55k5nnychr234282irb2zjd";
        url = "https://registry.npmjs.org/caseless/-/caseless-0.12.0.tgz";
      });
      pkgname = "caseless";
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
    "chalk@2.4.2" = {
      pname = "chalk";
      version = "2.4.2";
      depKeys = [
        ("ansi-styles@3.2.1")
        ("escape-string-regexp@1.0.5")
        ("supports-color@5.5.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wf6hln5gcjb2n8p18gag6idghl6dfq4if6pxa6s1jqnwr94x26h";
        url = "https://registry.npmjs.org/chalk/-/chalk-2.4.2.tgz";
      });
      pkgname = "chalk";
    };
    "chownr@1.1.2" = {
      pname = "chownr";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "14wla27pr8qayywycysykk4b5nv96bsijfsjacgkbcy6j4jvsjgi";
        url = "https://registry.npmjs.org/chownr/-/chownr-1.1.2.tgz";
      });
      pkgname = "chownr";
    };
    "chownr@2.0.0" = {
      pname = "chownr";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "177wsdfmn1d2f12wy8m875b5y9a74ibfdh33jarlv3a0zrbmvqlv";
        url = "https://registry.npmjs.org/chownr/-/chownr-2.0.0.tgz";
      });
      pkgname = "chownr";
    };
    "ci-info@1.6.0" = {
      pname = "ci-info";
      version = "1.6.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lfy9p0mlff437lrszcirp743rkxhynmljj66bmbky71cd7g24gj";
        url = "https://registry.npmjs.org/ci-info/-/ci-info-1.6.0.tgz";
      });
      pkgname = "ci-info";
    };
    "class-utils@0.3.6" = {
      pname = "class-utils";
      version = "0.3.6";
      depKeys = [
        ("arr-union@3.1.0")
        ("define-property@0.2.5")
        ("isobject@3.0.1")
        ("static-extend@0.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0567alh9j9bl7rj91frmjdpb4q5zig9rydzkdm9pmij85h7sffjh";
        url = "https://registry.npmjs.org/class-utils/-/class-utils-0.3.6.tgz";
      });
      pkgname = "class-utils";
    };
    "clean-stack@2.2.0" = {
      pname = "clean-stack";
      version = "2.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0manylf8kgqm9knb26lwxs7lfdf384r8hnxjwmhgzimq19k3fv05";
        url = "https://registry.npmjs.org/clean-stack/-/clean-stack-2.2.0.tgz";
      });
      pkgname = "clean-stack";
    };
    "cliui@4.1.0" = {
      pname = "cliui";
      version = "4.1.0";
      depKeys = [
        ("string-width@2.1.1")
        ("strip-ansi@4.0.0")
        ("wrap-ansi@2.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vz146bjll7py9za4f6y9nhb4vqg3ybgpkhmbssdzaj6rhwpjmlc";
        url = "https://registry.npmjs.org/cliui/-/cliui-4.1.0.tgz";
      });
      pkgname = "cliui";
    };
    "co@4.6.0" = {
      pname = "co";
      version = "4.6.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "166g74ggagkjs3vgpavffm8rignh3lw0j945w67yc8iq98m3dm11";
        url = "https://registry.npmjs.org/co/-/co-4.6.0.tgz";
      });
      pkgname = "co";
    };
    "code-point-at@1.1.0" = {
      pname = "code-point-at";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g8bfw3l2mfpl654na0pjfbwri9dms92bc615a2q2qvdk1wclyaj";
        url = "https://registry.npmjs.org/code-point-at/-/code-point-at-1.1.0.tgz";
      });
      pkgname = "code-point-at";
    };
    "collection-visit@1.0.0" = {
      pname = "collection-visit";
      version = "1.0.0";
      depKeys = [
        ("map-visit@1.0.0")
        ("object-visit@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "062q78a3fjfvk4vplkay9hd4rx6f1xw4r0438sa0hbv62jf5bc46";
        url = "https://registry.npmjs.org/collection-visit/-/collection-visit-1.0.0.tgz";
      });
      pkgname = "collection-visit";
    };
    "color-convert@1.9.3" = {
      pname = "color-convert";
      version = "1.9.3";
      depKeys = [
        ("color-name@1.1.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ahbdssv1qgwlzvhv7731hpfgz8wny0619x97b7n5x9lckj17i0j";
        url = "https://registry.npmjs.org/color-convert/-/color-convert-1.9.3.tgz";
      });
      pkgname = "color-convert";
    };
    "color-name@1.1.3" = {
      pname = "color-name";
      version = "1.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kkq17s5yg6lg8ncg2nls6asih58qafn7wbrcgmwnqr5zdqk7vxh";
        url = "https://registry.npmjs.org/color-name/-/color-name-1.1.3.tgz";
      });
      pkgname = "color-name";
    };
    "combined-stream@1.0.8" = {
      pname = "combined-stream";
      version = "1.0.8";
      depKeys = [
        ("delayed-stream@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "04hm5rrkwda2qgy1afwhrz42asmflw5hxkbpxddn741ywnmmmgmn";
        url = "https://registry.npmjs.org/combined-stream/-/combined-stream-1.0.8.tgz";
      });
      pkgname = "combined-stream";
    };
    "commander@2.20.0" = {
      pname = "commander";
      version = "2.20.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "10in1plyla91sphd2z86vksxn8xwgxyzip0n6k2wm2a2ny6ir2qv";
        url = "https://registry.npmjs.org/commander/-/commander-2.20.0.tgz";
      });
      pkgname = "commander";
    };
    "component-emitter@1.3.0" = {
      pname = "component-emitter";
      version = "1.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0qc1qx0ngvah8lmkn0d784vlxmya2kr5gpjcpfikxlpwx5v3wr0h";
        url = "https://registry.npmjs.org/component-emitter/-/component-emitter-1.3.0.tgz";
      });
      pkgname = "component-emitter";
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
    "console-control-strings@1.1.0" = {
      pname = "console-control-strings";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dl328x4g2dqhf4lbfajf4c7vlb6m7ff8adpk1ngig7s1i49pm7h";
        url = "https://registry.npmjs.org/console-control-strings/-/console-control-strings-1.1.0.tgz";
      });
      pkgname = "console-control-strings";
    };
    "convert-source-map@1.6.0" = {
      pname = "convert-source-map";
      version = "1.6.0";
      depKeys = [
        ("safe-buffer@5.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1aj14nakiddw2mar6ldqgmyjpw6w8gmqmji8sr1wfh3r4gmn5c57";
        url = "https://registry.npmjs.org/convert-source-map/-/convert-source-map-1.6.0.tgz";
      });
      pkgname = "convert-source-map";
    };
    "copy-descriptor@0.1.1" = {
      pname = "copy-descriptor";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dmlg6g04hfn1kmjklw6l33va255gsml1mrlz07jfv2a4alz4470";
        url = "https://registry.npmjs.org/copy-descriptor/-/copy-descriptor-0.1.1.tgz";
      });
      pkgname = "copy-descriptor";
    };
    "core-js@2.6.9" = {
      pname = "core-js";
      version = "2.6.9";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "15iaygsrj4r8xqxyjc4xvr61zd1l2ws1malj467ic57zxc6388dz";
        url = "https://registry.npmjs.org/core-js/-/core-js-2.6.9.tgz";
      });
      pkgname = "core-js";
    };
    "core-util-is@1.0.2" = {
      pname = "core-util-is";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "164k94d9bdzw1335kzakj7hflhnnixpx4n6ydbhf7vbrcnmlv954";
        url = "https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.2.tgz";
      });
      pkgname = "core-util-is";
    };
    "cross-spawn@5.1.0" = {
      pname = "cross-spawn";
      version = "5.1.0";
      depKeys = [
        ("lru-cache@4.1.5")
        ("shebang-command@1.2.0")
        ("which@1.3.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0vgzrj7qwzw49xv1yqx2axya667fbsbg12gp89plv9jxrpl0a24i";
        url = "https://registry.npmjs.org/cross-spawn/-/cross-spawn-5.1.0.tgz";
      });
      pkgname = "cross-spawn";
    };
    "cssom@0.3.8" = {
      pname = "cssom";
      version = "0.3.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dq5z0asdnnvlpgjfc8ylzn78lpdkpqqd66djwdcdlnwp07d6d81";
        url = "https://registry.npmjs.org/cssom/-/cssom-0.3.8.tgz";
      });
      pkgname = "cssom";
    };
    "cssstyle@1.4.0" = {
      pname = "cssstyle";
      version = "1.4.0";
      depKeys = [
        ("cssom@0.3.8")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0bh3iz1r144h4k5740glg1knwyvwsa9nwg8xk13wv0665hnfnyg4";
        url = "https://registry.npmjs.org/cssstyle/-/cssstyle-1.4.0.tgz";
      });
      pkgname = "cssstyle";
    };
    "dashdash@1.14.1" = {
      pname = "dashdash";
      version = "1.14.1";
      depKeys = [
        ("assert-plus@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0h2kaml5wgx5x430wlbnjz3j6q1ppvndqckylfmi13xa33gfnycb";
        url = "https://registry.npmjs.org/dashdash/-/dashdash-1.14.1.tgz";
      });
      pkgname = "dashdash";
    };
    "data-urls@1.1.0" = {
      pname = "data-urls";
      version = "1.1.0";
      depKeys = [
        ("abab@2.0.0")
        ("whatwg-mimetype@2.3.0")
        ("whatwg-url@7.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vfyqvchhvmmlvs3h11vpsynqc4fn1mnxymbbjy1kxgqpffraa0c";
        url = "https://registry.npmjs.org/data-urls/-/data-urls-1.1.0.tgz";
      });
      pkgname = "data-urls";
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
    "debug@3.2.6" = {
      pname = "debug";
      version = "3.2.6";
      depKeys = [
        ("ms@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0l9b6y3syggfrif720i2sa8v6sd4sasfg64vw16l601a0yqzha1r";
        url = "https://registry.npmjs.org/debug/-/debug-3.2.6.tgz";
      });
      pkgname = "debug";
    };
    "debug@4.3.2" = {
      pname = "debug";
      version = "4.3.2";
      depKeys = [
        ("ms@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1fx7gy0slvrpr7sijfx863fbmbwnkv7k9gz80c0420nwf62bkd86";
        url = "https://registry.npmjs.org/debug/-/debug-4.3.2.tgz";
      });
      pkgname = "debug";
    };
    "decamelize@1.2.0" = {
      pname = "decamelize";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0r187qd80plv8mm8riqk3xcmpip3zcpsgjrvf013m37323syzbdl";
        url = "https://registry.npmjs.org/decamelize/-/decamelize-1.2.0.tgz";
      });
      pkgname = "decamelize";
    };
    "decode-uri-component@0.2.0" = {
      pname = "decode-uri-component";
      version = "0.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1mhafchzv526marx5laflfrfz1dsz0mi61r9805rn96dhry44gha";
        url = "https://registry.npmjs.org/decode-uri-component/-/decode-uri-component-0.2.0.tgz";
      });
      pkgname = "decode-uri-component";
    };
    "deep-extend@0.6.0" = {
      pname = "deep-extend";
      version = "0.6.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "11hk1g7qjw9bj03c8y7v7n8p8mdfacpd9l8n57dga8qcj8s5zk0d";
        url = "https://registry.npmjs.org/deep-extend/-/deep-extend-0.6.0.tgz";
      });
      pkgname = "deep-extend";
    };
    "deep-is@0.1.3" = {
      pname = "deep-is";
      version = "0.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "11m7mds6valw8m5c5hgjnr83s104nirkvcnmclm38g02gvxf4rcq";
        url = "https://registry.npmjs.org/deep-is/-/deep-is-0.1.3.tgz";
      });
      pkgname = "deep-is";
    };
    "default-require-extensions@1.0.0" = {
      pname = "default-require-extensions";
      version = "1.0.0";
      depKeys = [
        ("strip-bom@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0sk7v5w2912clwmzh08xnc0yilf8l0ybx92zg6lxxdgpf39irli0";
        url = "https://registry.npmjs.org/default-require-extensions/-/default-require-extensions-1.0.0.tgz";
      });
      pkgname = "default-require-extensions";
    };
    "define-properties@1.1.3" = {
      pname = "define-properties";
      version = "1.1.3";
      depKeys = [
        ("object-keys@1.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19bhbbwl9m4jaj34gcvyw65bsx675y721fliqy9az5dv2pdz892m";
        url = "https://registry.npmjs.org/define-properties/-/define-properties-1.1.3.tgz";
      });
      pkgname = "define-properties";
    };
    "define-property@0.2.5" = {
      pname = "define-property";
      version = "0.2.5";
      depKeys = [
        ("is-descriptor@0.1.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1r2gws87mpwv0i1rl3l79bw8psgpz44vwyd9va9cr90bvkada5yk";
        url = "https://registry.npmjs.org/define-property/-/define-property-0.2.5.tgz";
      });
      pkgname = "define-property";
    };
    "define-property@1.0.0" = {
      pname = "define-property";
      version = "1.0.0";
      depKeys = [
        ("is-descriptor@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1547m4v074hgd28jzv4k82ig43pl7rgfnp0y832swxmlff4ra6m6";
        url = "https://registry.npmjs.org/define-property/-/define-property-1.0.0.tgz";
      });
      pkgname = "define-property";
    };
    "define-property@2.0.2" = {
      pname = "define-property";
      version = "2.0.2";
      depKeys = [
        ("is-descriptor@1.0.2")
        ("isobject@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0m8x3myy76d3w777c1jq94gafphxqrpj7sy3myxcvksfk0p8vpha";
        url = "https://registry.npmjs.org/define-property/-/define-property-2.0.2.tgz";
      });
      pkgname = "define-property";
    };
    "del@3.0.0" = {
      pname = "del";
      version = "3.0.0";
      depKeys = [
        ("globby@6.1.0")
        ("is-path-cwd@1.0.0")
        ("is-path-in-cwd@1.0.1")
        ("p-map@1.2.0")
        ("pify@3.0.0")
        ("rimraf@2.6.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1smqb7vj0zq16ym6ki8x8z28iqk84d0kyiz6cmykirgr6gy3c5iv";
        url = "https://registry.npmjs.org/del/-/del-3.0.0.tgz";
      });
      pkgname = "del";
    };
    "delayed-stream@1.0.0" = {
      pname = "delayed-stream";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lr98585rayrc5xfj599hg6mxqvks38diir74ivivyvx47jgqf5c";
        url = "https://registry.npmjs.org/delayed-stream/-/delayed-stream-1.0.0.tgz";
      });
      pkgname = "delayed-stream";
    };
    "delegates@1.0.0" = {
      pname = "delegates";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0qb4rw56fbxcpc2iwj1x0qxzakwwqigxgggggd6ajl7d27sdpvxz";
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
        sha256 = "07645ghplj1qy8z6g3vz1855xjy2j217q90bib3m44c2npk6pql3";
        url = "https://registry.npmjs.org/depd/-/depd-1.1.2.tgz";
      });
      pkgname = "depd";
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
    "detect-libc@1.0.3" = {
      pname = "detect-libc";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12r1f4mi84lcsqs2p86wx2f7282dgqaqwcckfs3nzcswp2cg4aks";
        url = "https://registry.npmjs.org/detect-libc/-/detect-libc-1.0.3.tgz";
      });
      pkgname = "detect-libc";
    };
    "detect-newline@2.1.0" = {
      pname = "detect-newline";
      version = "2.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "05l1lia3z28ar2xshhhzh6g7wammdv6011j9pjrgyf94z5ydm67z";
        url = "https://registry.npmjs.org/detect-newline/-/detect-newline-2.1.0.tgz";
      });
      pkgname = "detect-newline";
    };
    "diff@3.5.0" = {
      pname = "diff";
      version = "3.5.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0m0h3a7z1khyqaqyrmamrk38g2d0jpd25z866s3kqgsc6jc3gxhn";
        url = "https://registry.npmjs.org/diff/-/diff-3.5.0.tgz";
      });
      pkgname = "diff";
    };
    "domexception@1.0.1" = {
      pname = "domexception";
      version = "1.0.1";
      depKeys = [
        ("webidl-conversions@4.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1d7s3fxbm93jyyiif82hsh2qn3ln6fi695x3nbjf21c4zyzcz1i1";
        url = "https://registry.npmjs.org/domexception/-/domexception-1.0.1.tgz";
      });
      pkgname = "domexception";
    };
    "ecc-jsbn@0.1.2" = {
      pname = "ecc-jsbn";
      version = "0.1.2";
      depKeys = [
        ("jsbn@0.1.1")
        ("safer-buffer@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x39lihzphr0h1fvh9p65k86vx3p7z6jrxgv4b402lvdrifd56k0";
        url = "https://registry.npmjs.org/ecc-jsbn/-/ecc-jsbn-0.1.2.tgz";
      });
      pkgname = "ecc-jsbn";
    };
    "electron-to-chromium@1.3.200" = {
      pname = "electron-to-chromium";
      version = "1.3.200";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1sq30cpknf6fhpb7786ncg6z80b701vxha32vf6hb12i9j2fc0s9";
        url = "https://registry.npmjs.org/electron-to-chromium/-/electron-to-chromium-1.3.200.tgz";
      });
      pkgname = "electron-to-chromium";
    };
    "encoding@0.1.13" = {
      pname = "encoding";
      version = "0.1.13";
      depKeys = [
        ("iconv-lite@0.6.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "116gipr1y0hc9zvflsvd39psbbf2j62zvpnw099pqf7fl0nb5xbc";
        url = "https://registry.npmjs.org/encoding/-/encoding-0.1.13.tgz";
      });
      pkgname = "encoding";
    };
    "end-of-stream@1.4.1" = {
      pname = "end-of-stream";
      version = "1.4.1";
      depKeys = [
        ("once@1.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0piqpaq15k6rnr92slrmgfyidqnbqbawkna3bqspmjxygj3gkk1z";
        url = "https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.4.1.tgz";
      });
      pkgname = "end-of-stream";
    };
    "env-paths@2.2.1" = {
      pname = "env-paths";
      version = "2.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "17knwv8glmap1vcgca11h1r48hyards94slc83y9z02q857qj2ss";
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
        sha256 = "1qj8n8paszjn4w39wgd19885wp49hj98fd8hlp7isbqm0i54yrm5";
        url = "https://registry.npmjs.org/err-code/-/err-code-2.0.3.tgz";
      });
      pkgname = "err-code";
    };
    "error-ex@1.3.2" = {
      pname = "error-ex";
      version = "1.3.2";
      depKeys = [
        ("is-arrayish@0.2.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "12gyrmh6iqpx838bnb5iwcqm2447rnbxx1bvqn76l40fvr1aichs";
        url = "https://registry.npmjs.org/error-ex/-/error-ex-1.3.2.tgz";
      });
      pkgname = "error-ex";
    };
    "es-abstract@1.13.0" = {
      pname = "es-abstract";
      version = "1.13.0";
      depKeys = [
        ("es-to-primitive@1.2.0")
        ("function-bind@1.1.1")
        ("has@1.0.3")
        ("is-callable@1.1.4")
        ("is-regex@1.0.4")
        ("object-keys@1.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09h428laspkgylh98jyqhqvndgzxahfnfj2ry2ha8wmqaqac41f8";
        url = "https://registry.npmjs.org/es-abstract/-/es-abstract-1.13.0.tgz";
      });
      pkgname = "es-abstract";
    };
    "es-to-primitive@1.2.0" = {
      pname = "es-to-primitive";
      version = "1.2.0";
      depKeys = [
        ("is-callable@1.1.4")
        ("is-date-object@1.0.1")
        ("is-symbol@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kw5mxawac546v2z9sjpgbhc0arhbmcn129vcc6n0knyg4ga54mb";
        url = "https://registry.npmjs.org/es-to-primitive/-/es-to-primitive-1.2.0.tgz";
      });
      pkgname = "es-to-primitive";
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
    "escodegen@1.11.1" = {
      pname = "escodegen";
      version = "1.11.1";
      depKeys = [
        ("esprima@3.1.3")
        ("estraverse@4.2.0")
        ("esutils@2.0.2")
        ("optionator@0.8.2")
        ("source-map@0.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "10mdc3cxjfr0hkf8n48vd6ppm8dvf0praw757zmmvwilqglkwp13";
        url = "https://registry.npmjs.org/escodegen/-/escodegen-1.11.1.tgz";
      });
      pkgname = "escodegen";
    };
    "esprima@3.1.3" = {
      pname = "esprima";
      version = "3.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ks3znk2k419ldldp9x22hq8kwbfm63s6s3pvxi5vwfcnx2kzrbc";
        url = "https://registry.npmjs.org/esprima/-/esprima-3.1.3.tgz";
      });
      pkgname = "esprima";
    };
    "esprima@4.0.1" = {
      pname = "esprima";
      version = "4.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x6cjgh4452wa28yz562b4c2dad78rn3fxfzqns9bk5ykh7938fq";
        url = "https://registry.npmjs.org/esprima/-/esprima-4.0.1.tgz";
      });
      pkgname = "esprima";
    };
    "estraverse@4.2.0" = {
      pname = "estraverse";
      version = "4.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vsvv28rfwhdvmr4hanyhdh8vq4ckjji4m4vps942w9ci9zy5a4i";
        url = "https://registry.npmjs.org/estraverse/-/estraverse-4.2.0.tgz";
      });
      pkgname = "estraverse";
    };
    "esutils@2.0.2" = {
      pname = "esutils";
      version = "2.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "15np0hrkgvp6z9s1jh0krgrdawqnlmj1wdra9xj9yyj4dznqp5wy";
        url = "https://registry.npmjs.org/esutils/-/esutils-2.0.2.tgz";
      });
      pkgname = "esutils";
    };
    "esy-bash@0.3.20" = {
      pname = "esy-bash";
      version = "0.3.20";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g4z8cf8zzmdlky8dldcfql4iqvwp4mbyl015nz2q6m0wrg6lzxy";
        url = "https://registry.npmjs.org/esy-bash/-/esy-bash-0.3.20.tgz";
      });
      pkgname = "esy-bash";
    };
    "esy-solve-cudf@0.1.10" = {
      pname = "esy-solve-cudf";
      version = "0.1.10";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0d7jscs62dp2jxghphzdw75qs72887rcz2riy5gmbzinalz27yrw";
        url = "https://registry.npmjs.org/esy-solve-cudf/-/esy-solve-cudf-0.1.10.tgz";
      });
      pkgname = "esy-solve-cudf";
    };
    "esy@." = {
      pname = "esy";
      version = "0.0.0-use.local";
      depKeys = [
        ("babel-preset-env@1.7.0")
        ("babel-preset-flow@6.23.0")
        ("del@3.0.0")
        ("esy-bash@0.3.20")
        ("esy-solve-cudf@0.1.10")
        ("flow-bin@0.77.0")
        ("fs-extra@7.0.1")
        ("invariant@2.2.4")
        ("is-ci@1.2.1")
        ("jest-cli@23.6.0")
        ("jest-junit@5.2.0")
        ("jest-pnp-resolver@1.2.1")
        ("klaw@2.1.1")
        ("minimatch@3.0.4")
        ("outdent@0.3.0")
        ("prettier@1.18.2")
        ("rimraf@2.6.3")
        ("semver@5.7.0")
        ("super-resolve@1.0.0")
        ("tar@4.4.10")
        ("tar-fs@1.16.3")
        ("tmp@0.0.33")
      ];
      pkgname = "esy";
    };
    "exec-sh@0.2.2" = {
      pname = "exec-sh";
      version = "0.2.2";
      depKeys = [
        ("merge@1.2.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1493miwgm1g0f76xzgn2bxg1zaqliih2d4lmfpzxwk4xaq6d2aiq";
        url = "https://registry.npmjs.org/exec-sh/-/exec-sh-0.2.2.tgz";
      });
      pkgname = "exec-sh";
    };
    "execa@0.7.0" = {
      pname = "execa";
      version = "0.7.0";
      depKeys = [
        ("cross-spawn@5.1.0")
        ("get-stream@3.0.0")
        ("is-stream@1.1.0")
        ("npm-run-path@2.0.2")
        ("p-finally@1.0.0")
        ("signal-exit@3.0.2")
        ("strip-eof@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "05jw6x4i9glhn4k5i2y5i0gkx24whcnpc4jzb9wmhgpfqlz3g2ys";
        url = "https://registry.npmjs.org/execa/-/execa-0.7.0.tgz";
      });
      pkgname = "execa";
    };
    "exit@0.1.2" = {
      pname = "exit";
      version = "0.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0h9ax37w49xq5cljxij0sg7svl32a4sc89l928c8zhir1750cps8";
        url = "https://registry.npmjs.org/exit/-/exit-0.1.2.tgz";
      });
      pkgname = "exit";
    };
    "expand-brackets@0.1.5" = {
      pname = "expand-brackets";
      version = "0.1.5";
      depKeys = [
        ("is-posix-bracket@0.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1fzgbcp2faxj7d6i41iybacbxaig8gpkx329dvcysic2yy2rn1c3";
        url = "https://registry.npmjs.org/expand-brackets/-/expand-brackets-0.1.5.tgz";
      });
      pkgname = "expand-brackets";
    };
    "expand-brackets@2.1.4" = {
      pname = "expand-brackets";
      version = "2.1.4";
      depKeys = [
        ("debug@2.6.9")
        ("define-property@0.2.5")
        ("extend-shallow@2.0.1")
        ("posix-character-classes@0.1.1")
        ("regex-not@1.0.2")
        ("snapdragon@0.8.2")
        ("to-regex@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0csxpxfx1xkf2dp10vpifynkrx8csx7md7gysvhy5xr094hdr3nq";
        url = "https://registry.npmjs.org/expand-brackets/-/expand-brackets-2.1.4.tgz";
      });
      pkgname = "expand-brackets";
    };
    "expand-range@1.8.2" = {
      pname = "expand-range";
      version = "1.8.2";
      depKeys = [
        ("fill-range@2.2.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1d78rg12y81sy87jfdr5i9a2dq7smg47w5s249f7bfgwlcn848zl";
        url = "https://registry.npmjs.org/expand-range/-/expand-range-1.8.2.tgz";
      });
      pkgname = "expand-range";
    };
    "expect@23.6.0" = {
      pname = "expect";
      version = "23.6.0";
      depKeys = [
        ("ansi-styles@3.2.1")
        ("jest-diff@23.6.0")
        ("jest-get-type@22.4.3")
        ("jest-matcher-utils@23.6.0")
        ("jest-message-util@23.4.0")
        ("jest-regex-util@23.3.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1kz8m913p31w11z9n6avfhzj78m12mvvx55910f7a708c97r6y6v";
        url = "https://registry.npmjs.org/expect/-/expect-23.6.0.tgz";
      });
      pkgname = "expect";
    };
    "extend-shallow@2.0.1" = {
      pname = "extend-shallow";
      version = "2.0.1";
      depKeys = [
        ("is-extendable@0.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09baxpl8w1rw3qmqmp7w23kyqrxks1hhbvpac0j82gbsgimrlz0v";
        url = "https://registry.npmjs.org/extend-shallow/-/extend-shallow-2.0.1.tgz";
      });
      pkgname = "extend-shallow";
    };
    "extend-shallow@3.0.2" = {
      pname = "extend-shallow";
      version = "3.0.2";
      depKeys = [
        ("assign-symbols@1.0.0")
        ("is-extendable@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "02bickcbljfrxfix2rbvq5j2cdlwm0dqflxc2ky4l6jp97bcl6m0";
        url = "https://registry.npmjs.org/extend-shallow/-/extend-shallow-3.0.2.tgz";
      });
      pkgname = "extend-shallow";
    };
    "extend@3.0.2" = {
      pname = "extend";
      version = "3.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ckjrzapv4awrafybcvq3n5rcqm6ljswfdx97wibl355zaqd148x";
        url = "https://registry.npmjs.org/extend/-/extend-3.0.2.tgz";
      });
      pkgname = "extend";
    };
    "extglob@0.3.2" = {
      pname = "extglob";
      version = "0.3.2";
      depKeys = [
        ("is-extglob@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "161asrmll909bda6hzz8ayfym5sp35yp45s25dcbfs3d9qcz0m98";
        url = "https://registry.npmjs.org/extglob/-/extglob-0.3.2.tgz";
      });
      pkgname = "extglob";
    };
    "extglob@2.0.4" = {
      pname = "extglob";
      version = "2.0.4";
      depKeys = [
        ("array-unique@0.3.2")
        ("define-property@1.0.0")
        ("expand-brackets@2.1.4")
        ("extend-shallow@2.0.1")
        ("fragment-cache@0.2.1")
        ("regex-not@1.0.2")
        ("snapdragon@0.8.2")
        ("to-regex@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1wza438hvcr83b28zic65h8jq8k0p0v9iw9b1lfk1zhb5xrkp8sy";
        url = "https://registry.npmjs.org/extglob/-/extglob-2.0.4.tgz";
      });
      pkgname = "extglob";
    };
    "extsprintf@1.3.0" = {
      pname = "extsprintf";
      version = "1.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0i6hmr7mkg76rgrxs7f0xny48kha2xi03wj43mfik77m0lk3k6yg";
        url = "https://registry.npmjs.org/extsprintf/-/extsprintf-1.3.0.tgz";
      });
      pkgname = "extsprintf";
    };
    "extsprintf@1.4.0" = {
      pname = "extsprintf";
      version = "1.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lphcbxrq7x1gz84f71hx7z4fkick5knxbif1cxim53ifn5cwrxm";
        url = "https://registry.npmjs.org/extsprintf/-/extsprintf-1.4.0.tgz";
      });
      pkgname = "extsprintf";
    };
    "fast-deep-equal@2.0.1" = {
      pname = "fast-deep-equal";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0a3iljq1zxzvkx47h831pf1acap5fhzqfnwbhar5lrwxnfrlr45g";
        url = "https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-2.0.1.tgz";
      });
      pkgname = "fast-deep-equal";
    };
    "fast-json-stable-stringify@2.0.0" = {
      pname = "fast-json-stable-stringify";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jppa6scaw1n2b172c7rjm7b9lpygm4w21x0vjp2c424dwbckzf0";
        url = "https://registry.npmjs.org/fast-json-stable-stringify/-/fast-json-stable-stringify-2.0.0.tgz";
      });
      pkgname = "fast-json-stable-stringify";
    };
    "fast-levenshtein@2.0.6" = {
      pname = "fast-levenshtein";
      version = "2.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g5zgdlp38dli94qbbm8vhvmj90fh48sxpggfn2083wbdcq50jxv";
        url = "https://registry.npmjs.org/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz";
      });
      pkgname = "fast-levenshtein";
    };
    "fb-watchman@2.0.0" = {
      pname = "fb-watchman";
      version = "2.0.0";
      depKeys = [
        ("bser@2.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "16aiv6k5563idi5qj2n06px23d1iixagpqyf04j7mn8arpbmfwrh";
        url = "https://registry.npmjs.org/fb-watchman/-/fb-watchman-2.0.0.tgz";
      });
      pkgname = "fb-watchman";
    };
    "filename-regex@2.0.1" = {
      pname = "filename-regex";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0swl7rv3vxrrmpjfr9i5fdbghif1s2yj9mdxmx6c27mg2kx88ya2";
        url = "https://registry.npmjs.org/filename-regex/-/filename-regex-2.0.1.tgz";
      });
      pkgname = "filename-regex";
    };
    "fileset@2.0.3" = {
      pname = "fileset";
      version = "2.0.3";
      depKeys = [
        ("glob@7.1.4")
        ("minimatch@3.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "11dbfqjmhd9nbc73906mnsx0i19j7m4bhwbrgdk4n8zq8ajw8x60";
        url = "https://registry.npmjs.org/fileset/-/fileset-2.0.3.tgz";
      });
      pkgname = "fileset";
    };
    "fill-range@2.2.4" = {
      pname = "fill-range";
      version = "2.2.4";
      depKeys = [
        ("is-number@2.1.0")
        ("isobject@2.1.0")
        ("randomatic@3.1.1")
        ("repeat-element@1.1.3")
        ("repeat-string@1.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "183q5x2pvh9xwbpm1lrhazqbm5pg400nxi6rirpks4980fiph7fi";
        url = "https://registry.npmjs.org/fill-range/-/fill-range-2.2.4.tgz";
      });
      pkgname = "fill-range";
    };
    "fill-range@4.0.0" = {
      pname = "fill-range";
      version = "4.0.0";
      depKeys = [
        ("extend-shallow@2.0.1")
        ("is-number@3.0.0")
        ("repeat-string@1.6.1")
        ("to-regex-range@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "14kaakn1yhkfsclqds0pg1g87aibi8nkrwn0axvfasj495hv2wzx";
        url = "https://registry.npmjs.org/fill-range/-/fill-range-4.0.0.tgz";
      });
      pkgname = "fill-range";
    };
    "find-up@1.1.2" = {
      pname = "find-up";
      version = "1.1.2";
      depKeys = [
        ("path-exists@2.1.0")
        ("pinkie-promise@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0zwbgl9mcnqg92hb0iy89clb1fa80wmysfrm0hax69yggj69drmi";
        url = "https://registry.npmjs.org/find-up/-/find-up-1.1.2.tgz";
      });
      pkgname = "find-up";
    };
    "find-up@2.1.0" = {
      pname = "find-up";
      version = "2.1.0";
      depKeys = [
        ("locate-path@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "07dd6cbb6dj1ff52pkkga0zaisn1vfp8n615x6n7wjrkqzybzzz3";
        url = "https://registry.npmjs.org/find-up/-/find-up-2.1.0.tgz";
      });
      pkgname = "find-up";
    };
    "flow-bin@0.77.0" = {
      pname = "flow-bin";
      version = "0.77.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1f4papilqziick6rv69pgql0ql7b9qc3czwjgcscgllxd9lbjrdl";
        url = "https://registry.npmjs.org/flow-bin/-/flow-bin-0.77.0.tgz";
      });
      pkgname = "flow-bin";
    };
    "for-in@1.0.2" = {
      pname = "for-in";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pm8dx9gvp9p91my9fqivajq7yhnxmn8scl391pgcv6d8h6s6zaf";
        url = "https://registry.npmjs.org/for-in/-/for-in-1.0.2.tgz";
      });
      pkgname = "for-in";
    };
    "for-own@0.1.5" = {
      pname = "for-own";
      version = "0.1.5";
      depKeys = [
        ("for-in@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0bxjf90a7n1r0l5vm93zrz00qzip9s4g4c3pzdg3grn2fw53byph";
        url = "https://registry.npmjs.org/for-own/-/for-own-0.1.5.tgz";
      });
      pkgname = "for-own";
    };
    "forever-agent@0.6.1" = {
      pname = "forever-agent";
      version = "0.6.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1i86r2ip6ryrnpg3v7pf0ywddhsdlr809xycd3zm9gq7zphn5a7c";
        url = "https://registry.npmjs.org/forever-agent/-/forever-agent-0.6.1.tgz";
      });
      pkgname = "forever-agent";
    };
    "form-data@2.3.3" = {
      pname = "form-data";
      version = "2.3.3";
      depKeys = [
        ("asynckit@0.4.0")
        ("combined-stream@1.0.8")
        ("mime-types@2.1.24")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j1ka178syqqaycr1m3vqahbb3bi7qsks0mp0iqbd6y7yj1wz7p3";
        url = "https://registry.npmjs.org/form-data/-/form-data-2.3.3.tgz";
      });
      pkgname = "form-data";
    };
    "fragment-cache@0.2.1" = {
      pname = "fragment-cache";
      version = "0.2.1";
      depKeys = [
        ("map-cache@0.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "114jfm5qpvz52127hf4ny4vz1qs7a597hql5lj0g2ncixn8sqg76";
        url = "https://registry.npmjs.org/fragment-cache/-/fragment-cache-0.2.1.tgz";
      });
      pkgname = "fragment-cache";
    };
    "fs-constants@1.0.0" = {
      pname = "fs-constants";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1yn5qyvxf9i3zrfly77wgmi3j9fl61gh1i0jjgamnir43dz6v4z7";
        url = "https://registry.npmjs.org/fs-constants/-/fs-constants-1.0.0.tgz";
      });
      pkgname = "fs-constants";
    };
    "fs-extra@7.0.1" = {
      pname = "fs-extra";
      version = "7.0.1";
      depKeys = [
        ("graceful-fs@4.2.0")
        ("jsonfile@4.0.0")
        ("universalify@0.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1f08bng4dgkdrwhd977f4xfch9419b7fbwvwwn1qpz3gy4zgja4b";
        url = "https://registry.npmjs.org/fs-extra/-/fs-extra-7.0.1.tgz";
      });
      pkgname = "fs-extra";
    };
    "fs-minipass@1.2.6" = {
      pname = "fs-minipass";
      version = "1.2.6";
      depKeys = [
        ("minipass@2.3.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "08dqfdpn9gavw6b9k6lim732y1xs0ybvyq9fj1fja0c4b305861l";
        url = "https://registry.npmjs.org/fs-minipass/-/fs-minipass-1.2.6.tgz";
      });
      pkgname = "fs-minipass";
    };
    "fs-minipass@2.1.0" = {
      pname = "fs-minipass";
      version = "2.1.0";
      depKeys = [
        ("minipass@3.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "029kdjb6h8gp0gfx7rx6yzwbv7pnd7i119gn563ynv0dqx02p5gx";
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
        sha256 = "174g5vay9jnd7h5q8hfdw6dnmwl1gdpn4a8sz0ysanhj2f3wp04y";
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
      });
      pkgname = "fs.realpath";
    };
    "fsevents@1.2.9" = {
      pname = "fsevents";
      version = "1.2.9";
      depKeys = [
        ("nan@2.14.0")
        ("node-pre-gyp@0.12.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1x0vam2bmi4iq849fi1i599i8p0s83fblqzqadnqxh7xr11mfpwi";
        url = "https://registry.npmjs.org/fsevents/-/fsevents-1.2.9.tgz";
      });
      pkgname = "fsevents";
    };
    "fsevents@fsevents@npm%3A1.2.9#~builtin<compat/fsevents>::version=1.2.9&hash=18f3a7" = {
      pname = "fsevents";
      version = "1.2.9";
      depKeys = [
        ("nan@2.14.0")
        ("node-pre-gyp@0.12.0")
      ];
      pkgname = "fsevents";
    };
    "function-bind@1.1.1" = {
      pname = "function-bind";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "10p0s9ypggwmazik4azdhywjnnayagnjxk10cjzsrhxlk1y2wm9d";
        url = "https://registry.npmjs.org/function-bind/-/function-bind-1.1.1.tgz";
      });
      pkgname = "function-bind";
    };
    "gauge@2.7.4" = {
      pname = "gauge";
      version = "2.7.4";
      depKeys = [
        ("aproba@1.2.0")
        ("console-control-strings@1.1.0")
        ("has-unicode@2.0.1")
        ("object-assign@4.1.1")
        ("signal-exit@3.0.2")
        ("string-width@1.0.2")
        ("strip-ansi@3.0.1")
        ("wide-align@1.1.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xk6970l7f0jd7xy8xbxicxbkgc19j9k7q2cypsg0z4qs3ah9ncq";
        url = "https://registry.npmjs.org/gauge/-/gauge-2.7.4.tgz";
      });
      pkgname = "gauge";
    };
    "get-caller-file@1.0.3" = {
      pname = "get-caller-file";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0s1b558j1an7g0y5kvbvyailjbxsqgk7374cbb07h26gkwbhc14x";
        url = "https://registry.npmjs.org/get-caller-file/-/get-caller-file-1.0.3.tgz";
      });
      pkgname = "get-caller-file";
    };
    "get-stream@3.0.0" = {
      pname = "get-stream";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0vh08ligj02bzcp49hcvibilrhyv02r5hj2gzgx03a59hfs0apkp";
        url = "https://registry.npmjs.org/get-stream/-/get-stream-3.0.0.tgz";
      });
      pkgname = "get-stream";
    };
    "get-value@2.0.6" = {
      pname = "get-value";
      version = "2.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "057wz0ya7zlgz59m08zbaasvzfdxjzgd6bzphd2xwsydhjwnw02l";
        url = "https://registry.npmjs.org/get-value/-/get-value-2.0.6.tgz";
      });
      pkgname = "get-value";
    };
    "getpass@0.1.7" = {
      pname = "getpass";
      version = "0.1.7";
      depKeys = [
        ("assert-plus@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ifl7rdzhkbwzb2pmi6mxvv92qd2ihbfbfkipw9nqvbn22x140wg";
        url = "https://registry.npmjs.org/getpass/-/getpass-0.1.7.tgz";
      });
      pkgname = "getpass";
    };
    "glob-base@0.3.0" = {
      pname = "glob-base";
      version = "0.3.0";
      depKeys = [
        ("glob-parent@2.0.0")
        ("is-glob@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19d8xlkbibp313hidn9ldliqx9n7qlscf7pgxwi5ld1rak5r7an7";
        url = "https://registry.npmjs.org/glob-base/-/glob-base-0.3.0.tgz";
      });
      pkgname = "glob-base";
    };
    "glob-parent@2.0.0" = {
      pname = "glob-parent";
      version = "2.0.0";
      depKeys = [
        ("is-glob@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kc5f3hd4n5aj58gvaslcfqnadx3zwk1qwmilgggqf5jv4wc0cb3";
        url = "https://registry.npmjs.org/glob-parent/-/glob-parent-2.0.0.tgz";
      });
      pkgname = "glob-parent";
    };
    "glob@7.1.4" = {
      pname = "glob";
      version = "7.1.4";
      depKeys = [
        ("fs.realpath@1.0.0")
        ("inflight@1.0.6")
        ("inherits@2.0.4")
        ("minimatch@3.0.4")
        ("once@1.4.0")
        ("path-is-absolute@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "18wla317z5w673k0f0gcw74xnm29ssk9csk2yqd2d5sc0gl0ahkx";
        url = "https://registry.npmjs.org/glob/-/glob-7.1.4.tgz";
      });
      pkgname = "glob";
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
        sha256 = "06q5g9ja57jfca5qqbnad6lfhd7xv2kziy9xpqf97ipd5zg77vpn";
        url = "https://registry.npmjs.org/glob/-/glob-7.2.0.tgz";
      });
      pkgname = "glob";
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
    "globby@6.1.0" = {
      pname = "globby";
      version = "6.1.0";
      depKeys = [
        ("array-union@1.0.2")
        ("glob@7.1.4")
        ("object-assign@4.1.1")
        ("pify@2.3.0")
        ("pinkie-promise@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0bx6wym4cj57f7mf4jxnvsn24mwbvbw52l79g1fbc0bmwgy5pr8g";
        url = "https://registry.npmjs.org/globby/-/globby-6.1.0.tgz";
      });
      pkgname = "globby";
    };
    "graceful-fs@4.2.0" = {
      pname = "graceful-fs";
      version = "4.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0igmf9h573g3lj7z8410qhdk4cgqr1wvds057s5z9ls8j0h9gbfh";
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.0.tgz";
      });
      pkgname = "graceful-fs";
    };
    "graceful-fs@4.2.8" = {
      pname = "graceful-fs";
      version = "4.2.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "19kdnpgkbf2g2f4jdqc869g60wljdq10qmk4vymvwq7q2fm12sp5";
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.8.tgz";
      });
      pkgname = "graceful-fs";
    };
    "growly@1.3.0" = {
      pname = "growly";
      version = "1.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "01v2gabh8mi35jijck5ljvh60i8kdrv30gyjannwichap90h9a1s";
        url = "https://registry.npmjs.org/growly/-/growly-1.3.0.tgz";
      });
      pkgname = "growly";
    };
    "handlebars@4.1.2" = {
      pname = "handlebars";
      version = "4.1.2";
      depKeys = [
        ("neo-async@2.6.1")
        ("optimist@0.6.1")
        ("source-map@0.6.1")
        ("uglify-js@3.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0j14xlvr1q4jglqqrcz667g24hn2hvhds9gqcw61xs0sf6ryk3gg";
        url = "https://registry.npmjs.org/handlebars/-/handlebars-4.1.2.tgz";
      });
      pkgname = "handlebars";
    };
    "har-schema@2.0.0" = {
      pname = "har-schema";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "09myh5q5225c53v39mw9n3a2kgf2pk0z9dfwbmm7rbb70npq8yrf";
        url = "https://registry.npmjs.org/har-schema/-/har-schema-2.0.0.tgz";
      });
      pkgname = "har-schema";
    };
    "har-validator@5.1.3" = {
      pname = "har-validator";
      version = "5.1.3";
      depKeys = [
        ("ajv@6.10.2")
        ("har-schema@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0k8galqd75nksyqnwszq5hhv8wvnwfhy3xq7rymjxa9gnvg2qa3s";
        url = "https://registry.npmjs.org/har-validator/-/har-validator-5.1.3.tgz";
      });
      pkgname = "har-validator";
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
    "has-flag@1.0.0" = {
      pname = "has-flag";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "19sfml8lx81kdl44305h7nr3wn75jpyb2q3ijcjs4r2g6p2rxdj8";
        url = "https://registry.npmjs.org/has-flag/-/has-flag-1.0.0.tgz";
      });
      pkgname = "has-flag";
    };
    "has-flag@3.0.0" = {
      pname = "has-flag";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1sp0m48zavms86q7vkf90mwll9z2bqi11hk3s01aw8nw40r72jzd";
        url = "https://registry.npmjs.org/has-flag/-/has-flag-3.0.0.tgz";
      });
      pkgname = "has-flag";
    };
    "has-symbols@1.0.0" = {
      pname = "has-symbols";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jfws5i839my6n1lkw6s1gfrwlvpdmndn5dg8czfpxd7jrf1f2n6";
        url = "https://registry.npmjs.org/has-symbols/-/has-symbols-1.0.0.tgz";
      });
      pkgname = "has-symbols";
    };
    "has-unicode@2.0.1" = {
      pname = "has-unicode";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1b7c6mrpncz2x7s6r1v9kcmqw6hix039kbkbzqz0czma56gxsqfh";
        url = "https://registry.npmjs.org/has-unicode/-/has-unicode-2.0.1.tgz";
      });
      pkgname = "has-unicode";
    };
    "has-value@0.3.1" = {
      pname = "has-value";
      version = "0.3.1";
      depKeys = [
        ("get-value@2.0.6")
        ("has-values@0.1.4")
        ("isobject@2.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1h4dnzr9rszpj0a015529r1c9g8ysy4wym6ay99vc6dls02jhmny";
        url = "https://registry.npmjs.org/has-value/-/has-value-0.3.1.tgz";
      });
      pkgname = "has-value";
    };
    "has-value@1.0.0" = {
      pname = "has-value";
      version = "1.0.0";
      depKeys = [
        ("get-value@2.0.6")
        ("has-values@1.0.0")
        ("isobject@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ikpbff1imw3nqqp9q9siwh7p93r1pdigiv6kgryx6l8hwiwbxr9";
        url = "https://registry.npmjs.org/has-value/-/has-value-1.0.0.tgz";
      });
      pkgname = "has-value";
    };
    "has-values@0.1.4" = {
      pname = "has-values";
      version = "0.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lnp2ww5w0lxxiqrm3scyaddj7csdrd4ldsmsvapys4rdfgnx0m6";
        url = "https://registry.npmjs.org/has-values/-/has-values-0.1.4.tgz";
      });
      pkgname = "has-values";
    };
    "has-values@1.0.0" = {
      pname = "has-values";
      version = "1.0.0";
      depKeys = [
        ("is-number@3.0.0")
        ("kind-of@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19ggazh85imjwxnvvhabypdpmyl0q4mgm3frwfx2dx3ffq1g1bwc";
        url = "https://registry.npmjs.org/has-values/-/has-values-1.0.0.tgz";
      });
      pkgname = "has-values";
    };
    "has@1.0.3" = {
      pname = "has";
      version = "1.0.3";
      depKeys = [
        ("function-bind@1.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wsmn2vcbqb23xpbzxipjd7xcdljid2gwnwl7vn5hkp0zkpgk363";
        url = "https://registry.npmjs.org/has/-/has-1.0.3.tgz";
      });
      pkgname = "has";
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
    "hosted-git-info@2.7.1" = {
      pname = "hosted-git-info";
      version = "2.7.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "19j9azym7j80cwasg544fh8szr5zlk3c43jpnd1q1r2bnpfmgsnc";
        url = "https://registry.npmjs.org/hosted-git-info/-/hosted-git-info-2.7.1.tgz";
      });
      pkgname = "hosted-git-info";
    };
    "html-encoding-sniffer@1.0.2" = {
      pname = "html-encoding-sniffer";
      version = "1.0.2";
      depKeys = [
        ("whatwg-encoding@1.0.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "11xni5fk8lgr4374z9zmw7ynkw4p91vcgagf52cjwbdlgggmf0w6";
        url = "https://registry.npmjs.org/html-encoding-sniffer/-/html-encoding-sniffer-1.0.2.tgz";
      });
      pkgname = "html-encoding-sniffer";
    };
    "http-cache-semantics@4.1.0" = {
      pname = "http-cache-semantics";
      version = "4.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j18fxbpdb6f43w7ndmqlmf7r0l9wv2m837mvvqi3y122xig0c0g";
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
        ("debug@4.3.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xa8vidkb3w7876sl6h149mg95dbx21phm9s1d21122ixaxpy50w";
        url = "https://registry.npmjs.org/http-proxy-agent/-/http-proxy-agent-4.0.1.tgz";
      });
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
      src = (pkgs.fetchurl {
        sha256 = "1y856b84kxhq6wc9yiqcfhd4187nizr7lhxi9z69mwzavmpnvgk6";
        url = "https://registry.npmjs.org/http-signature/-/http-signature-1.2.0.tgz";
      });
      pkgname = "http-signature";
    };
    "https-proxy-agent@5.0.0" = {
      pname = "https-proxy-agent";
      version = "5.0.0";
      depKeys = [
        ("agent-base@6.0.2")
        ("debug@4.3.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1a7mbscj5g23bcprp7psn5f82dhqz09sdris931dwkazq8gfparq";
        url = "https://registry.npmjs.org/https-proxy-agent/-/https-proxy-agent-5.0.0.tgz";
      });
      pkgname = "https-proxy-agent";
    };
    "humanize-ms@1.2.1" = {
      pname = "humanize-ms";
      version = "1.2.1";
      depKeys = [
        ("ms@2.1.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09sy84kkmvq1la85iws84w2jv1phdsf5jswg7mk7qjbr47dyc3sl";
        url = "https://registry.npmjs.org/humanize-ms/-/humanize-ms-1.2.1.tgz";
      });
      pkgname = "humanize-ms";
    };
    "iconv-lite@0.4.24" = {
      pname = "iconv-lite";
      version = "0.4.24";
      depKeys = [
        ("safer-buffer@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0da6ff7dlx6lfhdafsd9sv0h09sicpfakms8bqylrm4f17r68v2p";
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.4.24.tgz";
      });
      pkgname = "iconv-lite";
    };
    "iconv-lite@0.6.3" = {
      pname = "iconv-lite";
      version = "0.6.3";
      depKeys = [
        ("safer-buffer@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1x681ziwavjjn09j4858fl3h3xi90vf512k5zwg06kwriwafq9vi";
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.6.3.tgz";
      });
      pkgname = "iconv-lite";
    };
    "ignore-walk@3.0.1" = {
      pname = "ignore-walk";
      version = "3.0.1";
      depKeys = [
        ("minimatch@3.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ps1wq49wwczy5qrp406jcg98xsyirama98hgxjidx20nbcxgy8q";
        url = "https://registry.npmjs.org/ignore-walk/-/ignore-walk-3.0.1.tgz";
      });
      pkgname = "ignore-walk";
    };
    "import-local@1.0.0" = {
      pname = "import-local";
      version = "1.0.0";
      depKeys = [
        ("pkg-dir@2.0.0")
        ("resolve-cwd@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bj7ji1j3xsd6sg1gmbiir9xls6m2w386kgnc1kwn0y0fbbnahjy";
        url = "https://registry.npmjs.org/import-local/-/import-local-1.0.0.tgz";
      });
      pkgname = "import-local";
    };
    "imurmurhash@0.1.4" = {
      pname = "imurmurhash";
      version = "0.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0q6bf91h2g5dhvcdss74sjvp5irimd97hp73jb8p2wvajqqs08xc";
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
        sha256 = "1822k378f65ipx6v9i132bywcnfjzk3rgilhnp443csfsz9p8sxw";
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
        sha256 = "0rc7is18a3558rkjkwc48a750f6zr44sgnpdzvpmgk8xhl2plyz5";
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
        sha256 = "16w864087xsh3q7f5gm3754s7bpsb9fq3dhknk9nmbvlk3sxr7ss";
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
        sha256 = "1bxg4igfni2hymabg8bkw86wd3qhhzhsswran47sridk3dnbqkfr";
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
      });
      pkgname = "inherits";
    };
    "ini@1.3.5" = {
      pname = "ini";
      version = "1.3.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pbq8qv4yry4cr1m0nmrz0vz6gfq96y816687vmlwh47rj3vv3py";
        url = "https://registry.npmjs.org/ini/-/ini-1.3.5.tgz";
      });
      pkgname = "ini";
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
    "invert-kv@1.0.0" = {
      pname = "invert-kv";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "17njfi4w2fan02ysnlk545wbdr8jnzqhy8kywh64jxhq9f1lycxd";
        url = "https://registry.npmjs.org/invert-kv/-/invert-kv-1.0.0.tgz";
      });
      pkgname = "invert-kv";
    };
    "ip@1.1.5" = {
      pname = "ip";
      version = "1.1.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0na248rdqaxsdx2q582vq6z0mspizl1q2q1cfzpriia29kd8ixm8";
        url = "https://registry.npmjs.org/ip/-/ip-1.1.5.tgz";
      });
      pkgname = "ip";
    };
    "is-accessor-descriptor@0.1.6" = {
      pname = "is-accessor-descriptor";
      version = "0.1.6";
      depKeys = [
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j9kc4m771w28kdrph25q8q62yfiazg2gi6frnbfd66xfmimhmi3";
        url = "https://registry.npmjs.org/is-accessor-descriptor/-/is-accessor-descriptor-0.1.6.tgz";
      });
      pkgname = "is-accessor-descriptor";
    };
    "is-accessor-descriptor@1.0.0" = {
      pname = "is-accessor-descriptor";
      version = "1.0.0";
      depKeys = [
        ("kind-of@6.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "18ybls0d0q6y7gp8mzhypyr0vbrx1vr5agm07s201byvc5dfmxql";
        url = "https://registry.npmjs.org/is-accessor-descriptor/-/is-accessor-descriptor-1.0.0.tgz";
      });
      pkgname = "is-accessor-descriptor";
    };
    "is-array@1.0.1" = {
      pname = "is-array";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pms32dj6arll4l586hpqbipgpncg9v6qf7adddxa7vkz2m5hd9v";
        url = "https://registry.npmjs.org/is-array/-/is-array-1.0.1.tgz";
      });
      pkgname = "is-array";
    };
    "is-arrayish@0.2.1" = {
      pname = "is-arrayish";
      version = "0.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "13734x7w9924g9pch6ywgz741hs5ir612k3578k9fy247vcib3c4";
        url = "https://registry.npmjs.org/is-arrayish/-/is-arrayish-0.2.1.tgz";
      });
      pkgname = "is-arrayish";
    };
    "is-buffer@1.1.6" = {
      pname = "is-buffer";
      version = "1.1.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "03l8f9r41xy0lq5zjm790jg758r8wv3fcsfwsd8331w6l30dh6ix";
        url = "https://registry.npmjs.org/is-buffer/-/is-buffer-1.1.6.tgz";
      });
      pkgname = "is-buffer";
    };
    "is-callable@1.1.4" = {
      pname = "is-callable";
      version = "1.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1arvhf4fim2sr46rsf6hhwc365szyzi00qshj8m6yzygw3fn6lhp";
        url = "https://registry.npmjs.org/is-callable/-/is-callable-1.1.4.tgz";
      });
      pkgname = "is-callable";
    };
    "is-ci@1.2.1" = {
      pname = "is-ci";
      version = "1.2.1";
      depKeys = [
        ("ci-info@1.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1cw9cn91kwsv36slvh7zpw9vb1m9cmfr2kiyyqwwzm05gv3x6hdv";
        url = "https://registry.npmjs.org/is-ci/-/is-ci-1.2.1.tgz";
      });
      pkgname = "is-ci";
    };
    "is-data-descriptor@0.1.4" = {
      pname = "is-data-descriptor";
      version = "0.1.4";
      depKeys = [
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0grcjmph4r8s17dd24mbq3ax09q9qgm6vrpjwkmhsc87nv42m9s3";
        url = "https://registry.npmjs.org/is-data-descriptor/-/is-data-descriptor-0.1.4.tgz";
      });
      pkgname = "is-data-descriptor";
    };
    "is-data-descriptor@1.0.0" = {
      pname = "is-data-descriptor";
      version = "1.0.0";
      depKeys = [
        ("kind-of@6.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0b51kish7r330jy625yaz424kvawrh8vxnpajmkx364pw9hm9hi8";
        url = "https://registry.npmjs.org/is-data-descriptor/-/is-data-descriptor-1.0.0.tgz";
      });
      pkgname = "is-data-descriptor";
    };
    "is-date-object@1.0.1" = {
      pname = "is-date-object";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dfv2846xxz676hapc3hh97xs018p16md0qj7y3i9q213grc2r45";
        url = "https://registry.npmjs.org/is-date-object/-/is-date-object-1.0.1.tgz";
      });
      pkgname = "is-date-object";
    };
    "is-descriptor@0.1.6" = {
      pname = "is-descriptor";
      version = "0.1.6";
      depKeys = [
        ("is-accessor-descriptor@0.1.6")
        ("is-data-descriptor@0.1.4")
        ("kind-of@5.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0smh1f833y06l7m1qasjms9kv9qjr11bzyaslpz0wq9qmbkl5mdh";
        url = "https://registry.npmjs.org/is-descriptor/-/is-descriptor-0.1.6.tgz";
      });
      pkgname = "is-descriptor";
    };
    "is-descriptor@1.0.2" = {
      pname = "is-descriptor";
      version = "1.0.2";
      depKeys = [
        ("is-accessor-descriptor@1.0.0")
        ("is-data-descriptor@1.0.0")
        ("kind-of@6.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bbfdklsskykp1qw9h2mpxjk7hjh6685s1raq73lxbn2b6iyfppy";
        url = "https://registry.npmjs.org/is-descriptor/-/is-descriptor-1.0.2.tgz";
      });
      pkgname = "is-descriptor";
    };
    "is-dotfile@1.0.3" = {
      pname = "is-dotfile";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "13k7xhnmgbirvqs0lrggm7knqhkghm73pdha2sb5fq6ys9l6bili";
        url = "https://registry.npmjs.org/is-dotfile/-/is-dotfile-1.0.3.tgz";
      });
      pkgname = "is-dotfile";
    };
    "is-equal-shallow@0.1.3" = {
      pname = "is-equal-shallow";
      version = "0.1.3";
      depKeys = [
        ("is-primitive@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1scqzxqgasmdyzw658nayiaykw4ba82rqkz83svrcdvjvp68phql";
        url = "https://registry.npmjs.org/is-equal-shallow/-/is-equal-shallow-0.1.3.tgz";
      });
      pkgname = "is-equal-shallow";
    };
    "is-extendable@0.1.1" = {
      pname = "is-extendable";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12f91w1hcv9hw2jlrxf3831zhw7fb0bmzdybzsqb71h5phyjnd7b";
        url = "https://registry.npmjs.org/is-extendable/-/is-extendable-0.1.1.tgz";
      });
      pkgname = "is-extendable";
    };
    "is-extendable@1.0.1" = {
      pname = "is-extendable";
      version = "1.0.1";
      depKeys = [
        ("is-plain-object@2.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0n1610rd5qv9h43zkr464dvk6hns1afmfpzg1g7b7z6as3axkss2";
        url = "https://registry.npmjs.org/is-extendable/-/is-extendable-1.0.1.tgz";
      });
      pkgname = "is-extendable";
    };
    "is-extglob@1.0.0" = {
      pname = "is-extglob";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "17arbivg9gky2l24xr5jjr2zpqslq73amb7sgp1flnadqcxmcgj7";
        url = "https://registry.npmjs.org/is-extglob/-/is-extglob-1.0.0.tgz";
      });
      pkgname = "is-extglob";
    };
    "is-finite@1.0.2" = {
      pname = "is-finite";
      version = "1.0.2";
      depKeys = [
        ("number-is-nan@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lvrm1psvg7qzdm9z2h0aaxa9spdq6b593rk2fy7szdyzs56yca1";
        url = "https://registry.npmjs.org/is-finite/-/is-finite-1.0.2.tgz";
      });
      pkgname = "is-finite";
    };
    "is-fullwidth-code-point@1.0.0" = {
      pname = "is-fullwidth-code-point";
      version = "1.0.0";
      depKeys = [
        ("number-is-nan@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0v38ngwaag3h6zggqljmc9ax6jpwy3ldm3qx9j0cqiqd2dm6bvbp";
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-1.0.0.tgz";
      });
      pkgname = "is-fullwidth-code-point";
    };
    "is-fullwidth-code-point@2.0.0" = {
      pname = "is-fullwidth-code-point";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0sx0mg720hlpxdcg3rpf5ck93bwzkvb5883686v2iwvbxvnx1l2c";
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz";
      });
      pkgname = "is-fullwidth-code-point";
    };
    "is-generator-fn@1.0.0" = {
      pname = "is-generator-fn";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12ix9gla2lbjxshisf5mxha15r3wf0ssa5f9gh0nf5acqzpwn25f";
        url = "https://registry.npmjs.org/is-generator-fn/-/is-generator-fn-1.0.0.tgz";
      });
      pkgname = "is-generator-fn";
    };
    "is-glob@2.0.1" = {
      pname = "is-glob";
      version = "2.0.1";
      depKeys = [
        ("is-extglob@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bchcw1g5fdi2mrz362hjhlxvrbbg2ppyz7dcqkldpxjl5x2n777";
        url = "https://registry.npmjs.org/is-glob/-/is-glob-2.0.1.tgz";
      });
      pkgname = "is-glob";
    };
    "is-lambda@1.0.1" = {
      pname = "is-lambda";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0hfdf0cspr2gkqgdiry39ykddh62y6hglzsxsmq3q0y4kw7in54l";
        url = "https://registry.npmjs.org/is-lambda/-/is-lambda-1.0.1.tgz";
      });
      pkgname = "is-lambda";
    };
    "is-number@2.1.0" = {
      pname = "is-number";
      version = "2.1.0";
      depKeys = [
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "07v7lz3vb6iq9f36ksnbf60gy91dggaa32l0m8026zpa5ccrx8r2";
        url = "https://registry.npmjs.org/is-number/-/is-number-2.1.0.tgz";
      });
      pkgname = "is-number";
    };
    "is-number@3.0.0" = {
      pname = "is-number";
      version = "3.0.0";
      depKeys = [
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19rpbi5ryx3y28bh0pwm99az1mridh0p2sinfdxkcbpbxfx5zbf4";
        url = "https://registry.npmjs.org/is-number/-/is-number-3.0.0.tgz";
      });
      pkgname = "is-number";
    };
    "is-number@4.0.0" = {
      pname = "is-number";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1f47qljw0w6ajdkln18gxzv1qbhbxr88lrs6w485vk0g1b3wqnsy";
        url = "https://registry.npmjs.org/is-number/-/is-number-4.0.0.tgz";
      });
      pkgname = "is-number";
    };
    "is-path-cwd@1.0.0" = {
      pname = "is-path-cwd";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "09yay4h9max5mc90n5kbi6q9ws5hvm659v9i869s76d7hlvhqwl8";
        url = "https://registry.npmjs.org/is-path-cwd/-/is-path-cwd-1.0.0.tgz";
      });
      pkgname = "is-path-cwd";
    };
    "is-path-in-cwd@1.0.1" = {
      pname = "is-path-in-cwd";
      version = "1.0.1";
      depKeys = [
        ("is-path-inside@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qz2wx61jc8qkz5sra0i48ixi1a67wdmlrvscjxw4cc44qgvklx3";
        url = "https://registry.npmjs.org/is-path-in-cwd/-/is-path-in-cwd-1.0.1.tgz";
      });
      pkgname = "is-path-in-cwd";
    };
    "is-path-inside@1.0.1" = {
      pname = "is-path-inside";
      version = "1.0.1";
      depKeys = [
        ("path-is-inside@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xfv2zvarg6p72wwyxy3b8p6ymrnmww2kpmx4vgycrpawkc739qf";
        url = "https://registry.npmjs.org/is-path-inside/-/is-path-inside-1.0.1.tgz";
      });
      pkgname = "is-path-inside";
    };
    "is-plain-object@2.0.4" = {
      pname = "is-plain-object";
      version = "2.0.4";
      depKeys = [
        ("isobject@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ipx9y0c1kmq6irjxix6vcxfax6ilnns9pkgjc6cq8ygnyagv4s8";
        url = "https://registry.npmjs.org/is-plain-object/-/is-plain-object-2.0.4.tgz";
      });
      pkgname = "is-plain-object";
    };
    "is-posix-bracket@0.1.1" = {
      pname = "is-posix-bracket";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "01yzwk96c7zvc0zlh7wg200ajpk1av5aahcgc1avxizwp53m1343";
        url = "https://registry.npmjs.org/is-posix-bracket/-/is-posix-bracket-0.1.1.tgz";
      });
      pkgname = "is-posix-bracket";
    };
    "is-primitive@2.0.0" = {
      pname = "is-primitive";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1s57swffqif8vd6zkbw3d5lg25c9236r9m1s8c7c616dmx3c4bnd";
        url = "https://registry.npmjs.org/is-primitive/-/is-primitive-2.0.0.tgz";
      });
      pkgname = "is-primitive";
    };
    "is-regex@1.0.4" = {
      pname = "is-regex";
      version = "1.0.4";
      depKeys = [
        ("has@1.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mcc85v0wl8kiix3yhvy7rznkxgvbc50h0awccb2r6a7vz22x1ib";
        url = "https://registry.npmjs.org/is-regex/-/is-regex-1.0.4.tgz";
      });
      pkgname = "is-regex";
    };
    "is-stream@1.1.0" = {
      pname = "is-stream";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "07rq3hqj1fnr9r4j6kj2jaimspyxlq52q70ajx0kcs8nbv3k7n4x";
        url = "https://registry.npmjs.org/is-stream/-/is-stream-1.1.0.tgz";
      });
      pkgname = "is-stream";
    };
    "is-symbol@1.0.2" = {
      pname = "is-symbol";
      version = "1.0.2";
      depKeys = [
        ("has-symbols@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ccm9q02avvm7ip7b73nl647lb8rnlf2wa54r6134plnfm2wpn4c";
        url = "https://registry.npmjs.org/is-symbol/-/is-symbol-1.0.2.tgz";
      });
      pkgname = "is-symbol";
    };
    "is-typedarray@1.0.0" = {
      pname = "is-typedarray";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0i9qr2b79d0chhvpd1fc5pcp9bvirpg37f99d40alciqffmrfp0d";
        url = "https://registry.npmjs.org/is-typedarray/-/is-typedarray-1.0.0.tgz";
      });
      pkgname = "is-typedarray";
    };
    "is-utf8@0.2.1" = {
      pname = "is-utf8";
      version = "0.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x2nsr1lsh9yjavjvvkmrrzsabw5iz50bc9wcx26vzmfbks40aw4";
        url = "https://registry.npmjs.org/is-utf8/-/is-utf8-0.2.1.tgz";
      });
      pkgname = "is-utf8";
    };
    "is-windows@1.0.2" = {
      pname = "is-windows";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "18iihzz6fs6sfrgq1bpvgkfk3cza6r9wrrgn7ahcbbra1lkjh4bv";
        url = "https://registry.npmjs.org/is-windows/-/is-windows-1.0.2.tgz";
      });
      pkgname = "is-windows";
    };
    "is-wsl@1.1.0" = {
      pname = "is-wsl";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nvwkhv30y0dnp7889wmw1z8pvixh2h7bi60k00f7j25aza55vch";
        url = "https://registry.npmjs.org/is-wsl/-/is-wsl-1.1.0.tgz";
      });
      pkgname = "is-wsl";
    };
    "isarray@1.0.0" = {
      pname = "isarray";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "11qcjpdzigcwcprhv7nyarlzjcwf3sv5i66q75zf08jj9zqpcg72";
        url = "https://registry.npmjs.org/isarray/-/isarray-1.0.0.tgz";
      });
      pkgname = "isarray";
    };
    "isexe@2.0.0" = {
      pname = "isexe";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0nc3rcqjgyb9yyqajwlzzhfcqmsb682z7zinnx9qrql8w1rfiks7";
        url = "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz";
      });
      pkgname = "isexe";
    };
    "isobject@2.1.0" = {
      pname = "isobject";
      version = "2.1.0";
      depKeys = [
        ("isarray@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "14df1spjczhml90421sq645shkxwggrbbkgp1qgal29kslc7av32";
        url = "https://registry.npmjs.org/isobject/-/isobject-2.1.0.tgz";
      });
      pkgname = "isobject";
    };
    "isobject@3.0.1" = {
      pname = "isobject";
      version = "3.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0dvx6rhjj5b9q7fcjg24lfy2nr3a1d2ypqy9zf9lqr2s00mwkiiw";
        url = "https://registry.npmjs.org/isobject/-/isobject-3.0.1.tgz";
      });
      pkgname = "isobject";
    };
    "isstream@0.1.2" = {
      pname = "isstream";
      version = "0.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0i0br6synccpj2ian2z5fnnna99qq4w73dbp46vnyi53l9w47bkr";
        url = "https://registry.npmjs.org/isstream/-/isstream-0.1.2.tgz";
      });
      pkgname = "isstream";
    };
    "istanbul-api@1.3.7" = {
      pname = "istanbul-api";
      version = "1.3.7";
      depKeys = [
        ("async@2.6.3")
        ("fileset@2.0.3")
        ("istanbul-lib-coverage@1.2.1")
        ("istanbul-lib-hook@1.2.2")
        ("istanbul-lib-instrument@1.10.2")
        ("istanbul-lib-report@1.1.5")
        ("istanbul-lib-source-maps@1.2.6")
        ("istanbul-reports@1.5.1")
        ("js-yaml@3.13.1")
        ("mkdirp@0.5.1")
        ("once@1.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0d7sqsyzh8bwv35g0g76ap2x4yky381d8nw5zfxdfs0b6s1i3sm3";
        url = "https://registry.npmjs.org/istanbul-api/-/istanbul-api-1.3.7.tgz";
      });
      pkgname = "istanbul-api";
    };
    "istanbul-lib-coverage@1.2.1" = {
      pname = "istanbul-lib-coverage";
      version = "1.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "07rqff1f7r0dcifkgimyg6m05k40j2r9hl5dprbp3204w8hj1jb2";
        url = "https://registry.npmjs.org/istanbul-lib-coverage/-/istanbul-lib-coverage-1.2.1.tgz";
      });
      pkgname = "istanbul-lib-coverage";
    };
    "istanbul-lib-hook@1.2.2" = {
      pname = "istanbul-lib-hook";
      version = "1.2.2";
      depKeys = [
        ("append-transform@0.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1njn9ypz4abfphkwh7y1648ix0bvrxc6vq4rjpp7j0623gpfj2g9";
        url = "https://registry.npmjs.org/istanbul-lib-hook/-/istanbul-lib-hook-1.2.2.tgz";
      });
      pkgname = "istanbul-lib-hook";
    };
    "istanbul-lib-instrument@1.10.2" = {
      pname = "istanbul-lib-instrument";
      version = "1.10.2";
      depKeys = [
        ("babel-generator@6.26.1")
        ("babel-template@6.26.0")
        ("babel-traverse@6.26.0")
        ("babel-types@6.26.0")
        ("babylon@6.18.0")
        ("istanbul-lib-coverage@1.2.1")
        ("semver@5.7.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0nvmqfsw85ddrlmxs12px959wi9jhy4hyx02k54j4bjp61mpmm5z";
        url = "https://registry.npmjs.org/istanbul-lib-instrument/-/istanbul-lib-instrument-1.10.2.tgz";
      });
      pkgname = "istanbul-lib-instrument";
    };
    "istanbul-lib-report@1.1.5" = {
      pname = "istanbul-lib-report";
      version = "1.1.5";
      depKeys = [
        ("istanbul-lib-coverage@1.2.1")
        ("mkdirp@0.5.1")
        ("path-parse@1.0.6")
        ("supports-color@3.2.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x4bwhsbsga0jcsmwq1l7y2cr1cjgblqlfi1lr3qwsxgkpgp1dvl";
        url = "https://registry.npmjs.org/istanbul-lib-report/-/istanbul-lib-report-1.1.5.tgz";
      });
      pkgname = "istanbul-lib-report";
    };
    "istanbul-lib-source-maps@1.2.6" = {
      pname = "istanbul-lib-source-maps";
      version = "1.2.6";
      depKeys = [
        ("debug@3.2.6")
        ("istanbul-lib-coverage@1.2.1")
        ("mkdirp@0.5.1")
        ("rimraf@2.6.3")
        ("source-map@0.5.7")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1x6289qpp7x8a3g82b5kbirsbzmrqx6575lpkpbfwra0mvl7nyml";
        url = "https://registry.npmjs.org/istanbul-lib-source-maps/-/istanbul-lib-source-maps-1.2.6.tgz";
      });
      pkgname = "istanbul-lib-source-maps";
    };
    "istanbul-reports@1.5.1" = {
      pname = "istanbul-reports";
      version = "1.5.1";
      depKeys = [
        ("handlebars@4.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0r2lpgjm4r09r32f31j5bi36pmgy84rlz3la3bcjafsza5lb0p68";
        url = "https://registry.npmjs.org/istanbul-reports/-/istanbul-reports-1.5.1.tgz";
      });
      pkgname = "istanbul-reports";
    };
    "jest-changed-files@23.4.2" = {
      pname = "jest-changed-files";
      version = "23.4.2";
      depKeys = [
        ("throat@4.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0l6l4scbjpjhx5jycgvsc7jnsyrnhxb9d2bdn227pw2czgyqnnch";
        url = "https://registry.npmjs.org/jest-changed-files/-/jest-changed-files-23.4.2.tgz";
      });
      pkgname = "jest-changed-files";
    };
    "jest-cli@23.6.0" = {
      pname = "jest-cli";
      version = "23.6.0";
      depKeys = [
        ("ansi-escapes@3.2.0")
        ("chalk@2.4.2")
        ("exit@0.1.2")
        ("glob@7.1.4")
        ("graceful-fs@4.2.0")
        ("import-local@1.0.0")
        ("is-ci@1.2.1")
        ("istanbul-api@1.3.7")
        ("istanbul-lib-coverage@1.2.1")
        ("istanbul-lib-instrument@1.10.2")
        ("istanbul-lib-source-maps@1.2.6")
        ("jest-changed-files@23.4.2")
        ("jest-config@23.6.0")
        ("jest-environment-jsdom@23.4.0")
        ("jest-get-type@22.4.3")
        ("jest-haste-map@23.6.0")
        ("jest-message-util@23.4.0")
        ("jest-regex-util@23.3.0")
        ("jest-resolve-dependencies@23.6.0")
        ("jest-runner@23.6.0")
        ("jest-runtime@23.6.0")
        ("jest-snapshot@23.6.0")
        ("jest-util@23.4.0")
        ("jest-validate@23.6.0")
        ("jest-watcher@23.4.0")
        ("jest-worker@23.2.0")
        ("micromatch@2.3.11")
        ("node-notifier@5.4.0")
        ("prompts@0.1.14")
        ("realpath-native@1.1.0")
        ("rimraf@2.6.3")
        ("slash@1.0.0")
        ("string-length@2.0.0")
        ("strip-ansi@4.0.0")
        ("which@1.3.1")
        ("yargs@11.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "08fwn06c50lr2gs026xc3abnlz6fxzigvm8qxlgzfidiaw8h6mdq";
        url = "https://registry.npmjs.org/jest-cli/-/jest-cli-23.6.0.tgz";
      });
      pkgname = "jest-cli";
    };
    "jest-config@23.6.0" = {
      pname = "jest-config";
      version = "23.6.0";
      depKeys = [
        ("babel-core@6.26.3")
        ("babel-jest@23.6.0")
        ("chalk@2.4.2")
        ("glob@7.1.4")
        ("jest-environment-jsdom@23.4.0")
        ("jest-environment-node@23.4.0")
        ("jest-get-type@22.4.3")
        ("jest-jasmine2@23.6.0")
        ("jest-regex-util@23.3.0")
        ("jest-resolve@23.6.0")
        ("jest-util@23.4.0")
        ("jest-validate@23.6.0")
        ("micromatch@2.3.11")
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1439ncl5g1hfk2bs7ycqvsm393l4qzzrq82miyy3y1h0sj8zr3cw";
        url = "https://registry.npmjs.org/jest-config/-/jest-config-23.6.0.tgz";
      });
      pkgname = "jest-config";
    };
    "jest-diff@23.6.0" = {
      pname = "jest-diff";
      version = "23.6.0";
      depKeys = [
        ("chalk@2.4.2")
        ("diff@3.5.0")
        ("jest-get-type@22.4.3")
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "051yd1mmssgqdgz8j5birdyk58ql6iqvdsvdrda7375r0vawj278";
        url = "https://registry.npmjs.org/jest-diff/-/jest-diff-23.6.0.tgz";
      });
      pkgname = "jest-diff";
    };
    "jest-docblock@23.2.0" = {
      pname = "jest-docblock";
      version = "23.2.0";
      depKeys = [
        ("detect-newline@2.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1kgyxa77d5pwc9fc479khflxi3nj4d39b62bqnl0h95173pjrv39";
        url = "https://registry.npmjs.org/jest-docblock/-/jest-docblock-23.2.0.tgz";
      });
      pkgname = "jest-docblock";
    };
    "jest-each@23.6.0" = {
      pname = "jest-each";
      version = "23.6.0";
      depKeys = [
        ("chalk@2.4.2")
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "07z4wdviklm31j5f5ybh6yy2avfrzkf1f3j8wjq19424w3wg30gy";
        url = "https://registry.npmjs.org/jest-each/-/jest-each-23.6.0.tgz";
      });
      pkgname = "jest-each";
    };
    "jest-environment-jsdom@23.4.0" = {
      pname = "jest-environment-jsdom";
      version = "23.4.0";
      depKeys = [
        ("jest-mock@23.2.0")
        ("jest-util@23.4.0")
        ("jsdom@11.12.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dw725132y64pnf7vjhgnsz6f9i0hw8cdbrhbmd1rmqv30b9gfra";
        url = "https://registry.npmjs.org/jest-environment-jsdom/-/jest-environment-jsdom-23.4.0.tgz";
      });
      pkgname = "jest-environment-jsdom";
    };
    "jest-environment-node@23.4.0" = {
      pname = "jest-environment-node";
      version = "23.4.0";
      depKeys = [
        ("jest-mock@23.2.0")
        ("jest-util@23.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wi0xypz487cwv53j8w62drda8fhlx6znvkyjjc8lsly8pqsn5ad";
        url = "https://registry.npmjs.org/jest-environment-node/-/jest-environment-node-23.4.0.tgz";
      });
      pkgname = "jest-environment-node";
    };
    "jest-get-type@22.4.3" = {
      pname = "jest-get-type";
      version = "22.4.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "04sg5jvyb186kvz0np130gyla2sirjm9s315833g65kdfpbcawd1";
        url = "https://registry.npmjs.org/jest-get-type/-/jest-get-type-22.4.3.tgz";
      });
      pkgname = "jest-get-type";
    };
    "jest-haste-map@23.6.0" = {
      pname = "jest-haste-map";
      version = "23.6.0";
      depKeys = [
        ("fb-watchman@2.0.0")
        ("graceful-fs@4.2.0")
        ("invariant@2.2.4")
        ("jest-docblock@23.2.0")
        ("jest-serializer@23.0.1")
        ("jest-worker@23.2.0")
        ("micromatch@2.3.11")
        ("sane@2.5.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ljavpkp3x935xza4gn3slnw2bnilrag04rjq7l8fgryz7zbf6z7";
        url = "https://registry.npmjs.org/jest-haste-map/-/jest-haste-map-23.6.0.tgz";
      });
      pkgname = "jest-haste-map";
    };
    "jest-jasmine2@23.6.0" = {
      pname = "jest-jasmine2";
      version = "23.6.0";
      depKeys = [
        ("babel-traverse@6.26.0")
        ("chalk@2.4.2")
        ("co@4.6.0")
        ("expect@23.6.0")
        ("is-generator-fn@1.0.0")
        ("jest-diff@23.6.0")
        ("jest-each@23.6.0")
        ("jest-matcher-utils@23.6.0")
        ("jest-message-util@23.4.0")
        ("jest-snapshot@23.6.0")
        ("jest-util@23.4.0")
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "03nhwj8qypn2y9q91lrmnywrizjgd2jsybmvvnk727m09gilcbd2";
        url = "https://registry.npmjs.org/jest-jasmine2/-/jest-jasmine2-23.6.0.tgz";
      });
      pkgname = "jest-jasmine2";
    };
    "jest-junit@5.2.0" = {
      pname = "jest-junit";
      version = "5.2.0";
      depKeys = [
        ("jest-config@23.6.0")
        ("jest-validate@23.6.0")
        ("mkdirp@0.5.1")
        ("strip-ansi@4.0.0")
        ("xml@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kfjfnf5q2yz2s2l72dfk4qim6zbxar2l2388m8jmnk0pvwh6a2x";
        url = "https://registry.npmjs.org/jest-junit/-/jest-junit-5.2.0.tgz";
      });
      pkgname = "jest-junit";
    };
    "jest-leak-detector@23.6.0" = {
      pname = "jest-leak-detector";
      version = "23.6.0";
      depKeys = [
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1czfhipi0n7fqckpzscihxkwrh8flrcx1l7qln07aa5zjb6ijhj6";
        url = "https://registry.npmjs.org/jest-leak-detector/-/jest-leak-detector-23.6.0.tgz";
      });
      pkgname = "jest-leak-detector";
    };
    "jest-matcher-utils@23.6.0" = {
      pname = "jest-matcher-utils";
      version = "23.6.0";
      depKeys = [
        ("chalk@2.4.2")
        ("jest-get-type@22.4.3")
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1m6yq7b4xbyqrgm0462j8458d4j63764m1q2gvfwscq1y49zcr4n";
        url = "https://registry.npmjs.org/jest-matcher-utils/-/jest-matcher-utils-23.6.0.tgz";
      });
      pkgname = "jest-matcher-utils";
    };
    "jest-message-util@23.4.0" = {
      pname = "jest-message-util";
      version = "23.4.0";
      depKeys = [
        ("@babel/code-frame@7.5.5")
        ("chalk@2.4.2")
        ("micromatch@2.3.11")
        ("slash@1.0.0")
        ("stack-utils@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "079iadbbpnm7d0s0cxmkpps62lb9a5j120srm48cfngg8gcdim57";
        url = "https://registry.npmjs.org/jest-message-util/-/jest-message-util-23.4.0.tgz";
      });
      pkgname = "jest-message-util";
    };
    "jest-mock@23.2.0" = {
      pname = "jest-mock";
      version = "23.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x5q8xnd0fx3g9yskvpsw9lr9a5mz35c6ncmvb0v4jjcqjqbjd2z";
        url = "https://registry.npmjs.org/jest-mock/-/jest-mock-23.2.0.tgz";
      });
      pkgname = "jest-mock";
    };
    "jest-pnp-resolver@1.2.1" = {
      pname = "jest-pnp-resolver";
      version = "1.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "057p2shfd1i6nyabmsakgkkf867z9l26j99ylksp60i9cm1lwr5z";
        url = "https://registry.npmjs.org/jest-pnp-resolver/-/jest-pnp-resolver-1.2.1.tgz";
      });
      pkgname = "jest-pnp-resolver";
    };
    "jest-regex-util@23.3.0" = {
      pname = "jest-regex-util";
      version = "23.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12v7wa9jifnm1yrrzjf0s48n6d6mhslj90xh5x82bz6qd8jycmda";
        url = "https://registry.npmjs.org/jest-regex-util/-/jest-regex-util-23.3.0.tgz";
      });
      pkgname = "jest-regex-util";
    };
    "jest-resolve-dependencies@23.6.0" = {
      pname = "jest-resolve-dependencies";
      version = "23.6.0";
      depKeys = [
        ("jest-regex-util@23.3.0")
        ("jest-snapshot@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0hqvni005ra9k7kagp01nf11773pnnbhx0c00nbpyp9w15qkgmmy";
        url = "https://registry.npmjs.org/jest-resolve-dependencies/-/jest-resolve-dependencies-23.6.0.tgz";
      });
      pkgname = "jest-resolve-dependencies";
    };
    "jest-resolve@23.6.0" = {
      pname = "jest-resolve";
      version = "23.6.0";
      depKeys = [
        ("browser-resolve@1.11.3")
        ("chalk@2.4.2")
        ("realpath-native@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "166vhpki0fm3amvjbfi09g5y8g3qy656rzivrxgnvma7vqa59dci";
        url = "https://registry.npmjs.org/jest-resolve/-/jest-resolve-23.6.0.tgz";
      });
      pkgname = "jest-resolve";
    };
    "jest-runner@23.6.0" = {
      pname = "jest-runner";
      version = "23.6.0";
      depKeys = [
        ("exit@0.1.2")
        ("graceful-fs@4.2.0")
        ("jest-config@23.6.0")
        ("jest-docblock@23.2.0")
        ("jest-haste-map@23.6.0")
        ("jest-jasmine2@23.6.0")
        ("jest-leak-detector@23.6.0")
        ("jest-message-util@23.4.0")
        ("jest-runtime@23.6.0")
        ("jest-util@23.4.0")
        ("jest-worker@23.2.0")
        ("source-map-support@0.5.12")
        ("throat@4.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "18q36n3ksb3s7lm9q2nn33c2x70g6dh7a2ccd83mwkzllyrglprs";
        url = "https://registry.npmjs.org/jest-runner/-/jest-runner-23.6.0.tgz";
      });
      pkgname = "jest-runner";
    };
    "jest-runtime@23.6.0" = {
      pname = "jest-runtime";
      version = "23.6.0";
      depKeys = [
        ("babel-core@6.26.3")
        ("babel-plugin-istanbul@4.1.6")
        ("chalk@2.4.2")
        ("convert-source-map@1.6.0")
        ("exit@0.1.2")
        ("fast-json-stable-stringify@2.0.0")
        ("graceful-fs@4.2.0")
        ("jest-config@23.6.0")
        ("jest-haste-map@23.6.0")
        ("jest-message-util@23.4.0")
        ("jest-regex-util@23.3.0")
        ("jest-resolve@23.6.0")
        ("jest-snapshot@23.6.0")
        ("jest-util@23.4.0")
        ("jest-validate@23.6.0")
        ("micromatch@2.3.11")
        ("realpath-native@1.1.0")
        ("slash@1.0.0")
        ("strip-bom@3.0.0")
        ("write-file-atomic@2.4.3")
        ("yargs@11.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0aki0i1dngsgmq2ia86dk0c4lj6m82b42v37mmc7qwj1vnss6ppv";
        url = "https://registry.npmjs.org/jest-runtime/-/jest-runtime-23.6.0.tgz";
      });
      pkgname = "jest-runtime";
    };
    "jest-serializer@23.0.1" = {
      pname = "jest-serializer";
      version = "23.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0nfxi980bdm9gisb8zm77c810h939xiakgz15gin5dl4hwfw5b8a";
        url = "https://registry.npmjs.org/jest-serializer/-/jest-serializer-23.0.1.tgz";
      });
      pkgname = "jest-serializer";
    };
    "jest-snapshot@23.6.0" = {
      pname = "jest-snapshot";
      version = "23.6.0";
      depKeys = [
        ("babel-types@6.26.0")
        ("chalk@2.4.2")
        ("jest-diff@23.6.0")
        ("jest-matcher-utils@23.6.0")
        ("jest-message-util@23.4.0")
        ("jest-resolve@23.6.0")
        ("mkdirp@0.5.1")
        ("natural-compare@1.4.0")
        ("pretty-format@23.6.0")
        ("semver@5.7.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "064cczijlwr4351m69jcligig0h77r173h7p1g973mlzafspkpim";
        url = "https://registry.npmjs.org/jest-snapshot/-/jest-snapshot-23.6.0.tgz";
      });
      pkgname = "jest-snapshot";
    };
    "jest-util@23.4.0" = {
      pname = "jest-util";
      version = "23.4.0";
      depKeys = [
        ("callsites@2.0.0")
        ("chalk@2.4.2")
        ("graceful-fs@4.2.0")
        ("is-ci@1.2.1")
        ("jest-message-util@23.4.0")
        ("mkdirp@0.5.1")
        ("slash@1.0.0")
        ("source-map@0.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "01sd8wqz1npf23jr9nxfw9p0phm7klwf1kyfyq0syq9ssna6s474";
        url = "https://registry.npmjs.org/jest-util/-/jest-util-23.4.0.tgz";
      });
      pkgname = "jest-util";
    };
    "jest-validate@23.6.0" = {
      pname = "jest-validate";
      version = "23.6.0";
      depKeys = [
        ("chalk@2.4.2")
        ("jest-get-type@22.4.3")
        ("leven@2.1.0")
        ("pretty-format@23.6.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19jggm8zll7qvzhkblgzkhp1vc2m4rp1s3j0b2v1vs5zfpq81rhm";
        url = "https://registry.npmjs.org/jest-validate/-/jest-validate-23.6.0.tgz";
      });
      pkgname = "jest-validate";
    };
    "jest-watcher@23.4.0" = {
      pname = "jest-watcher";
      version = "23.4.0";
      depKeys = [
        ("ansi-escapes@3.2.0")
        ("chalk@2.4.2")
        ("string-length@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lv5vc0bjycykf5p3ag1vw8gfwbv8mhx5g08lhbipdycxczlimrv";
        url = "https://registry.npmjs.org/jest-watcher/-/jest-watcher-23.4.0.tgz";
      });
      pkgname = "jest-watcher";
    };
    "jest-worker@23.2.0" = {
      pname = "jest-worker";
      version = "23.2.0";
      depKeys = [
        ("merge-stream@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wwpdm5bj96rr9h9wmm8fj4hchy2jgr8h5dzr882x78hk144vddi";
        url = "https://registry.npmjs.org/jest-worker/-/jest-worker-23.2.0.tgz";
      });
      pkgname = "jest-worker";
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
    "js-yaml@3.13.1" = {
      pname = "js-yaml";
      version = "3.13.1";
      depKeys = [
        ("argparse@1.0.10")
        ("esprima@4.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0hdr4jpjcj4zmdq1v8dc6cp0ljwm6imfay3mys8qwdyxkcqk4bk6";
        url = "https://registry.npmjs.org/js-yaml/-/js-yaml-3.13.1.tgz";
      });
      pkgname = "js-yaml";
    };
    "jsbn@0.1.1" = {
      pname = "jsbn";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "08r3wxx18yixax4w9rs18ya1ggw6kgzjhw5vbsj7sb8a974lpi2s";
        url = "https://registry.npmjs.org/jsbn/-/jsbn-0.1.1.tgz";
      });
      pkgname = "jsbn";
    };
    "jsdom@11.12.0" = {
      pname = "jsdom";
      version = "11.12.0";
      depKeys = [
        ("abab@2.0.0")
        ("acorn@5.7.3")
        ("acorn-globals@4.3.2")
        ("array-equal@1.0.0")
        ("cssom@0.3.8")
        ("cssstyle@1.4.0")
        ("data-urls@1.1.0")
        ("domexception@1.0.1")
        ("escodegen@1.11.1")
        ("html-encoding-sniffer@1.0.2")
        ("left-pad@1.3.0")
        ("nwsapi@2.1.4")
        ("parse5@4.0.0")
        ("pn@1.1.0")
        ("request@2.88.0")
        ("request-promise-native@1.0.7")
        ("sax@1.2.4")
        ("symbol-tree@3.2.4")
        ("tough-cookie@2.5.0")
        ("w3c-hr-time@1.0.1")
        ("webidl-conversions@4.0.2")
        ("whatwg-encoding@1.0.5")
        ("whatwg-mimetype@2.3.0")
        ("whatwg-url@6.5.0")
        ("ws@5.2.2")
        ("xml-name-validator@3.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qnj9dh7xgmqs04nmz85gid55fx6pcwi0nkk8qv24s28j2zcfzxz";
        url = "https://registry.npmjs.org/jsdom/-/jsdom-11.12.0.tgz";
      });
      pkgname = "jsdom";
    };
    "jsesc@0.5.0" = {
      pname = "jsesc";
      version = "0.5.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x365wjgs65s1xa7zad9rbg5izayxbh2mfgsjgqm7zl0gi3116iy";
        url = "https://registry.npmjs.org/jsesc/-/jsesc-0.5.0.tgz";
      });
      pkgname = "jsesc";
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
    "json-schema-traverse@0.4.1" = {
      pname = "json-schema-traverse";
      version = "0.4.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0rf0pvm62k8g81vs7n7zx080p6sfylwk52vc149jx1216vcssdgp";
        url = "https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz";
      });
      pkgname = "json-schema-traverse";
    };
    "json-schema@0.2.3" = {
      pname = "json-schema";
      version = "0.2.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0gwkxqmwlwb5nffgxsjf1rcd1lv21br555mxr5mcnc60zd9kq5p3";
        url = "https://registry.npmjs.org/json-schema/-/json-schema-0.2.3.tgz";
      });
      pkgname = "json-schema";
    };
    "json-stringify-safe@5.0.1" = {
      pname = "json-stringify-safe";
      version = "5.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12ljc7ipy7cprz5zxzzds20ykw6z5616763ca5zx9xmzq1jvzyxp";
        url = "https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz";
      });
      pkgname = "json-stringify-safe";
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
    "jsonfile@4.0.0" = {
      pname = "jsonfile";
      version = "4.0.0";
      depKeys = [
        ("graceful-fs@4.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1s701cy3mlbvgyhhyy2ypqcy064w5990sk8x81gv0200yybrbfaz";
        url = "https://registry.npmjs.org/jsonfile/-/jsonfile-4.0.0.tgz";
      });
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
      src = (pkgs.fetchurl {
        sha256 = "0ipc481jham9q4ayfl335zjdfmnxc1wcixx5qibfwl2ncz60gwqx";
        url = "https://registry.npmjs.org/jsprim/-/jsprim-1.4.1.tgz";
      });
      pkgname = "jsprim";
    };
    "kind-of@3.2.2" = {
      pname = "kind-of";
      version = "3.2.2";
      depKeys = [
        ("is-buffer@1.1.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0isxns331nf5f4h8yj0vb4rj626bscxh1rh7j92vk8lbzcs2x93q";
        url = "https://registry.npmjs.org/kind-of/-/kind-of-3.2.2.tgz";
      });
      pkgname = "kind-of";
    };
    "kind-of@4.0.0" = {
      pname = "kind-of";
      version = "4.0.0";
      depKeys = [
        ("is-buffer@1.1.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0afwg6007r7l0c9r7jghdk8pwvfffmykhybpwrs0nlks59d2ziym";
        url = "https://registry.npmjs.org/kind-of/-/kind-of-4.0.0.tgz";
      });
      pkgname = "kind-of";
    };
    "kind-of@5.1.0" = {
      pname = "kind-of";
      version = "5.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wkp161zwgg2jp5rjnkw7d7lgczbxj6bwvqvh4s8j68ghk0c8q2d";
        url = "https://registry.npmjs.org/kind-of/-/kind-of-5.1.0.tgz";
      });
      pkgname = "kind-of";
    };
    "kind-of@6.0.2" = {
      pname = "kind-of";
      version = "6.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "143y1awpq5s0nsrpmj78x58s256x1r8kdryss01rdyibm0p5fi5q";
        url = "https://registry.npmjs.org/kind-of/-/kind-of-6.0.2.tgz";
      });
      pkgname = "kind-of";
    };
    "klaw@2.1.1" = {
      pname = "klaw";
      version = "2.1.1";
      depKeys = [
        ("graceful-fs@4.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "02d5qza0i7szkic29rq4px6gh92cx4ifbh2bfhsjxqllfqqcpb4h";
        url = "https://registry.npmjs.org/klaw/-/klaw-2.1.1.tgz";
      });
      pkgname = "klaw";
    };
    "kleur@2.0.2" = {
      pname = "kleur";
      version = "2.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kxd7yry861gp5b3bjrly655rc9g3pxc3ah21xw0gb2v4lbabkir";
        url = "https://registry.npmjs.org/kleur/-/kleur-2.0.2.tgz";
      });
      pkgname = "kleur";
    };
    "lcid@1.0.0" = {
      pname = "lcid";
      version = "1.0.0";
      depKeys = [
        ("invert-kv@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0hscsbr9zk4hs9vpi3ryib1ynbdvfmaswgy150lq42m4m80dcjac";
        url = "https://registry.npmjs.org/lcid/-/lcid-1.0.0.tgz";
      });
      pkgname = "lcid";
    };
    "left-pad@1.3.0" = {
      pname = "left-pad";
      version = "1.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1pc1siibc9nw5xxqgrmqmpya47k5gs5d0cl89y6sa8v217hhy347";
        url = "https://registry.npmjs.org/left-pad/-/left-pad-1.3.0.tgz";
      });
      pkgname = "left-pad";
    };
    "leven@2.1.0" = {
      pname = "leven";
      version = "2.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ivyhqz9xpw7bhc8s9pyz0i8pg5mjakb359npz77k8krvm11sbn5";
        url = "https://registry.npmjs.org/leven/-/leven-2.1.0.tgz";
      });
      pkgname = "leven";
    };
    "levn@0.3.0" = {
      pname = "levn";
      version = "0.3.0";
      depKeys = [
        ("prelude-ls@1.1.2")
        ("type-check@0.3.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "094nf5lc3jk3gv0hs01nzgq2vw0h2y9cxaqsbgs0xc45in2kw0ds";
        url = "https://registry.npmjs.org/levn/-/levn-0.3.0.tgz";
      });
      pkgname = "levn";
    };
    "load-json-file@1.1.0" = {
      pname = "load-json-file";
      version = "1.1.0";
      depKeys = [
        ("graceful-fs@4.2.0")
        ("parse-json@2.2.0")
        ("pify@2.3.0")
        ("pinkie-promise@2.0.1")
        ("strip-bom@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0zjx2iyr8bxvgfapx6cvr6ddn3mmqgi0qfcrs3pzcl4qlv0xky7d";
        url = "https://registry.npmjs.org/load-json-file/-/load-json-file-1.1.0.tgz";
      });
      pkgname = "load-json-file";
    };
    "locate-path@2.0.0" = {
      pname = "locate-path";
      version = "2.0.0";
      depKeys = [
        ("p-locate@2.0.0")
        ("path-exists@3.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1hkjzakjwk6lix7yr73yx65hhlpf45rc8i2mj2c70fiab3zhzaxi";
        url = "https://registry.npmjs.org/locate-path/-/locate-path-2.0.0.tgz";
      });
      pkgname = "locate-path";
    };
    "lodash.sortby@4.7.0" = {
      pname = "lodash.sortby";
      version = "4.7.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0jjm2g5q17j1wrjxdci7vv1frm5vigmxgkm5a91p98qlbpzdd71j";
        url = "https://registry.npmjs.org/lodash.sortby/-/lodash.sortby-4.7.0.tgz";
      });
      pkgname = "lodash.sortby";
    };
    "lodash@4.17.15" = {
      pname = "lodash";
      version = "4.17.15";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "03fcxzmmqgsbdk6s45fwx69a6b6a2xhpr7pp5npwlb9j1gkjy72l";
        url = "https://registry.npmjs.org/lodash/-/lodash-4.17.15.tgz";
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
    "lru-cache@4.1.5" = {
      pname = "lru-cache";
      version = "4.1.5";
      depKeys = [
        ("pseudomap@1.0.2")
        ("yallist@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1fdbhyf0d7pxg06qkzav7sz1mayvzbq31bxcshnfcyhihpd3bzf9";
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-4.1.5.tgz";
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
        sha256 = "0pnziizgv8jpg708ykywcjby0syjz1l2ll1j727rdxhw0gmhvr2w";
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
        ("minipass@3.1.5")
        ("minipass-collect@1.0.2")
        ("minipass-fetch@1.4.1")
        ("minipass-flush@1.0.5")
        ("minipass-pipeline@1.2.4")
        ("negotiator@0.6.2")
        ("promise-retry@2.0.1")
        ("socks-proxy-agent@6.1.0")
        ("ssri@8.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0yzhwfhqm2bafsxmm931i3fc7kbg483zf0c05gnzjd65xbvr0x0x";
        url = "https://registry.npmjs.org/make-fetch-happen/-/make-fetch-happen-9.1.0.tgz";
      });
      pkgname = "make-fetch-happen";
    };
    "makeerror@1.0.11" = {
      pname = "makeerror";
      version = "1.0.11";
      depKeys = [
        ("tmpl@1.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mcffrm6gifv3jar1giwqjrxqypsp44hf9cskasmnblzikl38psf";
        url = "https://registry.npmjs.org/makeerror/-/makeerror-1.0.11.tgz";
      });
      pkgname = "makeerror";
    };
    "map-cache@0.2.2" = {
      pname = "map-cache";
      version = "0.2.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0gag01y8x17l2ffdmi5rgll24bw4cmyi3wksk45xpghirlkrkhj1";
        url = "https://registry.npmjs.org/map-cache/-/map-cache-0.2.2.tgz";
      });
      pkgname = "map-cache";
    };
    "map-visit@1.0.0" = {
      pname = "map-visit";
      version = "1.0.0";
      depKeys = [
        ("object-visit@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19fhyr0jmskx32s1s9b6p0jb96gmbxxnbmzx4sc42sxzwkfmqvpi";
        url = "https://registry.npmjs.org/map-visit/-/map-visit-1.0.0.tgz";
      });
      pkgname = "map-visit";
    };
    "math-random@1.0.4" = {
      pname = "math-random";
      version = "1.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0882pbcf4m1irc214h2ddi3faspwah70813ryvxl14h3ar0jnqjx";
        url = "https://registry.npmjs.org/math-random/-/math-random-1.0.4.tgz";
      });
      pkgname = "math-random";
    };
    "mem@1.1.0" = {
      pname = "mem";
      version = "1.1.0";
      depKeys = [
        ("mimic-fn@1.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "14ipxankn62q7bikdrp964f91cpidcyh2xaxwdpzhcg7vq2ixw94";
        url = "https://registry.npmjs.org/mem/-/mem-1.1.0.tgz";
      });
      pkgname = "mem";
    };
    "merge-stream@1.0.1" = {
      pname = "merge-stream";
      version = "1.0.1";
      depKeys = [
        ("readable-stream@2.3.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0snv60l3jng5f7fjj89gwss8qi78iaxkhmnqq7wq4z0i0h4d6fdv";
        url = "https://registry.npmjs.org/merge-stream/-/merge-stream-1.0.1.tgz";
      });
      pkgname = "merge-stream";
    };
    "merge@1.2.1" = {
      pname = "merge";
      version = "1.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jkairlra9950qzmfiglyagxahccd9an27i2gjlkp6say0s04m5x";
        url = "https://registry.npmjs.org/merge/-/merge-1.2.1.tgz";
      });
      pkgname = "merge";
    };
    "micromatch@2.3.11" = {
      pname = "micromatch";
      version = "2.3.11";
      depKeys = [
        ("arr-diff@2.0.0")
        ("array-unique@0.2.1")
        ("braces@1.8.5")
        ("expand-brackets@0.1.5")
        ("extglob@0.3.2")
        ("filename-regex@2.0.1")
        ("is-extglob@1.0.0")
        ("is-glob@2.0.1")
        ("kind-of@3.2.2")
        ("normalize-path@2.1.1")
        ("object.omit@2.0.1")
        ("parse-glob@3.0.4")
        ("regex-cache@0.4.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1gz4w1hn7sh17wv82j53d97pr5fli3747sv28fb00r7ghbn5zxla";
        url = "https://registry.npmjs.org/micromatch/-/micromatch-2.3.11.tgz";
      });
      pkgname = "micromatch";
    };
    "micromatch@3.1.10" = {
      pname = "micromatch";
      version = "3.1.10";
      depKeys = [
        ("arr-diff@4.0.0")
        ("array-unique@0.3.2")
        ("braces@2.3.2")
        ("define-property@2.0.2")
        ("extend-shallow@3.0.2")
        ("extglob@2.0.4")
        ("fragment-cache@0.2.1")
        ("kind-of@6.0.2")
        ("nanomatch@1.2.13")
        ("object.pick@1.3.0")
        ("regex-not@1.0.2")
        ("snapdragon@0.8.2")
        ("to-regex@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j4m1y8x2sib8i5rfilml7yzpgs5njsg2nxzxwlb63997qlpb7p5";
        url = "https://registry.npmjs.org/micromatch/-/micromatch-3.1.10.tgz";
      });
      pkgname = "micromatch";
    };
    "mime-db@1.40.0" = {
      pname = "mime-db";
      version = "1.40.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ki5v1b41dfb171bdcs8i469aycfg2b4i6raig8vk64wyp19bif5";
        url = "https://registry.npmjs.org/mime-db/-/mime-db-1.40.0.tgz";
      });
      pkgname = "mime-db";
    };
    "mime-types@2.1.24" = {
      pname = "mime-types";
      version = "2.1.24";
      depKeys = [
        ("mime-db@1.40.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1n7fsi13xp213dxdcs0qfyk596nbsaklbfxnd4xjnhnf65abcsy1";
        url = "https://registry.npmjs.org/mime-types/-/mime-types-2.1.24.tgz";
      });
      pkgname = "mime-types";
    };
    "mimic-fn@1.2.0" = {
      pname = "mimic-fn";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0fkbqr66pl1vzbqph4m8qc0ss1wr7hhnxymdhj32klsxlvbiz4xi";
        url = "https://registry.npmjs.org/mimic-fn/-/mimic-fn-1.2.0.tgz";
      });
      pkgname = "mimic-fn";
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
    "minimist@0.0.10" = {
      pname = "minimist";
      version = "0.0.10";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xnbzwsqm66i3ns2fpjml0ky96f79z6sm47sckl3wkx6zgjkxq3k";
        url = "https://registry.npmjs.org/minimist/-/minimist-0.0.10.tgz";
      });
      pkgname = "minimist";
    };
    "minimist@0.0.8" = {
      pname = "minimist";
      version = "0.0.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0csa8y60rwkyf641ry8y4qzf0ayachvnk98zkkszl8dr12iaylvr";
        url = "https://registry.npmjs.org/minimist/-/minimist-0.0.8.tgz";
      });
      pkgname = "minimist";
    };
    "minimist@1.2.0" = {
      pname = "minimist";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0w7jll4vlqphxgk9qjbdjh3ni18lkrlfaqgsm7p14xl3f7ghn3gc";
        url = "https://registry.npmjs.org/minimist/-/minimist-1.2.0.tgz";
      });
      pkgname = "minimist";
    };
    "minipass-collect@1.0.2" = {
      pname = "minipass-collect";
      version = "1.0.2";
      depKeys = [
        ("minipass@3.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1m50q2isnw0xr4hyb3v38pxrgzl0zsy4lj3nldydcyx2l1d6bbx5";
        url = "https://registry.npmjs.org/minipass-collect/-/minipass-collect-1.0.2.tgz";
      });
      pkgname = "minipass-collect";
    };
    "minipass-fetch@1.4.1" = {
      pname = "minipass-fetch";
      version = "1.4.1";
      depKeys = [
        ("encoding@0.1.13")
        ("minipass@3.1.5")
        ("minipass-sized@1.0.3")
        ("minizlib@2.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0w83xvxxl05y3s5va71q808hbrl4mgvmb8yms4zk7ibf0ybdv88r";
        url = "https://registry.npmjs.org/minipass-fetch/-/minipass-fetch-1.4.1.tgz";
      });
      pkgname = "minipass-fetch";
    };
    "minipass-flush@1.0.5" = {
      pname = "minipass-flush";
      version = "1.0.5";
      depKeys = [
        ("minipass@3.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1rh40nh1wan1h01iszhi6bpjd7vr4b4phi9d39krqlzvym689psj";
        url = "https://registry.npmjs.org/minipass-flush/-/minipass-flush-1.0.5.tgz";
      });
      pkgname = "minipass-flush";
    };
    "minipass-pipeline@1.2.4" = {
      pname = "minipass-pipeline";
      version = "1.2.4";
      depKeys = [
        ("minipass@3.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "13q7asqh62g3cdypm8rgvyq72crns331a9hqg6w92qzx68wg4r0b";
        url = "https://registry.npmjs.org/minipass-pipeline/-/minipass-pipeline-1.2.4.tgz";
      });
      pkgname = "minipass-pipeline";
    };
    "minipass-sized@1.0.3" = {
      pname = "minipass-sized";
      version = "1.0.3";
      depKeys = [
        ("minipass@3.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1d9h3h6pnyr09381zyax0jr0k0wmx75qrfqdzbirrmhmcp5xiqjw";
        url = "https://registry.npmjs.org/minipass-sized/-/minipass-sized-1.0.3.tgz";
      });
      pkgname = "minipass-sized";
    };
    "minipass@2.3.5" = {
      pname = "minipass";
      version = "2.3.5";
      depKeys = [
        ("safe-buffer@5.2.0")
        ("yallist@3.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1rrmpymb9569i78w3pq50mis8fvsc56xmrxqs77rl0w7bbgzhh66";
        url = "https://registry.npmjs.org/minipass/-/minipass-2.3.5.tgz";
      });
      pkgname = "minipass";
    };
    "minipass@3.1.5" = {
      pname = "minipass";
      version = "3.1.5";
      depKeys = [
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0050rbjr8vb8cjpzprkrr8j86rwz1qvw3w7npz2pc9wkcv6cxn0b";
        url = "https://registry.npmjs.org/minipass/-/minipass-3.1.5.tgz";
      });
      pkgname = "minipass";
    };
    "minizlib@1.2.1" = {
      pname = "minizlib";
      version = "1.2.1";
      depKeys = [
        ("minipass@2.3.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "08cqq424fjnaz4y7lhcsjhhfwaxvsrxwds4ngavc7qgjh2faw4lc";
        url = "https://registry.npmjs.org/minizlib/-/minizlib-1.2.1.tgz";
      });
      pkgname = "minizlib";
    };
    "minizlib@2.1.2" = {
      pname = "minizlib";
      version = "2.1.2";
      depKeys = [
        ("minipass@3.1.5")
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vffn3i5ys3w74s8m8n4l7vvzijddi44flpaxdfv96q85n513va4";
        url = "https://registry.npmjs.org/minizlib/-/minizlib-2.1.2.tgz";
      });
      pkgname = "minizlib";
    };
    "mixin-deep@1.3.2" = {
      pname = "mixin-deep";
      version = "1.3.2";
      depKeys = [
        ("for-in@1.0.2")
        ("is-extendable@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kdw3h2r5cpfazjdfjzh9yac7c2gb1vrl3nxm0bhl7pb3yh276iq";
        url = "https://registry.npmjs.org/mixin-deep/-/mixin-deep-1.3.2.tgz";
      });
      pkgname = "mixin-deep";
    };
    "mkdirp@0.5.1" = {
      pname = "mkdirp";
      version = "0.5.1";
      depKeys = [
        ("minimist@0.0.8")
      ];
      src = (pkgs.fetchurl {
        sha256 = "095z70b1y5dsadjf7apkwkmnvnnk6jxavkdgwzhnip6yx1q2idbp";
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.1.tgz";
      });
      pkgname = "mkdirp";
    };
    "mkdirp@1.0.4" = {
      pname = "mkdirp";
      version = "1.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "06nqac14zbpar89jc7s574l1qpmamr1kzy0dr3qyhvxg8570f5qx";
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-1.0.4.tgz";
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
    "ms@2.1.2" = {
      pname = "ms";
      version = "2.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0j7vrqxzg2fxip3q0cws360wk3cz2nprr8zkragipziz1piscmqi";
        url = "https://registry.npmjs.org/ms/-/ms-2.1.2.tgz";
      });
      pkgname = "ms";
    };
    "ms@2.1.3" = {
      pname = "ms";
      version = "2.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ii24v83yrryzmj9p369qxmpr53337kkqbdaklpmbv9hwlanwqgn";
        url = "https://registry.npmjs.org/ms/-/ms-2.1.3.tgz";
      });
      pkgname = "ms";
    };
    "nan@2.14.0" = {
      pname = "nan";
      version = "2.14.0";
      depKeys = [
        ("node-gyp@8.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "182g2dwdclgz981bmdff8967nsfakz9ldv4dlkcakryrqm1zna0f";
        url = "https://registry.npmjs.org/nan/-/nan-2.14.0.tgz";
      });
      pkgname = "nan";
    };
    "nanomatch@1.2.13" = {
      pname = "nanomatch";
      version = "1.2.13";
      depKeys = [
        ("arr-diff@4.0.0")
        ("array-unique@0.3.2")
        ("define-property@2.0.2")
        ("extend-shallow@3.0.2")
        ("fragment-cache@0.2.1")
        ("is-windows@1.0.2")
        ("kind-of@6.0.2")
        ("object.pick@1.3.0")
        ("regex-not@1.0.2")
        ("snapdragon@0.8.2")
        ("to-regex@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1f4fxk7azvglyi6gfbkxmh91pd3n6i7av03y9bpizfn37xjf7g0z";
        url = "https://registry.npmjs.org/nanomatch/-/nanomatch-1.2.13.tgz";
      });
      pkgname = "nanomatch";
    };
    "natural-compare@1.4.0" = {
      pname = "natural-compare";
      version = "1.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vkrwxgc7w81923739lrnqklmpnin52qmhd868vgfr10s7n6jmay";
        url = "https://registry.npmjs.org/natural-compare/-/natural-compare-1.4.0.tgz";
      });
      pkgname = "natural-compare";
    };
    "needle@2.4.0" = {
      pname = "needle";
      version = "2.4.0";
      depKeys = [
        ("debug@3.2.6")
        ("iconv-lite@0.4.24")
        ("sax@1.2.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0sn5q5fnpb71a22imfbgz2hwgfcqcjlgn1gmv4hq3ba0qnm9yjsv";
        url = "https://registry.npmjs.org/needle/-/needle-2.4.0.tgz";
      });
      pkgname = "needle";
    };
    "negotiator@0.6.2" = {
      pname = "negotiator";
      version = "0.6.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1zpx97aamn044id45ljzalxpa9l1dm0gn260w5hwjg7998vxjz68";
        url = "https://registry.npmjs.org/negotiator/-/negotiator-0.6.2.tgz";
      });
      pkgname = "negotiator";
    };
    "neo-async@2.6.1" = {
      pname = "neo-async";
      version = "2.6.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "18iararb5vcfgrxpjw4p3dnslk7g1mjxnmdh8yfj6v9ykm3kf37a";
        url = "https://registry.npmjs.org/neo-async/-/neo-async-2.6.1.tgz";
      });
      pkgname = "neo-async";
    };
    "node-gyp@8.4.0" = {
      pname = "node-gyp";
      version = "8.4.0";
      depKeys = [
        ("env-paths@2.2.1")
        ("glob@7.2.0")
        ("graceful-fs@4.2.8")
        ("make-fetch-happen@9.1.0")
        ("nopt@5.0.0")
        ("npmlog@4.1.2")
        ("rimraf@3.0.2")
        ("semver@7.3.5")
        ("tar@6.1.11")
        ("which@2.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0v8kysxmmm3hw8xgydlw2z6vw0m4k5vfh7gi6fbdpq9spm27d9gh";
        url = "https://registry.npmjs.org/node-gyp/-/node-gyp-8.4.0.tgz";
      });
      pkgname = "node-gyp";
    };
    "node-int64@0.4.0" = {
      pname = "node-int64";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0mr21y67mxrzp7ps8w52q8sjp0f4ags8z97f5ig995f86y4n40i5";
        url = "https://registry.npmjs.org/node-int64/-/node-int64-0.4.0.tgz";
      });
      pkgname = "node-int64";
    };
    "node-notifier@5.4.0" = {
      pname = "node-notifier";
      version = "5.4.0";
      depKeys = [
        ("growly@1.3.0")
        ("is-wsl@1.1.0")
        ("semver@5.7.0")
        ("shellwords@0.1.1")
        ("which@1.3.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0313v4d633nnracb60mzlxkndi2ppghjcyc7fwbb2drqqjlhsn5b";
        url = "https://registry.npmjs.org/node-notifier/-/node-notifier-5.4.0.tgz";
      });
      pkgname = "node-notifier";
    };
    "node-pre-gyp@0.12.0" = {
      pname = "node-pre-gyp";
      version = "0.12.0";
      depKeys = [
        ("detect-libc@1.0.3")
        ("mkdirp@0.5.1")
        ("needle@2.4.0")
        ("nopt@4.0.1")
        ("npm-packlist@1.4.4")
        ("npmlog@4.1.2")
        ("rc@1.2.8")
        ("rimraf@2.6.3")
        ("semver@5.7.0")
        ("tar@4.4.10")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0jbazv6xmrlym6i5wh0a21x4sg7r812mfjzwk58ivz0p2lmgnpyx";
        url = "https://registry.npmjs.org/node-pre-gyp/-/node-pre-gyp-0.12.0.tgz";
      });
      pkgname = "node-pre-gyp";
    };
    "nopt@4.0.1" = {
      pname = "nopt";
      version = "4.0.1";
      depKeys = [
        ("abbrev@1.1.1")
        ("osenv@0.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dzqsmp946ym7c4cyw9bmn2gliq841gkxs6mkm02a22yc6vg4057";
        url = "https://registry.npmjs.org/nopt/-/nopt-4.0.1.tgz";
      });
      pkgname = "nopt";
    };
    "nopt@5.0.0" = {
      pname = "nopt";
      version = "5.0.0";
      depKeys = [
        ("abbrev@1.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1h4pv5dd3yd8zvf4z61sg9ydqvwimdws1w2dm581kj93j35sxivz";
        url = "https://registry.npmjs.org/nopt/-/nopt-5.0.0.tgz";
      });
      pkgname = "nopt";
    };
    "normalize-package-data@2.5.0" = {
      pname = "normalize-package-data";
      version = "2.5.0";
      depKeys = [
        ("hosted-git-info@2.7.1")
        ("resolve@1.11.1")
        ("semver@5.7.0")
        ("validate-npm-package-license@3.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0yqy8wn6iz66nw5yi56xly07vg50j3wrmdxq9alsn8r2dz2mk6zc";
        url = "https://registry.npmjs.org/normalize-package-data/-/normalize-package-data-2.5.0.tgz";
      });
      pkgname = "normalize-package-data";
    };
    "normalize-path@2.1.1" = {
      pname = "normalize-path";
      version = "2.1.1";
      depKeys = [
        ("remove-trailing-separator@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1d82jyqqyqgk8qkzb4sk7vnz6sgf8xznlm55mazlp43fc6w100cj";
        url = "https://registry.npmjs.org/normalize-path/-/normalize-path-2.1.1.tgz";
      });
      pkgname = "normalize-path";
    };
    "npm-bundled@1.0.6" = {
      pname = "npm-bundled";
      version = "1.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jns0pn7xxvvp72ghf9vnb5kb117rbwz8bv5dal8384agr35mbcl";
        url = "https://registry.npmjs.org/npm-bundled/-/npm-bundled-1.0.6.tgz";
      });
      pkgname = "npm-bundled";
    };
    "npm-packlist@1.4.4" = {
      pname = "npm-packlist";
      version = "1.4.4";
      depKeys = [
        ("ignore-walk@3.0.1")
        ("npm-bundled@1.0.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0lh7pbmdahgp6jiwpi0x2hfm377cbfmammac3bxqcf43nlfx3m2z";
        url = "https://registry.npmjs.org/npm-packlist/-/npm-packlist-1.4.4.tgz";
      });
      pkgname = "npm-packlist";
    };
    "npm-run-path@2.0.2" = {
      pname = "npm-run-path";
      version = "2.0.2";
      depKeys = [
        ("path-key@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1xz1f33ps8aqjjkvry886zb5nf4aznbx6axwn5nq76d0ica5cvb5";
        url = "https://registry.npmjs.org/npm-run-path/-/npm-run-path-2.0.2.tgz";
      });
      pkgname = "npm-run-path";
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
      src = (pkgs.fetchurl {
        sha256 = "0n87fxjxjw958xgk4xz73sm6plhrlfplj2ahaxyrqdy14i3sj4k8";
        url = "https://registry.npmjs.org/npmlog/-/npmlog-4.1.2.tgz";
      });
      pkgname = "npmlog";
    };
    "number-is-nan@1.0.1" = {
      pname = "number-is-nan";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g4zc4nr2jw5g1h1brgi90bgvk9jam5x4vg4n0cz58394bfwavl9";
        url = "https://registry.npmjs.org/number-is-nan/-/number-is-nan-1.0.1.tgz";
      });
      pkgname = "number-is-nan";
    };
    "nwsapi@2.1.4" = {
      pname = "nwsapi";
      version = "2.1.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1znxs9f5ldh9ddi3h14bp836x78nxqcxj6hn62b410kvayxifgv6";
        url = "https://registry.npmjs.org/nwsapi/-/nwsapi-2.1.4.tgz";
      });
      pkgname = "nwsapi";
    };
    "oauth-sign@0.9.0" = {
      pname = "oauth-sign";
      version = "0.9.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1g6rl2pv86pxcx4mv25qqv0w265mc5ardp3vxd2hqg80c4bsy5h0";
        url = "https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.9.0.tgz";
      });
      pkgname = "oauth-sign";
    };
    "object-assign@4.1.1" = {
      pname = "object-assign";
      version = "4.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1v999sycxcp74j2pikdhyinm2d80p2bsy4nnrrnb59rv4rm74bbq";
        url = "https://registry.npmjs.org/object-assign/-/object-assign-4.1.1.tgz";
      });
      pkgname = "object-assign";
    };
    "object-copy@0.1.0" = {
      pname = "object-copy";
      version = "0.1.0";
      depKeys = [
        ("copy-descriptor@0.1.1")
        ("define-property@0.2.5")
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1b59pq32z0kdzhjkwphyk5h0m59gcc4qvmkvq7zb49yla00w5f0w";
        url = "https://registry.npmjs.org/object-copy/-/object-copy-0.1.0.tgz";
      });
      pkgname = "object-copy";
    };
    "object-keys@1.1.1" = {
      pname = "object-keys";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "04pjwxszvk8alk6z5lzk02ba3q56i2g70cs02f57qxhraq2xjy4n";
        url = "https://registry.npmjs.org/object-keys/-/object-keys-1.1.1.tgz";
      });
      pkgname = "object-keys";
    };
    "object-visit@1.0.1" = {
      pname = "object-visit";
      version = "1.0.1";
      depKeys = [
        ("isobject@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "05qpsh7jyq40dk2mqm85hbcaapb4g4hyjcb4z6b2kcziqfiynpsl";
        url = "https://registry.npmjs.org/object-visit/-/object-visit-1.0.1.tgz";
      });
      pkgname = "object-visit";
    };
    "object.getownpropertydescriptors@2.0.3" = {
      pname = "object.getownpropertydescriptors";
      version = "2.0.3";
      depKeys = [
        ("define-properties@1.1.3")
        ("es-abstract@1.13.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1zpzg709dmpd8rv4sj3lfy0qkyamg5631v3b4r419pw3ysypkb78";
        url = "https://registry.npmjs.org/object.getownpropertydescriptors/-/object.getownpropertydescriptors-2.0.3.tgz";
      });
      pkgname = "object.getownpropertydescriptors";
    };
    "object.omit@2.0.1" = {
      pname = "object.omit";
      version = "2.0.1";
      depKeys = [
        ("for-own@0.1.5")
        ("is-extendable@0.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1zyjhjfjgmqbnszcxqlvncg7kahc045sp5w1j8f0z92cq9y25zws";
        url = "https://registry.npmjs.org/object.omit/-/object.omit-2.0.1.tgz";
      });
      pkgname = "object.omit";
    };
    "object.pick@1.3.0" = {
      pname = "object.pick";
      version = "1.3.0";
      depKeys = [
        ("isobject@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "02zfyg9vkizb5vanjy3d976cnbjnx4qrcjrd92z2ylyl4ih24040";
        url = "https://registry.npmjs.org/object.pick/-/object.pick-1.3.0.tgz";
      });
      pkgname = "object.pick";
    };
    "once@1.4.0" = {
      pname = "once";
      version = "1.4.0";
      depKeys = [
        ("wrappy@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1kygzk36kdcfiqz01dhql2dk75rl256m2vlpigv9iikhlc5lclfg";
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
      });
      pkgname = "once";
    };
    "optimist@0.6.1" = {
      pname = "optimist";
      version = "0.6.1";
      depKeys = [
        ("minimist@0.0.10")
        ("wordwrap@0.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "19d167h1254y4r4hydsc7ah6j32fd0m29zs8528i5wvph79myhjn";
        url = "https://registry.npmjs.org/optimist/-/optimist-0.6.1.tgz";
      });
      pkgname = "optimist";
    };
    "optionator@0.8.2" = {
      pname = "optionator";
      version = "0.8.2";
      depKeys = [
        ("deep-is@0.1.3")
        ("fast-levenshtein@2.0.6")
        ("levn@0.3.0")
        ("prelude-ls@1.1.2")
        ("type-check@0.3.2")
        ("wordwrap@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "07d6095pgqv7n0skv7wrlqg84ahkizfy35wxcpwzkxfvbsh5x6fg";
        url = "https://registry.npmjs.org/optionator/-/optionator-0.8.2.tgz";
      });
      pkgname = "optionator";
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
    "os-locale@2.1.0" = {
      pname = "os-locale";
      version = "2.1.0";
      depKeys = [
        ("execa@0.7.0")
        ("lcid@1.0.0")
        ("mem@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x2ndi3r36sc00ppp972kmirhplbcvvwnw4ax4yqkg5pn840gpd1";
        url = "https://registry.npmjs.org/os-locale/-/os-locale-2.1.0.tgz";
      });
      pkgname = "os-locale";
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
    "osenv@0.1.5" = {
      pname = "osenv";
      version = "0.1.5";
      depKeys = [
        ("os-homedir@1.0.2")
        ("os-tmpdir@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0j34a50i707jwxbz4mzap9awpsm0cyd75l0yadi55www26d4c6bx";
        url = "https://registry.npmjs.org/osenv/-/osenv-0.1.5.tgz";
      });
      pkgname = "osenv";
    };
    "outdent@0.3.0" = {
      pname = "outdent";
      version = "0.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0477gd84i65j3xj7373g6nvykvzgyf4lg1klinlpzrl5gbgjhkgp";
        url = "https://registry.npmjs.org/outdent/-/outdent-0.3.0.tgz";
      });
      pkgname = "outdent";
    };
    "p-finally@1.0.0" = {
      pname = "p-finally";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0hc8zfqhw1qnrbm62dxqb7a019r1vbsg2hx2hhm58c0kkvh89zgg";
        url = "https://registry.npmjs.org/p-finally/-/p-finally-1.0.0.tgz";
      });
      pkgname = "p-finally";
    };
    "p-limit@1.3.0" = {
      pname = "p-limit";
      version = "1.3.0";
      depKeys = [
        ("p-try@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0l611k2j249zka517bgvylhzypfxz28fd1zqb3ps1iffk6zcpzf2";
        url = "https://registry.npmjs.org/p-limit/-/p-limit-1.3.0.tgz";
      });
      pkgname = "p-limit";
    };
    "p-locate@2.0.0" = {
      pname = "p-locate";
      version = "2.0.0";
      depKeys = [
        ("p-limit@1.3.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ipv5a7kmwxbkn75bldn4lyah3269arpaixi9rdvy04qk97lpiq7";
        url = "https://registry.npmjs.org/p-locate/-/p-locate-2.0.0.tgz";
      });
      pkgname = "p-locate";
    };
    "p-map@1.2.0" = {
      pname = "p-map";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0j7fnqfcd21qnv25hjcsgdvd4pa2rlwdc38y922j92b54b3h7jzg";
        url = "https://registry.npmjs.org/p-map/-/p-map-1.2.0.tgz";
      });
      pkgname = "p-map";
    };
    "p-map@4.0.0" = {
      pname = "p-map";
      version = "4.0.0";
      depKeys = [
        ("aggregate-error@3.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "147z64sp0ifrix961cr3f6sw2fs2wqx225d24mdbgvn3c5sj6c51";
        url = "https://registry.npmjs.org/p-map/-/p-map-4.0.0.tgz";
      });
      pkgname = "p-map";
    };
    "p-try@1.0.0" = {
      pname = "p-try";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1pjl0b25kqxzavp62l8jha7vk1zch98lkv9zrb1m4yx7q6ld9zlr";
        url = "https://registry.npmjs.org/p-try/-/p-try-1.0.0.tgz";
      });
      pkgname = "p-try";
    };
    "parse-glob@3.0.4" = {
      pname = "parse-glob";
      version = "3.0.4";
      depKeys = [
        ("glob-base@0.3.0")
        ("is-dotfile@1.0.3")
        ("is-extglob@1.0.0")
        ("is-glob@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1pj6awfzkdl4i9ljmfcqgr16qh8pp11hqb1jsx5lq4rhw12laxmh";
        url = "https://registry.npmjs.org/parse-glob/-/parse-glob-3.0.4.tgz";
      });
      pkgname = "parse-glob";
    };
    "parse-json@2.2.0" = {
      pname = "parse-json";
      version = "2.2.0";
      depKeys = [
        ("error-ex@1.3.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1mbfkx6wfbaxvinnn7i90mm6d0ddin47cya8apslvxgz6qf2kccb";
        url = "https://registry.npmjs.org/parse-json/-/parse-json-2.2.0.tgz";
      });
      pkgname = "parse-json";
    };
    "parse5@4.0.0" = {
      pname = "parse5";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "19254a0ydh34dm0cbhbd5ffcm8qfhz03alpjhxw1xy7j1h2x96aj";
        url = "https://registry.npmjs.org/parse5/-/parse5-4.0.0.tgz";
      });
      pkgname = "parse5";
    };
    "pascalcase@0.1.1" = {
      pname = "pascalcase";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0hd2yjrsfhw3183dxzs5045xnas07in2ww5sl0m5jx035zcrqv2m";
        url = "https://registry.npmjs.org/pascalcase/-/pascalcase-0.1.1.tgz";
      });
      pkgname = "pascalcase";
    };
    "path-exists@2.1.0" = {
      pname = "path-exists";
      version = "2.1.0";
      depKeys = [
        ("pinkie-promise@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "12d8db0b5pki1rzv8d1r00gn35ghpimmd01639hfmgil1j2qyczs";
        url = "https://registry.npmjs.org/path-exists/-/path-exists-2.1.0.tgz";
      });
      pkgname = "path-exists";
    };
    "path-exists@3.0.0" = {
      pname = "path-exists";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0b9j0s6mvbf7js1fsga1jx4k6c4k17yn9c1jlaiziqkmvi98gxyp";
        url = "https://registry.npmjs.org/path-exists/-/path-exists-3.0.0.tgz";
      });
      pkgname = "path-exists";
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
    "path-is-inside@1.0.2" = {
      pname = "path-is-inside";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "17adl8ap5kvzaa1j27ciz5475g8f5cxfz8f900x6g28wra3kxvw8";
        url = "https://registry.npmjs.org/path-is-inside/-/path-is-inside-1.0.2.tgz";
      });
      pkgname = "path-is-inside";
    };
    "path-key@2.0.1" = {
      pname = "path-key";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1w2fn5cgssfvg4wfgkf9mqz4slsv45aq6f8cgszvb4h78dm9hwgf";
        url = "https://registry.npmjs.org/path-key/-/path-key-2.0.1.tgz";
      });
      pkgname = "path-key";
    };
    "path-parse@1.0.6" = {
      pname = "path-parse";
      version = "1.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "07x1wv7r4yky2hgcxl465a39a48hf5746840g9xkzggl3gb35ad4";
        url = "https://registry.npmjs.org/path-parse/-/path-parse-1.0.6.tgz";
      });
      pkgname = "path-parse";
    };
    "path-type@1.1.0" = {
      pname = "path-type";
      version = "1.1.0";
      depKeys = [
        ("graceful-fs@4.2.0")
        ("pify@2.3.0")
        ("pinkie-promise@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0fxikwyx6afyvapnwxc7spr4n39hfjf6ykxhyjqfvx0ll8bhx4f6";
        url = "https://registry.npmjs.org/path-type/-/path-type-1.1.0.tgz";
      });
      pkgname = "path-type";
    };
    "performance-now@2.1.0" = {
      pname = "performance-now";
      version = "2.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0ich517fgk1nhmcjs2mfv4dp70ppqvj3xgmv3syl25zixzfrk3q6";
        url = "https://registry.npmjs.org/performance-now/-/performance-now-2.1.0.tgz";
      });
      pkgname = "performance-now";
    };
    "pify@2.3.0" = {
      pname = "pify";
      version = "2.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0c05nakijggqjz2w2ky6pim8kagi73hvdph4d9pj4pga3s9jr9bl";
        url = "https://registry.npmjs.org/pify/-/pify-2.3.0.tgz";
      });
      pkgname = "pify";
    };
    "pify@3.0.0" = {
      pname = "pify";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g04k40h8kzpjsw4mznd9a6y74k8zp59lc9wp9fydf3wjgwx272r";
        url = "https://registry.npmjs.org/pify/-/pify-3.0.0.tgz";
      });
      pkgname = "pify";
    };
    "pinkie-promise@2.0.1" = {
      pname = "pinkie-promise";
      version = "2.0.1";
      depKeys = [
        ("pinkie@2.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "055djd7zy24zid262i878fh5sgh085iglf9bqq1wnlbkc48cidlj";
        url = "https://registry.npmjs.org/pinkie-promise/-/pinkie-promise-2.0.1.tgz";
      });
      pkgname = "pinkie-promise";
    };
    "pinkie@2.0.4" = {
      pname = "pinkie";
      version = "2.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "10rxvakkn6r9z5l02737zv9f3j8w94mamck57vmykbb3bv15ia3r";
        url = "https://registry.npmjs.org/pinkie/-/pinkie-2.0.4.tgz";
      });
      pkgname = "pinkie";
    };
    "pkg-dir@2.0.0" = {
      pname = "pkg-dir";
      version = "2.0.0";
      depKeys = [
        ("find-up@2.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0nx46f86jsncg5hhd399rzs7i1d5hw1zqnkwhywvqbr0jygrq4gk";
        url = "https://registry.npmjs.org/pkg-dir/-/pkg-dir-2.0.0.tgz";
      });
      pkgname = "pkg-dir";
    };
    "pn@1.1.0" = {
      pname = "pn";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ym8mvg44d3yzpd4iyb33y8r269wzxpyc88rlmpn19qrv1mwgwwh";
        url = "https://registry.npmjs.org/pn/-/pn-1.1.0.tgz";
      });
      pkgname = "pn";
    };
    "posix-character-classes@0.1.1" = {
      pname = "posix-character-classes";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "08c07ib7iaj34d1mnjhll0bq0yh3kb98q4mf334js2l4166y9rcr";
        url = "https://registry.npmjs.org/posix-character-classes/-/posix-character-classes-0.1.1.tgz";
      });
      pkgname = "posix-character-classes";
    };
    "prelude-ls@1.1.2" = {
      pname = "prelude-ls";
      version = "1.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0msvwq9la3w6wm51s2p3j2dv6634sj7iydyx3iqw4y67vkj8zzgs";
        url = "https://registry.npmjs.org/prelude-ls/-/prelude-ls-1.1.2.tgz";
      });
      pkgname = "prelude-ls";
    };
    "preserve@0.2.0" = {
      pname = "preserve";
      version = "0.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "10lk61d1axbbh6j2cglvbcxamn7vh6dy5mmgkc2agmj05nlmlkr9";
        url = "https://registry.npmjs.org/preserve/-/preserve-0.2.0.tgz";
      });
      pkgname = "preserve";
    };
    "prettier@1.18.2" = {
      pname = "prettier";
      version = "1.18.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1fhizmzpa8xs0wjzc580q2qadxswrhi9vmj6b8kjm72zsqyay5ld";
        url = "https://registry.npmjs.org/prettier/-/prettier-1.18.2.tgz";
      });
      pkgname = "prettier";
    };
    "pretty-format@23.6.0" = {
      pname = "pretty-format";
      version = "23.6.0";
      depKeys = [
        ("ansi-regex@3.0.0")
        ("ansi-styles@3.2.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "18ldv459x58s43qa4ynvj8njagn17y1mnhcjwzgpkrh73igijxdm";
        url = "https://registry.npmjs.org/pretty-format/-/pretty-format-23.6.0.tgz";
      });
      pkgname = "pretty-format";
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
    "process-nextick-args@2.0.1" = {
      pname = "process-nextick-args";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "16w8m2ycy5s4ykgdfg97qxa67gfvkh6x3vdwfsncafyj4p3zhns2";
        url = "https://registry.npmjs.org/process-nextick-args/-/process-nextick-args-2.0.1.tgz";
      });
      pkgname = "process-nextick-args";
    };
    "promise-inflight@1.0.1" = {
      pname = "promise-inflight";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "02ibq6bvxhmyx3lh4bz1ikrlb5n728nj0gshgf5bgqxjpijkphwl";
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
        sha256 = "1k2mdc2jbw2h3ykxcgvh2wv20gdb6m1siacllr7dy2x4rlk3g5jq";
        url = "https://registry.npmjs.org/promise-retry/-/promise-retry-2.0.1.tgz";
      });
      pkgname = "promise-retry";
    };
    "prompts@0.1.14" = {
      pname = "prompts";
      version = "0.1.14";
      depKeys = [
        ("kleur@2.0.2")
        ("sisteransi@0.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vlaibwjbdzsknmr8cqbhnmar1cr54sadg9fwdbqz0djsdj5qlg2";
        url = "https://registry.npmjs.org/prompts/-/prompts-0.1.14.tgz";
      });
      pkgname = "prompts";
    };
    "pseudomap@1.0.2" = {
      pname = "pseudomap";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "13jv1dwki6m9w32bl2q44nqwf4xfqg91v7gc28a1dc69hws5ds87";
        url = "https://registry.npmjs.org/pseudomap/-/pseudomap-1.0.2.tgz";
      });
      pkgname = "pseudomap";
    };
    "psl@1.2.0" = {
      pname = "psl";
      version = "1.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0blsrghfgjpc27w0z321b1y8jam0dkiphya67k2vnyqqy4szg424";
        url = "https://registry.npmjs.org/psl/-/psl-1.2.0.tgz";
      });
      pkgname = "psl";
    };
    "pump@1.0.3" = {
      pname = "pump";
      version = "1.0.3";
      depKeys = [
        ("end-of-stream@1.4.1")
        ("once@1.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "12bs1bp3x318n7lqlqwypfvm9wvah4wb0nq49fab6cwxkfmd9qqa";
        url = "https://registry.npmjs.org/pump/-/pump-1.0.3.tgz";
      });
      pkgname = "pump";
    };
    "punycode@1.4.1" = {
      pname = "punycode";
      version = "1.4.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "12gdim25jn0g82kqql0qb44kjf8gbwzhcy8wf53vq56ad5rwlas5";
        url = "https://registry.npmjs.org/punycode/-/punycode-1.4.1.tgz";
      });
      pkgname = "punycode";
    };
    "punycode@2.1.1" = {
      pname = "punycode";
      version = "2.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0g7z0kdxs15jrcijwbka2jajgr4b7bvpa6xmrcs0wf82pxwx1k75";
        url = "https://registry.npmjs.org/punycode/-/punycode-2.1.1.tgz";
      });
      pkgname = "punycode";
    };
    "qs@6.5.2" = {
      pname = "qs";
      version = "6.5.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1w0n5rg0w76b97ds80svkhmcqzcn76c3g5z81sblvii89ww4k4sk";
        url = "https://registry.npmjs.org/qs/-/qs-6.5.2.tgz";
      });
      pkgname = "qs";
    };
    "randomatic@3.1.1" = {
      pname = "randomatic";
      version = "3.1.1";
      depKeys = [
        ("is-number@4.0.0")
        ("kind-of@6.0.2")
        ("math-random@1.0.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1jawbnz6qqy98w7v45yp1wby00ykwrpmai5bmvbkw1nw9q56cy0p";
        url = "https://registry.npmjs.org/randomatic/-/randomatic-3.1.1.tgz";
      });
      pkgname = "randomatic";
    };
    "rc@1.2.8" = {
      pname = "rc";
      version = "1.2.8";
      depKeys = [
        ("deep-extend@0.6.0")
        ("ini@1.3.5")
        ("minimist@1.2.0")
        ("strip-json-comments@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0fz9r8aphj84cvxv8k0m7g008gffz561r6ryvljb8gi0hpjgm983";
        url = "https://registry.npmjs.org/rc/-/rc-1.2.8.tgz";
      });
      pkgname = "rc";
    };
    "read-pkg-up@1.0.1" = {
      pname = "read-pkg-up";
      version = "1.0.1";
      depKeys = [
        ("find-up@1.1.2")
        ("read-pkg@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "09j7gryd348bl4shv986ya1bxr992sixd5apymnb6fm1nzf8s1g7";
        url = "https://registry.npmjs.org/read-pkg-up/-/read-pkg-up-1.0.1.tgz";
      });
      pkgname = "read-pkg-up";
    };
    "read-pkg@1.1.0" = {
      pname = "read-pkg";
      version = "1.1.0";
      depKeys = [
        ("load-json-file@1.1.0")
        ("normalize-package-data@2.5.0")
        ("path-type@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1wpgaspymw60malqf2mmkphbsa25x428i0crhzcszgpvpfqnxhwf";
        url = "https://registry.npmjs.org/read-pkg/-/read-pkg-1.1.0.tgz";
      });
      pkgname = "read-pkg";
    };
    "readable-stream@2.3.6" = {
      pname = "readable-stream";
      version = "2.3.6";
      depKeys = [
        ("core-util-is@1.0.2")
        ("inherits@2.0.4")
        ("isarray@1.0.0")
        ("process-nextick-args@2.0.1")
        ("safe-buffer@5.1.2")
        ("string_decoder@1.1.1")
        ("util-deprecate@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xswqhcra34iff36l2ycrslcr1rz7dcd3wdvbgq01cqgvih5n80g";
        url = "https://registry.npmjs.org/readable-stream/-/readable-stream-2.3.6.tgz";
      });
      pkgname = "readable-stream";
    };
    "realpath-native@1.1.0" = {
      pname = "realpath-native";
      version = "1.1.0";
      depKeys = [
        ("util.promisify@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nvd7mqq5sv3nhsahqj4mgf729i8wv7b0gfp4cwaaym718yd1ihs";
        url = "https://registry.npmjs.org/realpath-native/-/realpath-native-1.1.0.tgz";
      });
      pkgname = "realpath-native";
    };
    "regenerate@1.4.0" = {
      pname = "regenerate";
      version = "1.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0izq5b0ssjy3ia8j061s37pxd5indkrfa0i7rl6kvw3g2smsc3g9";
        url = "https://registry.npmjs.org/regenerate/-/regenerate-1.4.0.tgz";
      });
      pkgname = "regenerate";
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
    "regenerator-transform@0.10.1" = {
      pname = "regenerator-transform";
      version = "0.10.1";
      depKeys = [
        ("babel-runtime@6.26.0")
        ("babel-types@6.26.0")
        ("private@0.1.8")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1pjxnhgik5mrjzqnby2plph28zrry6vir9wiyjsx3icq12an1yxn";
        url = "https://registry.npmjs.org/regenerator-transform/-/regenerator-transform-0.10.1.tgz";
      });
      pkgname = "regenerator-transform";
    };
    "regex-cache@0.4.4" = {
      pname = "regex-cache";
      version = "0.4.4";
      depKeys = [
        ("is-equal-shallow@0.1.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "100lg733jk0j378l77n72w5qfqzyrnacf744y2icp170wwsrvm36";
        url = "https://registry.npmjs.org/regex-cache/-/regex-cache-0.4.4.tgz";
      });
      pkgname = "regex-cache";
    };
    "regex-not@1.0.2" = {
      pname = "regex-not";
      version = "1.0.2";
      depKeys = [
        ("extend-shallow@3.0.2")
        ("safe-regex@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0xpjprkrk0c9fn6yhqay3bm8vw44k197smcfby89g3sfjsxlhi7s";
        url = "https://registry.npmjs.org/regex-not/-/regex-not-1.0.2.tgz";
      });
      pkgname = "regex-not";
    };
    "regexpu-core@2.0.0" = {
      pname = "regexpu-core";
      version = "2.0.0";
      depKeys = [
        ("regenerate@1.4.0")
        ("regjsgen@0.2.0")
        ("regjsparser@0.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1cj0pi7y3wdd66na176pms5x0f3s5dfq6p29x7lc9a45n84b2a7a";
        url = "https://registry.npmjs.org/regexpu-core/-/regexpu-core-2.0.0.tgz";
      });
      pkgname = "regexpu-core";
    };
    "regjsgen@0.2.0" = {
      pname = "regjsgen";
      version = "0.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0f197wxb7wm641n7fh5vqkb63d2jy4nx8f3j0a6fhgbaq3a03vy3";
        url = "https://registry.npmjs.org/regjsgen/-/regjsgen-0.2.0.tgz";
      });
      pkgname = "regjsgen";
    };
    "regjsparser@0.1.5" = {
      pname = "regjsparser";
      version = "0.1.5";
      depKeys = [
        ("jsesc@0.5.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0i1rxqrgn88m7ylxf3f0w3nrcchpz381ra9pz1rpgd7wv67kksxa";
        url = "https://registry.npmjs.org/regjsparser/-/regjsparser-0.1.5.tgz";
      });
      pkgname = "regjsparser";
    };
    "remove-trailing-separator@1.1.0" = {
      pname = "remove-trailing-separator";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "08b3msz9s5kw1alivgn9saaz6w04grjqppkdk3qbr7blk38l04sf";
        url = "https://registry.npmjs.org/remove-trailing-separator/-/remove-trailing-separator-1.1.0.tgz";
      });
      pkgname = "remove-trailing-separator";
    };
    "repeat-element@1.1.3" = {
      pname = "repeat-element";
      version = "1.1.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1p71vsqclms9dxadcpnaajh8jkp3acxlkv6xic7f9x98dpdss8g6";
        url = "https://registry.npmjs.org/repeat-element/-/repeat-element-1.1.3.tgz";
      });
      pkgname = "repeat-element";
    };
    "repeat-string@1.6.1" = {
      pname = "repeat-string";
      version = "1.6.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1zmlk22rp97i5yfxqlb9hix87zlznngd60pm8qwhcg6bssacpq8b";
        url = "https://registry.npmjs.org/repeat-string/-/repeat-string-1.6.1.tgz";
      });
      pkgname = "repeat-string";
    };
    "repeating@2.0.1" = {
      pname = "repeating";
      version = "2.0.1";
      depKeys = [
        ("is-finite@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "15w0nan6zgw2c1w0nclbbld80gi12grhssb82dmgrm6zvsjnss1b";
        url = "https://registry.npmjs.org/repeating/-/repeating-2.0.1.tgz";
      });
      pkgname = "repeating";
    };
    "request-promise-core@1.1.2" = {
      pname = "request-promise-core";
      version = "1.1.2";
      depKeys = [
        ("lodash@4.17.15")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kqp4cfk9sqr1l0dmdrqmpr30n75rlnckqjyr53g5lykwzw0smng";
        url = "https://registry.npmjs.org/request-promise-core/-/request-promise-core-1.1.2.tgz";
      });
      pkgname = "request-promise-core";
    };
    "request-promise-native@1.0.7" = {
      pname = "request-promise-native";
      version = "1.0.7";
      depKeys = [
        ("request-promise-core@1.1.2")
        ("stealthy-require@1.1.1")
        ("tough-cookie@2.5.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vdw1jvfw0walfsk0c7fjzqm5csz2mw4drl8rglq06gk02i1qflp";
        url = "https://registry.npmjs.org/request-promise-native/-/request-promise-native-1.0.7.tgz";
      });
      pkgname = "request-promise-native";
    };
    "request@2.88.0" = {
      pname = "request";
      version = "2.88.0";
      depKeys = [
        ("aws-sign2@0.7.0")
        ("aws4@1.8.0")
        ("caseless@0.12.0")
        ("combined-stream@1.0.8")
        ("extend@3.0.2")
        ("forever-agent@0.6.1")
        ("form-data@2.3.3")
        ("har-validator@5.1.3")
        ("http-signature@1.2.0")
        ("is-typedarray@1.0.0")
        ("isstream@0.1.2")
        ("json-stringify-safe@5.0.1")
        ("mime-types@2.1.24")
        ("oauth-sign@0.9.0")
        ("performance-now@2.1.0")
        ("qs@6.5.2")
        ("safe-buffer@5.2.0")
        ("tough-cookie@2.4.3")
        ("tunnel-agent@0.6.0")
        ("uuid@3.3.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "196s991npfkla26vv6h08w5c2rcaa5hdp7jnq7x3slgbsmgpgbv1";
        url = "https://registry.npmjs.org/request/-/request-2.88.0.tgz";
      });
      pkgname = "request";
    };
    "require-directory@2.1.1" = {
      pname = "require-directory";
      version = "2.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1j46ydacaai73mx5krskl0k78r32lnjx94l79bz860rn8h4fwfvh";
        url = "https://registry.npmjs.org/require-directory/-/require-directory-2.1.1.tgz";
      });
      pkgname = "require-directory";
    };
    "require-main-filename@1.0.1" = {
      pname = "require-main-filename";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1hwrk7489dy8pp8zny8ms72y2mzywni9f9yg3g85hygp9v92v9v3";
        url = "https://registry.npmjs.org/require-main-filename/-/require-main-filename-1.0.1.tgz";
      });
      pkgname = "require-main-filename";
    };
    "resolve-cwd@2.0.0" = {
      pname = "resolve-cwd";
      version = "2.0.0";
      depKeys = [
        ("resolve-from@3.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qmyxj0w9dg9avxyki81x4j5c1f554a3qjdgr80cmkbsqj0lqxj4";
        url = "https://registry.npmjs.org/resolve-cwd/-/resolve-cwd-2.0.0.tgz";
      });
      pkgname = "resolve-cwd";
    };
    "resolve-from@3.0.0" = {
      pname = "resolve-from";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ghppacmmjwrw5xx80qr19ap1wpizrrl8dbljj0yn87mnn6pr98k";
        url = "https://registry.npmjs.org/resolve-from/-/resolve-from-3.0.0.tgz";
      });
      pkgname = "resolve-from";
    };
    "resolve-url@0.2.1" = {
      pname = "resolve-url";
      version = "0.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "090qal7agjs8d6x98jrf0wzgx5j85ksbkb3c85f14wv3idbwpsc8";
        url = "https://registry.npmjs.org/resolve-url/-/resolve-url-0.2.1.tgz";
      });
      pkgname = "resolve-url";
    };
    "resolve@1.1.7" = {
      pname = "resolve";
      version = "1.1.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "02zyw1san3apkwcr68pmyrr7cin2j372avlllhnnvmrpd302cmv0";
        url = "https://registry.npmjs.org/resolve/-/resolve-1.1.7.tgz";
      });
      pkgname = "resolve";
    };
    "resolve@1.11.1" = {
      pname = "resolve";
      version = "1.11.1";
      depKeys = [
        ("path-parse@1.0.6")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qwgcyj1bk7sb5jb11nc3b26h6vs2km8gyx0ld1380g8lhgnrki5";
        url = "https://registry.npmjs.org/resolve/-/resolve-1.11.1.tgz";
      });
      pkgname = "resolve";
    };
    "resolve@resolve@npm%3A1.1.7#~builtin<compat/resolve>::version=1.1.7&hash=07638b" = {
      pname = "resolve";
      version = "1.1.7";
      depKeys = [
      ];
      pkgname = "resolve";
    };
    "resolve@resolve@npm%3A1.11.1#~builtin<compat/resolve>::version=1.11.1&hash=07638b" = {
      pname = "resolve";
      version = "1.11.1";
      depKeys = [
        ("path-parse@1.0.6")
      ];
      pkgname = "resolve";
    };
    "ret@0.1.15" = {
      pname = "ret";
      version = "0.1.15";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1zk9xw3jzs7di9b31sxg3fi0mljac8w09k0q6m6y311i1fsn4x2a";
        url = "https://registry.npmjs.org/ret/-/ret-0.1.15.tgz";
      });
      pkgname = "ret";
    };
    "retry@0.12.0" = {
      pname = "retry";
      version = "0.12.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0a5l61f1aqn124j25m2q6m0j60mv7d9h74a8gfqnmp5ajz8wcqfz";
        url = "https://registry.npmjs.org/retry/-/retry-0.12.0.tgz";
      });
      pkgname = "retry";
    };
    "rimraf@2.6.3" = {
      pname = "rimraf";
      version = "2.6.3";
      depKeys = [
        ("glob@7.1.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0zkzyrndihic25mizl3hhqw3y2ah36hq5kr4rqcwy56jpp56zdcc";
        url = "https://registry.npmjs.org/rimraf/-/rimraf-2.6.3.tgz";
      });
      pkgname = "rimraf";
    };
    "rimraf@3.0.2" = {
      pname = "rimraf";
      version = "3.0.2";
      depKeys = [
        ("glob@7.1.4")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0lkzjyxjij6ssh5h2l3ncp0zx00ylzhww766dq2vf1s7v07w4xjq";
        url = "https://registry.npmjs.org/rimraf/-/rimraf-3.0.2.tgz";
      });
      pkgname = "rimraf";
    };
    "rsvp@3.6.2" = {
      pname = "rsvp";
      version = "3.6.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0vixmmpbs80lwmzhqbgqrlv71pclffcqfmg413zb11vr5c6h6zl3";
        url = "https://registry.npmjs.org/rsvp/-/rsvp-3.6.2.tgz";
      });
      pkgname = "rsvp";
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
    "safe-buffer@5.2.0" = {
      pname = "safe-buffer";
      version = "5.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1avkj16bydzzd33h8bjk0n59pj1ljxm5y1wvrh10wgsph760ykc1";
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.2.0.tgz";
      });
      pkgname = "safe-buffer";
    };
    "safe-regex@1.1.0" = {
      pname = "safe-regex";
      version = "1.1.0";
      depKeys = [
        ("ret@0.1.15")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1lkcz58mjp3nfdiydh4iynpcfgxhf5mr339swzi5k05sikx8j4k2";
        url = "https://registry.npmjs.org/safe-regex/-/safe-regex-1.1.0.tgz";
      });
      pkgname = "safe-regex";
    };
    "safer-buffer@2.1.2" = {
      pname = "safer-buffer";
      version = "2.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1cx383s7vchfac8jlg3mnb820hkgcvhcpfn9w4f0g61vmrjjz0bq";
        url = "https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz";
      });
      pkgname = "safer-buffer";
    };
    "sane@2.5.2" = {
      pname = "sane";
      version = "2.5.2";
      depKeys = [
        ("anymatch@2.0.0")
        ("capture-exit@1.2.0")
        ("exec-sh@0.2.2")
        ("fb-watchman@2.0.0")
        ("fsevents@1.2.9")
        ("micromatch@3.1.10")
        ("minimist@1.2.0")
        ("walker@1.0.7")
        ("watch@0.18.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "048c4brawzvxzbflp5zsc9dqxv4dqkgkn5a168dchyc8m3x4jqlr";
        url = "https://registry.npmjs.org/sane/-/sane-2.5.2.tgz";
      });
      pkgname = "sane";
    };
    "sax@1.2.4" = {
      pname = "sax";
      version = "1.2.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1whw09cqikd6qf0glms5k2lifpxf0rhd06249p5gy7042zh45i5d";
        url = "https://registry.npmjs.org/sax/-/sax-1.2.4.tgz";
      });
      pkgname = "sax";
    };
    "semver@5.7.0" = {
      pname = "semver";
      version = "5.7.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1gfyzgk2glx3jc0jw772x9vghjs6mfbqws038gb6fb07j9jbk7li";
        url = "https://registry.npmjs.org/semver/-/semver-5.7.0.tgz";
      });
      pkgname = "semver";
    };
    "semver@7.3.5" = {
      pname = "semver";
      version = "7.3.5";
      depKeys = [
        ("lru-cache@6.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "17jrlrwq1fm80pl54lmra4zpj8crr3y7kj031fhq02g274j807xg";
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
        sha256 = "0gb9mvv8bjfavsxlzq56189qis7z2lrp893px04xl2cyvgkswd6r";
        url = "https://registry.npmjs.org/set-blocking/-/set-blocking-2.0.0.tgz";
      });
      pkgname = "set-blocking";
    };
    "set-value@2.0.1" = {
      pname = "set-value";
      version = "2.0.1";
      depKeys = [
        ("extend-shallow@2.0.1")
        ("is-extendable@0.1.1")
        ("is-plain-object@2.0.4")
        ("split-string@3.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0qbp2ndx2qmmn6i7y92lk8jaj79cv36gpv9lq29lgw52wr6jbrl0";
        url = "https://registry.npmjs.org/set-value/-/set-value-2.0.1.tgz";
      });
      pkgname = "set-value";
    };
    "shebang-command@1.2.0" = {
      pname = "shebang-command";
      version = "1.2.0";
      depKeys = [
        ("shebang-regex@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1xz1gpsia9137vsm4zx3jda6wl72641djg5nk5g8b9vzssp88rg5";
        url = "https://registry.npmjs.org/shebang-command/-/shebang-command-1.2.0.tgz";
      });
      pkgname = "shebang-command";
    };
    "shebang-regex@1.0.0" = {
      pname = "shebang-regex";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0wf6hlgf5b2mn2zydi5nn23cpgpjkdpi6q9xaqdwa8b6ir714vv7";
        url = "https://registry.npmjs.org/shebang-regex/-/shebang-regex-1.0.0.tgz";
      });
      pkgname = "shebang-regex";
    };
    "shellwords@0.1.1" = {
      pname = "shellwords";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "00j4d0lrp11hdpx40zpfziixwazb2avkqgvzzgwmcs1y03wx90bc";
        url = "https://registry.npmjs.org/shellwords/-/shellwords-0.1.1.tgz";
      });
      pkgname = "shellwords";
    };
    "signal-exit@3.0.2" = {
      pname = "signal-exit";
      version = "3.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1n6jbf6dq3ymdgc9k8bwfcbbpfyh4p0477aj4xf8x7yva380x46q";
        url = "https://registry.npmjs.org/signal-exit/-/signal-exit-3.0.2.tgz";
      });
      pkgname = "signal-exit";
    };
    "sisteransi@0.1.1" = {
      pname = "sisteransi";
      version = "0.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x4iihygpxmyjl8sisy38ba6i057ypr7wpj12938373yb6127y7n";
        url = "https://registry.npmjs.org/sisteransi/-/sisteransi-0.1.1.tgz";
      });
      pkgname = "sisteransi";
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
    "smart-buffer@4.2.0" = {
      pname = "smart-buffer";
      version = "4.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "18ahcjprcl5mr719dxpzh7kq1lylnwzf7j3bmi3vkgnirgj1b61x";
        url = "https://registry.npmjs.org/smart-buffer/-/smart-buffer-4.2.0.tgz";
      });
      pkgname = "smart-buffer";
    };
    "snapdragon-node@2.1.1" = {
      pname = "snapdragon-node";
      version = "2.1.1";
      depKeys = [
        ("define-property@1.0.0")
        ("isobject@3.0.1")
        ("snapdragon-util@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0idm24bf2jvwgqi8fx1fkn1w78ylqnpm137s2m0g0ni43y19i97j";
        url = "https://registry.npmjs.org/snapdragon-node/-/snapdragon-node-2.1.1.tgz";
      });
      pkgname = "snapdragon-node";
    };
    "snapdragon-util@3.0.1" = {
      pname = "snapdragon-util";
      version = "3.0.1";
      depKeys = [
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0c4fcrilagmpsrhh4mjfj7ah0vdxwkm9a4h5658bj8m7machxm2f";
        url = "https://registry.npmjs.org/snapdragon-util/-/snapdragon-util-3.0.1.tgz";
      });
      pkgname = "snapdragon-util";
    };
    "snapdragon@0.8.2" = {
      pname = "snapdragon";
      version = "0.8.2";
      depKeys = [
        ("base@0.11.2")
        ("debug@2.6.9")
        ("define-property@0.2.5")
        ("extend-shallow@2.0.1")
        ("map-cache@0.2.2")
        ("source-map@0.5.7")
        ("source-map-resolve@0.5.2")
        ("use@3.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1anpibb0ajgw2yv400aq30bvvpcyi3yzyrp7fac2ia6r7ysxcgvq";
        url = "https://registry.npmjs.org/snapdragon/-/snapdragon-0.8.2.tgz";
      });
      pkgname = "snapdragon";
    };
    "socks-proxy-agent@6.1.0" = {
      pname = "socks-proxy-agent";
      version = "6.1.0";
      depKeys = [
        ("agent-base@6.0.2")
        ("debug@4.3.2")
        ("socks@2.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "13ssf514sv52r518m07qlv3iyxphnfnz8hrigw9zxxapmh83i1mp";
        url = "https://registry.npmjs.org/socks-proxy-agent/-/socks-proxy-agent-6.1.0.tgz";
      });
      pkgname = "socks-proxy-agent";
    };
    "socks@2.6.1" = {
      pname = "socks";
      version = "2.6.1";
      depKeys = [
        ("ip@1.1.5")
        ("smart-buffer@4.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "02ffxfykmdjcp2hs0p83gvybb8c07l8pp19lpmrgmh6h6jm2xii5";
        url = "https://registry.npmjs.org/socks/-/socks-2.6.1.tgz";
      });
      pkgname = "socks";
    };
    "source-map-resolve@0.5.2" = {
      pname = "source-map-resolve";
      version = "0.5.2";
      depKeys = [
        ("atob@2.1.2")
        ("decode-uri-component@0.2.0")
        ("resolve-url@0.2.1")
        ("source-map-url@0.4.0")
        ("urix@0.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1356gnlqa9qhh7kglvwjj1909dbvd0m3fw7nkbdljpgvcwrs60va";
        url = "https://registry.npmjs.org/source-map-resolve/-/source-map-resolve-0.5.2.tgz";
      });
      pkgname = "source-map-resolve";
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
    "source-map-support@0.5.12" = {
      pname = "source-map-support";
      version = "0.5.12";
      depKeys = [
        ("buffer-from@1.1.1")
        ("source-map@0.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1x3c75kz7yl7h4fm7mgsfcsgn17ahhgjw53hydh4pj1i3h5qghg3";
        url = "https://registry.npmjs.org/source-map-support/-/source-map-support-0.5.12.tgz";
      });
      pkgname = "source-map-support";
    };
    "source-map-url@0.4.0" = {
      pname = "source-map-url";
      version = "0.4.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "04ph8f65achmyf62g889xsvqbgq5qykzpy91rabjkpcma72zc924";
        url = "https://registry.npmjs.org/source-map-url/-/source-map-url-0.4.0.tgz";
      });
      pkgname = "source-map-url";
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
    "source-map@0.6.1" = {
      pname = "source-map";
      version = "0.6.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "11ib173i7xf5sd85da9jfrcbzygr48pppz5csl15hnpz2w6s3g5x";
        url = "https://registry.npmjs.org/source-map/-/source-map-0.6.1.tgz";
      });
      pkgname = "source-map";
    };
    "spdx-correct@3.1.0" = {
      pname = "spdx-correct";
      version = "3.1.0";
      depKeys = [
        ("spdx-expression-parse@3.0.0")
        ("spdx-license-ids@3.0.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kqn8vxnb7s2n1p395cxpg5idyx5acqgw7ihyrn0gghnfhq9jifi";
        url = "https://registry.npmjs.org/spdx-correct/-/spdx-correct-3.1.0.tgz";
      });
      pkgname = "spdx-correct";
    };
    "spdx-exceptions@2.2.0" = {
      pname = "spdx-exceptions";
      version = "2.2.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1aybgrscfb8v8n6g539k2d6ff4v8zd34qig5byj803ds5md8d5xk";
        url = "https://registry.npmjs.org/spdx-exceptions/-/spdx-exceptions-2.2.0.tgz";
      });
      pkgname = "spdx-exceptions";
    };
    "spdx-expression-parse@3.0.0" = {
      pname = "spdx-expression-parse";
      version = "3.0.0";
      depKeys = [
        ("spdx-exceptions@2.2.0")
        ("spdx-license-ids@3.0.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "057j9czqcm7lngldvmk0bgbivpl9x2z0iqma6z5g2zc7kk53136x";
        url = "https://registry.npmjs.org/spdx-expression-parse/-/spdx-expression-parse-3.0.0.tgz";
      });
      pkgname = "spdx-expression-parse";
    };
    "spdx-license-ids@3.0.5" = {
      pname = "spdx-license-ids";
      version = "3.0.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bjd1d65gic7ndbrpp4qvd9620pg901j6pvfs8j40g3h15fvaahf";
        url = "https://registry.npmjs.org/spdx-license-ids/-/spdx-license-ids-3.0.5.tgz";
      });
      pkgname = "spdx-license-ids";
    };
    "split-string@3.1.0" = {
      pname = "split-string";
      version = "3.1.0";
      depKeys = [
        ("extend-shallow@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bx5n7bga42bd5d804w7y06wx96qk524gylxl4xi3i8nb8ch86na";
        url = "https://registry.npmjs.org/split-string/-/split-string-3.1.0.tgz";
      });
      pkgname = "split-string";
    };
    "sprintf-js@1.0.3" = {
      pname = "sprintf-js";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "10qsmbfw9hv4hahsvq79py6v0dddhckwynji2vsr1p18qfy2dyrs";
        url = "https://registry.npmjs.org/sprintf-js/-/sprintf-js-1.0.3.tgz";
      });
      pkgname = "sprintf-js";
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
      src = (pkgs.fetchurl {
        sha256 = "0f885dfxv4nhpgsin60z0iflnbr9wfax9lwbcv4i9j3s7shxsjjw";
        url = "https://registry.npmjs.org/sshpk/-/sshpk-1.16.1.tgz";
      });
      pkgname = "sshpk";
    };
    "ssri@8.0.1" = {
      pname = "ssri";
      version = "8.0.1";
      depKeys = [
        ("minipass@3.1.5")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bibhxd1mhhvvrq80281fv6rwir5p7zkhwwga01gwf1x3kp6zia9";
        url = "https://registry.npmjs.org/ssri/-/ssri-8.0.1.tgz";
      });
      pkgname = "ssri";
    };
    "stack-utils@1.0.2" = {
      pname = "stack-utils";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1iqdciyrrxg8w7r5bswn4lyfi2vvbpi7z6csifjfy359xz3v7sms";
        url = "https://registry.npmjs.org/stack-utils/-/stack-utils-1.0.2.tgz";
      });
      pkgname = "stack-utils";
    };
    "static-extend@0.1.2" = {
      pname = "static-extend";
      version = "0.1.2";
      depKeys = [
        ("define-property@0.2.5")
        ("object-copy@0.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1hwg7diq3kg6q7d2ymj423562yx6nfdqlym538s6ca02zxjgi7nl";
        url = "https://registry.npmjs.org/static-extend/-/static-extend-0.1.2.tgz";
      });
      pkgname = "static-extend";
    };
    "stealthy-require@1.1.1" = {
      pname = "stealthy-require";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "131x1qz4kky2kjsywjfws1sivnx12yw6cmdqmk81f59xsabip7py";
        url = "https://registry.npmjs.org/stealthy-require/-/stealthy-require-1.1.1.tgz";
      });
      pkgname = "stealthy-require";
    };
    "string-length@2.0.0" = {
      pname = "string-length";
      version = "2.0.0";
      depKeys = [
        ("astral-regex@1.0.0")
        ("strip-ansi@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1r7ajkn2ncnbfr5w3px7p94laicz0jgpmd2xm42i5ajccg3cdzb9";
        url = "https://registry.npmjs.org/string-length/-/string-length-2.0.0.tgz";
      });
      pkgname = "string-length";
    };
    "string-width@1.0.2" = {
      pname = "string-width";
      version = "1.0.2";
      depKeys = [
        ("code-point-at@1.1.0")
        ("is-fullwidth-code-point@1.0.0")
        ("strip-ansi@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pg2b50g5l2adc9ph82ci6a41yw0zvy501ldisjj8vfaiknlvrcp";
        url = "https://registry.npmjs.org/string-width/-/string-width-1.0.2.tgz";
      });
      pkgname = "string-width";
    };
    "string-width@2.1.1" = {
      pname = "string-width";
      version = "2.1.1";
      depKeys = [
        ("is-fullwidth-code-point@2.0.0")
        ("strip-ansi@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0b3rb6pbkyg411hvnzb5v5w2vckasgxvslwwijh0p410x46dqz12";
        url = "https://registry.npmjs.org/string-width/-/string-width-2.1.1.tgz";
      });
      pkgname = "string-width";
    };
    "string_decoder@1.1.1" = {
      pname = "string_decoder";
      version = "1.1.1";
      depKeys = [
        ("safe-buffer@5.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0fln2r91b8gj845j7jl76fvsp7nij13fyzvz82985yh88m1n50mg";
        url = "https://registry.npmjs.org/string_decoder/-/string_decoder-1.1.1.tgz";
      });
      pkgname = "string_decoder";
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
    "strip-ansi@4.0.0" = {
      pname = "strip-ansi";
      version = "4.0.0";
      depKeys = [
        ("ansi-regex@3.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0b90ys7pxxbavph56rhfmlymla8f8vaq7fy2pa91dq4r6r3sic5a";
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-4.0.0.tgz";
      });
      pkgname = "strip-ansi";
    };
    "strip-bom@2.0.0" = {
      pname = "strip-bom";
      version = "2.0.0";
      depKeys = [
        ("is-utf8@0.2.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0lq6zn1ihj7vm3kcirgyc3a3mf29cfkqxd3ncng771k5vdix37md";
        url = "https://registry.npmjs.org/strip-bom/-/strip-bom-2.0.0.tgz";
      });
      pkgname = "strip-bom";
    };
    "strip-bom@3.0.0" = {
      pname = "strip-bom";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1qiy06v3aqna30vc9cqzssvfjb13h29w06b9xdksiyppl48lq2a8";
        url = "https://registry.npmjs.org/strip-bom/-/strip-bom-3.0.0.tgz";
      });
      pkgname = "strip-bom";
    };
    "strip-eof@1.0.0" = {
      pname = "strip-eof";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0pcw45dhan54hnd8pkc9jkm5dz2nqhpqblfknvnl8b94445svgpj";
        url = "https://registry.npmjs.org/strip-eof/-/strip-eof-1.0.0.tgz";
      });
      pkgname = "strip-eof";
    };
    "strip-json-comments@2.0.1" = {
      pname = "strip-json-comments";
      version = "2.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "16aq89q4gbs10fgy3a5n5miqphvs1sy44ckk4mf2dxqvmzmmzr6v";
        url = "https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-2.0.1.tgz";
      });
      pkgname = "strip-json-comments";
    };
    "super-resolve@1.0.0" = {
      pname = "super-resolve";
      version = "1.0.0";
      depKeys = [
        ("array-foreach@1.0.2")
        ("array-map@0.0.0")
        ("is-array@1.0.1")
        ("object-keys@1.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0k2r8d3cpvylhjf5vzjxrfl645zr08wl2x46ssyilcjab23rcrx2";
        url = "https://registry.npmjs.org/super-resolve/-/super-resolve-1.0.0.tgz";
      });
      pkgname = "super-resolve";
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
    "supports-color@3.2.3" = {
      pname = "supports-color";
      version = "3.2.3";
      depKeys = [
        ("has-flag@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vlr9grz03rwnis9nnpp4560z2d876cldm5mgqlzw574rjb80lxq";
        url = "https://registry.npmjs.org/supports-color/-/supports-color-3.2.3.tgz";
      });
      pkgname = "supports-color";
    };
    "supports-color@5.5.0" = {
      pname = "supports-color";
      version = "5.5.0";
      depKeys = [
        ("has-flag@3.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ap0lk4n0m3948cnkfmyz71pizqlzjdfrhs0f954pksg4jnk52h5";
        url = "https://registry.npmjs.org/supports-color/-/supports-color-5.5.0.tgz";
      });
      pkgname = "supports-color";
    };
    "symbol-tree@3.2.4" = {
      pname = "symbol-tree";
      version = "3.2.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1g2ap5vvjzp141idqnd5vpn3hzy3ihwr8vqivyxdn2yh00570sca";
        url = "https://registry.npmjs.org/symbol-tree/-/symbol-tree-3.2.4.tgz";
      });
      pkgname = "symbol-tree";
    };
    "tar-fs@1.16.3" = {
      pname = "tar-fs";
      version = "1.16.3";
      depKeys = [
        ("chownr@1.1.2")
        ("mkdirp@0.5.1")
        ("pump@1.0.3")
        ("tar-stream@1.6.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "00063xk10kf0vwf3nv7w2giz9jascf92drj37yq69gacsnzyq3jr";
        url = "https://registry.npmjs.org/tar-fs/-/tar-fs-1.16.3.tgz";
      });
      pkgname = "tar-fs";
    };
    "tar-stream@1.6.2" = {
      pname = "tar-stream";
      version = "1.6.2";
      depKeys = [
        ("bl@1.2.2")
        ("buffer-alloc@1.2.0")
        ("end-of-stream@1.4.1")
        ("fs-constants@1.0.0")
        ("readable-stream@2.3.6")
        ("to-buffer@1.1.1")
        ("xtend@4.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dg2skxjr5vmwc36kdr1638nfnc1rlknk89kix2vqmcyr7ddlfi7";
        url = "https://registry.npmjs.org/tar-stream/-/tar-stream-1.6.2.tgz";
      });
      pkgname = "tar-stream";
    };
    "tar@4.4.10" = {
      pname = "tar";
      version = "4.4.10";
      depKeys = [
        ("chownr@1.1.2")
        ("fs-minipass@1.2.6")
        ("minipass@2.3.5")
        ("minizlib@1.2.1")
        ("mkdirp@0.5.1")
        ("safe-buffer@5.2.0")
        ("yallist@3.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "001z6dmz959giwwnmxxar735zhzxi2jw0ya4v5gjg280rdvwfbcj";
        url = "https://registry.npmjs.org/tar/-/tar-4.4.10.tgz";
      });
      pkgname = "tar";
    };
    "tar@6.1.11" = {
      pname = "tar";
      version = "6.1.11";
      depKeys = [
        ("chownr@2.0.0")
        ("fs-minipass@2.1.0")
        ("minipass@3.1.5")
        ("minizlib@2.1.2")
        ("mkdirp@1.0.4")
        ("yallist@4.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "131l7k28di5w0a17kvy7gzqp1mm8vlya38k21wmbmmqji77jcfv5";
        url = "https://registry.npmjs.org/tar/-/tar-6.1.11.tgz";
      });
      pkgname = "tar";
    };
    "test-exclude@4.2.3" = {
      pname = "test-exclude";
      version = "4.2.3";
      depKeys = [
        ("arrify@1.0.1")
        ("micromatch@2.3.11")
        ("object-assign@4.1.1")
        ("read-pkg-up@1.0.1")
        ("require-main-filename@1.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1pywwwlkr32az94v87a27xxxyd1ca740cclkb2qc03fa663lzmry";
        url = "https://registry.npmjs.org/test-exclude/-/test-exclude-4.2.3.tgz";
      });
      pkgname = "test-exclude";
    };
    "throat@4.1.0" = {
      pname = "throat";
      version = "4.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "06vsbsqrlxz9k3wpm96h5dbzygzjm1pqcd0733nnxv25k82g2x3l";
        url = "https://registry.npmjs.org/throat/-/throat-4.1.0.tgz";
      });
      pkgname = "throat";
    };
    "tmp@0.0.33" = {
      pname = "tmp";
      version = "0.0.33";
      depKeys = [
        ("os-tmpdir@1.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ifn24mp4ds8yx9i79739gsdsj5ml6vzx8v3w5vg0m74dig22fyj";
        url = "https://registry.npmjs.org/tmp/-/tmp-0.0.33.tgz";
      });
      pkgname = "tmp";
    };
    "tmpl@1.0.4" = {
      pname = "tmpl";
      version = "1.0.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1s09g3dm76wr92rn5d4j0n3mb06hmw2n0pqff08s2ly2fxxscf74";
        url = "https://registry.npmjs.org/tmpl/-/tmpl-1.0.4.tgz";
      });
      pkgname = "tmpl";
    };
    "to-buffer@1.1.1" = {
      pname = "to-buffer";
      version = "1.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0m3swhwpzicdsmn6m7hhzammn6skbvlfv4ixl7wda905j2nv4xc1";
        url = "https://registry.npmjs.org/to-buffer/-/to-buffer-1.1.1.tgz";
      });
      pkgname = "to-buffer";
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
    "to-object-path@0.3.0" = {
      pname = "to-object-path";
      version = "0.3.0";
      depKeys = [
        ("kind-of@3.2.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "01n40v8xlqm635rp6cyz0jpw6295wm9fkr6m85nqcf457rfbqc68";
        url = "https://registry.npmjs.org/to-object-path/-/to-object-path-0.3.0.tgz";
      });
      pkgname = "to-object-path";
    };
    "to-regex-range@2.1.1" = {
      pname = "to-regex-range";
      version = "2.1.1";
      depKeys = [
        ("is-number@3.0.0")
        ("repeat-string@1.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0rw8mjvncwxhyg5m7mzwqg16ddpyq5qzdwds0v0jnskqhklh14bq";
        url = "https://registry.npmjs.org/to-regex-range/-/to-regex-range-2.1.1.tgz";
      });
      pkgname = "to-regex-range";
    };
    "to-regex@3.0.2" = {
      pname = "to-regex";
      version = "3.0.2";
      depKeys = [
        ("define-property@2.0.2")
        ("extend-shallow@3.0.2")
        ("regex-not@1.0.2")
        ("safe-regex@1.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "039l28qygjrjy10jz9cm3j066nw5fkfimzkp5ipq47w2pl2ii0w6";
        url = "https://registry.npmjs.org/to-regex/-/to-regex-3.0.2.tgz";
      });
      pkgname = "to-regex";
    };
    "tough-cookie@2.4.3" = {
      pname = "tough-cookie";
      version = "2.4.3";
      depKeys = [
        ("psl@1.2.0")
        ("punycode@1.4.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0lx248q5fkzpxks378hckl597sb755rnq4jpwd3p7m941mpm9gw7";
        url = "https://registry.npmjs.org/tough-cookie/-/tough-cookie-2.4.3.tgz";
      });
      pkgname = "tough-cookie";
    };
    "tough-cookie@2.5.0" = {
      pname = "tough-cookie";
      version = "2.5.0";
      depKeys = [
        ("psl@1.2.0")
        ("punycode@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0knsdm6l5mn88rh78hajzr2rrydal6wf97l2pbpqjq8ws4w8gazh";
        url = "https://registry.npmjs.org/tough-cookie/-/tough-cookie-2.5.0.tgz";
      });
      pkgname = "tough-cookie";
    };
    "tr46@1.0.1" = {
      pname = "tr46";
      version = "1.0.1";
      depKeys = [
        ("punycode@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1g2x0gyxqm09zlk2mcay4h0nxnwhi5gjwhmaimbxmp6c44cfq1np";
        url = "https://registry.npmjs.org/tr46/-/tr46-1.0.1.tgz";
      });
      pkgname = "tr46";
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
    "tunnel-agent@0.6.0" = {
      pname = "tunnel-agent";
      version = "0.6.0";
      depKeys = [
        ("safe-buffer@5.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "04jhbjld99zavh1rvik2bayrgxwj2zx69xsbcm0gmlnna15c1qyk";
        url = "https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.6.0.tgz";
      });
      pkgname = "tunnel-agent";
    };
    "tweetnacl@0.14.5" = {
      pname = "tweetnacl";
      version = "0.14.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1mnzrxlww1sqwv493gn6ph9ak7n8l9w5qrahsa5kzn4vgbb37skc";
        url = "https://registry.npmjs.org/tweetnacl/-/tweetnacl-0.14.5.tgz";
      });
      pkgname = "tweetnacl";
    };
    "type-check@0.3.2" = {
      pname = "type-check";
      version = "0.3.2";
      depKeys = [
        ("prelude-ls@1.1.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "05iwxwj2sdbnxwp5lkxrdkbdcdvmkvq6zbq7lmsg20zbw3pyy56l";
        url = "https://registry.npmjs.org/type-check/-/type-check-0.3.2.tgz";
      });
      pkgname = "type-check";
    };
    "uglify-js@3.6.0" = {
      pname = "uglify-js";
      version = "3.6.0";
      depKeys = [
        ("commander@2.20.0")
        ("source-map@0.6.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0jmi519rcx3jadrabdfk07mw2qm3df88lb552748y36wlp4m0dwj";
        url = "https://registry.npmjs.org/uglify-js/-/uglify-js-3.6.0.tgz";
      });
      pkgname = "uglify-js";
    };
    "union-value@1.0.1" = {
      pname = "union-value";
      version = "1.0.1";
      depKeys = [
        ("arr-union@3.1.0")
        ("get-value@2.0.6")
        ("is-extendable@0.1.1")
        ("set-value@2.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "00rjw4hvxnj5vrji9qzbxn6y9rx6av1q3nv8ilyxpska3q0zpj75";
        url = "https://registry.npmjs.org/union-value/-/union-value-1.0.1.tgz";
      });
      pkgname = "union-value";
    };
    "unique-filename@1.1.1" = {
      pname = "unique-filename";
      version = "1.1.1";
      depKeys = [
        ("unique-slug@2.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1dcfh15m1cjiqm4fapjws8inzydklx3jhbaflma2qcx7s9ax14av";
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
        sha256 = "1z85ywz4zz0g8b8l2mkcn70yli30w7zj424hlikdymxb5k6ifvxl";
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
        sha256 = "0lykbpkmvjkjg0sqngrn086rxlyddgjkfnsi22r8hgixxzxb2alc";
        url = "https://registry.npmjs.org/universalify/-/universalify-0.1.2.tgz";
      });
      pkgname = "universalify";
    };
    "unset-value@1.0.0" = {
      pname = "unset-value";
      version = "1.0.0";
      depKeys = [
        ("has-value@0.3.1")
        ("isobject@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "11jj8ggkz8c54sf0zyqwlnwv89i5gj572ywbry7ispy6lqa84qsk";
        url = "https://registry.npmjs.org/unset-value/-/unset-value-1.0.0.tgz";
      });
      pkgname = "unset-value";
    };
    "uri-js@4.2.2" = {
      pname = "uri-js";
      version = "4.2.2";
      depKeys = [
        ("punycode@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1bppdmqj9ajmsr8vsas1ipnjvigsf11l5nzg5k49vaz0vc7klbps";
        url = "https://registry.npmjs.org/uri-js/-/uri-js-4.2.2.tgz";
      });
      pkgname = "uri-js";
    };
    "urix@0.1.0" = {
      pname = "urix";
      version = "0.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "19qmq8cra96cf7ji8d4ljfcgnazzrvw4lcxlf91jk1816ndx1pbm";
        url = "https://registry.npmjs.org/urix/-/urix-0.1.0.tgz";
      });
      pkgname = "urix";
    };
    "use@3.1.1" = {
      pname = "use";
      version = "3.1.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1nqrazqb927s0nma2qi2c3aambpy34krz8cgl6610n456zg5vjin";
        url = "https://registry.npmjs.org/use/-/use-3.1.1.tgz";
      });
      pkgname = "use";
    };
    "util-deprecate@1.0.2" = {
      pname = "util-deprecate";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1rd3qbgdrwkmcrf7vqx61sh7icma7jvxcmklqj032f8v7jcdx8br";
        url = "https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz";
      });
      pkgname = "util-deprecate";
    };
    "util.promisify@1.0.0" = {
      pname = "util.promisify";
      version = "1.0.0";
      depKeys = [
        ("define-properties@1.1.3")
        ("object.getownpropertydescriptors@2.0.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "00jwgzmirr1xfsdb5k7bsckscjf27dbb7v8cp1sdvfaahvxzrprz";
        url = "https://registry.npmjs.org/util.promisify/-/util.promisify-1.0.0.tgz";
      });
      pkgname = "util.promisify";
    };
    "uuid@3.3.2" = {
      pname = "uuid";
      version = "3.3.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0s7fnkwanv1w642lckg07fb4b64fli94ic7kx8yqbxixp3wqypsh";
        url = "https://registry.npmjs.org/uuid/-/uuid-3.3.2.tgz";
      });
      pkgname = "uuid";
    };
    "validate-npm-package-license@3.0.4" = {
      pname = "validate-npm-package-license";
      version = "3.0.4";
      depKeys = [
        ("spdx-correct@3.1.0")
        ("spdx-expression-parse@3.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "137xfxkycbb0cp1gxxmc1mff6jrihkzzhx9avza338a19nryyrh1";
        url = "https://registry.npmjs.org/validate-npm-package-license/-/validate-npm-package-license-3.0.4.tgz";
      });
      pkgname = "validate-npm-package-license";
    };
    "verror@1.10.0" = {
      pname = "verror";
      version = "1.10.0";
      depKeys = [
        ("assert-plus@1.0.0")
        ("core-util-is@1.0.2")
        ("extsprintf@1.4.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0swyg46nvq95xlrrjjbhhmhjrdxg19yrc1aj69zipck0vi24b6q1";
        url = "https://registry.npmjs.org/verror/-/verror-1.10.0.tgz";
      });
      pkgname = "verror";
    };
    "w3c-hr-time@1.0.1" = {
      pname = "w3c-hr-time";
      version = "1.0.1";
      depKeys = [
        ("browser-process-hrtime@0.1.3")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1r10610ing2iq91dw68zfnr7hhcqy9vw986pqhkkgi2phwrw9snf";
        url = "https://registry.npmjs.org/w3c-hr-time/-/w3c-hr-time-1.0.1.tgz";
      });
      pkgname = "w3c-hr-time";
    };
    "walker@1.0.7" = {
      pname = "walker";
      version = "1.0.7";
      depKeys = [
        ("makeerror@1.0.11")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1hlx0xp2lvgnmiv6k8rqn3rnyd6jqdap1378bkl5nsfgkp5bggs8";
        url = "https://registry.npmjs.org/walker/-/walker-1.0.7.tgz";
      });
      pkgname = "walker";
    };
    "watch@0.18.0" = {
      pname = "watch";
      version = "0.18.0";
      depKeys = [
        ("exec-sh@0.2.2")
        ("minimist@1.2.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0si4qxch89jxgvqka8mv08nrgr3v0cbyhf4by0biydj8z4apdpqw";
        url = "https://registry.npmjs.org/watch/-/watch-0.18.0.tgz";
      });
      pkgname = "watch";
    };
    "webidl-conversions@4.0.2" = {
      pname = "webidl-conversions";
      version = "4.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "128hg4ghkc3a0agi2m73i5ly5acifbks21y788jffnrghl9jxkf6";
        url = "https://registry.npmjs.org/webidl-conversions/-/webidl-conversions-4.0.2.tgz";
      });
      pkgname = "webidl-conversions";
    };
    "whatwg-encoding@1.0.5" = {
      pname = "whatwg-encoding";
      version = "1.0.5";
      depKeys = [
        ("iconv-lite@0.4.24")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0n6a241xc18cjfm2dhhv00v19f5da6d90gyvygzdnqc8v0fzil24";
        url = "https://registry.npmjs.org/whatwg-encoding/-/whatwg-encoding-1.0.5.tgz";
      });
      pkgname = "whatwg-encoding";
    };
    "whatwg-mimetype@2.3.0" = {
      pname = "whatwg-mimetype";
      version = "2.3.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1ysy27vwlm149n2kdx0p8mi39vfp9gvj7z1070czdq3xw5xhzns8";
        url = "https://registry.npmjs.org/whatwg-mimetype/-/whatwg-mimetype-2.3.0.tgz";
      });
      pkgname = "whatwg-mimetype";
    };
    "whatwg-url@6.5.0" = {
      pname = "whatwg-url";
      version = "6.5.0";
      depKeys = [
        ("lodash.sortby@4.7.0")
        ("tr46@1.0.1")
        ("webidl-conversions@4.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1pgql3v7bm76qib59jcng1q614l7kkwxvd164hszws3xlj15bfl5";
        url = "https://registry.npmjs.org/whatwg-url/-/whatwg-url-6.5.0.tgz";
      });
      pkgname = "whatwg-url";
    };
    "whatwg-url@7.0.0" = {
      pname = "whatwg-url";
      version = "7.0.0";
      depKeys = [
        ("lodash.sortby@4.7.0")
        ("tr46@1.0.1")
        ("webidl-conversions@4.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0d00bkyxx18jb5wyx8wk7dgg6ygqkchl8xkzv57h5dpmhq6lfq14";
        url = "https://registry.npmjs.org/whatwg-url/-/whatwg-url-7.0.0.tgz";
      });
      pkgname = "whatwg-url";
    };
    "which-module@2.0.0" = {
      pname = "which-module";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1si822gi00hkvx9ny5mqb202jmi1xskk20hlrw53dygbw7xi5gsg";
        url = "https://registry.npmjs.org/which-module/-/which-module-2.0.0.tgz";
      });
      pkgname = "which-module";
    };
    "which@1.3.1" = {
      pname = "which";
      version = "1.3.1";
      depKeys = [
        ("isexe@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "077d08k2zz1zhn5nc09m4vkiz2hjfk2lp02a3kphhianj3b26rcn";
        url = "https://registry.npmjs.org/which/-/which-1.3.1.tgz";
      });
      pkgname = "which";
    };
    "which@2.0.2" = {
      pname = "which";
      version = "2.0.2";
      depKeys = [
        ("isexe@2.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1p2fkm4lr36s85gdjxmyr6wh86dizf0iwmffxmarcxpbvmgxyfm1";
        url = "https://registry.npmjs.org/which/-/which-2.0.2.tgz";
      });
      pkgname = "which";
    };
    "wide-align@1.1.3" = {
      pname = "wide-align";
      version = "1.1.3";
      depKeys = [
        ("string-width@2.1.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1xdhvcq22hfnfll6fvc7j9brqhr45p4h2b3zw58df7925cdh99vx";
        url = "https://registry.npmjs.org/wide-align/-/wide-align-1.1.3.tgz";
      });
      pkgname = "wide-align";
    };
    "wordwrap@0.0.3" = {
      pname = "wordwrap";
      version = "0.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x72ga8xs61rxq5abpsvswn49nlvrym1b0zag337fhv4kjcwv7s1";
        url = "https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.3.tgz";
      });
      pkgname = "wordwrap";
    };
    "wordwrap@1.0.0" = {
      pname = "wordwrap";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0f08g3gb6si97h2faw175isf8k7hjbnw5rr2bm4wcr1141lzd0f3";
        url = "https://registry.npmjs.org/wordwrap/-/wordwrap-1.0.0.tgz";
      });
      pkgname = "wordwrap";
    };
    "wrap-ansi@2.1.0" = {
      pname = "wrap-ansi";
      version = "2.1.0";
      depKeys = [
        ("string-width@1.0.2")
        ("strip-ansi@3.0.1")
      ];
      src = (pkgs.fetchurl {
        sha256 = "141l2bc9shm7rfzh0g46i92q6x032k02qb1z7625j4nxilx6i72f";
        url = "https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-2.1.0.tgz";
      });
      pkgname = "wrap-ansi";
    };
    "wrappy@1.0.2" = {
      pname = "wrappy";
      version = "1.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1yzx63jf27yz0bk0m78vy4y1cqzm113d2mi9h91y3cdpj46p7wxg";
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
      });
      pkgname = "wrappy";
    };
    "write-file-atomic@2.4.3" = {
      pname = "write-file-atomic";
      version = "2.4.3";
      depKeys = [
        ("graceful-fs@4.2.0")
        ("imurmurhash@0.1.4")
        ("signal-exit@3.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0zbyl63kwdczr9liivfl5q7r8dsjx2g5nq0c7k7iyga5lbn8q57n";
        url = "https://registry.npmjs.org/write-file-atomic/-/write-file-atomic-2.4.3.tgz";
      });
      pkgname = "write-file-atomic";
    };
    "ws@5.2.2" = {
      pname = "ws";
      version = "5.2.2";
      depKeys = [
        ("async-limiter@1.0.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1zb9swmylqy2biwa97xkfiq5v7smal17y1mixpa686hpv7i5l9zw";
        url = "https://registry.npmjs.org/ws/-/ws-5.2.2.tgz";
      });
      pkgname = "ws";
    };
    "xml-name-validator@3.0.0" = {
      pname = "xml-name-validator";
      version = "3.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1gaj2d1lzv0sdms1sn3avasy04d4j9bbizfdyl7p72m52n0d31c4";
        url = "https://registry.npmjs.org/xml-name-validator/-/xml-name-validator-3.0.0.tgz";
      });
      pkgname = "xml-name-validator";
    };
    "xml@1.0.1" = {
      pname = "xml";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "08x60jmp9gjy028cvavf3a41mkk1cxgda7p35rxl487s07bjn0rq";
        url = "https://registry.npmjs.org/xml/-/xml-1.0.1.tgz";
      });
      pkgname = "xml";
    };
    "xtend@4.0.2" = {
      pname = "xtend";
      version = "4.0.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0j5s840a0a3mjzxixr95jpila80kbdvrxyixnmxvx6f78cfs08mx";
        url = "https://registry.npmjs.org/xtend/-/xtend-4.0.2.tgz";
      });
      pkgname = "xtend";
    };
    "y18n@3.2.1" = {
      pname = "y18n";
      version = "3.2.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0h978r8qp7aiims0dx5a7f71f92blnbqbaiwgf20c8b45pki4x2d";
        url = "https://registry.npmjs.org/y18n/-/y18n-3.2.1.tgz";
      });
      pkgname = "y18n";
    };
    "yallist@2.1.2" = {
      pname = "yallist";
      version = "2.1.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "1cmhmkw7cf9h92pnv4pzm488zkdnrrc8xhj69cqifpjjsf211cy7";
        url = "https://registry.npmjs.org/yallist/-/yallist-2.1.2.tgz";
      });
      pkgname = "yallist";
    };
    "yallist@3.0.3" = {
      pname = "yallist";
      version = "3.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0x4ihkady5jp8d9pis948yw32yqs6mjdv0i36zxicc56zxl3cldj";
        url = "https://registry.npmjs.org/yallist/-/yallist-3.0.3.tgz";
      });
      pkgname = "yallist";
    };
    "yallist@4.0.0" = {
      pname = "yallist";
      version = "4.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        sha256 = "0jadz9mh1lzfk19bvqqlrg40ggfk2yyfyrpgj5c62dk54ym7h358";
        url = "https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz";
      });
      pkgname = "yallist";
    };
    "yargs-parser@9.0.2" = {
      pname = "yargs-parser";
      version = "9.0.2";
      depKeys = [
        ("camelcase@4.1.0")
      ];
      src = (pkgs.fetchurl {
        sha256 = "1vcn7x29rrial3a1kyvsfrjv44zn4kamzsqig54qfxfw35i485ym";
        url = "https://registry.npmjs.org/yargs-parser/-/yargs-parser-9.0.2.tgz";
      });
      pkgname = "yargs-parser";
    };
    "yargs@11.1.0" = {
      pname = "yargs";
      version = "11.1.0";
      depKeys = [
        ("cliui@4.1.0")
        ("decamelize@1.2.0")
        ("find-up@2.1.0")
        ("get-caller-file@1.0.3")
        ("os-locale@2.1.0")
        ("require-directory@2.1.1")
        ("require-main-filename@1.0.1")
        ("set-blocking@2.0.0")
        ("string-width@2.1.1")
        ("which-module@2.0.0")
        ("y18n@3.2.1")
        ("yargs-parser@9.0.2")
      ];
      src = (pkgs.fetchurl {
        sha256 = "0kk5yyxscgnh486a9bhxn16r0fgs0wf7sppai21nqzlnylbw9yb5";
        url = "https://registry.npmjs.org/yargs/-/yargs-11.1.0.tgz";
      });
      pkgname = "yargs";
    };
  };
}