# WebStorm package definition
# pkgs: { webstorm }
# Uses ~/.toolchains/nodejs/bin — stable symlink managed by home-manager (toolchains.nix)
# Node.js versions detected via ~/.nvm/versions/node/ symlinks (home/demwe/nodejs.nix)

pkgs: {
  webstorm = pkgs.unstable.jetbrains.webstorm.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/webstorm \
        --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  });
}
