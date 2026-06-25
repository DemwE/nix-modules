# Liberica JDK 17 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java17*, bin/javac17*, …
# pkgs: { java17 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java17 = mkLiberica {
    featureVersion = 17;
    version        = "17.0.18+10";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.18+10/bellsoft-jdk17.0.18+10-linux-amd64.tar.gz";
    sha256         = "sha256-uJ7yaEcewFxyFx0D+84A+Z9t+HzaBH7AZFyxwSQhMfg=";
  };
}
