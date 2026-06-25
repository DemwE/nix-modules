# Overlay exposing all custom/patched packages under pkgs.custom
# Usage: pkgs.custom.<pkg>
# Package definitions live in modules/directives/default.nix

final: prev:
let
  packages = import ../directives/default.nix final;
in
{
  custom = (prev.custom or { }) // packages;
}
