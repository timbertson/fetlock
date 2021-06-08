#!bash
set -eux
cd "$(dirname "$2")"
gup -u lock.nix
gup --always # nix can handle dependency invalidation
nix-build default.nix --out-link "$1" --show-trace