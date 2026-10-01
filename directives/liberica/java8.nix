# Liberica JDK 8 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java8*, bin/javac8*, …
# pkgs: { java8, java8-full, jre8 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java8 = mkLiberica {
    featureVersion = 8;
    version        = "8u504+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u504+1/bellsoft-jdk8u504+1-linux-amd64.tar.gz";
    sha256         = "sha256-pynMqg1dem0faL9nieAkRNpIKkFXqJGqAfKk5kvu/BU=";
  };
  java8-full = mkLiberica {
    featureVersion = 8;
    version        = "8u504+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u504+1/bellsoft-jdk8u504+1-linux-amd64-full.tar.gz";
    sha256         = "sha256-EJYef8gTpsp2zUz6tuW8tK9CWsT1xhzDVXnJtbLrs9o=";
  };
  jre8 = mkLiberica {
    featureVersion = 8;
    version        = "8u504+1";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u504+1/bellsoft-jre8u504+1-linux-amd64.tar.gz";
    sha256         = "sha256-kxQgB5lqe/5Cvc9DN6mygyXQyD/K6huuCIQ3U+jKeZA=";
  };
}
