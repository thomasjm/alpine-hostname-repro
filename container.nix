
let
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    rev = "9ea61f7bc4454734ffbff73c9b6173420fe3147b";
    ref = "release-20.03";
  };
  pkgs = import nixpkgs {};

  app = ((import ./.) {}).app.http-client-alpine-repro.components.exes.http-client-alpine-repro-exe;

  baseImage = pkgs.dockerTools.pullImage {
    imageName = "alpine";
    finalImageTag = "3.12";
    imageDigest = "sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321";
    os = "linux";
    arch = "amd64";
    sha256 = "046pw7aiagf6qqi7cbwzx6awq3wsbl1l45aagkd9cj1wvykg8c75";
  };

in

with pkgs;
with dockerTools;

buildImage {
  name = "http-client-alpine-repro";

  contents = [app];

  fromImage = baseImage;
  created = "now";

  config = {
    Cmd = ["/nix_bin/codedown-server" "run" "/conf/config.yaml"];
    Env = [
      "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/nix_bin"
    ];
    Volumes = {
      "/conf" = {};
      "/sqlite" = {};
    };
  };
}
