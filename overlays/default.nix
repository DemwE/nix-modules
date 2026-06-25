{ ... }:
{
  nixpkgs.overlays = [
    (import ./custom.nix)
    (import ./stable.nix)
  ];
}
