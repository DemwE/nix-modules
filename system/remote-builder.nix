{ config, lib, ... }:
let
  cfg = config.my.remoteBuilder;
  hasBuildHosts = cfg.buildHosts != [ ];
in
{
  options.my.remoteBuilder = {
    config = {
      enableExternalBuilding = lib.mkEnableOption "accept external/distributed builds on this host";

      maxJobs = lib.mkOption {
        type = lib.types.oneOf [
          lib.types.int
          lib.types.str
        ];
        default = "auto";
        description = ''
          Maximum parallel jobs accepted by this host when acting as builder.
          Use "auto" to consume all CPU cores.
        '';
      };

      trustedUsers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "root" ];
        description = "Users trusted by nix-daemon on this host.";
      };
    };

    buildHosts = lib.mkOption {
      default = [ ];
      description = ''
        Remote build hosts in Nix style. Non-empty list enables distributed builds.
        MaxJobs defaults to 0 which lets the remote host limit via its own max-jobs.
      '';
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            hostName = lib.mkOption {
              type = lib.types.str;
              description = "Remote host name or IP.";
              example = "192.168.0.100";
            };

            user = lib.mkOption {
              type = lib.types.str;
              default = "root";
              description = "SSH user used for remote builds.";
            };

            sshKey = lib.mkOption {
              type = lib.types.str;
              default = "/root/.ssh/builder_key";
              description = "Path to SSH private key used by nix-daemon.";
            };

            system = lib.mkOption {
              type = lib.types.str;
              default = "x86_64-linux";
              description = "Target system of remote host.";
            };

            maxJobs = lib.mkOption {
              type = lib.types.int;
              default = 0;
              description = ''
                Maximum jobs delegated to this host.
                0 means rely on remote host capacity (recommended universal default).
              '';
            };

            speedFactor = lib.mkOption {
              type = lib.types.int;
              default = 1;
              description = "Relative speed of remote host.";
            };

            supportedFeatures = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              description = "Optional supported features of remote host.";
            };

            mandatoryFeatures = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              description = "Optional mandatory features required on remote host.";
            };
          };
        }
      );
    };
  };

  config = lib.mkMerge [
    {
      nix.extraOptions = ''
        fallback = true
        connect-timeout = 5
      '';
    }
    
    (lib.mkIf cfg.config.enableExternalBuilding {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
      };

      nix.settings = {
        trusted-users = cfg.config.trustedUsers;
        max-jobs = cfg.config.maxJobs;
      };
    })

    (lib.mkIf hasBuildHosts {
      nix.buildMachines = map (h: {
        inherit (h)
          hostName
          system
          maxJobs
          speedFactor
          supportedFeatures
          mandatoryFeatures
          ;
        sshUser = h.user;
        sshKey = h.sshKey;
      }) cfg.buildHosts;

      nix.distributedBuilds = true;
      nix.settings.builders-use-substitutes = true;
      nix.settings.max-jobs = lib.mkDefault "auto";
    })
  ];
}
