/*
  Feature: Wireshark
  Provides: Network protocol analyzer (GUI)
  Enabling this feature will:
   - enable Wireshark with GUI
   - allow capturing network and USB traffic
   - add user to 'wireshark' group for permissions
*/
{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.wireshark;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.wireshark.enable = mkEnableOption "Enable Wireshark network protocol analyzer";

  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
  };
}
