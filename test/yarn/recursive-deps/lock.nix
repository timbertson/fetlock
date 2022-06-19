final:
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
        hash = "sha512-TIGnTpdo+E3+pCyAluZvtED5p5wCqLdezCyhPZzKPcxvFplEt4i+W7OONCKgeZFT3+y5NZZfOOS/Bdcanm1MYA==";
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
        hash = "sha512-kmCevFghRiWM7HB5zTPULl4r9bVFSWjz62MhqizDGUrq2NWuNMQyuv4tHHoKJHs69M/MF64lEcHdYIocrdWQYA==";
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
        hash = "sha512-XqYMR2dfdGMW+hd0IUZ2PwK+fGeFkOxZJ0wY+JaQAHzt1Zx8LcvpiZD2NiGkEG8qx0CfkAOr5xt76d1e8vG90g==";
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
        hash = "sha512-6jyFLuDmeidKmUEb3NM+/yawG0M2bDZ9Z1qbZP59cyHLz8kYGKYwpJP0UwUKKUiTRNvxfLesJnTedqczP7cTDA==";
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
        hash = "sha512-HyfwY6ApZj7BYTcJURpM5tznulaBvyio7/0d4zFOeMPUmfxkCjHocCuoLa2SAGzBI8AREcH3eP3758F672DppA==";
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
        hash = "sha512-n7pFrqQm44TCYvrCDb0MqabAF+JUBq+ijBvNMUxpkLjJaAu32faIexewMumrH5KLLJ1HDyT0PTEqRyAe/GwwuQ==";
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
        hash = "sha512-Bl3ZiA+LjqaMtNYopA9TYE9HP1tQ+E5dLxE0XrAzcIJeK2UqF0/EaqXwBn9esd4UmTfEab+P+UYQ1GnioFIb/w==";
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
        hash = "sha512-veliHlHX06wjaeY8xNITbveXSiI+ASFnOqvne/LaIJIqOWi2Ogmj91KOugEz/hoh/fwMhXNBJPCv8Xaz5CyM4A==";
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
        hash = "sha512-ITKNuq2wKlW1fJg9sSW52eepoYgZBggvOAHC0u/CYu/qxQ9EVzThCgR69BnSXLHjy2f7SY5zaQ4yt7H9ZVxY2g==";
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
        hash = "sha512-PCOcLFW7/eazGUKIoqH97sO9A2UYMahsn/yRQ7uOk37iutwjq7ODtcTNF+iFDSHNfkctqsLRjLP7URnOx0T1fg==";
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
        hash = "sha512-iSxeXx7apsjCHe9c7n8VtRXGzI2Bk1rBSOJgCCjfyXb6v1aCqE1KSEpq/8SXuVN8Ka/Rh1WDTF0MDzkvTA4MIA==";
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
        hash = "sha512-zhe3V/26rCWsEZK8kZN+HaQj5yQ1CilTObixFzKW1UWjqG7618Twz6YEsCnjfg5gBcJh02DrpCkS9h98ZqDY+g==";
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
        hash = "sha512-q/UEjfGJ2Cm3oKV71DJz9d25TPnq5rhBVL2Q4fA5wcC3jcrdn7+SssEybFIxwAvvP+YCsCYNKughoF33GxgycQ==";
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
        hash = "sha512-3oSeUO0TMV67hN1AmbXsK4yaqU7tjiHlbxRDZOpH0KW9+CeX4bRAaX0Anxt0tx2MrpRpWwQaPwIlISEJhYU5Pw==";
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
        hash = "sha512-iCuPHDFgrHX7H2vEI/5xpz07zSHB00TpugqhmYtVmMO6518mCuRMoOYFldEBl0g187ufozdaHgWKcYFb61qGiA==";
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
        hash = "sha512-U3lRVLMSlsCfjqYPbLyVv11M9CPW4I728d6TCKMAOJueEeB9/8o+eSsMnxPJD+Q+K909sdESg7C+tIkoH6on1A==";
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
        hash = "sha512-/Srv4dswyQNBfohGpz9o6Yb3Gz3SrUDqBH5rTuhGR7ahtlbYKnVxw2bCFMRljaA7EXHaXZ8wsHdodFvbkhKmqg==";
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
        hash = "sha512-+OQdjP49zViI/6i7nIJpA8rAl4sV/JdPfU9nZs3VqOwGIgizICvuN2ru6fMd+4llL0tar18UYJXfZ/TWtmhUjA==";
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
        hash = "sha512-Kb2wC0fvsWfQrgk8HU5lW6U/Lcs8+9aaYcy4ZFc6DDlo4nZ7n70dEgE5rtR0oG6ufKDUnrwfWL1mXR5ljDatrQ==";
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
        hash = "sha512-bC7ElrdJaJnPbAP+1EotYvqZsb3ecl5wi6Bfi6BJTUcNowp6cvspg0jXznRTKDjm/E7AdgFBVeAPVMNcKGsHMA==";
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
        hash = "sha512-BDKtmHlOzwI7iRuEkhzsnPoi5ypEhWAJB5RvHWe1kMr06js3uK5B3734i3ui5Yd+wOJV1cpE4JnivPD283GU/A==";
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
        hash = "sha512-vbRorB5FUQWvla16U8R/qgaFIya2qGzwDrNmCZuYKrbdSUMG6I1ZCGQRefkRVhuOkIGVne7BQ35DSfo1qvJqFg==";
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
        hash = "sha512-kVscqXk4OCp68SZ0dkgEKVi6/8ij300KBWTJq32P/dYeWTSwK41WyTxalN1eRmA5Z9UU/LX9D7FWSmV9SAYx6g==";
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
        hash = "sha512-S0nG3CLEQiY/ILxqtztTWH/3iRRdyBLw6KMDxnKMchrtbj2OFmehVh0WUCfW3DUrIgx/qFrJPICrq4Z4sTR9UQ==";
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
        hash = "sha512-C8vBJ8DwUCx19vhm7urhTuUsr4/IyP6l4VzNQDv+ryHQObW3TTTp9yB68WpYgRe2bbaGuZ/se74IqFeVnMnLZg==";
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
        hash = "sha512-ycURW7oUxE2sNiPVw1HVEFsW+ecOpJ5zaj7eC0RlwhibhRBod20muUN8qu/gzx956YrLolVvs1MTXwKgC2rVEg==";
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
        hash = "sha512-phJfQVBuaJM5raOpJjSfkiD6BpbCE4Ns//LaXl6wGYtUBY83nWS6Rf9tXm2e8VaK60JEjYldbPif/A2B1C2gNA==";
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
        hash = "sha512-cdyMtqX/BOqqNBBiKlIVkytNHm49MtMlYyn1zxzvJKWmFMlGzm+ry5BBfYyeY9YmNKbRSo/o7OX9w9ale0wg3w==";
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
        hash = "sha512-RjTcuD4xjtthQkaWH7dFlH85L+QaVtSoOyGdZ3g6HFhS9dFNDfLyqgm2NFe2X6cQpeFmt0452FJjFG5UameExg==";
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
        hash = "sha512-RdJUflcE3cUzKiMqQgsCu06FPu9UdIJO0beYbPhHN4k6apgJtifcoCtT9bcxOpYBtpD2kCM6Sbzg4CausW/PKQ==";
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
        hash = "sha512-Mke0DA0QjUWuJlhsE0ZPPhYiJkRap642SmI/4ztCFaUs6V2AiH1sfecc+57NgaryfAA2VR3v6O+CSjC1jZJKOA==";
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
        hash = "sha512-4xrs1aW+6N5DalkqSVA8fxh458CXvR99WU8WLKmq4v8eWAL86Xo3BVqyd3SkA9wEVjCMqyvvRRkshAdOnBp5rw==";
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
        hash = "sha512-v2kDEe57lecTulaDIuNTPy3Ry4gLGJ6Z1O3vE1krgXZNrsQ+LFTGHVxVjcXPs17LhbZVGedAJv8XZ1tvj5FvSg==";
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
        hash = "sha512-lyuxPGr/Wfhrlem2CL/UcnUc1zcqKAImBDzukY7Y5F/yQiNdko6+fRLevlw1HgMySw7f611UIY408EtxRSoK3Q==";
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
    "ms@2.0.0" = {
      pname = "ms";
      version = "2.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha512-Tpp60P6IUJDTuOq/5Z8cdskzJujfwqfOTkrwIwj7IRISpnkJnT6SyJ4PCPnGMoFjC9ddhal5KVIYtAt97ix05A==";
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
        hash = "sha512-B5JU3cabzk8c67mRRd3ECmROafjYMXbuzlwtqdM8IbS8ktlTix8aFGb2bAGKrSRIlnfKwovGUUr72JUPyOb6kQ==";
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
        hash = "sha512-D2FR03Vir7FIu45XBY20mTb+/ZSWB00sjU9jdQXt83gDrI4Ztz5Fs7/yy74g2N5SVQY4xY1qDr4rNddwYRVX0g==";
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
        hash = "sha512-AVbw3UJ2e9bq64vSaS9Am0fje1Pa8pbGqTTsmXfaIiMpnr5DlDhfJOuLj9Sf95ZPVDAUerDfEk88MPmPe7UCQg==";
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
        hash = "sha512-VvivMrbvd2nKkiG38qjULzlc+4Vx4wm/whI9pQD35YrARNnhxeiRktSOhSukRLFNlzg6Br/cJPet5J/u19r/mg==";
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
      src = (final.pathSrc ../.);
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
        hash = "sha512-MguG95oij0fC3QV3URf4V2SDYGJhJnJGqvIIgdECeODCT98wSWDAJ94SSuVpYQUoTcGUIL6L4yNB7j1DFFHSBg==";
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
        hash = "sha512-ZqtSMuVybkISo2OWvqvm7iHSWngvdaW3IpsT9/uP8v4gMi591LY6h35wdOfvQdWCKFWZWm2Y1Opp4kV7vQKT6A==";
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
        hash = "sha512-Gd2UZBJDkXlY7GbJxfsE8/nvKkUEU1G38c1siN6QP6a9PT9MmHB8GnpscSmMJSoF8LOIrt8ud/wPtojys4G6+g==";
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
        hash = "sha512-3TYDR7xWt4dIqV2JauJr+EJeW356RXijHeUlO+8djJ+uBXPn8/2dpzBc8yQhh583sVvc9CvFAeQVgijsH+PNNg==";
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
        hash = "sha512-try0/JqxPLF9nOjvSta7tVondkP5dwgyLDjVoyMDlmjugT2lRZ1OfsrYTkCd2hkDnJTKRbO/Rl3orm8vlsUzbA==";
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
        hash = "sha512-LbrmJOMUSdEVxIKvdcJzQC+nQhe8FUZQTXQy6+I75skNgn3OoQ0DZA8YnFa7gp8tqtL3KPf1kmo0R5DoApeSGQ==";
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
        hash = "sha512-VhumSSbBqDTP8p2ZLKj40UjBCV4+v8bUSEpUb4KjRgWk9pbqGF4REFj6KEagidb2f/M6AzC0EmFyDNGaw9OCzg==";
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
        hash = "sha512-KKNVtd6pCYgPIKU4cp2733HWYCpplQhddZLBUryaAHou723x+FRzQ5Df824Fj+IyyuiQTRoub4SnIFfIcrp70g==";
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
        hash = "sha512-lxrWP8ejsq+7E3nNjwYmUBMAgjMTZoTI+sdBOpvNyijeDLa29LUn9QaoXAHv4+Z578hbmHHJKZknzxVtvo77og==";
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
        hash = "sha512-WZGXGstmCWgeevgTL54hrCuw1dyMQIzWy7ZfqRJfSmJZBwklI15egmQytFP6bPidmw3M8d5yEowl1niq4vmqZw==";
        url = "https://registry.npmjs.org/trim-right/-/trim-right-1.0.1.tgz";
      });
      pkgname = "trim-right";
    };
  };
}