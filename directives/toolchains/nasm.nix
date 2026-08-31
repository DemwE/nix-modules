# NASM toolchain: nasm
# pkgs: { toolchain-nasm }

pkgs: {
  toolchain-nasm = pkgs.symlinkJoin {
    name = "toolchain-nasm";
    paths = [
      pkgs.nasm
      pkgs.nasmfmt
      pkgs.asm-lsp
    ];
  };
}
