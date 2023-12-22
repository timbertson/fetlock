final: prev:
with prev.pkgs.lib;
{
  key, pname, version,
  depKeys,
  cache,
  src ? null,
  artifacts ? null,
  buildTask ? "TODO",
  artifactPath ? "TODO",
}@spec:
let

  offlineRepositories = prev.pkgs.writeTextFile {
    name = "offline-repos";
    text = ''
  [repositories]
    local
    '';
  };
  
  repositoryConfig = final.context.repositoryConfig;

  # Note: we don't want to use these; in fact we'd prefer to run fully offline.
  # But the coursier cache path is based on repo URL, so it needs to resolve repos
  # exactly as it did for initial resolution
  onlineRepositories = prev.pkgs.writeTextFile {
    name = "online-repos";
    text = repositoryConfig;
  };
  onlineReposFlags = if repositoryConfig == null then [] else ["-Dsbt.repository.config=${onlineRepositories}"];

in
if artifacts != null then throw "artifact-only specification ${key} can't be built individually" else
{
  inherit pname version depKeys src;
  configurePhase = "true";
  SBT_OPTS = concatStringsSep " " ([
    # https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html

    "-Dsbt.boot.directory=.nix_sbt/boot"
    "-Dsbt.global.base=.nix_sbt/sbt"
    "-Duser.home=.nix_sbt/home"
    "-Dcoursier.cache=.nix_sbt/cache"
    "-Dsbt.offline=true"
    "-Dsbt.override.build.repos=true"
    "-Dsbt.coursier=true"
  ] ++ onlineReposFlags);
  
  # above properties sbt.offline and coursier.cache seem unreliable
  COURSIER_MODE = "offline";

  # COURSIER_CACHE = ".nix_sbt/cache";
  COURSIER_CACHE = "${cache}/cache";
  HOME = ".nix_sbt/home";
  
    # export HOME="$PWD/.nix_sbt/home"
    # cp -a --no-preserve=mode "${cache}/cache" .nix_sbt/
  # sbt wants to write to the cache directory, so we need to make a copy :sigh:
  buildPhase = ''
    mkdir -p .nix_sbt/{boot,sbt,home}
    echo >&2 "Using coursier cache at $COURSIER_CACHE"
    sbt --debug ${buildTask}
  '';
  installPhase = ''
    mkdir -p $out
    cp -r --no-preserve=mode ./${artifactPath} $out/
  '';

  buildInputs = [ final.pkgs.sbt ];
}
