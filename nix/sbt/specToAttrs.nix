final: prev:
with prev.pkgs.lib;
{
  key, pname, version,
  depKeys,
  cache,
  src ? null,
  artifacts ? null,
  buildTask ? "TODO",
  buildInputs ? [],
  ...
}@spec:
let
  extraAttrs = filterAttrs (n: v: ! (elem n [
    "key"
    "pname"
    "version"
    "depKeys"
    "cache"
    "src"
    "artifacts"
    "buildTask"
    "buildInputs"
  ])) spec;

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
  
  # properties sbt.offline and coursier.cache seem unreliable
  COURSIER_MODE = "offline";
  COURSIER_CACHE = "${cache}/cache";
  HOME = ".nix_sbt/home";
  buildPhase = ''
    mkdir -p .nix_sbt/{boot,sbt,home}
    echo >&2 "Using coursier cache at $COURSIER_CACHE"
    sbt ${buildTask}
  '';

  buildInputs = [ final.pkgs.sbt ] ++ buildInputs;
} // extraAttrs
