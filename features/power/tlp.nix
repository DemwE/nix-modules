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
    powerManagement.powertop.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersave";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        NVME_PTHR_ON_AC = 10;
        NVME_PTHR_ON_BAT = 10;

        SOUND_POWER_SAVE_ON_AC = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;

        WIFI_PWR_ON_AC = "on";
        WIFI_PWR_ON_BAT = "on";
      };
    };
  };
}
