# Haskell toolchain: haskell
# pkgs: { toolchain-haskell }

pkgs: {
  toolchain-haskell = pkgs.symlinkJoin {
    name = "toolchain-haskell";
    paths = [
      pkgs.unstable.haskellPackages.ghc
      pkgs.unstable.haskellPackages.cabal-install
    ];
  };
}
