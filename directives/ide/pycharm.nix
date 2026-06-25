# PyCharm package definition
# pkgs: { pycharm }
# Note: ~/.pyenv/versions/ symlinks (created by home/demwe/python.nix) let PyCharm auto-detect Python interpreters.
# ~/.toolchains/nodejs/bin injected so the GitHub Copilot plugin can find Node.js.

pkgs:
{
  pycharm = pkgs.unstable.jetbrains.pycharm.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/pycharm \
        --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  });
}
