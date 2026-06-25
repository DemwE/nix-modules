{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.nvidia;
  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  options.my.features.nvidia = {
    enable = mkEnableOption "Enable NVIDIA proprietary driver and related settings";

    runtimePowerManagement = mkEnableOption ''
      Enable fine-grained runtime power management for NVIDIA GPU.
      Sets NVreg_DynamicPowerManagement=0x01 and adds udev rules to put
      NVIDIA PCI devices into auto power/control — allows D3cold (~1W idle).
      Requires powerManagement.enable = true (already set).
    '';

    dynamicBoost = mkEnableOption ''
      Enable NVIDIA Dynamic Boost (nvidia-powerd).
      Keep this disabled unless your hardware/firmware supports it.
    '';

    prime = {
      enable = mkEnableOption "Enable NVIDIA PRIME for hybrid Intel/NVIDIA graphics";

      mode = mkOption {
        type = types.enum [ "offload" "sync" ];
        default = "offload";
        description = ''
          PRIME rendering mode:
          - offload: Intel renders by default, NVIDIA on demand via
                     `nvidia-offload <cmd>`. Best for battery life.
          - sync:    NVIDIA renders everything, output via Intel.
                     Best performance, higher power draw.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # NVIDIA-specific VA-API bridge — merges into hardware.graphics set by system/graphics.nix
    hardware.graphics.extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];

    # Load NVIDIA driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Power management settings
      powerManagement.enable = true;
      powerManagement.finegrained = cfg.runtimePowerManagement; # D3cold + udev rules + NVreg_DynamicPowerManagement=1

      # Dynamic Boost: nvidia-powerd shifts TGP based on combined workload.
      # This is opt-in because it fails on some laptops/firmware.
      dynamicBoost.enable = cfg.dynamicBoost;

      # Use the NVIDIA open source kernel module? (Turing+ only)
      open = false;

      # Enable the NVIDIA settings tool (`nvidia-settings`)
      nvidiaSettings = false;

      # Select the driver package (adjust if you need a specific version)
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = lib.mkIf cfg.prime.enable {
        # ThinkPad X1 Extreme Gen 4: Intel UHD + RTX 3050 Ti
        intelBusId  = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = lib.mkIf (cfg.prime.mode == "offload") {
          enable = true;
          # Adds `nvidia-offload` wrapper command to run apps on dGPU
          enableOffloadCmd = true;
        };

        sync.enable = cfg.prime.mode == "sync";
      };
    };
  };
}
