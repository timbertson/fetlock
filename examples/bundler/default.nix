{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = (callPackage ../../nix {});
  selection = fetlock.bundler.load ./lock.nix {
    pkgOverrides = self: [
      (self.addBuildInputs {
        nokogiri = [ libiconv zlib ];
      })
    ];
  };
in
selection.drvsByName.rails
