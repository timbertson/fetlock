self:
let
	ocamlPackages = self.context.ocamlPackages;
in
[
  (self.overrideDrv {
    # it's too hard to make upstream opam package work, it relies on complex opam features.
    # The `pname` is so that core.nix features work (drvsByName etc)
    ocaml = _: self.pkgs.lib.extendDerivation true { pname = "ocaml"; } ocamlPackages.ocaml;
  })
]