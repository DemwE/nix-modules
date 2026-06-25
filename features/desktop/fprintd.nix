{ lib, config, ... }:
/*
  Feature: fprintd (Fingerprint Reader)
  Provides: Fingerprint authentication for all PAM services
            (login, sudo, polkit, screensaver, etc.).
  When services.fprintd.enable = true, NixOS automatically wires
  fprintd into every PAM service via security.pam.services.<name>.fprintd.
  After first rebuild, run: fprintd-enroll
  to register your fingerprint.
*/
let
  cfg = config.my.features.fprintd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.fprintd.enable =
    mkEnableOption "Enable fingerprint reader support via fprintd";

  config = mkIf cfg.enable {
    services.fprintd.enable = true;
    # By default pam_fprintd.so retries 3 times before falling through to
    # password. Set max_tries=1 so a single failed scan (or just lifting your
    # finger) immediately falls back to the password prompt.
    security.pam.services.sudo.rules.auth.fprintd.args = [ "max_tries=2" ];
    security.pam.services.polkit-1.rules.auth.fprintd.args = [ "max_tries=2" ];
  };
}
