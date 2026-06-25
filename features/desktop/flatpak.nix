{
  lib,
  config,
  ...
}:
/*
  Feature: Flatpak
  Provides: Declarative Flatpak support via nix-flatpak.
  Enabling this feature will:
   - import the nix-flatpak NixOS module
   - inject the nix-flatpak Home Manager module via sharedModules
   - enable the system Flatpak service
   - register the Flathub remote for all users
  Per-user packages are declared in modules/users/<user>/packages.nix via
  home-manager.users.<name>.services.flatpak.packages.
*/
let
  nix-flatpak = builtins.fetchTarball {
    url    = "https://github.com/gmodena/nix-flatpak/archive/refs/tags/v0.7.0.tar.gz";
    sha256 = "1jsxx20jv2dmf75563i9ldyva99d0qcls2rm424ikx83hnasx47d";
  };
  cfg = config.my.features.flatpak;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    "${nix-flatpak}/modules/nixos.nix"
  ];

  options.my.features.flatpak = {
    enable = mkEnableOption "Enable declarative Flatpak support via nix-flatpak";
  };

  config = mkIf cfg.enable {
    # Inject the nix-flatpak HM module so services.flatpak is available per-user
    home-manager.sharedModules = [ "${nix-flatpak}/modules/home-manager.nix" ];

    services.flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
    };
  };
}
