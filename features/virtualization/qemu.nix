{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.features.qemu;
  inherit (lib) mkEnableOption mkIf mkMerge;
in
{
  options.my.features.qemu.enable =
    mkEnableOption "Enable full virtualization stack (libvirtd + QEMU + OVMF + swtpm + virt-manager)";
  config = mkIf cfg.enable (mkMerge [
    {
      # libvirtd core daemon with QEMU backend configuration
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true; # needed for some device passthrough scenarios
          swtpm.enable = true; # provide virtual TPM
          # ovmf = {
          #   enable = true;
          #   packages = [
          #     (pkgs.OVMF.override {
          #       secureBoot = true;
          #       tpmSupport = true;
          #     }).fd
          #   ];
          # };
        };
      };
      # Tooling packages (CLI + GUI)
      environment.systemPackages = [
        pkgs.qemu
        pkgs.virt-manager
      ];
      programs.virt-manager.enable = true;
      services.spice-vdagentd.enable = true;
      # Ensure libvirtd group exists so user membership can be added elsewhere
      users.groups.libvirtd = { };
    }
  ]);
}
