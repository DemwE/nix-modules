# Liberica JDK 8 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java8*, bin/javac8*, …
# pkgs: { java8 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java8 = mkLiberica {
    featureVersion = 8;
    version        = "8u482+10";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u482+10/bellsoft-jdk8u482+10-linux-amd64.tar.gz";
    sha256         = "sha256-RVoUob8nLduS8x1bS7Hx2Y3AQtwmHl45s0vWAByeEYM=";
  };
}
