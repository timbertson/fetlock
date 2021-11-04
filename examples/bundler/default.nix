{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = (callPackage ../../nix {});
  selection = fetlock.bundler.load ./lock.nix {
    pkgOverrides = self: [
      (self.overrideAttrs {
        nokogiri = o: {
          buildInputs = (o.buildInputs or []) ++ [ libiconv zlib ];
        };
      })
    ];
  };
in
selection.drvsByName.rails
