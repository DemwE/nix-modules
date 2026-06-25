{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.syncthing;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.syncthing.enable = mkEnableOption "Enable Syncthing service";

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      package = pkgs.unstable.syncthing;
      user = "demwe";
      group = "users";
      configDir = "/home/demwe/.local/state/syncthing";
    };
  };
}