# Fetlock

... is _extremely_ alpha. Have a poke around, but don't expect it to work for you, because it's still basically a toy and **I do not recommend or support its use** (yet).

Fetlock is a _unified tool_ for converting various lockfiles into `nix` expressions, plus a common `nix` API for building and tweaking the generated expressions.

## Available backends:

 - [bundler][] (rubygems)
 - [cargo][] (rust): used to build `fetlock` itself
 - [esy][] (reason / ocaml): requires [opam2nix][], lots of overrides needed currently
 - [opam][] (ocaml): requires [opam2nix][]
 - [yarn][] (nodejs): rudimentary support for v2 lockfiles
   - no `bin` wrappers
   - no `install` script / native compilation support

## Workflow

The general workflow is:

### Write `fetlock.nix`:

(TODO: automate `fetlock init`)

This imports the nix code from the master branch for ease of demonstration, you should pin the revision as appropriate:

```
# fetlock.nix
import (builtins.fetchTarball "https://github.com/timbertson/opam2nix/archive/v1.tar.gz") {}
```

### Get into a development shell:

(TODO: `fetlock shell -t cargo`)

This is a convenience to get shell both `fetlock` and the backend-appropriate tooling available on $PATH.

```
$ nix-shell -A cargo.shell fetlock.nix
```

### Generate `lock.nix`

(TODO: default -o to nix/lock.nix)

```
$ fetlock --type cargo -o lock.nix Cargo.lock
```

### Use the lock.nix to build a full nix expression

(TODO: part of `fetlock init`)

```
# default.nix
let
  fetlock = import ./fetlock.nix;
  selection = fetlock.cargo.load ./lock.nix;
in
selection.root
```

Fingers crossed, this derivation will build your whole project. If there are issues, you may need to add package-specific overrides to tweak things (e.g. adding missing dependencies which aren't captured by the language-specific package manager).

See the `examples/` directory for more examples.

### Updating dependencies

You can of course use your regular tooling to update your lockfile, and then regenerate `lock.nix` as above. But `fetlock` also provides convenience commands so that you don't have to install those development tools yourself.

(TODO: implement this)
If you run `fetlock update`, it'll invoke the appropriate command within a nix-shell that has the appropriate development tooling available, as well as updating `lock.nix`. So after that, a `nix-shell` will drop you into a shell with any changed dependencies available.
(TODO: --lockfile-only)

---

## Specifying a source

A source can be either local or remote. (TODO: automatically set `src` to fetchgit or ./. if within the store)

A local source is simply the path to the project directory.

A remote source is a github author/project, plus an (optional) relative path to the project directory.

Most backends have a hardcoded lock filename (think `yarn.lock` or `Cargo.lock`). For backends with arbitrary lockfile names, you can pass in the `--file` option to specify the lockfile name.

## Specifying a lock type

Typically, fetlock can autodetect the type. If you don't pass `--type` or `--file`, it'll look for known lock types in your project directory. If it can't find one (or finds multiple), you'll need to either pass `--type` or `--file` (lockfiles typically have an unambiguous mapping to a backend).

--

## The problem

There's a well-established pattern in the [nix][] community, for adopting language-specific packages into generic nix ones. That is, each ecosystem has one (or a handful of competing) `ecosystemToNix` tools.

These tools take _many_ different forms.

Some are implemented in nix directly, providing only a nix API.

Some are standalone code generators, where you run a program to generate a nix expression and then use a separate nix expression to import the results.

Some take lockfiles, some take package requirements.

Some need to be paired with a corresponding "nix universe" to mirror the ecosystem's package universe.

Unfortunately, there's a huge amount of diversity in these tools. Some of that is due to the difference between ecosystems, but a lot is the result of fairly arbitrary implementation choices.

## The plan:

Fetlock aims to be a single tool to turn _arbitrary lockfiles_ into nix expressions. In practice, that means there will need to be one backend module to support each language-specific ecosystem.

But, being a single tool, they can lean on common functionality:

 - resolving packages in online repositories
 - prefetching source archives
 - common structures & conversion utilities
 - nix expression generation
 - specifying package & configuration overrides
 - consistent nix API for importing the generated expressions

The benefit for fetlock _contriubtors_ is that adding a new language backend should be easier than writing a new tool, particularly if the language isn't doing anything particularly novel.

And for _users_, there's a single tool with consistent behaviour and functionality, rather than each language having its own unique usage, features and quirks.

## Goals:

**Consistency:** where possible, things should work the same way and support the same features across ecosystems.

**Rich generation-time features:** the `fetlock` tool should eventually be highly configurable, perhaps with its own configuration file.

**Efficient generation:** written in rust and sharing functionality means every backend gets to use common caching functionality and parallelism features.

**Clean, efficient derivations:** Where possible, we'll go to extra effort at _generation_ time to create efficient, straightforward derivations. This means having minimal build-time dependencies to prevent heavy closures and unnecessary rebuilds. It also means putting logic at the nix level (e.g. setup hooks) so that overrides work as expected.

## Non-goals:

**Language-specific features:** If a feature is very particular to one ecosystem, it's harder to justify.

**Working on anything other than lockfile inputs**: Package managers do a lot of work to produce a lock file, and fetlock has no intention of reimplementing that.

**Replacement for language-specific package managers**: since `fetlock` works on lock files, you still need the invidual package managers to create this lock file, and they likely provide a better development experience.

## "Maybe one day":

I'm not ruling these out, but I've made no attempt at them so far:

**Cross-platform builds**: I've never needed this myself, and I have no idea how hard it is.

## Why the name?

It **fet**ches **lock**file implementations. Also a fetlock is a flexible muscle found on horses and other quadrupeds.

## Why did you build this?

I've built one such tool before, [opam2nix][]. It takes [opam][] packages and generates nix expressions. I suspect this is one of the more complex tools, because opam packages are crazy expressive.

Even so, `opam2nix` is not brilliant. It works well enough, but the nix API can be cumbersome and it doesn't support things like development / test dependencies. I'd like to improve that, but the thought of reimplementing this advanced functionality into every such tool is exhausting. I've _also_ used many other tools (`bundix`, `node2nix`, etc) and found _them_ lacking.

In parallel, I've also wanted to build [esy][] packages with nix. I could bolt that onto `opam2nix` since they're both implemented in OCaml, but that doesn't feel right. If I'm going to build another tool, I might as well build The Last One I'll Ever Need To Build.

## So you want to replace all these tools with ones of your making?

...I suppose so? I'm terribly lazy, so that doesn't sound like fun. But I have a hunch that the guts of many of these tools aren't that different, and could benefit from a suite of shared functionality.

_If_ this turns out to work well for a few backends, perhaps it'll gain some traction and others might help ensure it works with all the crazy edge cases out there. It's likely that some of the backends receive a lot more attention than others, but I hope to keep each backend at least working for some nontrivial example program.

[nix]: https://nixos.org/
[opam2nix]: https://github.com/timbertson/opam2nix
[opam]: https://opam.ocaml.org/
[esy]: https://esy.sh/
[yarn]: https://yarnpkg.com/
[bundler]: https://bundler.io/
[cargo]: https://crates.io/
