final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "bundler";
    version = "1";
    toplevel = [
      ("rails")
    ];
  };
  specs = {
    actioncable = {
      pname = "actioncable";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("activesupport")
        ("nio4r")
        ("websocket-driver")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/actioncable-6.1.3.1.gem";
        sha256 = "0dr6w3h7i7xyqd04aw66x2ddm7xinvlw02pkk1sxczi8x21z16hf";
      };
    };
    actionmailbox = {
      pname = "actionmailbox";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("activejob")
        ("activerecord")
        ("activestorage")
        ("activesupport")
        ("mail")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/actionmailbox-6.1.3.1.gem";
        sha256 = "0w3cq2m1qbmxp7yv3qs82ffn9y46vq5q04vqwxak6ln0ki0v4hn4";
      };
    };
    actionmailer = {
      pname = "actionmailer";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("actionview")
        ("activejob")
        ("activesupport")
        ("mail")
        ("rails-dom-testing")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/actionmailer-6.1.3.1.gem";
        sha256 = "1wsa6kcgjx5am9hn44q2afg174m2gda4n8bfk5na17nj48s9g1ii";
      };
    };
    actionpack = {
      pname = "actionpack";
      version = "6.1.3.1";
      depKeys = [
        ("actionview")
        ("activesupport")
        ("rack")
        ("rack-test")
        ("rails-dom-testing")
        ("rails-html-sanitizer")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/actionpack-6.1.3.1.gem";
        sha256 = "0brr9kbmmc4fr2x8a7kj88yv8whfjfvalik3h82ypxlbg5b1c9iz";
      };
    };
    actiontext = {
      pname = "actiontext";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("activerecord")
        ("activestorage")
        ("activesupport")
        ("nokogiri")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/actiontext-6.1.3.1.gem";
        sha256 = "04f7x7ycg73zc2v3lhvrnl072f7nl0nhp0sspfa2sqq14v4akmmb";
      };
    };
    actionview = {
      pname = "actionview";
      version = "6.1.3.1";
      depKeys = [
        ("activesupport")
        ("builder")
        ("erubi")
        ("rails-dom-testing")
        ("rails-html-sanitizer")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/actionview-6.1.3.1.gem";
        sha256 = "0m009iki20hhwwj713bqdw57hmz650l7drfbajw32xn2qnawf294";
      };
    };
    activejob = {
      pname = "activejob";
      version = "6.1.3.1";
      depKeys = [
        ("activesupport")
        ("globalid")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/activejob-6.1.3.1.gem";
        sha256 = "0zjwcfr4qyff9ln4hhjb1csbjpvr3z4pdgvg8axvhcs86h4xpy2n";
      };
    };
    activemodel = {
      pname = "activemodel";
      version = "6.1.3.1";
      depKeys = [
        ("activesupport")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/activemodel-6.1.3.1.gem";
        sha256 = "118slj94hif5g1maaijlxsywrq75h7qdz20bq62303pkrzabjaxm";
      };
    };
    activerecord = {
      pname = "activerecord";
      version = "6.1.3.1";
      depKeys = [
        ("activemodel")
        ("activesupport")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/activerecord-6.1.3.1.gem";
        sha256 = "1jva5iqnjmj76mhhxcvx6xzda071cy80bhxn3r79f76pvgwwyymg";
      };
    };
    activestorage = {
      pname = "activestorage";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("activejob")
        ("activerecord")
        ("activesupport")
        ("marcel")
        ("mini_mime")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/activestorage-6.1.3.1.gem";
        sha256 = "1800ski0619mzyk2p2xcmy4xlym18g3lbqw8wb3ss06jhvn5dl5p";
      };
    };
    activesupport = {
      pname = "activesupport";
      version = "6.1.3.1";
      depKeys = [
        ("concurrent-ruby")
        ("i18n")
        ("minitest")
        ("tzinfo")
        ("zeitwerk")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/activesupport-6.1.3.1.gem";
        sha256 = "0l0khgrb7zn611xjnmygv5wdxh7wq645f613wldn5397q5w3l9lc";
      };
    };
    builder = {
      pname = "builder";
      version = "3.2.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/builder-3.2.4.gem";
        sha256 = "045wzckxpwcqzrjr353cxnyaxgf0qg22jh00dcx7z38cys5g1jlr";
      };
    };
    concurrent-ruby = {
      pname = "concurrent-ruby";
      version = "1.1.8";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/concurrent-ruby-1.1.8.gem";
        sha256 = "0mr23wq0szj52xnj0zcn1k0c7j4v79wlwbijkpfcscqww3l6jlg3";
      };
    };
    crass = {
      pname = "crass";
      version = "1.0.6";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/crass-1.0.6.gem";
        sha256 = "0pfl5c0pyqaparxaqxi6s4gfl21bdldwiawrc0aknyvflli60lfw";
      };
    };
    erubi = {
      pname = "erubi";
      version = "1.10.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/erubi-1.10.0.gem";
        sha256 = "09l8lz3j00m898li0yfsnb6ihc63rdvhw3k5xczna5zrjk104f2l";
      };
    };
    globalid = {
      pname = "globalid";
      version = "0.4.2";
      depKeys = [
        ("activesupport")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/globalid-0.4.2.gem";
        sha256 = "1zkxndvck72bfw235bd9nl2ii0lvs5z88q14706cmn702ww2mxv1";
      };
    };
    i18n = {
      pname = "i18n";
      version = "1.8.10";
      depKeys = [
        ("concurrent-ruby")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/i18n-1.8.10.gem";
        sha256 = "0g2fnag935zn2ggm5cn6k4s4xvv53v2givj1j90szmvavlpya96a";
      };
    };
    loofah = {
      pname = "loofah";
      version = "2.9.1";
      depKeys = [
        ("crass")
        ("nokogiri")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/loofah-2.9.1.gem";
        sha256 = "1w9mbii8515p28xd4k72f3ab2g6xiyq15497ys5r8jn6m355lgi7";
      };
    };
    mail = {
      pname = "mail";
      version = "2.7.1";
      depKeys = [
        ("mini_mime")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/mail-2.7.1.gem";
        sha256 = "00wwz6ys0502dpk8xprwcqfwyf3hmnx6lgxaiq6vj43mkx43sapc";
      };
    };
    marcel = {
      pname = "marcel";
      version = "1.0.1";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/marcel-1.0.1.gem";
        sha256 = "0bp001p687nsa4a8sp3q1iv8pfhs24w7s3avychjp64sdkg6jxq3";
      };
    };
    method_source = {
      pname = "method_source";
      version = "1.0.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/method_source-1.0.0.gem";
        sha256 = "1pnyh44qycnf9mzi1j6fywd5fkskv3x7nmsqrrws0rjn5dd4ayfp";
      };
    };
    mini_mime = {
      pname = "mini_mime";
      version = "1.0.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/mini_mime-1.0.3.gem";
        sha256 = "1np6srnyagghhh2w4nyv09sz47v0i6ri3q6blicj94vgxqp12c94";
      };
    };
    mini_portile2 = {
      pname = "mini_portile2";
      version = "2.5.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/mini_portile2-2.5.0.gem";
        sha256 = "1hdbpmamx8js53yk3h8cqy12kgv6ca06k0c9n3pxh6b6cjfs19x7";
      };
    };
    minitest = {
      pname = "minitest";
      version = "5.14.4";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/minitest-5.14.4.gem";
        sha256 = "19z7wkhg59y8abginfrm2wzplz7py3va8fyngiigngqvsws6cwgl";
      };
    };
    nio4r = {
      pname = "nio4r";
      version = "2.5.7";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/nio4r-2.5.7.gem";
        sha256 = "00fwz0qq7agd2xkdz02i8li236qvwhma3p0jdn5bdvc21b7ydzd5";
      };
    };
    nokogiri = {
      pname = "nokogiri";
      version = "1.11.3";
      depKeys = [
        ("mini_portile2")
        ("racc")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/nokogiri-1.11.3.gem";
        sha256 = "19d78mdg2lbz9jb4ph6nk783c9jbsdm8rnllwhga6pd53xffp6x0";
      };
    };
    racc = {
      pname = "racc";
      version = "1.5.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/racc-1.5.2.gem";
        sha256 = "178k7r0xn689spviqzhvazzvxfq6fyjldxb3ywjbgipbfi4s8j1g";
      };
    };
    rack = {
      pname = "rack";
      version = "2.2.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/rack-2.2.3.gem";
        sha256 = "0i5vs0dph9i5jn8dfc6aqd6njcafmb20rwqngrf759c9cvmyff16";
      };
    };
    rack-test = {
      pname = "rack-test";
      version = "1.1.0";
      depKeys = [
        ("rack")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/rack-test-1.1.0.gem";
        sha256 = "0rh8h376mx71ci5yklnpqqn118z3bl67nnv5k801qaqn1zs62h8m";
      };
    };
    rails = {
      pname = "rails";
      version = "6.1.3.1";
      depKeys = [
        ("actioncable")
        ("actionmailbox")
        ("actionmailer")
        ("actionpack")
        ("actiontext")
        ("actionview")
        ("activejob")
        ("activemodel")
        ("activerecord")
        ("activestorage")
        ("activesupport")
        ("bundler")
        ("railties")
        ("sprockets-rails")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/rails-6.1.3.1.gem";
        sha256 = "1yl6wy2gfvjkq0457plwadk7jwx5sbpqxl9aycbphskisis9g238";
      };
    };
    rails-dom-testing = {
      pname = "rails-dom-testing";
      version = "2.0.3";
      depKeys = [
        ("activesupport")
        ("nokogiri")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/rails-dom-testing-2.0.3.gem";
        sha256 = "1lfq2a7kp2x64dzzi5p4cjcbiv62vxh9lyqk2f0rqq3fkzrw8h5i";
      };
    };
    rails-html-sanitizer = {
      pname = "rails-html-sanitizer";
      version = "1.3.0";
      depKeys = [
        ("loofah")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/rails-html-sanitizer-1.3.0.gem";
        sha256 = "1icpqmxbppl4ynzmn6dx7wdil5hhq6fz707m9ya6d86c7ys8sd4f";
      };
    };
    railties = {
      pname = "railties";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("activesupport")
        ("method_source")
        ("rake")
        ("thor")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/railties-6.1.3.1.gem";
        sha256 = "1m3ckisji9n3li2700jpkyncsrh5b2z20zb0b4jl5x16cwsymr7b";
      };
    };
    rake = {
      pname = "rake";
      version = "13.0.3";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/rake-13.0.3.gem";
        sha256 = "1iik52mf9ky4cgs38fp2m8r6skdkq1yz23vh18lk95fhbcxb6a67";
      };
    };
    sprockets = {
      pname = "sprockets";
      version = "4.0.2";
      depKeys = [
        ("concurrent-ruby")
        ("rack")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/sprockets-4.0.2.gem";
        sha256 = "0ikgwbl6jv3frfiy3xhg5yxw9d0064rgzghar1rg391xmrc4gm38";
      };
    };
    sprockets-rails = {
      pname = "sprockets-rails";
      version = "3.2.2";
      depKeys = [
        ("actionpack")
        ("activesupport")
        ("sprockets")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/sprockets-rails-3.2.2.gem";
        sha256 = "0mwmz36265646xqfyczgr1mhkm1hfxgxxvgdgr4xfcbf2g72p1k2";
      };
    };
    thor = {
      pname = "thor";
      version = "1.1.0";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/thor-1.1.0.gem";
        sha256 = "18yhlvmfya23cs3pvhr1qy38y41b6mhr5q9vwv5lrgk16wmf3jna";
      };
    };
    tzinfo = {
      pname = "tzinfo";
      version = "2.0.4";
      depKeys = [
        ("concurrent-ruby")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/tzinfo-2.0.4.gem";
        sha256 = "10qp5x7f9hvlc0psv9gsfbxg4a7s0485wsbq1kljkxq94in91l4z";
      };
    };
    websocket-driver = {
      pname = "websocket-driver";
      version = "0.7.3";
      depKeys = [
        ("websocket-extensions")
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/websocket-driver-0.7.3.gem";
        sha256 = "1i3rs4kcj0jba8idxla3s6xd1xfln3k8b4cb1dik2lda3ifnp3dh";
      };
    };
    websocket-extensions = {
      pname = "websocket-extensions";
      version = "0.1.5";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/websocket-extensions-0.1.5.gem";
        sha256 = "0hc2g9qps8lmhibl5baa91b4qx8wqw872rgwagml78ydj8qacsqw";
      };
    };
    zeitwerk = {
      pname = "zeitwerk";
      version = "2.4.2";
      depKeys = [
      ];
      src = pkgs.fetchurl {
        url = "https://rubygems.org/downloads/zeitwerk-2.4.2.gem";
        sha256 = "1746czsjarixq0x05f7p3hpzi38ldg6wxnxxw74kbjzh1sdjgmpl";
      };
    };
  };
}