# Liberica JDK 21 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java21*, bin/javac21*, …
# pkgs: { java21, java21-full, jre21 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.11+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.11+11/bellsoft-jdk21.0.11+11-linux-amd64.tar.gz";
    sha256         = "sha256-ItvOkihG614X1q9AOTrG9MFYW1qHui9j1plr8GgrPSs=";
  };
  java21-full = mkLiberica {
    featureVersion = 21;
    version        = "21.0.11+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.11+11/bellsoft-jdk21.0.11+11-linux-amd64-full.tar.gz";
    sha256         = "sha256-KXgbpRpMDJHorhOlByUuhZWO5DAS0/79GOk5hL2wiJM=";
  };
  jre21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.11+11";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.11+11/bellsoft-jre21.0.11+11-linux-amd64.tar.gz";
    sha256         = "sha256-bSQf1wzJSvZnozyE7F+H0CthgVsIHSVcqPhaG233LUw=";
  };
}
