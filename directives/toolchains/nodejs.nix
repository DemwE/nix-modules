# Node.js toolchain: pnpm, nodejs
# pkgs: { toolchain-nodejs }

pkgs: {
  toolchain-nodejs = pkgs.symlinkJoin {
    name = "toolchain-nodejs";
    paths = [
      pkgs.unstable.pnpm
      pkgs.nodejs_26
    ];
  };
}
