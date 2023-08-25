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
 - [gomod][] modules:
   - all-in-one build, i.e. a single `buildGoModule` derivation
   - no way to individually build or override dependencies
   - cache-inefficient, since a change in source code or any dependency causes a full rebuild

## Workflow

The general workflow is:

## Getting started:

TODO clean me up / sanity check

```
#   Generate some nix boilerplate, plus the initial lock expression. Use `fetlock init --update` if you don't already have a lockfile:
$ nix-shell -A cargo.shell --expr 'import (builtins.fetchTarball "https://github.com/timbertson/fetlock/archive/master.tar.gz")' --run 'fetlock init'

#   Your generated shell.nix will include fetlock plus your package manager.
#   You should run further `fetlock` commands from inside this shell
$ nix-shell

#    For example, update lockfile (based on dependency specification) and generate a new nix expression:
$ fetlock update

#    And of course, we wouldn't be here if it didn't give us a buildable derivation:
$ nix-build
```

If that doesn't build, you may need to dig deeper into overrides etc to add missing dependencies. See the `examples/` directory for more examples.

### Updating dependencies

You can of course use your regular tooling to update your lockfile, and then regenerate `lock.nix` by running `fetlock`. But you can also just run `fetlock update` to do both at once.

## Nix API:

Aside from poking around the `examples/` directory, some of the nix API is documented in [doc/nix-api.md](doc/nix-api.md).

## nix-shell usage

The default generated `shell.nix` only includes fetlock and your package manager. It doesn't need a valid `nix/lock.nix`, so it should always work. For reference, it looks like this:

```
(import ./nix {}).shell
```

Depending on your setup, you may prefer to replace the `.shell` attribute path:

 - your package's build-time dependencies only: `.root`
 - your package's build-time dependencies, _plus_ fetlock and your package manager: `.root.shell`

If you just want a one-off shell with these options, you can bypass `shell.nix` and pass in the attribute path explicitly, e.g.:

```
$ nix-shell nix/ --attr root.shell
```

Note that getting into a shell with these alternatives requires a valid `lock.nix`, and that all of your dependencies are buildable. This means you can "lock yourself out" if some derivations are unbuildable, preventing you from running any `fetlock` commands. If this happens, use the above one-off command with `--attr shell` to get the basic fetlock shell.

---

## Specifying a project

A project can be either local or remote. (TODO: automatically set `src` to fetchgit or ./. if within the store)

A local project is simply the path to the project directory.

A remote source is a github author/project, plus an (optional) relative path to the project directory.

Most backends have a hardcoded lock filename (think `yarn.lock` or `Cargo.lock`). For backends with arbitrary lockfile names, you can pass in the `--file` option to specify the lockfile name.

## Specifying a `src`

You'll typically use `fetlock` on a local project. But nix needs a source expression to build.

By default, the source for local projects is `../.` (which works for the default path of `nix/lock.nix`). But you can pass `--src` to override this. To pass a local path, it must start with a dot (i.e. `./` or `../`). Anything else is assumed to be a github `author/reponame` pair.

Note: if the project path is a git directory, the generated source expression will actually be a git checkout, rather than the raw files.

## Specifying a lock type

Typically, fetlock can autodetect the type. If you don't pass `--type` or `--lockfile`, it'll look for known lock types in your project directory. If it can't find one (or finds multiple), you'll need to either pass `--type` or `--lockfile` (lockfiles typically have an unambiguous mapping to a type, so you rarely need to specify both).

## Private repositories

In a corporate setting, you will often need to fetch from private repositories. Fetlock integrates with nix's authentication mechanism, since you'll need to set that up in order to actually build the generated expressions anyway.

This is a sample auth setup for accessing a private bundler repository:

```sh
$ grep netrc-file /etc/nix/nix.conf
netrc-file = /etc/netrc

$ cat /etc/netrc
machine gemrepo.mycompany.com
  login employee1234
  password J8CXZnz3EhZ6x/Hdri/EXU53XfQ=
```

That will provide the credentials necessary for fetlock (and nix!) to access gems specified via e.g.:

```ruby
source "https://gemrepo.mycompany.com/gems-internal/" do
  gem "secretsauce", "~> 1.0"
end
```

--

# Backend specific details

## Bundler backend:

To ensure you're working with the right ruby version, you can pass either `ruby` (a derivation) or `rubyVersion` (a version string, e.g. "2.7.5") as `load` function arguments.

When using `rubyVersion` the minor version will be used based on nixpkgs naming conventions - e.g. "2.7.5" uses `ruby_2_7`. The patch version is disregarded, and you'll get an error if nixpkgs doesn't include that version of ruby.

--

# The problem

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

## Adding a new backend:

The idea is that backends should be able to make use of common functionality, but new backends need to be wired up in a few places:

 - Rust:
   - add a `foo.rs` exporting `foo/backend.rs`, and add `mod foo` to `lib.rs`
   - add `Foo` to `lock::Type`
   - add detection logic to `opts.rs` (converting an explicit str -> lock::Type, and detecting a lock::Type from a filename)
 - Nix:
   - update `makeBackends` in `fetlock.nix`
   - add `"foo"` to `backends.nix
   - update `runtimeDeps.nix`

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
[gomod]: https://go.dev/
