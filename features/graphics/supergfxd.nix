{ lib, config, ... }:
let
  cfg = config.my.features.supergfxd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.supergfxd = {
    enable = mkEnableOption "Enable supergfxd for MUX switch / GPU mode switching";
  };

  config = mkIf cfg.enable {
    services.supergfxd.enable = true;
    services.supergfxd.settings = {
      mode = "Hybrid";
      no_logind = false;
      logout_timeout_s = 180;
    };
  };
}
