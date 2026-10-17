#!/bin/bash
# Removes the patched Parallels Desktop app, its license file and hosts entries.
set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "== Parallels Desktop patched build — uninstaller =="
echo "This will remove:"
echo "  - /Applications/Parallels Desktop.app"
echo "  - /Library/Preferences/Parallels/licenses.json"
echo "  - the PARALLELS-BLOCK section from /etc/hosts"
echo "Virtual machine files are NOT touched."
read -r -p "Continue? [y/N] " answer
case "$answer" in
  y|Y) ;;
  *) echo "Aborted."; exit 1 ;;
esac

if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

launchctl bootout system/com.parallels.desktop.launchdaemon >/dev/null 2>&1 || true
pkill -f "/Applications/Parallels Desktop.app/Contents/MacOS/" >/dev/null 2>&1 || true
pkill -f "/Library/Parallels/Parallels Desktop/launchd_wrapper" >/dev/null 2>&1 || true
sleep 2
pkill -9 -f "prl_disp_service|prl_naptd|prl_vm_app|prl_client_app|MacOS/watchdog" >/dev/null 2>&1 || true
killall InternetSharing >/dev/null 2>&1 || true
sleep 1

rm -rf "/Applications/Parallels Desktop.app"

LIC="/Library/Preferences/Parallels/licenses.json"
if [ -e "$LIC" ]; then
  chflags -R 0 "$LIC" >/dev/null 2>&1 || true
  rm -f "$LIC"
fi

if grep -q "PARALLELS-BLOCK-BEGIN" /etc/hosts 2>/dev/null; then
  cp /etc/hosts /etc/hosts.parallels-patch.bak 2>/dev/null || true
  sed -i '' '/# PARALLELS-BLOCK-BEGIN/,/# PARALLELS-BLOCK-END/d' /etc/hosts
  dscacheutil -flushcache >/dev/null 2>&1 || true
  killall -HUP mDNSResponder >/dev/null 2>&1 || true
fi

echo "Uninstall complete. (VM files were not touched.)"
