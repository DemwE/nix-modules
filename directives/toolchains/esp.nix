# pkgs: { toolchain-esp }

pkgs: {
  toolchain-esp = pkgs.symlinkJoin {
    name = "toolchain-esp";
    paths = [
      pkgs.espflash
      pkgs.probe-rs-tools
      pkgs.esp-generate
      pkgs.espup
    ];
  };
}
