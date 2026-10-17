#!/bin/bash
# One-step setup for the patched Parallels Desktop build:
#   1. pristine DMG (GitHub release asset) -> source/   [gh, or curl fallback]
#   2. local "PDLocal Code Sign" signing identity (created on first use)
#   3. deliverable/install.command (rebuilds + installs the patched app)
# Safe to re-run: every step is idempotent and verified.
set -uo pipefail

DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$DIR" || exit 1

REPO="pentoshi007/parallels-patched"
TAG="v27.0.3-58680"
DMG_NAME="ParallelsDesktop-27.0.3-58680.dmg"
DMG="$DIR/source/$DMG_NAME"
URL="https://github.com/$REPO/releases/download/$TAG/$DMG_NAME"
SHA="301175ad94bc8575adb3f4ced24e9707a328c0e4220330cc4e92bd1da6da6bea"

say() { printf '%s\n' "$*"; }
die() { say ""; say "[!] $*"; exit 1; }

say "== Parallels Desktop 27.0.3 patched build - bootstrap =="

mkdir -p "$DIR/source"
if [ -f "$DMG" ] && [ "$(shasum -a 256 "$DMG" | awk '{print $1}')" = "$SHA" ]; then
  say "[1/3] pristine DMG present, checksum OK"
else
  say "[1/3] fetching pristine DMG (release asset, ~155 MB) ..."
  rm -f "$DMG"
  if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    gh release download "$TAG" -R "$REPO" -p '*.dmg' -D "$DIR/source" --clobber || die "release download failed"
  else
    say "      (gh CLI not available or not logged in - using curl)"
    curl -fL --retry 3 --progress-bar -o "$DMG" "$URL" || {
      rm -f "$DMG"
      die "download failed. Alternative: download $DMG_NAME from the release page in your browser and place it at source/."
    }
  fi
  [ "$(shasum -a 256 "$DMG" | awk '{print $1}')" = "$SHA" ] || die "DMG checksum mismatch - refusing to continue."
  say "      downloaded + verified"
fi

if security find-identity -v -p codesigning 2>/dev/null | grep -q 'PDLocal Code Sign'; then
  say "[2/3] local signing identity present"
else
  say "[2/3] creating local signing identity ..."
  bash "$DIR/deliverable/setup-signing-identity.command" || die "signing identity setup failed"
fi

say "[3/3] running installer (asks for your admin password) ..."
exec bash "$DIR/deliverable/install.command"
