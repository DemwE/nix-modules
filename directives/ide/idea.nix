# IntelliJ IDEA wrapper
# pkgs: { idea }
# pname is "intellij-idea", so the launcher is $out/bin/intellij-idea.
# ~/.jdks/ symlinks (home/demwe/java.nix) let IDEA auto-detect all JDKs.
# LD_LIBRARY_PATH is nixpkgs' job (autoPatchelfHook + buildInputs).
# Node.js for the GitHub Copilot plugin.

pkgs:
let
  wrap = import ./wrap.nix { inherit pkgs; };
in
{
  idea = wrap {
    package = pkgs.unstable.intellij-idea;
    wrapperArgs = ''
      --run 'export PATH="$HOME/.toolchains/nodejs/bin:$PATH"'
    '';
  };
}
