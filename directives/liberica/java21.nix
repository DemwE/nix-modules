# Liberica JDK 21 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java21*, bin/javac21*, …
# pkgs: { java21, java21-full, jre21 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.12.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.12.1+1/bellsoft-jdk21.0.12.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-lK4YpmUnpU669EkCeeA2MfzEfb8mKGPwmaycj19SWkk=";
  };
  java21-full = mkLiberica {
    featureVersion = 21;
    version        = "21.0.12.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.12.1+1/bellsoft-jdk21.0.12.1+1-linux-amd64-full.tar.gz";
    sha256         = "sha256-5d8ZNkTSn0c20V7ZChQgafTq0TtO18NBYp1FxujTOWg=";
  };
  jre21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.12.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.12.1+1/bellsoft-jre21.0.12.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-wKfayPjYpjHto2MOEjEI4TUHBRs+Ya3Ofh7jVPzZd3Y=";
  };
}
