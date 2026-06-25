{ lib, config, pkgs, ... }:
/*
  Feature: PostgreSQL server
  Provides: Simple switch to enable a system PostgreSQL server and client tools.
  Enabling this feature will:
   - enable `services.postgresql`
   - add `postgresql` to `environment.systemPackages`
  You can extend this later with version/package options if needed.
*/
let
  cfg = config.my.features.postgres;
  inherit (lib) mkEnableOption mkIf mkMerge;
in
{
  options.my.features.postgres = {
    enable = mkEnableOption "Enable PostgreSQL server and client tooling";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.postgresql = {
        enable = true;
        # Use the default package from nixpkgs; override in a host/profile if you
        # want a specific major version (postgresql_15, etc.).
        package = pkgs.postgresql_18;
      };

      environment.systemPackages = with pkgs; [ postgresql_18 ];
    }
  ]);
}
