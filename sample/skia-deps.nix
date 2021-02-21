{ fetchgit ? (import <nixpkgs> {}).fetchgit }:
{
  angle2 = fetchgit {
    url = "https://chromium.googlesource.com/angle/angle.git";
    rev = "b001528ffa00e7c15a5002124f707570e59a5697";
    sha256 = "0i8s4zacf7s4kkglk90xwpmdvnly2gwa2ljbvw01nq2zl7mw4xb1";
  };
  dng_sdk = fetchgit {
    url = "https://android.googlesource.com/platform/external/dng_sdk.git";
    rev = "96443b262250c390b0caefbf3eed8463ba35ecae";
    sha256 = "1rsr7njhj7c5p87hfznj069fdc3qqhvvnq9sa2rb8c4q849rlzx6";
  };
  expat = fetchgit {
    url = "https://android.googlesource.com/platform/external/expat.git";
    rev = "android-6.0.1_r55";
    sha256 = "01440savlf78rra2rd5fsdrpk55fdv0kb57n728k3y7b4x6h3ycb";
  };
  freetype = fetchgit {
    url = "https://skia.googlesource.com/third_party/freetype2.git";
    rev = "fa6da7bf6dcbcfa22d2464259ad1cccee3233189";
    sha256 = "0izacky9yr2gsxf5hyq5d2npqp91l8m0m8ggps40dv3m087lw4rw";
  };
  googletest = fetchgit {
    url = "https://android.googlesource.com/platform/external/googletest";
    rev = "dd43b9998e9a44a579a7aba6c1309407d1a5ed95";
    sha256 = "0y4r8x8zx2l3sjhlr5l70ws56mqzcmlpdn98wihvbakaxbfgispr";
  };
  harfbuzz = fetchgit {
    url = "https://skia.googlesource.com/third_party/harfbuzz.git";
    rev = "1.4.2";
    sha256 = "17isi1fasd6m466gmw254bqxqkbb91v7lli8y7cxilh5sm35f4k8";
  };
  icu = fetchgit {
    url = "https://chromium.googlesource.com/chromium/deps/icu.git";
    rev = "ec9c1133693148470ffe2e5e53576998e3650c1d";
    sha256 = "1x92ja0a89pb7xpf00d0hbza7gg2nm6llpkv2v99m1sby8z2zy9i";
  };
  imgui = fetchgit {
    url = "https://skia.googlesource.com/external/github.com/ocornut/imgui.git";
    rev = "6384eee34f08cb7eab8d835043e1738e4adcdf75";
    sha256 = "0aqnffdgnxg17vnwkmzj9nn0pa3cz9yfg3cnc5bcn4p7hifkkh9y";
  };
  jsoncpp = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/open-source-parsers/jsoncpp.git";
    rev = "1.0.0";
    sha256 = "01j0mqygrxlimyizyx1w02gv36234fjbficqwsb4gr57gq6xdhsr";
  };
  libjpeg-turbo = fetchgit {
    url = "https://skia.googlesource.com/external/github.com/libjpeg-turbo/libjpeg-turbo.git";
    rev = "1.5.3";
    sha256 = "1xrchs46g4jszx5vdw1d0xp6gbzxrhy3xkykqkpclcp3k54wasyc";
  };
  libpng = fetchgit {
    url = "https://skia.googlesource.com/third_party/libpng.git";
    rev = "v1.6.33";
    sha256 = "1q3nm6bk365fn1s205qzmc3gdn1v4n6f8dnbhn5g8v56jvjrj3cq";
  };
  libwebp = fetchgit {
    url = "https://chromium.googlesource.com/webm/libwebp.git";
    rev = "v0.6.1";
    sha256 = "0x1m83wirr58511kmn7hyvrb6bdv43a0sb7bn7fq58i3svpw5j87";
  };
  lua = fetchgit {
    url = "https://skia.googlesource.com/external/github.com/lua/lua.git";
    rev = "v5-3-4";
    sha256 = "11wnq02aq495dilgw46y68cqv4vf1dq9z5ni9m8qsmz84z44hk7g";
  };
  microhttpd = fetchgit {
    url = "https://android.googlesource.com/platform/external/libmicrohttpd";
    rev = "748945ec6f1c67b7efc934ab0808e1d32f2fb98d";
    sha256 = "0y2wxkngr5y97lighzyilir3m2qzkas4kcrg7ivlw3f31z1zhxlk";
  };
  piex = fetchgit {
    url = "https://android.googlesource.com/platform/external/piex.git";
    rev = "bb217acdca1cc0c16b704669dd6f91a1b509c406";
    sha256 = "05ipmag6k55jmidbyvg5mkqm69zfw03gfkqhi9jnjlmlbg31y412";
  };
  rapidjson = fetchgit {
    url = "https://skia.googlesource.com/external/github.com/Tencent/rapidjson.git";
    rev = "af223d44f4e8d3772cb1ac0ce8bc2a132b51717f";
    sha256 = "1rcyqxf36n178kfifszfd01n1sbbgjzn7z6ysp9k25di6hmqfcbd";
  };
  sdl = fetchgit {
    url = "https://skia.googlesource.com/third_party/sdl";
    rev = "5d7cfcca344034aff9327f77fc181ae3754e7a90";
    sha256 = "0lnkgwxxbxid8l3hm98ycwc3g2wpwhagq00p6nj8f8nd23hjqbyv";
  };
  sfntly = fetchgit {
    url = "https://chromium.googlesource.com/external/github.com/googlei18n/sfntly.git";
    rev = "b18b09b6114b9b7fe6fc2f96d8b15e8a72f66916";
    sha256 = "0zf1h0dibmm38ldypccg4faacvskmd42vsk6zbxlfcfwjlqm6pp4";
  };
  spirv-headers = fetchgit {
    url = "https://skia.googlesource.com/external/github.com/KhronosGroup/SPIRV-Headers.git";
    rev = "661ad91124e6af2272afd00f804d8aa276e17107";
    sha256 = "1hdnqhxzswa46gcs2dd14v69gkag4gk2fdg54yjmvw2nwqdj2z32";
  };
  spirv-tools = fetchgit {
    url = "https://skia.googlesource.com/external/github.com/KhronosGroup/SPIRV-Tools.git";
    rev = "e9e4393b1c5aad7553c05782acefbe32b42644bd";
    sha256 = "09qrx4y3qfk7baw01q7pi1q1v7j9a3hrg8zfwzyyxsbffvrz3jfg";
  };
  swiftshader = fetchgit {
    url = "https://swiftshader.googlesource.com/SwiftShader";
    rev = "cbb80f5f0078a9941f3ec43e83e52c3d15a43bea";
    sha256 = "0r1jxijibvmv2lbymykx6g7jbr6w8sw84r7wbi0vx0li01j0zaa7";
  };
  zlib = fetchgit {
    url = "https://chromium.googlesource.com/chromium/src/third_party/zlib";
    rev = "e7afdfe128e01ca480a28f757b571957befdd962";
    sha256 = "0lc5hbpi0aj4ijjzksm4x007vbmnpp8lxlng4h9wfgwdz0y4q505";
  };
}
