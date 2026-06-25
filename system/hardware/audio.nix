{ ... }:
/*
  Audio stack module
  Provides PipeWire (with ALSA 32‑bit, PulseAudio compatibility, JACK) and rtkit scheduling.
*/
{
  security.rtkit.enable = true; # Realtime permissions for low-latency audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; # PulseAudio compatibility layer
    jack.enable = true; # JACK emulation

    extraConfig.pipewire."92-low-latency" = {
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

    extraConfig.pipewire-pulse."92-pulse-max" = {
      "pulse.properties" = {
        "pulse.default.format" = "S32LE";
        "pulse.default.rate" = 192000;
      };
    };
  };
}
