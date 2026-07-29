# Liberica JDK 25 — exposes plain bin/java*, bin/javac*, …
# Use .override { withSuffix = true; } or .versioned to get bin/java25*, bin/javac25*, …
# pkgs: { java25, java25-full, jre25 }

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {
  java25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.4+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.4+9/bellsoft-jdk25.0.4+9-linux-amd64.tar.gz";
    sha256         = "sha256-ZXqmGgF9G/Gao40rqkLSm1YJo15YRDx8IL1k/Wj0aj8=";
  };
  java25-full = mkLiberica {
    featureVersion = 25;
    version        = "25.0.4+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.4+9/bellsoft-jdk25.0.4+9-linux-amd64-full.tar.gz";
    sha256         = "sha256-wMqdxEDc0EjBohqQAX4+awEi5oub0kWFW/jpdPwHydI=";
  };
  jre25 = mkLiberica {
    featureVersion = 25;
    version        = "25.0.4+9";
    url            = "https://github.com/bell-sw/Liberica/releases/download/25.0.4+9/bellsoft-jre25.0.4+9-linux-amd64.tar.gz";
    sha256         = "sha256-mooGcAfHvmARwFptHsC3TcVF6E8RJi1ZYN+xb9JUZJg=";
  };
}
