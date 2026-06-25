# Bun toolchain: bun
# pkgs: { toolchain-bun }

pkgs: {
  toolchain-bun = pkgs.symlinkJoin {
    name = "toolchain-bun";
    paths = [
      pkgs.unstable.bun
    ];
  };
}
