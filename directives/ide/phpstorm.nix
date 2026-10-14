# PHPStorm wrapper
# pkgs: { phpstorm }
# ~/.toolchains/nodejs/bin is a stable symlink (home/demwe/toolchains.nix);
# per-version installs come from ~/.nvm/versions/node/ (home/demwe/nodejs.nix).

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  phpstorm = wrap {
    package = pkgs.unstable.jetbrains.phpstorm;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  };
}
