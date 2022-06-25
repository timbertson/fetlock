final:
let
  pkgs = final.pkgs;
in
{
  context = {
    type = "Go";
    version = "1";
    root = "Burrow@development";
  };
  specs = {
    "Burrow@development" = {
      pname = "Burrow";
      version = "development";
      depKeys = [
      ];
      src = (pkgs.fetchFromGitHub {
        hash = "sha256-yNW9rqK3ayni4WuSVyU3fU7LaRliVGAUuL1Ip8EA9n8=";
        owner = "linkedin";
        repo = "Burrow";
        rev = "be40f44509e48462a8b5420a57f4f40cd6839921";
      });
      vendorSha256 = "sha256-7Ea7GAMVcUIFVOY1RWgXE761q5OAZjrgWa5aQgYiwDU=";
    };
  };
}