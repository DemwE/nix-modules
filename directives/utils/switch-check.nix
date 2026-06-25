# Check NixOS host configuration
# Usage: switch-check <hostname>

pkgs: {
  switch-check = pkgs.writeShellApplication {
    name = "switch-check";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      if [ -z "$1" ]; then
        echo "Usage: switch-check <hostname>"
        echo "Available hosts: NixBook DemwEPC"
        exit 1
      fi
      HOST="$1"
      echo "Checking host: $HOST"
      exec sudo nix --extra-experimental-features flakes flake check "/home/nixos-configs#$HOST"
    '';
  };
}
