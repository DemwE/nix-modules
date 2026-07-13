# Odin toolchain: odin
# pkgs: { toolchain-odin }

pkgs: {
  toolchain-odin = pkgs.symlinkJoin {
    name = "toolchain-odin";
    paths = [
      pkgs.unstable.odin
      pkgs.unstable.ols
    ];
  };
}
