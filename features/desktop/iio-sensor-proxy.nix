{ lib, config, ... }:
/*
  Feature: iio-sensor-proxy + HPD (Human Presence Detection)
  Provides: Ambient-light, accelerometer, and proximity sensor support.
  Enabling this feature will:
   - start the iio-sensor-proxy daemon
   - expose the hardware IIO sensors to GNOME
  GNOME uses the proximity sensor for:
   - "Screen Lift" — wake on approach
   - "Idle Dim" — dim/lock when you walk away
*/
let
  cfg = config.my.features.iioSensorProxy;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.iioSensorProxy.enable =
    mkEnableOption "Enable IIO sensor proxy for HPD, ambient light and orientation";

  config = mkIf cfg.enable {
    hardware.sensor.iio.enable = true;
  };
}
