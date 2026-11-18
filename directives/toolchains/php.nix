# pkgs: { toolchain-php }

pkgs: {
  toolchain-php = pkgs.symlinkJoin {
    name = "toolchain-php";
    paths = [
      pkgs.php85
      pkgs.php85Packages.composer
    ];
  };
}
