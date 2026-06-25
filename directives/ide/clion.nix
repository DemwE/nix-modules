# CLion package definition
# pkgs: { clion }
# Toolchain pre-seeded via ~/.config/JetBrains/CLion*/options/linux/toolchains.xml
# (managed by home/demwe/cpp.nix — analogous to java.nix for IDEA)
# ~/.toolchains/nodejs/bin injected so the GitHub Copilot plugin can find Node.js.

pkgs:
{
  clion = pkgs.unstable.jetbrains.clion.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/clion \
        --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  });
}
