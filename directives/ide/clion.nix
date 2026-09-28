# CLion wrapper
# pkgs: { clion }
# Toolchains pre-seeded via ~/.config/JetBrains/CLion*/options/linux/toolchains.xml
# (home/demwe/cpp.nix, same idea as java.nix for IDEA).
# Node.js for the GitHub Copilot plugin.

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  clion = wrap {
    package = pkgs.unstable.clion;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  };
}
