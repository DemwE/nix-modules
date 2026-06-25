{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.gnome;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.gnome.enable = mkEnableOption "Enable GNOME desktop environment";

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.gnome.enable = true;

    # GNOME services
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm-password.enableGnomeKeyring = true;
    services.gnome.localsearch.enable = true;
    services.gnome.tinysparql.enable = true;
    # Enables "Launch using Dedicated Graphics Card" in GNOME app context menu
    services.switcherooControl.enable = true;

    # Exclude some default GNOME apps if desired
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
      geary
      gnome-weather
      gnome-maps
      gnome-contacts
      gnome-software
      gnome-system-monitor
    ];

    environment.systemPackages = with pkgs; [
      blackbox-terminal
      mission-center
    ];

    programs.gnome-terminal.enable = false; # Use xdg.terminal-exec instead

    xdg.terminal-exec = {
      enable = true;
      package = pkgs.blackbox-terminal;
      settings = {
        default = [
          "com.raggesilver.BlackBox.desktop"
        ];
      };
    };
  };
}
