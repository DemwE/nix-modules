{ ... }:
{
  imports = [
    # Base independent modules
    ./theme/core.nix
    ./overlays

    # Common modules (available for all hosts)
    ./common/boot/default.nix
    ./common/networking/default.nix
    ./common/services/default.nix
    ./common/packages/default.nix

    # Aggregated collections
    ./system
    ./features
  ];
}
