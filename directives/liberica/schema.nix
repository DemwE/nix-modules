pkgs: { featureVersion, version, url, sha256 }:

let
  ver = toString featureVersion;

  jdk = pkgs.stdenv.mkDerivation {
    pname = "liberica-jdk-${ver}";
    inherit version;

    src = pkgs.fetchurl { inherit url sha256; };

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
      pkgs.alsa-lib
      pkgs.libX11
      pkgs.libXext
      pkgs.libXrender
      pkgs.libXtst
      pkgs.libXi
      pkgs.glib
      pkgs.gdk-pixbuf
      pkgs.cairo
      pkgs.pango
      pkgs.fontconfig
      pkgs.freetype
      pkgs.libXxf86vm
      pkgs.libGL
      pkgs.gtk2
      pkgs.gtk3
      pkgs.atk
    ];

    # BellSoft bundles its own ffmpeg libs inside the JDK with sonames that
    # differ from nixpkgs. Ignore them — they resolve via RPATH within the JDK.
    # Uses fnmatch glob patterns.
    autoPatchelfIgnoreMissingDeps = [
      "libavcodec.so.*"
      "libavformat.so.*"
      "libavcodec-ffmpeg.so.*"
      "libavformat-ffmpeg.so.*"
    ];

    installPhase = ''
      runHook preInstall
      cp -r . $out
      runHook postInstall
    '';

    meta = {
      description = "BellSoft Liberica JDK ${ver} (${version})";
      homepage = "https://bell-sw.com/liberica-jdk";
      sourceProvenance = [ pkgs.lib.sourceTypes.binaryNativeCode ];
      platforms = [ "x86_64-linux" ];
    };
  };

  jdkTools = [
    "java" "javac" "javadoc" "javap"
    "jar" "jarsigner"
    "jshell" "jdeps" "jdeprscan"
    "jlink" "jmod" "jimage" "jpackage"
    "jps" "jstat" "jstatd" "jinfo"
    "jmap" "jstack" "jcmd" "jdb"
    "jhsdb" "jfr" "jconsole" "jrunscript"
    "serialver" "keytool" "rmiregistry"
  ];

  # Build a wrapper package; withSuffix=false → plain names, true → java25/javac25/…
  mkWrappers = { withSuffix ? false }:
    pkgs.runCommand "liberica-jdk${ver}-wrappers${if withSuffix then "-versioned" else ""}" {
      inherit (jdk) meta;
      passthru = {
        inherit jdk;
        # java25.versioned gives the suffixed variant; java25 itself is plain
        versioned = mkWrappers { withSuffix = true; };
      };
    } (pkgs.lib.concatMapStrings (bin:
      let name = if withSuffix then "${bin}${ver}" else bin; in ''
        install -Dm755 /dev/stdin $out/bin/${name} <<'WRAPPER'
        #!/bin/sh
        exec "${jdk}/bin/${bin}" "$@"
        WRAPPER
      '') jdkTools);

in
  pkgs.lib.makeOverridable mkWrappers {}
