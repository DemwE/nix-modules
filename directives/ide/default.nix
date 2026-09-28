# Aggregator for all IDE packages
# pkgs: { rust-rover, webstorm, clion, pycharm, rider, idea, datagrip }
# ./wrap.nix is a helper function, so it is intentionally not listed here.

pkgs:
pkgs.lib.mergeAttrsList (
  map (f: import f pkgs) [
    ./rust-rover.nix
    ./webstorm.nix
    ./clion.nix
    ./pycharm.nix
    ./rider.nix
    ./idea.nix
    ./datagrip.nix
  ]
)
