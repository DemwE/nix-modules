{ lib, config, pkgs, ... }:
let
  cfg = config.my.features.polkit;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.polkit.enable = mkEnableOption "Enable polkit agent and base policy rules";
  config = mkIf cfg.enable {
    # User session service launching the GTK polkit agent
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "Polkit authentication agent (GTK)";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
        Environment = [ "GTK_THEME=${config.my.theme.gtkTheme}" ];
      };
    };
    # Core polkit daemon
    security.polkit.enable = true;
    # Custom rule: allow reboot/poweroff without re‑auth for normal users
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("users") && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )) { return polkit.Result.YES; }
      });
    '';
  };
}
