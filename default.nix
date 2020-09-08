{
  haskellNix ? import (builtins.fetchTarball "https://github.com/input-output-hk/haskell.nix/archive/e328d1de1f2fd5319d39c825851cdc9cf8158bca.tar.gz") {}

, nixpkgsSrc ? builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    rev = "9ea61f7bc4454734ffbff73c9b6173420fe3147b";
    ref = "release-20.03";
  }

, nixpkgsArgs ? haskellNix.nixpkgsArgs

, pkgs ? import nixpkgsSrc nixpkgsArgs
}:

with pkgs;

{
  app = import ./app.nix { inherit pkgs; };
}
