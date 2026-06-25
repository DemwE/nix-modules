{ pkgs, ... }:
{
  # Base graphics stack — vendor-agnostic.
  # Intel VA-API lives here (not in nvidia.nix) so iGPU decoding works
  # regardless of whether the NVIDIA feature is enabled.

  # Force all VA-API consumers (GStreamer, mpv, ffmpeg, browsers…) to use
  # Intel iHD driver by default. NVIDIA NVDEC is opt-in via PRIME env vars
  environment.variables.LIBVA_DRIVER_NAME = "iHD";
  hardware.graphics = {
    enable = true;

    # 32-bit support required by Steam, Wine, Proton, etc.
    enable32Bit = true;

    extraPackages = with pkgs; [
      # Intel iGPU VA-API driver (Gen 8+ / Broadwell+)
      intel-media-driver
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      # VA-API runtime libs for 32-bit apps (Steam/Proton)
      libva
    ];
  };
}
