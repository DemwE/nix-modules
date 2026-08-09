{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.xdg;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.xdg.enable = mkEnableOption "Enable XDG desktop portal";

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
    };
  };
}
