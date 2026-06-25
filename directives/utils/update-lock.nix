# Update flake lock file
# Usage: update-lock

pkgs: {
  update-lock = pkgs.writeShellApplication {
    name = "update-lock";
    text = ''
      echo "Updating flake lock..."
      exec sudo nix --extra-experimental-features 'nix-command flakes' flake update --flake /home/nixos-configs
    '';
  };
}
