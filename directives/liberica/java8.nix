# Liberica JDK 8 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java8*, bin/javac8*, …
# pkgs: { java8, java8-full, jre8 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java8 = mkLiberica {
    featureVersion = 8;
    version        = "8u502+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u502+9/bellsoft-jdk8u502+9-linux-amd64.tar.gz";
    sha256         = "sha256-mHgRaxHLSIheilyFBwcnKaG/9FZ2z7dcrcgRIXtwg3U=";
  };
  java8-full = mkLiberica {
    featureVersion = 8;
    version        = "8u502+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u502+9/bellsoft-jdk8u502+9-linux-amd64-full.tar.gz";
    sha256         = "sha256-O3BoiqNQKy6yDDxFJ4PALyjpPSZuVkpFQChu+1cuWgY=";
  };
  jre8 = mkLiberica {
    featureVersion = 8;
    version        = "8u502+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/8u502+9/bellsoft-jre8u502+9-linux-amd64.tar.gz";
    sha256         = "sha256-9FRkRcPGeC1rrJKnxDpAKsadIsAZwVQTEHR+zdAqQRs=";
  };
}
