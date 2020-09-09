{
  haskellNix ? import (builtins.fetchTarball "https://github.com/input-output-hk/haskell.nix/archive/e328d1de1f2fd5319d39c825851cdc9cf8158bca.tar.gz") {}

, nixpkgsSrc ? import ./pinned-nixpkgs.nix

, nixpkgsArgs ? haskellNix.nixpkgsArgs

, pkgs ? import nixpkgsSrc nixpkgsArgs
}:

with pkgs;

let src = ./src;

in

haskell-nix.stackProject {
  inherit src;

  # modules = [
  #   {
  #     # Necessary to prevent gcc runtime dependency blowing up the closure size; see
  #     # https://github.com/input-output-hk/haskell.nix/issues/829
  #     packages.http-client-alpine-repro.components.exes.http-client-alpine-repro-exe = false;
  #   }
  # ];
}
