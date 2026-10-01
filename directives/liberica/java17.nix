# Liberica JDK 17 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java17*, bin/javac17*, …
# pkgs: { java17, java17-full, jre17 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java17 = mkLiberica {
    featureVersion = 17;
    version        = "17.0.20.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.20.1+1/bellsoft-jdk17.0.20.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-jjrSX+r+qG4sH5/+EdyhdXoCFZLPSfQcawhtXKWLl54=";
  };
  java17-full = mkLiberica {
    featureVersion = 17;
    version        = "17.0.20.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.20.1+1/bellsoft-jdk17.0.20.1+1-linux-amd64-full.tar.gz";
    sha256         = "sha256-UFgW2KFkAX+V/twu71zO1jgIJxQ0yTGfbHiCQywwf7Y=";
  };
  jre17 = mkLiberica {
    featureVersion = 17;
    version        = "17.0.20.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.20.1+1/bellsoft-jre17.0.20.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-iZafRUbhBtip470RBMRev64BEHVplH0JuuOxilr6hsk=";
  };
}
