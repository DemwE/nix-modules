# C/C++ toolchain: gcc, clang, cmake, gnumake, gdb, lldb, pkg-config
# pkgs: { toolchain-cpp }

pkgs: {
  toolchain-cpp = pkgs.symlinkJoin {
    name = "toolchain-cpp";
    paths = [
      pkgs.gcc
      pkgs.clang
      pkgs.cmake
      pkgs.gnumake
      pkgs.ninja
      pkgs.gdb
      pkgs.lldb
      pkgs.pkg-config
      pkgs.clang-tools
      pkgs.valgrind
    ];
  };
}
