# Fetlock

... is _extremely_ alpha. Have a poke around, but don't expect it to work for you, because it's still basically a toy and **I do not recommend or support its use** (yet).

## The problem

There's a well-established pattern in the [nix][] community, for adopting language-specific packages into generic nix ones. That is, each ecosystem has one (or a handful of competing) `ecosystemToNix` tools.

These tools take _many_ different forms.

Some are implemented in nix directly, providing only a nix API.

Some are standalone code generators, where you run a program to generate a nix expression and then use a separate nix expression to import the results.

Some take lockfiles, some take package requirements.

Some need to be paired with a corresponding "nix universe" to mirror the ecosystem's package universe.

Unfortunately, there's a huge amount of diversity in these tools. Some of that is due to the difference between ecosystems, but a lot is the result of fairly arbitrary implementation choices.

## The plan:

Fetlock aims to be a single tool to turn _arbitrary lockfiles_ into nix expressions. In practice, that means there will need to be one backend module to support all the language-specific requirements.

But, being a single tool, they can lean on common functionality:

 - resolving packages in online repositories
 - prefetching source archives
 - common structures & conversion utilities
 - nix expression generation
 - specifying package & configuration overrides
 - consistent nix API for importing the generated expressions

The benefit for _developers_ is that adding a new language backend should be easier than writing a new tool, particularly if the language isn't doing anything particularly novel.

And for _users_, there's a single tool with consistent behaviour and functionality, rather than each language having its own unique usage, features and quirks.

## Goals:

**Consistency:** where possible, things should work the same way and support the same features across ecosystems.

**Rich generation features:** the `fetlock` tool should eventually be highly configurable, perhaps with its own configuration file.

**Efficient generation:** Written in rust and sharing functionality means every backend gets to use common caching functionality and parallelism features.

**Clean, efficient derivations:** Where possible, we'll go to extra effort at _generation_ time to create efficient derivations. Where possible, derivations should _not_ include a build-time dependency on any package manager.

## Non-goals:

**Language-specific features:** If a feature is very particular to one ecosystem, it's harder to justify.

**Working on anything other than lock files**: Some tools work on a raw dependency specification, resolving dependencies for you. That's a complex, language-specific job, so `fetlock` requires that you already have a lock file.

**Replacement for language-specific package managers**: since `fetlock` works on lock files, you still need the invidual package managers to create this lock file, and they likely provide a better development experience.

## Backends implemented:

 - [esy][]

(you can see why most of the text on this page is aspirational at this point ;))

## Why the name?

It **fet**ches **lock**file implementations. Also a fetlock is a flexible muscle found on horses and other quadrupeds.

## Why did you start this?

I've built one such tool, [opam2nix][]. It takes [opam][] packages and generates nix expressions. I suspect this is one of the more complex tools, because opam packages are crazy expressive.

Even so, `opam2nix` is not brilliant. It works well enough, but the nix API can be cumbersome and it's hard to tweak the solver's behaviour. I'd like to improve that, but the thought of reimplementing this advanced functionality into every such tool is exhausting. I've _also_ used many other tools (`bundix`, `node2nix`, etc) and found _them_ lacking.

In parallel, I've also wanted to build [esy][] packages with nix. I could bolt that onto `opam2nix` since they're both implemented in OCaml, but that doesn't feel right. If I'm going to build another tool, I might as well build The Last One I'll Ever Need To Build.

## So you want to replace all these tools with ones of your making?

...I suppose so? I'm terribly lazy, so that doesn't sound like fun. But I have a hunch that the guts of many of these tools aren't that different, and could benefit from a suite of shared functionality.

_If_ this turns out to work well for a few backends, perhaps it'll gain some traction and others might help add backends.

## Can this actually work?

I don't think I'll know until I implement a few very different backends, so stay tuned!

[nix]: https://nixos.org/
[opam2nix]: https://github.com/timbertson/opam2nix
[opam]: https://opam.ocaml.org/
[esy]: https://esy.sh/