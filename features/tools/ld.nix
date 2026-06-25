{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: nix-ld
  Provides: nix-ld — LD\_PRELOAD-based loader for running unpatched dynamic
  binaries (e.g. pre-compiled C/C++ programs) on NixOS.

  Enabling this feature will:
   - enable programs.nix-ld
   - add common C/C++ libraries needed by typical unpatched binaries
*/
let
  cfg = config.my.features.ld;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.ld.enable = mkEnableOption "Enable nix-ld support for running unpatched dynamic binaries";

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
  };
}
