#!/usr/bin/env python3
"""
Update Liberica JDK Nix derivations via BellSoft Product Discovery API.

Usage:
  python3 update.py              # update all supported versions
  python3 update.py 21 25        # update only JDK 21 and 25
  python3 update.py --check      # show available versions without writing
  python3 update.py --check 21   # show available version for JDK 21 only
  python3 update.py --force      # force re-download and regenerate even if up-to-date
"""

import json
import subprocess
import sys
import urllib.request
from pathlib import Path

API = "https://api.bell-sw.com/v1/liberica/releases"

REPO = Path(__file__).resolve().parent
NIXDIR = REPO / "../directives/liberica"

SUPPORTED = [8, 11, 17, 21, 25]

# (bundle_type, attr_name_template)
BUNDLES = [
    ("jdk",      "java{ver}"),
    ("jdk-full", "java{ver}-full"),
    ("jre",      "jre{ver}"),
]

NIX_TEMPLATE = """\
# Liberica JDK {ver} — exposes plain bin/java*, bin/javac*, …
# Use .override {{ withSuffix = true; }} or .versioned to get bin/java{ver}*, bin/javac{ver}*, …
# pkgs: {{ {attrs} }}

pkgs:
let
  mkLiberica = import ./schema.nix pkgs;
in {{
{body}
}}
"""

BODY_TEMPLATE = """\
  {attr} = mkLiberica {{
    featureVersion = {ver};
    version        = "{version}";
    url            = "{url}";
    sha256         = "{sha256}";
  }};"""

LIBERICA_ATTR = "java{ver}"


def api_url(feature_version: int, bundle_type: str) -> str:
    return (
        f"{API}?version-modifier=latest"
        f"&version-feature={feature_version}"
        f"&os=linux&arch=x86&bitness=64"
        f"&package-type=tar.gz&bundle-type={bundle_type}"
    )


def fetch_latest(feature_version: int, bundle_type: str) -> dict:
    url = api_url(feature_version, bundle_type)
    req = urllib.request.Request(
        url, headers={"User-Agent": "liberica-fetch/1.0"},
    )
    with urllib.request.urlopen(req, timeout=30) as resp:
        data = json.loads(resp.read().decode())
    if not data:
        raise RuntimeError(
            f"No releases for JDK {feature_version} bundle={bundle_type}"
        )
    return data[0]


def compute_sha256(download_url: str) -> str:
    result = subprocess.run(
        ["nix-prefetch-url", download_url],
        capture_output=True, text=True, check=True, timeout=600,
    )
    conv = subprocess.run(
        ["nix", "hash", "convert", "--hash-algo", "sha256", result.stdout.strip()],
        capture_output=True, text=True, check=True,
    )
    return conv.stdout.strip()


def write_nix(feature_version: int,
              bundles: list[tuple[str, str, str, str]]):
    """
    bundles: list of (attr_name, version, url, sha256)
    """
    path = NIXDIR / f"java{feature_version}.nix"
    attr_names = [b[0] for b in bundles]
    body_lines = []
    for attr, version, url, sha256 in bundles:
        body_lines.append(BODY_TEMPLATE.format(
            attr=attr, ver=feature_version,
            version=version, url=url, sha256=sha256,
        ))
    content = NIX_TEMPLATE.format(
        ver=feature_version,
        attrs=", ".join(attr_names),
        body="\n".join(body_lines),
    )
    path.write_text(content)
    print(f"  Written {path}")


def load_current_version(path: Path) -> str | None:
    if not path.exists():
        return None
    for line in path.read_text().splitlines():
        line = line.strip()
        if line.startswith("version"):
            return line.split('"')[1]
    return None


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("-")]
    flags = set(a for a in sys.argv[1:] if a.startswith("-"))

    check_only = "--check" in flags
    force = "--force" in flags
    versions = [int(a) for a in args] if args else SUPPORTED

    for v in versions:
        if v not in SUPPORTED:
            print(f"Warning: JDK {v} is not in supported list {SUPPORTED}, skipping")
            continue

        print(f"\n{'=' * 50}")
        print(f"JDK {v}")
        print(f"{'=' * 50}")

        releases = {}
        ok = True
        for bundle_type, attr_tpl in BUNDLES:
            attr = attr_tpl.format(ver=v)
            try:
                r = fetch_latest(v, bundle_type)
                releases[bundle_type] = r
                print(f"  {attr:15s}  {r['version']}")
            except Exception as e:
                print(f"  {bundle_type:15s}  ERROR: {e}")
                ok = False

        if not ok:
            continue

        api_version = releases["jdk"]["version"]
        current_path = NIXDIR / f"java{v}.nix"
        current = load_current_version(current_path)

        if current and current == api_version and not force:
            print(f"  Already up-to-date ({api_version})")
            continue

        print(f"  Current:  {current or 'N/A'}")
        print(f"  Latest:   {api_version}")

        if check_only:
            continue

        bundle_data = []
        for bundle_type, attr_tpl in BUNDLES:
            attr = attr_tpl.format(ver=v)
            r = releases[bundle_type]
            print(f"  Computing hash for {attr} …", end="", flush=True)
            try:
                sha256 = compute_sha256(r["downloadUrl"])
                bundle_data.append((attr, r["version"], r["downloadUrl"], sha256))
                print(" done")
            except Exception as e:
                print(f"\n  ERROR: {e}")
                ok = False

        if not ok:
            continue

        write_nix(v, bundle_data)


if __name__ == "__main__":
    main()
