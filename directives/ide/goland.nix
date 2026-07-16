# GoLand package definition
# pkgs: { goland }
# Note: ~/.pyenv/versions/ symlinks (created by home/demwe/python.nix) let GoLand auto-detect Python interpreters.
# ~/.toolchains/nodejs/bin injected so the GitHub Copilot plugin can find Node.js.

pkgs:
{
  goland = pkgs.unstable.jetbrains.goland.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/goland \
        --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  });
}
