{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = (callPackage ../../nix {});
  osx = darwin.apple_sdk.frameworks;
  selection = fetlock.cargo.load ./lock.nix {
    pkgOverrides = self: [
      (self.addBuildInputs {
        fetlock = if stdenv.isDarwin then [ osx.Security ] else [];
      })
    ];
  };
in
selection.root
