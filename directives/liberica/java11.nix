# Liberica JDK 11 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java11*, bin/javac11*, …
# pkgs: { java11, java11-full, jre11 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.32+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.32+11/bellsoft-jdk11.0.32+11-linux-amd64.tar.gz";
    sha256         = "sha256-YW8u05awkKXmp9QfsrhSP7iqdX5XcaUGFc1UNwYF1mg=";
  };
  java11-full = mkLiberica {
    featureVersion = 11;
    version        = "11.0.32+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.32+11/bellsoft-jdk11.0.32+11-linux-amd64-full.tar.gz";
    sha256         = "sha256-jkGslD7COdpCQxBZjToQLSLVyJ74SZV9wDx7HY4sLBo=";
  };
  jre11 = mkLiberica {
    featureVersion = 11;
    version        = "11.0.32+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/11.0.32+11/bellsoft-jre11.0.32+11-linux-amd64.tar.gz";
    sha256         = "sha256-NMra+ZXikDn0XCkVs3GlNoXkGWoVXGVNg7X7H6De474=";
  };
}
