# Liberica JDK 25 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java25*, bin/javac25*, …
# pkgs: { java25, java25-full, jre25 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.3+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.3+11/bellsoft-jdk25.0.3+11-linux-amd64.tar.gz";
    sha256         = "sha256-y81/BfGZuAiop1m7VdFTnuYFLDOXCAfr4V1Le68SAVQ=";
  };
  java25-full = mkLiberica {
    featureVersion = 25;
    version        = "25.0.3+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.3+11/bellsoft-jdk25.0.3+11-linux-amd64-full.tar.gz";
    sha256         = "sha256-LQ4UXEAdDlVemzqtl3o6cA+9ZmvH1FJHICZ92A6zvkI=";
  };
  jre25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.3+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.3+11/bellsoft-jre25.0.3+11-linux-amd64.tar.gz";
    sha256         = "sha256-FNEDdOgujUXGvkY2nGq5/Dywtx/THs708kjsXYIC5oU=";
  };
}
