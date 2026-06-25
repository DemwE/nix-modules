{
  lib,
  pkgs,
  pkgs-unstable ? null,
  config,
  ...
}:
{
  options.my.boot = {
    kernel = lib.mkOption {
      type = lib.types.enum [
        "stable"
        "unstable"
        "lts"
      ];
      default = "stable";
      description = "Kernel version to use";
    };
  };

  config = {
    boot.kernelPackages =
      if config.my.boot.kernel == "unstable" && pkgs-unstable != null then
        pkgs-unstable.linuxPackages_latest
      else if config.my.boot.kernel == "lts" then
        pkgs.linuxPackages_6_6
      else
        pkgs.linuxPackages;
  };
}
