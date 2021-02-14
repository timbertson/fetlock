final: prev:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "esy";
    version = "1";
    toplevel = [
      ("Oni2@link-dev:./package.json")
    ];
  };
  specs = {
    "@opam/conf-m4@opam:1@196bf219" = {
      pname = "conf-m4";
      version = "1";
      depKeys = [
        ("esy-m4@github:esy-packages/esy-m4#c7cf0ac9221be2b1f9d90e83559ca08397a629e7@d41d8cd9")
        ("@esy-ocaml/substs@0.0.1@d41d8cd9")
      ];
      build = {
        buildPhase = "sh -exc \"echo | m4\"";
        depexts = [
          ("m4")
        ];
        mode = "opam";
      };
    };
  };
}