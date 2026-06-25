# Vintage Story with gamescope wrapper
# pkgs: { vintage-story }

pkgs:
let
  vintagestory = pkgs.unstable.vintagestory;
  gamescope = pkgs.unstable.gamescope;
in
{
  vintage-story = pkgs.symlinkJoin {
    name = "vintagestory-wrapped-${vintagestory.version}";
    paths = [ vintagestory ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      rm $out/bin/vintagestory

      makeWrapper ${gamescope}/bin/gamescope $out/bin/vintagestory \
        --add-flags "-w 1920 -h 1200 -W 3840 -H 2400 -F fsr -f -- ${vintagestory}/bin/vintagestory"

      rm $out/share/applications/vintagestory.desktop
      sed -e 's|Name=Vintage Story|Name=Vintage Story (Gamescope)|' \
          -e 's|Exec=vintagestory|Exec=vintagestory|' \
          ${vintagestory}/share/applications/vintagestory.desktop > $out/share/applications/vintagestory.desktop
    '';
  };
}