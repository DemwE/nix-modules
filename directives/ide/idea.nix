# IntelliJ IDEA package definition with Java toolchain in PATH
# pkgs: { idea }
# Note: ~/.jdks/ symlinks (created by home/demwe/java.nix) let IDEA auto-detect all JDK versions.
# ~/.toolchains/nodejs/bin injected so the GitHub Copilot plugin can find Node.js.

pkgs:
let
  composeDeps = with pkgs; [
    libGL
    fontconfig
    freetype
    libX11
    libXcursor
    libXi
    libXrandr
    stdenv.cc.cc.lib
    zlib
    mesa
  ];

  composeLibPath = pkgs.lib.makeLibraryPath composeDeps;
in
{
  idea = pkgs.unstable.jetbrains.idea.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];

    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/idea \
        --prefix PATH : "\$HOME/.toolchains/nodejs/bin" \
        --prefix LD_LIBRARY_PATH : "${composeLibPath}"
    '';
  });
}
