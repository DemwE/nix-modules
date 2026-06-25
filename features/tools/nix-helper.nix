{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.nix-helper;
  inherit (lib) mkEnableOption mkIf; 
in
{
  options.my.features.nix-helper.enable = mkEnableOption "Nix helper tool";

  config = mkIf cfg.enable {
    programs.nh.enable = true;
  };
}