{ config, lib, pkgs, ... }:

let
  cfg = config.my.features.incus;
  inherit (lib) mkEnableOption mkIf mkMerge;
in
{
  options.my.features.incus = {
    enable = mkEnableOption "Enable Incus virtualization";
    ui.enable = mkEnableOption "Enable Incus UI";
  };
  config = mkIf cfg.enable (mkMerge [
    {
      # Enable Incus daemon and start at boot
      virtualisation.incus = {
        enable = true;
        ui.enable = cfg.ui.enable;
      };
      # Ensure incus group exists so user membership can be added elsewhere
      users.groups.incus = { };
      networking.firewall.trustedInterfaces = [ "ibr0" ];
    }
  ]);
}