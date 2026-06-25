pkgs: {
  beets = pkgs.unstable.beets.overridePythonAttrs (old: {
    propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [
      pkgs.unstable.python3Packages.pillow
      pkgs.unstable.python3Packages.spotipy
    ];

    postPatch = (old.postPatch or "") + ''
      substituteInPlace beetsplug/fetchart.py \
        --replace "1200x1200bb" "2400x2400bb.png" \
        --replace "1200x1200bb-100" "2400x2400bb-100" \
        --replace "100000x100000-999" "4000x4000bb.png"
    '';
  });
}