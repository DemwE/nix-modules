# Liberica JDK 11 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java11*, bin/javac11*, …
# pkgs: { java11, java11-full, jre11 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.31+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.31+11/bellsoft-jdk11.0.31+11-linux-amd64.tar.gz";
    sha256         = "sha256-V50oP5LkpFo9gJMSq4zrOJDPztZeSOz5qZ53zohjT6Q=";
  };
  java11-full = mkLiberica {
    featureVersion = 11;
    version        = "11.0.31+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.31+11/bellsoft-jdk11.0.31+11-linux-amd64-full.tar.gz";
    sha256         = "sha256-xuWeR0h2GEC/ymuDj4fiGZZWLll4cTgESVbCZ/va1Fk=";
  };
  jre11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.31+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.31+11/bellsoft-jre11.0.31+11-linux-amd64.tar.gz";
    sha256         = "sha256-2RR7MmVOFQlUQS1GyI6PGPBCS/J2LtjFJUwB/xsuj4A=";
  };
}
