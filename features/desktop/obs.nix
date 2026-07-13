{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: OBS Studio with CUDA support
*/
let
  cfg = config.my.features.obs;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.obs.enable =
    mkEnableOption "Enable OBS Studio with CUDA support";

  config = mkIf cfg.enable {
    programs.obs = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };
    };
  };
}
