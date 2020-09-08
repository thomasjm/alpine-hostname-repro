{ pkgs }:

with pkgs;

let src = import ./.;

in

haskell-nix.stackProject {
  inherit src;

  modules = [
    {
      # Necessary to prevent gcc runtime dependency blowing up the closure size; see
      # https://github.com/input-output-hk/haskell.nix/issues/829
      packages.http-client-alpine-repro.components.exes.http-client-alpine-repro-exe = false;
    }
  ];
}
