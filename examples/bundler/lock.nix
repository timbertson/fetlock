final:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "bundler";
    version = "1";
    root = "_virtual_root";
  };
  specs = {
    _virtual_root = {
      pname = "fetlock-virtual-root";
      version = "dev";
      depKeys = [
        ("rails")
      ];
      src = (final.pathSrc ./src);
    };
    actioncable = {
      pname = "actioncable";
      version = "6.1.3.1";
      depKeys = [
        ("actionpack")
        ("activesupport")
        ("nio4r")
        ("websocket-driver")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Dprwg+goftZ1mPMKwOm2sZ/amujGcEVAw76feODgJjc=";
        url = "https://rubygems.org/gems/actioncable-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-xEKyQZzAUjNV53gTgAvehvhknRNI47H9ub0uHKrAbHA=";
        url = "https://rubygems.org/gems/actionmailbox-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-MYaXNCLSnqBsmW4hS1R7opITnlMCE2Jhqqp0+dg0SvM=";
        url = "https://rubygems.org/gems/actionmailer-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-PyYWVnmL9usFgmNGqraTDnK0PUJyHoW6yI6wWtdMOS8=";
        url = "https://rubygems.org/gems/actionpack-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-q9apyCYBYy2Uu1qDCy2g9jhxALV5Qzq2YH+cx/zpxxE=";
        url = "https://rubygems.org/gems/actiontext-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-JAnHlcXCdjG4VMvldigo5ld4Cm94jXAk5xACEWdMAFQ=";
        url = "https://rubygems.org/gems/actionview-6.1.3.1.gem";
      });
    };
    activejob = {
      pname = "activejob";
      version = "6.1.3.1";
      depKeys = [
        ("activesupport")
        ("globalid")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-VvjbCTRIM7i7Qm+/dskfeV+5NAtLQkgsTc55TLJjXH4=";
        url = "https://rubygems.org/gems/activejob-6.1.3.1.gem";
      });
    };
    activemodel = {
      pname = "activemodel";
      version = "6.1.3.1";
      depKeys = [
        ("activesupport")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-tSu51M/zDjCEwQuI3/CB5eDMve5URqVqeMVFSJKkGoU=";
        url = "https://rubygems.org/gems/activemodel-6.1.3.1.gem";
      });
    };
    activerecord = {
      pname = "activerecord";
      version = "6.1.3.1";
      depKeys = [
        ("activemodel")
        ("activesupport")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-r3rP+dvXHJdOHrbDBZBn4QDVfjd9sw5hNUdWaXEsass=";
        url = "https://rubygems.org/gems/activerecord-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-t9BW7IbSAK3H4ojjRcdDoXraia+siyum/zUFA+LUAKA=";
        url = "https://rubygems.org/gems/activestorage-6.1.3.1.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-jCY6eMEnjWIb5SMYV4jB/MDeeNnPVyt7CMb+s/KDE1A=";
        url = "https://rubygems.org/gems/activesupport-6.1.3.1.gem";
      });
    };
    builder = {
      pname = "builder";
      version = "3.2.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-mcrwivYMjX86awBAKcTDwL2uvO1slJFl/pjx2yf7vBA=";
        url = "https://rubygems.org/gems/builder-3.2.4.gem";
      });
    };
    concurrent-ruby = {
      pname = "concurrent-ruby";
      version = "1.1.8";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-41Fp6OAcM83cnTIuTnk6m8jDwAyWfSBtF0V+DTAfIlc=";
        url = "https://rubygems.org/gems/concurrent-ruby-1.1.8.gem";
      });
    };
    crass = {
      pname = "crass";
      version = "1.0.6";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-3FFgIqVuezsVYJmryBttKwjqHtEmdqx6VldhfwEr1F0=";
        url = "https://rubygems.org/gems/crass-1.0.6.gem";
      });
    };
    erubi = {
      pname = "erubi";
      version = "1.10.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-VDgCwpT5F2U/62UODnfLwzAYzbLaeRApSqgCIMeniCY=";
        url = "https://rubygems.org/gems/erubi-1.10.0.gem";
      });
    };
    globalid = {
      pname = "globalid";
      version = "0.4.2";
      depKeys = [
        ("activesupport")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YfcqOBfg2MoMOCRghH7Rm4IYBbWprTIEd0ucyXazff4=";
        url = "https://rubygems.org/gems/globalid-0.4.2.gem";
      });
    };
    i18n = {
      pname = "i18n";
      version = "1.8.10";
      depKeys = [
        ("concurrent-ruby")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-yiTlL91q169BkkHu+MQeZe9ONJnGslLfE/aXkZ6yTjw=";
        url = "https://rubygems.org/gems/i18n-1.8.10.gem";
      });
    };
    loofah = {
      pname = "loofah";
      version = "2.9.1";
      depKeys = [
        ("crass")
        ("nokogiri")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Jz5ayqjGSpSL9ieRErCP3Tyx1HDiTNI6EreEgmJcNfE=";
        url = "https://rubygems.org/gems/loofah-2.9.1.gem";
      });
    };
    mail = {
      pname = "mail";
      version = "2.7.1";
      depKeys = [
        ("mini_mime")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-7Co9SJ91ELkNjqo/arqtcDjPHWY8347mbQIUoL35nAM=";
        url = "https://rubygems.org/gems/mail-2.7.1.gem";
      });
    };
    marcel = {
      pname = "marcel";
      version = "1.0.1";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-A3dp3myamCsh81sNfTgRGrqLdgx4XI0UUdoeZG4A4C4=";
        url = "https://rubygems.org/gems/marcel-1.0.1.gem";
      });
    };
    method_source = {
      pname = "method_source";
      version = "1.0.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-13lFWitWZqB5zlhXe/rYU09XGvfOyBB/Tc4yjwmB3t4=";
        url = "https://rubygems.org/gems/method_source-1.0.0.gem";
      });
    };
    mini_mime = {
      pname = "mini_mime";
      version = "1.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-JDERLu5vkyRZpMvgEbOJYB/ydQLbW8IFhPA95W3W5to=";
        url = "https://rubygems.org/gems/mini_mime-1.0.3.gem";
      });
    };
    mini_portile2 = {
      pname = "mini_portile2";
      version = "2.5.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-p6egnWRmGdjvsImBaYBiZr8pgscMwTH9KFqiXlW9q8E=";
        url = "https://rubygems.org/gems/mini_portile2-2.5.0.gem";
      });
    };
    minitest = {
      pname = "minitest";
      version = "5.14.4";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-9HFmNNcbP/tifNY7pPbw93x6Pxc1OxvfUsin8uDk56c=";
        url = "https://rubygems.org/gems/minitest-5.14.4.gem";
      });
    };
    nio4r = {
      pname = "nio4r";
      version = "2.5.7";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-WmoCbL3gRJizB7NbND+6up40dJ4IUIYQrueRmrlGXqw=";
        url = "https://rubygems.org/gems/nio4r-2.5.7-java.gem";
      });
    };
    nokogiri = {
      pname = "nokogiri";
      version = "1.11.3";
      depKeys = [
        ("mini_portile2")
        ("racc")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-oJvrXB+lXaMe5JTajGrTSyY20JnWwEuWTH9R8VpFp6U=";
        url = "https://rubygems.org/gems/nokogiri-1.11.3.gem";
      });
    };
    racc = {
      pname = "racc";
      version = "1.5.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-EQu/nNbybuoihS/hEuJROU3/rBcmisDJld+HmOZ0G4c=";
        url = "https://rubygems.org/gems/racc-1.5.2-java.gem";
      });
    };
    rack = {
      pname = "rack";
      version = "2.2.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-Jjjn62aJpXJcfhbzDMSqTjFpTcPKMNeQlSUmeBvQu0Q=";
        url = "https://rubygems.org/gems/rack-2.2.3.gem";
      });
    };
    rack-test = {
      pname = "rack-test";
      version = "1.1.0";
      depKeys = [
        ("rack")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-FUFh9A8WKxwAmmVbewxd46MQLMbX0ulLZOH0as6ACGY=";
        url = "https://rubygems.org/gems/rack-test-1.1.0.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-aIiXdNRxangX8yrRju/SpXN5ZlOc3lMIwFNu94Tnhvo=";
        url = "https://rubygems.org/gems/rails-6.1.3.1.gem";
      });
    };
    rails-dom-testing = {
      pname = "rails-dom-testing";
      version = "2.0.3";
      depKeys = [
        ("activesupport")
        ("nokogiri")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-sUDE859uYJyBExN7mmDfwuy4mGTklvh/I6aLO48S2NE=";
        url = "https://rubygems.org/gems/rails-dom-testing-2.0.3.gem";
      });
    };
    rails-html-sanitizer = {
      pname = "rails-html-sanitizer";
      version = "1.3.0";
      depKeys = [
        ("loofah")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-jjSNtD/MoGaUT/WA853BEBYaGz+9GVu/9YTeu3rFl8U=";
        url = "https://rubygems.org/gems/rails-html-sanitizer-1.3.0.gem";
      });
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
      src = (pkgs.fetchurl {
        hash = "sha256-6+TqNWcm9EIlWWB9IL5YBWbNrJ9XAnBEpMOmKHWcbNQ=";
        url = "https://rubygems.org/gems/railties-6.1.3.1.gem";
      });
    };
    rake = {
      pname = "rake";
      version = "13.0.3";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-xyizOlvQlTQpCnAP8X3As01tMqriOjT0Y8TP5KooM8Y=";
        url = "https://rubygems.org/gems/rake-13.0.3.gem";
      });
    };
    sprockets = {
      pname = "sprockets";
      version = "4.0.2";
      depKeys = [
        ("concurrent-ruby")
        ("rack")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-aNRHWK49pPFyyAq+/zIxALTEuy8P9uGjy25saejib0Y=";
        url = "https://rubygems.org/gems/sprockets-4.0.2.gem";
      });
    };
    sprockets-rails = {
      pname = "sprockets-rails";
      version = "3.2.2";
      depKeys = [
        ("actionpack")
        ("activesupport")
        ("sprockets")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-YoYrzhNuMddJfu3t3l93MNQJa8jvM+9wN8QUI8z4lVc=";
        url = "https://rubygems.org/gems/sprockets-rails-3.2.2.gem";
      });
    };
    thor = {
      pname = "thor";
      version = "1.1.0";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-ysrhKjdhvkzL5jvhkmE1KxCPhschw32HZkMo7+qm0KM=";
        url = "https://rubygems.org/gems/thor-1.1.0.gem";
      });
    };
    tzinfo = {
      pname = "tzinfo";
      version = "2.0.4";
      depKeys = [
        ("concurrent-ruby")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-n9CQbCQJ9ynpDHhpXhAB+ijy+nL6pa0vYHTD5E4vF4M=";
        url = "https://rubygems.org/gems/tzinfo-2.0.4.gem";
      });
    };
    websocket-driver = {
      pname = "websocket-driver";
      version = "0.7.3";
      depKeys = [
        ("websocket-extensions")
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-m3GiaIzKZvm025qTntog4M9gA9OqOAqDH+U0zXFCnfI=";
        url = "https://rubygems.org/gems/websocket-driver-0.7.3-java.gem";
      });
    };
    websocket-extensions = {
      pname = "websocket-extensions";
      version = "0.1.5";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-HGumMJLNo0PrU/xlcRDHHHVMVkhKrUJXhJUifXF6gkE=";
        url = "https://rubygems.org/gems/websocket-extensions-0.1.5.gem";
      });
    };
    zeitwerk = {
      pname = "zeitwerk";
      version = "2.4.2";
      depKeys = [
      ];
      src = (pkgs.fetchurl {
        hash = "sha256-9NYnmw7wyzXJ4b3bzs1rFI34Lxz3uAI6wD1mJfVnhpw=";
        url = "https://rubygems.org/gems/zeitwerk-2.4.2.gem";
      });
    };
  };
}