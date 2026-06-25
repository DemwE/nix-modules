{ pkgs, lib, config, ... }:
let
  hasNvidiaFgpm = config.my.features.nvidia.finegrainedPowerManagement or false;

  mkPowerScript = name: body: pkgs.writeShellScriptBin name ''
    set -euo pipefail
    if [[ $EUID -ne 0 ]]; then
      exec sudo "$0" "$@"
    fi
    ${body}
  '';

  # Standalone wrappers — delegate CPU to PPD, hook handles turbo + NVIDIA automatically.
  powerSave    = mkPowerScript "power-save"        ''${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver'';
  balanced     = mkPowerScript "power-balanced"    ''${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced'';
  performance  = mkPowerScript "power-performance" ''${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance'';

  # ── Status ────────────────────────────────────────────────────────────────────
  powerStatus = pkgs.writeShellScriptBin "power-status" ''
    echo "── Active PPD profile ──"
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl 2>/dev/null || echo "(PPD not running)"

    echo ""
    echo "── CPU governors ──"
    grep . /sys/devices/system/cpu/cpu{0,1,2,3}/cpufreq/scaling_governor 2>/dev/null | head -4

    echo ""
    echo "── Turbo ──"
    if [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]]; then
      no_turbo=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)
      [[ "$no_turbo" == "1" ]] && echo "off" || echo "on"
    fi

    ${lib.optionalString hasNvidiaFgpm ''
    echo ""
    echo "── NVIDIA power control ──"
    for dev in /sys/bus/pci/devices/*/power/control; do
      vendor=$(cat "$(dirname "$dev")/vendor" 2>/dev/null || true)
      if [[ "$vendor" == "0x10de" ]]; then
        echo "$dev -> $(cat "$dev")"
      fi
    done
    ''}
  '';

  # ── D-Bus hook: only handles turbo + NVIDIA, PPD owns the CPU ─────────────────
  ppdHookScript = pkgs.writeShellScript "ppd-hook" ''
    set -euo pipefail
    export PATH=${lib.makeBinPath [ pkgs.glib pkgs.gnugrep pkgs.coreutils ]}:$PATH

    apply_extras() {
      local profile="$1"
      case "$profile" in
        power-saver)
          [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]] && \
            echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
          ${lib.optionalString hasNvidiaFgpm ''
          for dev in /sys/bus/pci/devices/*/power/control; do
            echo auto > "$dev" 2>/dev/null || true
          done
          ''}
          ;;
        balanced)
          [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]] && \
            echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
          ${lib.optionalString hasNvidiaFgpm ''
          for dev in /sys/bus/pci/devices/*/power/control; do
            echo auto > "$dev" 2>/dev/null || true
          done
          ''}
          ;;
        performance)
          [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]] && \
            echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
          ${lib.optionalString hasNvidiaFgpm ''
          for dev in /sys/bus/pci/devices/*/power/control; do
            echo on > "$dev" 2>/dev/null || true
          done
          ''}
          ;;
      esac
      echo "[ppd-hook] extras applied for: $profile"
    }

    # Apply extras for current profile on service start
    current=$(gdbus call --system \
      --dest net.hadess.PowerProfiles \
      --object-path /net/hadess/PowerProfiles \
      --method org.freedesktop.DBus.Properties.Get \
      net.hadess.PowerProfiles ActiveProfile 2>/dev/null \
      | grep -oP "(?<=<')[^']+" || echo "balanced")
    echo "[ppd-hook] startup profile: $current"
    apply_extras "$current"

    # Watch for profile changes via D-Bus — apply extras only, never touch CPU governor
    gdbus monitor --system \
      --dest net.hadess.PowerProfiles \
      --object-path /net/hadess/PowerProfiles 2>/dev/null \
    | while IFS= read -r line; do
        if echo "$line" | grep -q "ActiveProfile"; then
          profile=$(echo "$line" | grep -oP "(?<=<')[^']+")
          echo "[ppd-hook] profile changed → $profile"
          apply_extras "$profile"
        fi
      done
  '';
in
{
  services.power-profiles-daemon.enable = true;

  systemd.services.ppd-hook = {
    description = "Custom power profile hooks (NVIDIA, turbo) on top of PPD";
    
    after = [ "power-profiles-daemon.service" "dbus.service" ];
    requires = [ "power-profiles-daemon.service" ];
    bindsTo = [ "power-profiles-daemon.service" ];
    wantedBy = [ "power-profiles-daemon.service" ]; 
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "3s";
      ExecStart = ppdHookScript;
    };
  };

  environment.systemPackages = [ powerSave balanced performance powerStatus ];

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = map (script: {
        command = "${script}/bin/${script.name}";
        options = [ "NOPASSWD" ];
      }) [ powerSave balanced performance ];
    }
  ];
}
