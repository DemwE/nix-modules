# Rider wrapper
# pkgs: { rider }
# DOTNET_ROOT is the standard .NET SDK discovery mechanism.
# Node.js for the GitHub Copilot plugin.

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  rider = wrap {
    package = pkgs.unstable.rider;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"' \
      --run 'export DOTNET_ROOT="$HOME/.toolchains/dotnet"'
    '';
  };
}
