# Switch to a specific NixOS host
# Usage: boot <hostname>

pkgs: {
  boot = pkgs.writeShellApplication {
    name = "boot";
    runtimeInputs = [ pkgs.nh ];
    text = ''
      if [ -z "$1" ]; then
        echo "Usage: boot <hostname>"
        exit 1
      fi
      HOST="$1"
      shift
      echo "Building host: $HOST"
      exec nh os boot /home/nixos-configs --hostname "$HOST" "$@"
    '';
  };
}
