# Liberica JDK 17 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java17*, bin/javac17*, …
# pkgs: { java17, java17-full, jre17 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java17 = mkLiberica {
    featureVersion = 17;
    version        = "17.0.19+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.19+11/bellsoft-jdk17.0.19+11-linux-amd64.tar.gz";
    sha256         = "sha256-BxMOgAIhtx4sTvBNoRXSVfk/Qt3k4csMgm+LW5KNJ60=";
  };
  java17-full = mkLiberica {
    featureVersion = 17;
    version        = "17.0.19+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.19+11/bellsoft-jdk17.0.19+11-linux-amd64-full.tar.gz";
    sha256         = "sha256-p4csSWSNXQo2ko1IJbVbmmxbqkh8bTWJZ/rqM421pR4=";
  };
  jre17 = mkLiberica {
    featureVersion = 17;
    version        = "17.0.19+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/17.0.19+11/bellsoft-jre17.0.19+11-linux-amd64.tar.gz";
    sha256         = "sha256-iq1QlAfPhwGjTfhbntQ3Vp5UKGO9nmv0wkY784+Guik=";
  };
}
