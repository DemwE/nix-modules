{ ... }:
{
  # Enable weekly TRIM for SSDs
  services.fstrim.enable = true;

  # Memory pressure helpers
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # 50% RAM as zram
  };

  systemd.oomd = {
    enable = true;
    enableUserSlices = true;
  };
}
