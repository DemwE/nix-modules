{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.hyprland;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.hyprland.enable = mkEnableOption "Enable Hyprland desktop environment";

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm-password.enableGnomeKeyring = true;
    services.switcherooControl.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
      quickshell
    ];
  };
}
