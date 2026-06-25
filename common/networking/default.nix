{
  lib,
  pkgs,
  pkgs-unstable ? null,
  config,
  ...
}:
{
  options.my.networking = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "NixOS";
      description = "System hostname";
    };
    openvpn = lib.mkEnableOption "Enable OpenVPN plugin for NetworkManager";

    firewall = {
      enable = lib.mkEnableOption "Enable firewall";

      allowedTCPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "TCP ports to open in the firewall.";
      };

      allowedTCPPortRanges = lib.mkOption {
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              from = lib.mkOption {
                type = lib.types.port;
                description = "Start of the TCP port range.";
              };

              to = lib.mkOption {
                type = lib.types.port;
                description = "End of the TCP port range.";
              };
            };
          }
        );
        default = [ ];
        description = "TCP port ranges to open in the firewall.";
      };

      allowedUDPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "UDP ports to open in the firewall.";
      };

      allowedUDPPortRanges = lib.mkOption {
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              from = lib.mkOption {
                type = lib.types.port;
                description = "Start of the UDP port range.";
              };

              to = lib.mkOption {
                type = lib.types.port;
                description = "End of the UDP port range.";
              };
            };
          }
        );
        default = [ ];
        description = "UDP port ranges to open in the firewall.";
      };
    };
  };

  config = {
    networking.hostName = config.my.networking.hostname;
    networking.networkmanager.enable = true;

    networking.networkmanager.plugins = lib.mkIf config.my.networking.openvpn [
      (
        if pkgs-unstable != null then pkgs-unstable.networkmanager-openvpn else pkgs.networkmanager-openvpn
      )
    ];

    networking.firewall = lib.mkIf config.my.networking.firewall.enable {
      enable = true;
      allowedTCPPorts = config.my.networking.firewall.allowedTCPPorts;
      allowedTCPPortRanges = config.my.networking.firewall.allowedTCPPortRanges;
      allowedUDPPorts = config.my.networking.firewall.allowedUDPPorts;
      allowedUDPPortRanges = config.my.networking.firewall.allowedUDPPortRanges;
    };

    networking.hosts = {
      "127.0.0.1" = [ "lh.me" ];
    };

    networking.networkmanager.dhcp = "internal";
    networking.networkmanager.dns = lib.mkForce "none";
    networking.networkmanager.wifi.backend = "iwd";

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = "true";
        DNSOverTLS = "opportunistic";
        Domains = [ "~." ];
        DNS = [
          # ipv4 main
          "1.1.1.1#cloudflare-dns.com"
          "8.8.8.8#dns.google"
          # ivp4 fallback
          "1.0.0.1#cloudflare-dns.com"
          "8.8.4.4#dns.google"
          # ipv6 main
          "2606:4700:4700::1111#cloudflare-dns.com"
          "2001:4860:4860::8888#dns.google"
          # ipv6 fallback
          "2606:4700:4700::1001#cloudflare-dns.com"
          "2001:4860:4860::8844#dns.google"
        ];
      };
    };

    boot.kernel.sysctl."net.ipv6.conf.all.use_tempaddr" = 2;
  };
}
