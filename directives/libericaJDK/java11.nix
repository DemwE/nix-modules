# Liberica JDK 11 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java11*, bin/javac11*, …
# pkgs: { java11 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.30+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.30+9/bellsoft-jdk11.0.30+9-linux-amd64.tar.gz";
    sha256         = "sha256-Fxf3RVL25XevI+4QgNaYsl+Hvf4V9bHQI+EQooka/i8=";
  };
}
