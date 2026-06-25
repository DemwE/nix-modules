{
  lib,
  config,
  pkgs,
  ...
}:
/*
  Feature: Steam
  Provides: Steam game client with proper 32-bit, Vulkan and NVIDIA PRIME support.
  Enabling this feature will:
   - enable programs.steam (NixOS module, not a raw package)
   - open firewall ports for Steam Remote Play

  32-bit graphics stack is provided by system/graphics.nix (not duplicated here).
  If NVIDIA PRIME offload is enabled, games automatically run on dGPU via env
  vars injected into Steam's FHS environment — no per-game launch options needed.
*/
let
  cfg = config.my.features.steam;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.steam.enable =
    mkEnableOption "Enable Steam game client with 32-bit and NVIDIA PRIME support";

  config = mkIf cfg.enable {
    # 32-bit is already enabled in system/graphics.nix — no need to repeat here.

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;

      # At runtime, check supergfxctl mode — inject PRIME vars only when NVIDIA is active.
      # Works transparently in both Hybrid and Integrated modes.
      package = pkgs.steam.override {
        extraProfile = ''
          MODE=$(${pkgs.supergfxctl}/bin/supergfxctl --get 2>/dev/null || echo "Hybrid")
          if [ "$MODE" != "Integrated" ]; then
            export __NV_PRIME_RENDER_OFFLOAD=1
            export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export __VK_LAYER_NV_optimus=NVIDIA_only
          fi
        '';
      };
    };
  };
}
