{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./server.nix
  ];

  config = {
    environment.systemPackages = (
      with pkgs;
      [
        neovim
        zsh
        fastfetch
        btop
        duf
        tree
        wget
        git
        git-lfs
        yazi
        fd
        bat
        usbutils
        pciutils
        net-tools
        eza
        fzf
        custom.switch
        custom.remote-switch
        custom.update-lock
        custom.switch-check
        custom.cls
        custom.compress
        custom.decompress
      ]
    );
  };
}
