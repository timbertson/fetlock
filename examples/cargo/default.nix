{ pkgs ? import <nixpkgs> {}, packageOverrides ? self: []}:
with pkgs;
let
  cargo = (callPackage ../../nix/cargo {});
  osx = darwin.apple_sdk.frameworks;
  selection = cargo.load ./lock.nix {
    pkgOverrides = self: [
      (self.overrideAttrs {
        fetlock = o: {
          src = builtins.fetchGit { url = ../..; };
          nativeBuildInputs = (o.nativeBuildInputs or []) ++ (if stdenv.isDarwin then [ osx.Security ] else []);
        };
      })
    ];
  };
in
selection.root.overrideAttrs (o: {
	passthru = selection.drvsByName;
})
