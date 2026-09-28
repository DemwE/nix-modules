# DataGrip wrapper
# pkgs: { datagrip }
# Node.js for plugins (GitHub Copilot).

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  datagrip = wrap {
    package = pkgs.unstable.datagrip;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  };
}
