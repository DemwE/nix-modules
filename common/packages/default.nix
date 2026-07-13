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
        custom.boot
        custom.remote-switch
        custom.update-lock
        custom.cls
        custom.compress
        custom.decompress
      ]
    );
  };
}
