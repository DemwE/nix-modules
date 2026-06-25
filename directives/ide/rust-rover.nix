# rust-rover package definition
# pkgs: { rust-rover }
# Injects ~/.toolchains/rust/bin into PATH so RustRover can find rustup regardless
# of whether the systemd user session has picked up sessionPath changes yet.
# ~/.toolchains/nodejs/bin injected so the GitHub Copilot plugin can find Node.js.

pkgs:
{
  rust-rover = pkgs.unstable.jetbrains.rust-rover.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/rust-rover \
        --run 'export PATH="$HOME/.toolchains/nodejs/bin:$HOME/.toolchains/rust/bin:$HOME/.cargo/bin:$PATH"'
    '';
  });
}
