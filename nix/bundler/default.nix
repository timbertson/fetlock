{ core }:
{ pkgs, stdenv, lib }:
with lib;
let
  base = final: prev: {
    specToDrv = with prev.pkgs.lib; {
      key, pname, version,
      depKeys,
      src ? prev.emptyDrv,
    }@spec: final.buildRubyGem {
      inherit pname version src;
      gemName = pname;
      propagatedBuildInputs = (map final.getDrv (filter (k: k != "bundler") depKeys));
    };

    # TODO can we do this with attrs instead of paths?
    bundler = pkgs.callPackage "${pkgs.path}/pkgs/development/ruby-modules/bundler" { inherit (final) ruby buildRubyGem; };
    buildRubyGem = pkgs.callPackage "${pkgs.path}/pkgs/development/ruby-modules/gem" { inherit (final) ruby bundler; };
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
  # The base overlays includes pkgs.ruby, so that e.g. shell works.
  # A full package may override this
  overlays = [ base (injectRuby pkgs.ruby) ];

  # accept `ruby` or `rubyVersion` and project it into the overlay
  userArgs = args:
    let ruby = if args ? ruby then args.ruby else (
      if args ? rubyVersion
        then rubyFromVersion args.rubyVersion
        else pkgs.ruby
    );
  in
  filterAttrs (n: v: n != "ruby" && n != "rubyVersion") (args // {
    overlays = (args.overlays or []) ++ [ (injectRuby ruby) ];
  });
}
