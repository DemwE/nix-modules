{ lib, config, ... }:
{
  # Core Nix maintenance (fallback when nh.clean is not enabled)
  nix.gc = {
    automatic = lib.mkDefault (!(config.my.features.nix-helper.enable or false));
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    cores = 0; # Use all available CPU cores for building
  };
  systemd.services.nix-daemon.environment.TMPDIR = "/tmp";
  # system.copySystemConfiguration = true; # Not supported with flakes
}
