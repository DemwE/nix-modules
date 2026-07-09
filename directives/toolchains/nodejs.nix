# Node.js toolchain: pnpm, nodejs
# pkgs: { toolchain-nodejs }

pkgs: {
  toolchain-nodejs = pkgs.symlinkJoin {
    name = "toolchain-nodejs";
    paths = [
      pkgs.pnpm
      pkgs.nodejs_26
    ];
  };
}
