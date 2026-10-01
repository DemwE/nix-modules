# Liberica JDK 25 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java25*, bin/javac25*, …
# pkgs: { java25, java25-full, jre25 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.4.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.4.1+1/bellsoft-jdk25.0.4.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-rLXMWr3Cuurs+j7FulYJvqZxIeuZAEsnA205f0p5wVI=";
  };
  java25-full = mkLiberica {
    featureVersion = 25;
    version        = "25.0.4.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.4.1+1/bellsoft-jdk25.0.4.1+1-linux-amd64-full.tar.gz";
    sha256         = "sha256-dN5phjz6jVjdSZkqlySa0EEWmtAdqhSlRe+cfvFzy9A=";
  };
  jre25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.4.1+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.4.1+1/bellsoft-jre25.0.4.1+1-linux-amd64.tar.gz";
    sha256         = "sha256-yeKzgdyzoPN4t7fRi76/8NLFfmRQqe9jLCtMxKlngwM=";
  };
}
