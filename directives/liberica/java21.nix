# Liberica JDK 21 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java21*, bin/javac21*, …
# pkgs: { java21, java21-full, jre21 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.12+10";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.12+10/bellsoft-jdk21.0.12+10-linux-amd64.tar.gz";
    sha256         = "sha256-I7SOWfRwmVl/hDeMCnZcg1iNytf2mH6y/vDQjn7hn5Y=";
  };
  java21-full = mkLiberica {
    featureVersion = 21;
    version        = "21.0.12+10";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.12+10/bellsoft-jdk21.0.12+10-linux-amd64-full.tar.gz";
    sha256         = "sha256-ywMYQyNrORFuMHRezNk+6MpP1odK7zm88id4LxQ+YJQ=";
  };
  jre21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.12+10";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.12+10/bellsoft-jre21.0.12+10-linux-amd64.tar.gz";
    sha256         = "sha256-QFq2MCl5/5Iuc09k5P0JFAWRnLFwDKaxrSybec63MmU=";
  };
}
