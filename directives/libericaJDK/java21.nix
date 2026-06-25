# Liberica JDK 21 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java21*, bin/javac21*, …
# pkgs: { java21 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java21 = mkLiberica {
    featureVersion = 21;
    version        = "21.0.10+10";
    url            = "https://github.com/bell-sw/Liberica/releases/download/21.0.10+10/bellsoft-jdk21.0.10+10-linux-amd64.tar.gz";
    sha256         = "sha256-VEU7lzujo8sGfh0OHCbuRVPP+D0ZR59yFPztLYBbfD0=";
  };
}
