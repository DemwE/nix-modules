# Aggregator for all Liberica JDK packages
# pkgs: { java8, java11, java17, java21, java25 }
#
# Each javaXX exposes plain bin/java, bin/javac, … → put one on PATH to set default.
# For versioned wrappers (bin/java21, bin/javac21, …) use:
#   java21.versioned                          ← passthru shortcut
#   java21.override { withSuffix = true; }    ← inline override

pkgs:
  pkgs.lib.mergeAttrsList (map (f: import f pkgs) [
    ./java8.nix
    ./java11.nix
    ./java17.nix
    ./java21.nix
    ./java25.nix
  ])
