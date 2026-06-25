{ ... }:
{
  # Aggregate core system modules for simpler host import.
  imports = [
    ./core/locale-input.nix
    ./core/nix-settings.nix
    ./core/shell.nix
    ./core/fonts.nix
    ./hardware/audio.nix
    ./hardware/graphics.nix
    ./services/housekeeping.nix
    ./hardware/power-profiles.nix
  ];
}
