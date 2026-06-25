{ ... }:
{
  # Core Nix maintenance
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    cores = 0; # Use all available CPU cores for building
  };
  systemd.services.nix-daemon.environment.TMPDIR = "/tmp";
  # system.copySystemConfiguration = true; # Not supported with flakes
}
