{ config, lib, pkgs, ... }:

let
  cfg = config.my.features.dokploy;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.dokploy = {
    enable = lib.mkEnableOption "Enable Dokploy deployment tool";
  };

  config = lib.mkIf config.my.features.dokploy.enable {
    services.dokploy = {
      enable = true;
      database.passwordFile = "/var/lib/secrets/dokploy-db-password";
      auth.secretFile = "/var/lib/secrets/dokploy-auth-secret";
      environment = {
        TZ = "Europe/Warsaw";
      };
    };

    # Enable Docker socket compatibility if Docker is not enabled
    my.features.docker.enable = true;
  };
}