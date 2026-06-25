# Aggregator for all toolchain packages

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./rust.nix
    ./cpp.nix
    ./nodejs.nix
    ./python.nix
    ./dotnet.nix
    ./bun.nix
    ./haskell.nix
    ./esp.nix
  ])
