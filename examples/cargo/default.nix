{ pkgs ? import <nixpkgs> {}}:
with pkgs;
let
  fetlock = (callPackage ../../nix {});
  selection = fetlock.cargo.load ./lock.nix {
    pkgOverrides = self: [
      (self.addBuildInputs {
        fetlock = if stdenv.isDarwin then [ apple-sdk ] else [];
      })
    ];
  };
in
selection.root
