{ lib, config, ... }:
let
  cfg = config.my.audio;
  inherit (lib) mkOption types mkIf;
in
{
  options.my.audio.quality = mkOption {
    type = types.enum [ "normal" "high" ];
    default = "high";
    description = ''
      Audio quality preset.
      - high: 192kHz sample rate, S32LE format, wide allowed-rates range
      - normal: 48kHz sample rate, S16LE format, standard allowed-rates
    '';
  };

  config = {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.pipewire.extraConfig = mkIf (cfg.quality == "high") {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 192000;
          "default.clock.allowed-rates" = [
            44100
            48000
            88200
            96000
            176400
            192000
          ];
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 8192;
        };
      };

      pipewire-pulse."92-pulse-max" = {
        "pulse.properties" = {
          "pulse.default.format" = "S32LE";
          "pulse.default.rate" = 192000;
        };
      };
    };
  };
}
