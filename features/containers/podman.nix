{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: Podman
  Provides: Podman daemon + CLI tools.
  Enabling this feature will:
   - ensure podman group exists
   - enable the system podman service
   - add podman client package to system packages
   - add podman-compose for compose support
*/
let
  cfg = config.my.features.podman;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.podman = {
    enable = mkEnableOption "Enable Podman engine and user tooling";
  };
  options.my.features.podman.dockerSocket = {
    enable = mkEnableOption "Enable Docker socket compatibility";
  };

  config = mkIf cfg.enable {
    # Enable daemon and start at boot
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = cfg.dockerSocket.enable or true;
      extraPackages = [ pkgs.slirp4netns ];
      autoPrune = {
        enable = true;
        dates = "daily";
      };
    };
    virtualisation.containers.containersConf.settings = {
      storage = {
        driver = "overlay";
        graphroot = "/persist/var/lib/containers/storage";
        runroot = "/run/containers/storage";
      };
    };
    # Create group so user can be added (handled in user module)
    users.groups.podman = { };
    # Provide podman client binaries and compose
    environment.systemPackages = [
      pkgs.podman
      pkgs.podman-compose
    ];
  };
}
