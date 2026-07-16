# Go toolchain: go
# pkgs: { toolchain-go }

pkgs: {
  toolchain-go = pkgs.symlinkJoin {
    name = "toolchain-go";
    paths = [
      pkgs.unstable.go
    ];
  };
}
