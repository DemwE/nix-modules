# Liberica JDK 8 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java8*, bin/javac8*, …
# pkgs: { java8, java8-full, jre8 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java8 = mkLiberica {
    featureVersion = 8;
    version        = "8u492+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u492+9/bellsoft-jdk8u492+9-linux-amd64.tar.gz";
    sha256         = "sha256-I9Ub8QYGdCXJT5KG0e51eaESoBroz3/WmzqSDgiKe+U=";
  };
  java8-full = mkLiberica {
    featureVersion = 8;
    version        = "8u492+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u492+9/bellsoft-jdk8u492+9-linux-amd64-full.tar.gz";
    sha256         = "sha256-5HxH1Vie0z0fw+sozn6oOSvLPBsNWFqxjUwbt6kFVl4=";
  };
  jre8 = mkLiberica {
    featureVersion = 8;
    version        = "8u492+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u492+9/bellsoft-jre8u492+9-linux-amd64.tar.gz";
    sha256         = "sha256-yKfEGEgfsuNa9aavsrwCpoYs4/MNiis4/Z8YzYuHrgc=";
  };
}
