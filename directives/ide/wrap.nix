# Wraps an already-built IDE instead of rebuilding it.
# overrideAttrs + postInstall changes the drv hash and re-runs the whole ~2 GB
# build; symlinkJoin is a trivial drv: lndir links the existing store path and
# wrapProgram re-wraps only the launcher.
#
# nixpkgs already sets PATH/LD_LIBRARY_PATH/JAVA_HOME in its own wrapper
# (jetbrains/builder/linux.nix). Ours is the outer layer, so these entries end
# up ahead of the session PATH.
#
# Gotcha: pass env as --run 'export VAR="..."'. --prefix/--set/--set-default
# quote via ${value@Q}, so $HOME stays literal and is never expanded.

{ pkgs }:
{
  package,
  wrapperArgs ? "",
}:
let
  launcher = package.meta.mainProgram;
in
pkgs.symlinkJoin {
  pname = package.pname;
  version = package.version;
  meta = package.meta;
  paths = [ package ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram "$out/bin/${launcher}" ${wrapperArgs}
  '';
}
