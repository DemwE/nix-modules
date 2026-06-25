# Python toolchain
# pkgs: { toolchain-python }

pkgs: {
  toolchain-python = pkgs.symlinkJoin {
    name = "toolchain-python";
    paths = [
      pkgs.python313
    ];
  };
}

