{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: Docker
  Provides: Docker daemon + CLI tools.
  Enabling this feature will:
   - ensure docker group exists
   - enable the system docker service
   - add docker client package to system packages
*/
let
  cfg = config.my.features.docker;
  inherit (lib) mkEnableOption mkIf mkMerge;
in
{
  options.my.features.docker = {
    enable = mkEnableOption "Enable Docker engine and user tooling";
    nvidia.enable = mkEnableOption "Enable NVIDIA Container Toolkit for GPU access inside containers";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # Enable daemon and start at boot
      virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
      };
      # Create group so user can be added (handled in user module)
      users.groups.docker = { };
      # Provide docker client binaries and compose
      environment.systemPackages = [
        pkgs.docker
        pkgs.docker-compose
      ];
    }
    (mkIf cfg.nvidia.enable {
      # NVIDIA Container Toolkit integration
      hardware.nvidia-container-toolkit.enable = true;
    })
  ]);
}
