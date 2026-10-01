# Liberica JDK 11 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java11*, bin/javac11*, …
# pkgs: { java11, java11-full, jre11 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.32.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.32.1+1/bellsoft-jdk11.0.32.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-aMacC/MSR9m1P1amJ9KQmImE373MrKfy/gLCI1hB+Kw=";
  };
  java11-full = mkLiberica {
    featureVersion = 11;
    version        = "11.0.32.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.32.1+1/bellsoft-jdk11.0.32.1+1-linux-amd64-full.tar.gz";
    sha256         = "sha256-yJxHCo6yL9Dy5OMLmj6mmAU7Q1lmIYVuKfRZzHjf8BE=";
  };
  jre11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.32.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.32.1+1/bellsoft-jre11.0.32.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-8cooEixHyqSLfcInJOO7TEAEwjCHyPej8d0BgFjOdeY=";
  };
}
