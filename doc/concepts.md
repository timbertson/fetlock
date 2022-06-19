# Fetlock concepts

Every package manager has their own peculiarities and terminology. To help grasp how fetlock fits into all of this, here's an overview of some concepts and how they relate.

## Locking

Locking is actually performed by the upstream pacakge manager, fetlock operates on their outputs: lockfiles.

The idea of a lockfile is to take a set of dependency specifications (e.g. `libfoo > 1.2`), look at the available versions (at the time), and produce a concrete specification with exact versions for all transitive dependencies.

Lockfiles prioritise reproducability, but reduce flexibility and freshness. A lockfile will always produce the same result, which means that you won't be able to use an updated version of a library until the application author publishes a new lockfile including that update.

Different package managers have different implementations of locking, but they generally produce the same kind of thing, which is why fetlock can provide (roughly) the same features on top of each backend.

## Overrides

Fetlock has multiple levels where you can override how a derivation is built:

**overrideSpec**: This is the highest level override. Each backend produces a nix file, with `specs` as a map from key to spec. `overrideSpec` allows you to override those values for a given package. Different backends may require / allow different spec fields.

**overrideAttrs**: This is a nixpkgs concept. It allows you to override the attrset passed to `stdenv.mkDerivation`. This is _after_ the language-specific frontend has converted the spec (above) into standard nix attributes like `buildInputs`, etc.

**overrideDrv**: This is the lowest level override. Your function is given the nix derivation, and you shoud return one. This can be used for wholesale substitutions or wrapping, like swapping a builtin `nixpkgs` derivation for some dependency which can't easily be built from upstream sources.

## Root package

The root package is the thing you're locking. Some package managers include this in the lockfile as its own entity, some only include dependencies. Where it's possible to load the root project's package metadata, fetlock will do so.

The root package could (conecptually) be one of many things:

#### Root: Nothing at all

You might simply have a lockfile for a bunch of packages, they're not a "dependency" of anything. In such cases, `root` likely won't evaluate or will be meaningless. You should just access `dependencies`, since that's all you need.

#### Root: A regular package

If you lock the "rails" gem, the root package is rails. This is a normal gem. Its metadata may be loaded differently, since you access it directly via source instead of rubygems.org, however it should be otherwise buildable like any other ruby gem.

In such a case, `root` should be a buildable package. If you lock a local path, you may need to override its `src` attribute for the result to be portable.

#### Root: An arbitrary derivation

In some cases, you might have software which depends on some yarn packages, but isn't itself a yarn package. It might have a `package.json`, but it might not. Either way, it's not merely a "yarn pacakge", and can't be built as one.

In this case you may want to use the `src` and `dependencies` attributes to build up your own nix derivation, but you likely won't want to use `root`.