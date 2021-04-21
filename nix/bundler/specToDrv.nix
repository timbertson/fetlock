final: prev:
with prev.pkgs.lib;
{
  key, pname, version,
  depKeys,
  src ? prev.emptyDrv,
}@spec: final.buildRubyGem {
  inherit pname version depKeys src;
  gemName = pname;
  
  propagatedBuildInputs = (map final.getDrv (filter (k: k != "bundler") depKeys));

  buildInputs = [ final.ruby ]; # TODO correct ruby version?
}