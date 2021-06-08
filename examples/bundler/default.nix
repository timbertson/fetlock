{ pkgs ? import <nixpkgs> {}, packageOverrides ? self: []}:
with pkgs;
let
  bundler = (callPackage ../../nix/bundler {});
  selection = bundler.load ./lock.nix {
    pkgOverrides = self: [
      (self.overrideAttrs {
        nokogiri = o: {
          buildInputs = (o.buildInputs or []) ++ [ libiconv zlib ];
        };
      })
    ];
  };
in
with lib;
selection.drvsByName.rails.overrideAttrs (o: {
  passthru = selection.drvsByName;
})