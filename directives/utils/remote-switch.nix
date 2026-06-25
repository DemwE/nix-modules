# custom.remote-switch

pkgs: {
  remote-switch = pkgs.writeShellApplication {
    name = "remote-switch";
    runtimeInputs = [ pkgs.nh]; 
    text = ''
      if [ "$#" -lt 2 ]; then
        echo "Usage: remote-switch <hostname> <user@build-host>"
        exit 1
      fi

      HOST="$1"
      BUILD_HOST="$2"

      echo "Redirecting build of $HOST to $BUILD_HOST"

      nh os switch /home/nixos-configs --hostname "$HOST" --build-host "$BUILD_HOST" "''${@:3}"
    '';
  };
}