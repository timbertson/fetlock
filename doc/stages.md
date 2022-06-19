# Stages in fetlock operations

There are 3 stages between source code and building via nix.

## Stage 1: solving

This often happens outside of fetlock, and you may not need to do this yourself - particularly when you just want to build an upstream application with its own lockfile.

However when you're working on your own (or modified) software you may want to use fetlock for this.

This stage always requires the underlying dependency manager, since fetlock implements no dependency management logic internally.

Even so, fetlock provides some support:

On the nix layer, `fetlock.<backend>.shell` provides the runtime tools needed (e.g. the underlying package manager).

In the CLI, `fetlock update` (or `fetlock init --update`) provides a convenient and consistent way to generate a lockfile, by delegating to the underlying package manager.

Note that `fetlock update` assumes the underlying package manager will be present, so you should run this from within a `fetlock.<backend>.shell` nix shell. It should not require any dependencies that _aren't_ provided by this shell.

## Stage 2: generating nix expression

Generating a nix expression is the main job of the fetlock CLI. It should not require any particular environment, i.e. you don't need to run it in a `nix shell`.

This is impure, since it reaches out to the internet (and typically uses a cache in your home directory).

Because this doesn't require a particular environment, it means fetlock has a dependency on backend-specific tools (like `opam2nix`). By default fetlock includes all such tools, however when building fetlock itself you can choose only certain backends, which reduces the build time depdendencies.

## Stage 3: build time

Build time is the responsibility of the nix/ api.

It must be pure, since it's part of a nix derivation.

It does not depend on the fetlock CLI. This is intentional, as that would cause everything to depend on fetlock, leading to mass rebuilds for every new fetlock version.

Where possible, it reuses upstream nixpkgs functionality like `buildRustCrate`, `buildRubyPackage`, etc.
