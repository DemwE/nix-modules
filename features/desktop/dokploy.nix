{ config, pkgs, ... }:

{
  my.features.dokploy = {
    enable = lib.mkEnableOption "Enable Dokploy deployment tool";
  };

  config = lib.mkIf config.my.features.dokploy.enable {
    services.dokploy.enable = true;
    services.dokploy.database.passwordFile = "/var/lib/secrets/dokploy-db-password";
    services.dokploy.auth.secretFile = "/var/lib/secrets/dokploy-auth-secret";

    # Enable Docker socket compatibility if Docker is not enabled
    my.features.docker.enable = true;
  };
}