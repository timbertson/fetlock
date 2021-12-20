{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToDrv = import ./specToDrv.nix final prev;

    # TODO can we do this with attrs instead of paths?
    bundler = pkgs.callPackage <nixpkgs/pkgs/development/ruby-modules/bundler> { inherit (final) ruby buildRubyGem; };
    buildRubyGem = pkgs.callPackage <nixpkgs/pkgs/development/ruby-modules/gem> { inherit (final) ruby bundler; };
    lockDependencies = [ final.bundler final.ruby ];
  };
  injectRuby = ruby: final: prev: { inherit ruby; };
  rubyFromVersion = version:
    let
      parts = splitString "." version;
      majorMinor = take 2 parts;
      key = "ruby_${concatStringsSep "_" majorMinor}";
      notFound = "Ruby not found in nixpkgs: ${key} (from version ${version}). Use a different version, or pass in `ruby` attribute explicitly";
    in
    if hasAttr key pkgs
      then getAttr key pkgs
      else abort notFound;

in core.makeAPI {
  overlays = [ base ];
  # accept `ruby` or `rubyVersion` and project it into the overlay
  userArgs = args:
    let ruby = if args ? ruby then args.ruby else (
      if args ? rubyVersion
        then rubyFromVersion args.rubyVersion
        else pkgs.ruby
    );
  in
  filterAttrs (n: v: n != "ruby" && n != "rubyVersion") (args // {
    overlays = (args.overlays or [])
      ++ [(injectRuby ruby)];
  });
}
