{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: Howdy (IR Camera / Windows Hello)
  NOTE: Temporarily disabled due to fetchTarball impure error.
  Requires: services.howdy from nixpkgs-unstable + pkgs.unstable.howdy
*/
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.howdy.enable =
    mkEnableOption "Enable face recognition login via Howdy (IR camera, unstable)";

  config = mkIf config.my.features.howdy.enable {
    assertions = [
      {
        assertion = pkgs ? unstable;
        message = "pkgs.unstable is required for howdy feature";
      }
    ];
  };
}
