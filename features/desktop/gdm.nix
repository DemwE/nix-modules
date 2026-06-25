{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.gdm;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.gdm.enable = mkEnableOption "Enable GDM display manager";
  
  config = mkIf cfg.enable {
    services.xserver.enable = true;
    # Prevent the fallback XTerm desktop session from being enabled/installed
    services.xserver.excludePackages = [ pkgs.xterm ];
    
    services.displayManager.gdm.enable = true;
  };
}
