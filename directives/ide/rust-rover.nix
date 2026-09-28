# RustRover wrapper
# pkgs: { rust-rover }
# Rust toolchain in PATH so it finds rustup even if the session hasn't picked up
# sessionPath yet. Node.js for the GitHub Copilot plugin.

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  rust-rover = wrap {
    package = pkgs.unstable.rust-rover;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$HOME/.toolchains/rust/bin:$HOME/.cargo/bin:$PATH"'
    '';
  };
}
