# Switch to a specific NixOS host
# Usage: switch <hostname>

pkgs: {
  switch = pkgs.writeShellApplication {
    name = "switch";
    runtimeInputs = [ pkgs.nh ];
    text = ''
      if [ -z "$1" ]; then
        echo "Usage: switch <hostname>"
        exit 1
      fi
      HOST="$1"
      shift
      echo "Building host: $HOST"
      exec nh os switch /home/nixos-configs --hostname "$HOST" "$@"
    '';
  };
}
