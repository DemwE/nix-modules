# PyCharm wrapper
# pkgs: { pycharm }
# ~/.pyenv/versions/ symlinks (home/demwe/python.nix) let PyCharm auto-detect
# interpreters. Node.js for the GitHub Copilot plugin.

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  pycharm = wrap {
    package = pkgs.unstable.pycharm;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  };
}
