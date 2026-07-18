# Aggregator for all IDE packages
# pkgs: { rust-rover, webstorm, clion, pycharm, rider, idea }

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./rust-rover.nix
    ./webstorm.nix
    ./clion.nix
    ./pycharm.nix
    ./rider.nix
    ./idea.nix
    ./datagrip.nix
  ])
