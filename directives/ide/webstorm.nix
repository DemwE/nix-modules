# WebStorm wrapper
# pkgs: { webstorm }
# ~/.toolchains/nodejs/bin is a stable symlink (home/demwe/toolchains.nix);
# per-version installs come from ~/.nvm/versions/node/ (home/demwe/nodejs.nix).

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  webstorm = wrap {
    package = pkgs.unstable.webstorm;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  };
}
