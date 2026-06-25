# Rust toolchain: rustup, rust-analyzer, gcc, gnumake, pkg-config
# pkgs: { toolchain-rust }
# rustup manages rustc/cargo/clippy/rustfmt via shims in ~/.cargo/bin/ (in sessionPath)
# rust-analyzer exposed for editors (neovim LSP etc.) independently of rustup

pkgs: {
  toolchain-rust = pkgs.symlinkJoin {
    name = "toolchain-rust";
    paths = [
      pkgs.rustup
      pkgs.rust-analyzer
      pkgs.gcc
      pkgs.gnumake
      pkgs.pkg-config
    ];
  };
}
