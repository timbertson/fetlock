# Nix API:

The `fetlock` command produces a nix lock file, which is suitable for committing alongside your package manager's lockfile. But to actually build software from this lockfile, you'll need to use the `fetlock` nix API, whose source is `nix/` in this repository.

# Choosing supported backends:

By default, fetlock includes the necessary runtime dependencies for _all_ popular backends (excluding ocaml/esy).
This can lead to large doanloads / closure sizes, so if you know upfront you can pass in just the ones you need as `fetlockBackends` (a list of strings) when building fetlock's nix expression or shell.

If a backend isn't compiled in, it can still be used - you will just need to arrange for that backend's runtime dependencies to be on `$PATH`.

## Top level `fetlock` attributes:

Each frontend is a separate attribute on `fetlock`, e.g. `fetlock.bundler`, `fetlock.yarn`, etc.

There is also a `shell` toplevel attribute.

This gives you a standalone shell with fetlock plus the given development utilities.

## load

`fetlock.<backend>load lock args`

`lock` is a generated fetlock lock expression, typically `./lock.nix`.

`args` is an attribute set with any of the following (they're all optional):
 - `overlays`: a list of [overlays](#overlay)
 - `pkgOverrides`: a functino taking `self` and returning a list of [package overrides](#package-override)
 - `src`: an expression for the source of the root package. If you provided `fetlock` an online source such as github, this is unnecessary. But if you ran it on a local folder, you'll need to provide a `src` nix expression.

The return type is [`selections`](#selections)

### overlay

This is a [standard nixpkgs overlay](https://nixos.org/manual/nixpkgs/stable/#sec-overlays-definition), used to modify the fetlock fix-point. This is an escape hatch for advanced use, you hopefully won't need to care about it.

If you're trying to understand the possile attributes, most of the backends provide some attributes but the bulk are in `core.nix`.

### package override

the `pkgOverrides` argument is a function taking `self` and returning a list of package overrides, which is a fetlock-specific abstraction. i.e. `pkgOverrides = self: [];`

A _raw_ override is a function taking an attrset of derivations and producing a new attrset of derivations.

You won't write your own raw override, you'll want to use some helpers on `self`, which each return an override:

 - `self.overrideAll (drv: ... )` runs the given function on every derivation in the selection

 - `self.overrideOnly { mypkg = (drv: newDrv); }` runs the given function (which returns a replacement derivation) when the derivation's `pname` matches the attribute key. You can provide many attribute keys to override multiple packages.

 - `self.overrideDrv { mypkg = newDrv; }` like `overrideOnly` except it simply replaces the derivation rahter than running it through a function.

 - `self.overrideDrv { mypkg = (attrs: newAttrs); }` like `overrideOnly` except it overrides the attributes (passed to `mkDerivation`, rather than the derivation itself)

 - `self.addBuildInputs { mypkg = [ input1 input2 ]; }` is a convenience function which appends to a derviation's `buildInputs`

 - `self.addPropagatedBuildInputs { mypkg = [ input1 input2 ]; }` as above, but for `propagatedBuildInputs`.

**note:**: `self` is actually the final fetlock fix-point, so you can also access e.g. `drvsByName` etc from [selections](#selections).

### selections

Selections is the result of the `load` function. It's an attrset containing:

 - `root`: the main / toplevel package
 - `dependencies`: list of [derivations](#derivation) corresponding to the root's `depKeys`. This is particularly useful if the root package is emtpy or you're trying to get dependencies for a shell.
 - `drvs`: an attrset of key to [derivation](#derivation) for each package in the lockfile. Most backends produce keys of the format `name@version`.
 - `drvsByName`: the same attrset, but keyed by `pname`, which doesn't include the version. This is typically more convenient, but can be ambiguous if the backend supports multiple packages with different versions.

(strictly speaking, `load` just returns the fetlock fix-point, but these attributes are the useful outputs)

### derviation

Each backend has its own `specToDrv` (or `specToAttrs`) function. Some are implemented with `stdenv.mkDerivation` directly, others use standard builders from `nixpkgs` (`buildCargoPackage`, `buildGoModule`, etc).

Regardless of how the derivatino is build, fetlock adds the following `passthru` attributes to every derivation:

 - `shell`: pass this to `nix-shell` to get the package's dependencies, plus fetlock and the underlying package manager (yarn, cargo, etc)
 - `spec`: the attributes passed to the frontend derivation build logic, essentially this package's attrs from `lock.nix`
 - `overrideSpec`: like overrideAttrs, but affects the spec before it's passed to the frontend's builder function, rather then `mkDerivation`. This enables higher level (frontend-specific) tweaks.
 - `drvsByName`: just a handy way to access this, it's copied from [selections](#selections)
