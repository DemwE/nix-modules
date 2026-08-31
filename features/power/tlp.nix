{
  lib,
  config,
  ...
}:
let
  cfg = config.my.features.tlp;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.tlp = {
    enable = mkEnableOption "Enable TLP power management (replaces power-profiles-daemon)";
  };

  config = mkIf cfg.enable {
    services.power-profiles-daemon.enable = false;
    powerManagement.powertop.enable = false;

    services.tlp = {
      enable = true;
      settings = {
        # For the intel_pstate driver (your i7-11800H), EPP is key rather than governors alone
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Platform profiles integrated with the ThinkPad BIOS
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # PCIe bus and power-saving behavior
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersave";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # Disable NMI wakeups (reduces unnecessary CPU wakeups)
        NMI_WATCHDOG = 0;

        # Audio and Wi-Fi power saving
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 1;

        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
      };
    };
  };
}