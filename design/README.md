Basic design: this tool is for converting a lockfile into nix. There will be frontends for many languages, and the output format is consistent.

# Responsibilities:

## Fetlock CLI:

 - understanding various lockfile formats
 - prefetching source archives, checking hashes and generating nix `fetch*` expressions for them
 - passing through various language-specific attributes and extensions
 - representing the dependency tree
   - if supported by the frontend, each package lists its dependencies, so that a targeted tree can be created

The raw structure exported is unstable, but currently is an overlay with the following structure:

```nix
final: prev:
	let pkgs = prev.pkgs;
{
	type = "opam";
	context = {
		# language-specific context about the entire solution
		repos = {
			opam = pkgs.fetchFromGithub { ... };
		};
	};
}
```

Required attributes:
 - `pkgs`: access to general tools, e.g. `fetchFromGitHub`

Exported attributes:
 - `context`: an attrset for information about the lock solution itself
   - `type`: the type of project (e.g. opam, gem, npm)
   - `version`: the version of fetlock used
   - `toplevel`: a list of toplevel spec keys (i.e. the actual requested packages)
   - other attrs provided by backends
 - `specs`: a flat attrset of specs. The key is implementation-dependent, but typically `${name}-{version}`
   - Each implementation exports:
     - `name`
     - `version` (may be null)
     - `src`: fetch* expression
     - `depKeys`: list of attribute names corresponding to keys in `specs`
     - additional attributes may be exported by language-specific backends, e.g:
       - `depexts` (opam)
       - `ocaml-version`

## Loader:

The loader is written in Nix, and wraps the minimal nix lock format to provide some common structure and utilities:

 - base fixpoint
 - overriding dependencies / sources
 - exposing the root package(s)

## Adapter:

Adapters are also written in nix, and provide language-specific functionality to enable building actual derivations:

 - providing a buildPackage function which can be used to build each entity in the lockfile
 - providing language-specific override functionality
 - interpreting language-specific metadata to affect build results
 
## Agent:

Some formats utilize an agent pattern, where we have some fetlock-aware code written in the host language to ease communication. For example, in bundler there's a very simple agent script (written in ruby) which uses the bundler API to generate a simple JSON for fetlock's use. This is dramatically less code than attempting to write a gemfile parser in fetlock itself.

# Naming

"fetlock" is a contraction of "fetch lock", and also an important muscle in many quadrupeds.
