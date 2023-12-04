final: prev:
with prev.pkgs.lib;
let
  addToCache = { path, fetched }: ''
    mkdir -p "$(dirname '${path}')"
    ln -s '${fetched}' '${path}'
  '';
  buildCacheDirectory = { artifacts }:
    stdenv.mkDerivation {
      buildCommand = ''
        mkdir $out
      '' + concatStringsSep (map addToCache artifacts);
    };

in
{
  key, pname, version,
  depKeys,
  src ? null,
  artifacts ? null,
  buildTask ? "TODO",
  artifactPath ? "TODO",
}@spec:

if artifacts != null then throw "artifact-only specification ${key} can't be built individually" else {
  inherit pname version depKeys src;
  configurePhase = "true";
  passthru = { inherit pkgname; };
  buildPhase = ''
    sbt ${buildTask}
  '';
  installPhase = ''
    mkdir -p $out
    cp -r --no-preserve=mode ./${artifactPath} $out/
  '';

  buildInputs = [ final.pkgs.sbt ];
}
