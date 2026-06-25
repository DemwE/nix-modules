# Liberica JDK 25 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java25*, bin/javac25*, …
# pkgs: { java25 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.2+12";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.2+12/bellsoft-jdk25.0.2+12-linux-amd64.tar.gz";
    sha256         = "sha256-jcP0RRsK/+AKbU2gqiMxJAv30UKjU/9SlnNQH4vQnEo=";
  };
}
