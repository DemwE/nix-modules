pkgs: {
  eartag = pkgs.unstable.eartag.overridePythonAttrs (old: {
    propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [
      pkgs.unstable.python3Packages.aiohttp-retry
    ];
  });
}
