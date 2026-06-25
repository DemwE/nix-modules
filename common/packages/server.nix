{ lib, config, pkgs, ... }:
{
  options.my.packages.server.enable = lib.mkEnableOption "server-oriented packages";

  config = lib.mkIf config.my.packages.server.enable {
    environment.systemPackages = with pkgs; [
      mdadm
      lm_sensors
      nfs-utils
      iotop
    ];
  };
}
