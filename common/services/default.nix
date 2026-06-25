{ lib, config, pkgs, ... }:
{
  options.my.services = {
    ssh = {
      enable = lib.mkEnableOption "Enable SSH server";
      preservation.enable = lib.mkEnableOption "Preserve SSH host keys across system rebuilds";
    };
    printing = {
      enable = lib.mkEnableOption "Enable printing support (CUPS)";
    };
    storage = {
      enable = lib.mkEnableOption "Enable storage services (udisks2, gvfs)";
    };
    openrgb = {
      enable = lib.mkEnableOption "Enable OpenRGB daemon";
    };
    thermald = {
      enable = lib.mkEnableOption "Enable Intel Themal Daemon (thermald)";
    };
    tailscale = {
      enable = lib.mkEnableOption "Enable Tailscale VPN client";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.my.services.ssh.enable {
      services.openssh = {
        enable = true;
        hostKeys = lib.mkIf config.my.services.ssh.preservation.enable [
          {
            path = "/persist/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
          {
            path = "/persist/ssh/ssh_host_rsa_key";
            type = "rsa";
          }
        ];
      };
    })

    (lib.mkIf config.my.services.printing.enable {
      services.printing = {
        enable = true;
        browsing = true;
        browsed.enable = true;
        openFirewall = true;
        webInterface = true;
        drivers = with pkgs; [
          hplip
          brlaser
        ];
      };
    })

    (lib.mkIf config.my.services.storage.enable {
      services.udisks2.enable = true;
      services.udisks2.mountOnMedia = true;
      services.gvfs.enable = true;
      services.tumbler.enable = true;
    })

    (lib.mkIf config.my.services.openrgb.enable {
      services.hardware.openrgb.enable = true;
    })

    (lib.mkIf config.my.services.thermald.enable {
      services.thermald.enable = true;
    })

    (lib.mkIf config.my.services.tailscale.enable {
      services.tailscale.enable = true;
    })
  ];
}
