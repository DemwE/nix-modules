# Exposes a `pkgs.stable` set pinned to the current release channel
# Now receives pkgs from flake inputs instead of fetchTarball

final: prev: {
  stable = prev.stable or prev.pkgs;
}
