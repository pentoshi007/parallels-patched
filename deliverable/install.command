#!/bin/bash
# Parallels Desktop 27.0.3 (58680) — patched build installer (Apple Silicon Macs).
#
# Rebuilds the patched app from the *pristine* Parallels DMG:
#   * license checks bypassed in prl_disp_service so the shipped offline
#     license (Business Edition) is accepted and no activation/trial UI shows;
#   * VM app made able to open vmnet interfaces (see evidence/netfix) so guest
#     networking works without Apple-provisioned vmnet entitlements;
#   * offline licenses.json installed root-owned/immutable;
#   * Parallels activation/update/telemetry endpoints blocked via /etc/hosts;
#   * CEP telemetry switched off.
#
# Traps learned during development are documented in README.md (read it).
# Run:  bash install.command
set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$SCRIPT_DIR"

DMG_SHA="301175ad94bc8575adb3f4ced24e9707a328c0e4220330cc4e92bd1da6da6bea"
DISP_ORIG_SHA="d9f2fff825b4e97400bfffb110b96b242d246d93aa3f4da05308f3e4319d6c26"
VMAPP_ORIG_SHA="79afaead95e143397c0e753ee9a2196fca6226eea74b635f855cb68539d786f3"
QTCORE_ORIG_SHA="2ab8836b93801dda4c194a246e9c10c24dbf8208d2e0cbe7bccbf686c970e015"
SIGN_SHA="F9E378C5241D0AEEE6F0EE77E095E70CBD974526"
SIGN_NAME="PDLocal Code Sign"

DST_APP="/Applications/Parallels Desktop.app"
DISP_REL="Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service"
VMA_REL="Contents/MacOS/Parallels VM.app"
VMAPP_REL="$VMA_REL/Contents/MacOS/prl_vm_app"
LIC_SRC="$SCRIPT_DIR/licenses.json"
LIC_DST="/Library/Preferences/Parallels/licenses.json"

fail() { echo "ERROR: $*" >&2; exit 1; }
step() { echo; echo "[$1] $2"; }

echo "== Parallels Desktop 27.0.3 — patched build installer (from pristine DMG) =="
[ "$(uname -s)" = "Darwin" ] || fail "This installer must run on macOS."
[ "$(uname -m)" = "arm64" ] || fail "Parallels Desktop 27 requires an Apple Silicon Mac."

# DMG location: next to this script, or in ../source/
DMG=""
for c in "$SCRIPT_DIR/ParallelsDesktop-27.0.3-58680.dmg" "$SCRIPT_DIR/../source/ParallelsDesktop-27.0.3-58680.dmg"; do
  [ -f "$c" ] && DMG="$(cd "$(dirname "$c")" && pwd)/$(basename "$c")" && break
done
[ -n "$DMG" ] || fail "ParallelsDesktop-27.0.3-58680.dmg not found (next to install.command or in ../source/)."
[ -f "$LIC_SRC" ] || fail "licenses.json not found next to this script."

if [ "$(id -u)" != "0" ]; then
  echo "Administrator rights are required — requesting sudo..."
  exec sudo -p "[sudo] password for %u: " /bin/bash "$0" "$@"
fi

WORK="$(mktemp -d /tmp/pd27-install.XXXXXX)"
MNT="$WORK/mnt"
cleanup() { hdiutil detach "$MNT" >/dev/null 2>&1 || true; rm -rf "$WORK"; }
trap cleanup EXIT

step "1/9" "Preflight: tools, signing identity, checksum"
for t in python3 clang codesign ditto hdiutil shasum curl; do
  command -v "$t" >/dev/null 2>&1 || fail "required tool not found: $t"
done
xcrun --find clang >/dev/null 2>&1 || fail "Xcode Command Line Tools are required (clang not functional)."

SIGN_ID="$(security find-identity -v -p codesigning 2>/dev/null | awk -v s="$SIGN_SHA" 'toupper($0) ~ toupper(s) {print $2; exit}')"
if [ -z "$SIGN_ID" ]; then
  SIGN_ID="$(security find-identity -v -p codesigning 2>/dev/null | awk -v n="$SIGN_NAME" 'index($0, "\"" n "\"") {print $2; exit}')"
fi
[ -n "$SIGN_ID" ] || fail "code-signing identity \"$SIGN_NAME\" (SHA-1 $SIGN_SHA) not found in any keychain.
Create it once (see README.md, 'Signing identity') or import the existing PDLocal cert."
echo "      signing identity: $SIGN_ID"

DSHA="$(shasum -a 256 "$DMG" | awk '{print $1}')"
[ "$DSHA" = "$DMG_SHA" ] || fail "DMG checksum mismatch:
  expected $DMG_SHA
  got      $DSHA
Refusing to install from an unknown/unverified image."
echo "      DMG checksum OK"

step "2/9" "Stopping any running Parallels services and VMs"
# Stop running VMs gracefully. prlctl run by root sees NO VMs (the service
# tracks them per user), so it must run in the console user's context - or the
# SIGTERM/kill fallback below hard-kills a running guest (unclean shutdown).
CONSOLE_USER="$(stat -f '%Su' /dev/console 2>/dev/null)"
if [ -n "$CONSOLE_USER" ] && [ "$CONSOLE_USER" != "root" ] && [ -x /usr/local/bin/prlctl ]; then
  RUNNING="$(sudo -u "$CONSOLE_USER" /usr/local/bin/prlctl list -a 2>/dev/null | awk '/ running /{print $1}')"
  if [ -n "$RUNNING" ]; then
    echo "$RUNNING" | while read -r _vm; do
      [ -n "$_vm" ] && sudo -u "$CONSOLE_USER" /usr/local/bin/prlctl stop "$_vm" >/dev/null 2>&1
    done
    echo "      stopped running VMs (user: $CONSOLE_USER)"
  fi
  for _i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30; do
    sudo -u "$CONSOLE_USER" /usr/local/bin/prlctl list -a 2>/dev/null | grep -q ' running ' || break
    sleep 1
  done
fi
launchctl bootout system/com.parallels.desktop.launchdaemon >/dev/null 2>&1 || true
pkill -f '/Applications/Parallels Desktop.app/Contents/MacOS/' >/dev/null 2>&1 || true
pkill -f '/Library/Parallels/Parallels Desktop/launchd_wrapper' >/dev/null 2>&1 || true
sleep 2
pkill -9 -f 'prl_disp_service|prl_naptd|prl_vm_app|prl_client_app|MacOS/watchdog' >/dev/null 2>&1 || true
killall InternetSharing >/dev/null 2>&1 || true
sleep 1
# A SIGKILLed service leaves pidfiles behind; the supervisor reads them and can
# skip starting daemons it believes are alive (seen after a reinstall: the
# dispatcher ran but prl_naptd did not - guests got no DHCP). Clear them.
rm -f /var/run/prl_disp_service.pid /var/run/prl_naptd.pid /var/run/prl_watchdog-*.pid 2>/dev/null || true
echo "      stopped"

step "3/9" "Mounting DMG and installing pristine app into /Applications"
mkdir -p "$MNT"
hdiutil attach "$DMG" -nobrowse -readonly -mountpoint "$MNT" >/dev/null 2>&1 || fail "could not mount $DMG"
SRC_APP="$MNT/Parallels Desktop.app"
[ -d "$SRC_APP" ] || fail "Parallels Desktop.app not found inside the DMG."
# Non-strict on purpose: the shipped files carry Finder-info xattrs and the
# Service.app symlink that strict mode rejects; the pinned DMG sha256 above is
# the primary integrity check.
codesign --verify "$SRC_APP" >/dev/null 2>&1 || fail "source app inside the DMG fails its code-signature check — refusing to install."
echo "      source app signature OK"
rm -rf "$DST_APP"
ditto "$SRC_APP" "$DST_APP" || fail "ditto failed while copying the app"
hdiutil detach "$MNT" >/dev/null 2>&1 || true
# Remove ONLY the quarantine attribute (never `xattr -cr`: it destroys the
# decmpfs-compressed files inside the app and the signature with it).
xattr -dr com.apple.quarantine "$DST_APP" >/dev/null 2>&1 || true
echo "      installed to $DST_APP (xattrs preserved, quarantine stripped)"

# The DMG's app ROOT DIRECTORY carries a non-empty com.apple.FinderInfo xattr
# (and a `hidden` flag). codesign refuses to re-seal a bundle whose root has
# FinderInfo - "resource fork, Finder information, or similar detritus not
# allowed" - and the attribute is protected against removal (EPERM). Rebuild
# the root directory: its contents are *moved* (renames, no copying).
mv "$DST_APP" "$DST_APP.pdroot"
mkdir "$DST_APP"
for _f in "$DST_APP.pdroot"/* "$DST_APP.pdroot"/.[!.]*; do
  [ -e "$_f" ] && mv "$_f" "$DST_APP/"
done
rmdir "$DST_APP.pdroot" 2>/dev/null || rm -rf "$DST_APP.pdroot"
chown "$(stat -f '%u:%g' "$DST_APP/Contents")" "$DST_APP" 2>/dev/null || true
echo "      app root directory refreshed (FinderInfo detritus removed)"

step "4/9" "Patching prl_disp_service (license bypass)"
check_sha() { # file expected tag
  local got; got="$(shasum -a 256 "$1" | awk '{print $1}')"
  [ "$got" = "$2" ] || fail "$3: sha256 mismatch
  expected $2
  got      $got"
}
check_sha "$DST_APP/$DISP_REL" "$DISP_ORIG_SHA" "prl_disp_service (pristine)"
check_sha "$DST_APP/$VMAPP_REL" "$VMAPP_ORIG_SHA" "prl_vm_app (pristine)"
check_sha "$DST_APP/Contents/Frameworks/QtCore.framework/Versions/5/QtCore" "$QTCORE_ORIG_SHA" "QtCore (pristine)"

cat > "$WORK/patch.py" <<'PYEOF'
#!/usr/bin/env python3
import struct, sys

def apply_sites(path, sites):
    d = bytearray(open(path, 'rb').read())
    for off, old, new, tag in sites:
        cur = bytes(d[off:off+len(old)])
        if cur == new:
            print(f"      already patched: {tag} @ {hex(off)}")
            continue
        if cur != old:
            sys.exit(f"FATAL: unexpected bytes at {hex(off)} ({tag}): {cur.hex()}")
        d[off:off+len(new)] = new
        print(f"      patched: {tag} @ {hex(off)}")
    open(path, 'wb').write(d)

def patch_disp(path):
    apply_sites(path, [
        # P1: license signature check -> ignore result (tbz -> nop)
        (0x279b88, bytes.fromhex('a0080036'), bytes.fromhex('1f2003d5'), 'license-sig check bypass'),
        # license credentials accessor -> always returns 1 (valid)
        (0x90b98, bytes.fromhex('ffc301d1f44f05a9'), bytes.fromhex('20008052c0035fd6'), 'creds accessor return 1'),
        (0x90bd8, bytes.fromhex('e0010036'), bytes.fromhex('1f2003d5'), 'creds accessor branch nop'),
        # Reproduced byte-exact from the verified working build. The stock
        # instruction here is `cbnz w20, err`; the working build carries this
        # rewritten branch. Kept verbatim for reproducibility (see README).
        (0x31ab04, bytes.fromhex('d4040035'), bytes.fromhex('05000535'), 'license getter branch (working-build quirk)'),
    ])

def patch_vmapp(path):
    apply_sites(path, [
        # peer-process check -> always take the accepted path
        (0x4bea0, bytes.fromhex('80020034'), bytes.fromhex('14000014'), 'peer check'),
        # license gate -> nop
        (0x589cc, bytes.fromhex('15030035'), bytes.fromhex('1f2003d5'), 'license gate'),
    ])

def inject(path, dylib):
    d = bytearray(open(path, 'rb').read())
    magic, cpu, sub, ft, ncmds, sizeofcmds, flags, res = struct.unpack('<IIIIIIII', d[:32])
    assert magic == 0xfeedfacf, 'not a thin 64-bit Mach-O'
    name = dylib.encode() + b'\0'
    # idempotency: already present?
    off = 32
    for _ in range(ncmds):
        c, size = struct.unpack('<II', d[off:off+8])
        if c == 0xC or c == 0x8000001C:
            noff = struct.unpack('<I', d[off+8:off+12])[0]
            existing = bytes(d[off+noff:off+size]).split(b'\0',1)[0].decode('utf-8','replace')
            if existing == dylib:
                print(f"      already injected: {dylib}")
                return
        off += size
    raw = 24 + len(name); cmdsize = (raw + 7) & ~7; pad = cmdsize - raw
    cmd = struct.pack('<IIIIII', 0xC, cmdsize, 24, 0, 0, 0) + name + b'\0'*pad
    insert_at = 32 + sizeofcmds
    first_sect = None
    off = 32
    for _ in range(ncmds):
        c, size = struct.unpack('<II', d[off:off+8])
        if c == 0x19:
            nsects = struct.unpack('<I', d[off+64:off+68])[0]
            so = off + 72
            for _s in range(nsects):
                saddr, ssize, soff = struct.unpack('<QQI', d[so+32:so+52])
                if first_sect is None: first_sect = soff
                so += 80
        off += size
    assert first_sect is not None and insert_at + cmdsize <= first_sect, 'no headerpad room for LC_LOAD_DYLIB'
    d[insert_at:insert_at+cmdsize] = cmd
    struct.pack_into('<II', d, 16, ncmds+1, sizeofcmds+cmdsize)
    open(path, 'wb').write(d)
    print(f"      injected LC_LOAD_DYLIB {dylib}")

mode = sys.argv[1]
if mode == 'disp':   patch_disp(sys.argv[2])
elif mode == 'vmapp': patch_vmapp(sys.argv[2])
elif mode == 'inject': inject(sys.argv[2], sys.argv[3])
else: sys.exit('unknown mode')
PYEOF

python3 "$WORK/patch.py" disp "$DST_APP/$DISP_REL" || fail "dispatcher patching failed"

# entitlements used for signing (restricted/TeamID entitlements must NOT be
# carried on our re-signed binaries: AMFI would kill them)
cat > "$WORK/ents_disp.plist" <<'PEOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>com.apple.security.smartcard</key><true/>
</dict></plist>
PEOF
cat > "$WORK/ents_vm.plist" <<'PEOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>com.apple.security.cs.allow-unsigned-executable-memory</key><true/>
<key>com.apple.security.hypervisor</key><true/>
</dict></plist>
PEOF
cat > "$WORK/ents_client.plist" <<'PEOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>com.apple.security.automation.apple-events</key><true/>
<key>com.apple.security.device.audio-input</key><true/>
<key>com.apple.security.device.camera</key><true/>
<key>com.apple.security.personal-information.addressbook</key><true/>
<key>com.apple.security.virtualization</key><true/>
</dict></plist>
PEOF

codesign --force --sign "$SIGN_ID" --timestamp=none \
  --entitlements "$WORK/ents_disp.plist" "$DST_APP/$DISP_REL" || fail "codesign dispatcher failed"
# non-strict: the Service.app bundle contains an official escaping symlink
codesign --verify "$DST_APP/$DISP_REL" >/dev/null 2>&1 || fail "dispatcher signature verification failed"
echo "      dispatcher patched and re-signed"

step "5/9" "Patching VM app and installing the vmnet launcher + in-memory Qt fix"
python3 "$WORK/patch.py" vmapp "$DST_APP/$VMAPP_REL" || fail "VM app patching failed"

# in-memory QtCore guard neutralizer (see README 'Networking fix')
cat > "$WORK/libprlqtfix.c" <<'CEOF'
// libprlqtfix.dylib — neutralize Qt 5.15's setuid refusal inside prl_vm_app only,
// in memory. QtCore on disk stays pristine: its Parallels Developer ID signature
// must remain valid for library-validation-enforcing product binaries
// (prl_net_start, ParallelsVirtualizationSDK) that load the same framework.
#include <mach-o/dyld.h>
#include <mach-o/loader.h>
#include <libkern/OSCacheControl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>

#define QTC_MATCH "QtCore.framework/Versions/5/QtCore"
#define FLAG_OFF  0x514228u   /* cached "setuid allowed" byte tested by tbnz */
#define GUARD_OFF 0x1d658c    /* b.ne -> qFatal("running setuid") path */
#define BNE_LE    0x54000341u
#define NOP_LE    0x1f2003d5u

static long pg_size(void) { static long pg; if (!pg) pg = sysconf(_SC_PAGESIZE); return pg; }

static void logmsg(const char *fmt, ...) {
    FILE *f = fopen("/tmp/prl_qtfix.log", "a");
    if (!f) return;
    va_list ap; va_start(ap, fmt); vfprintf(f, fmt, ap); va_end(ap);
    fputc('\n', f); fclose(f);
}

static void patch_image(const struct mach_header *mh, intptr_t slide) {
    if (mh->magic != MH_MAGIC_64) return;
    const char *name = NULL;
    uint32_t n = _dyld_image_count();
    for (uint32_t i = 0; i < n; i++)
        if (_dyld_get_image_header(i) == mh) { name = _dyld_get_image_name(i); break; }
    if (!name || !strstr(name, QTC_MATCH)) return;
    uint8_t *base = (uint8_t *)mh;   /* header addr already includes the slide */
    volatile uint8_t *flag = base + FLAG_OFF;
    volatile uint32_t *guard = (volatile uint32_t *)(base + GUARD_OFF);
    uint32_t before = *guard;
    int flag_before = *flag, flag_rc = -1, nop_rc = -3;
    uintptr_t fpg = (uintptr_t)flag & ~((uintptr_t)pg_size()-1);
    if (mprotect((void *)fpg, pg_size(), PROT_READ|PROT_WRITE) == 0) {
        *flag = 1;
        flag_rc = *flag == 1 ? 0 : -2;
    }
    if (before == NOP_LE) {
        nop_rc = 1;
    } else if (before == BNE_LE) {
        uintptr_t pg = (uintptr_t)guard & ~((uintptr_t)pg_size()-1);
        if (mprotect((void *)pg, pg_size(), PROT_READ|PROT_WRITE) == 0) {
            *guard = NOP_LE;
            sys_icache_invalidate((void *)guard, sizeof(uint32_t));
            mprotect((void *)pg, pg_size(), PROT_READ|PROT_EXEC);
            nop_rc = *guard == NOP_LE ? 0 : -4;
        } else { nop_rc = -5; }
    }
    logmsg("pid=%d euid=%d ruid=%d img=%s slide=%#lx guard_before=%#010x flag_before=%d "
           "flag_rc=%d nop_rc=%d guard_after=%#010x",
           getpid(), geteuid(), getuid(), name, (unsigned long)slide, before, flag_before,
           flag_rc, nop_rc, *guard);
}

__attribute__((constructor))
static void prl_qtfix_init(void) {
    logmsg("pid=%d euid=%d ruid=%d libprlqtfix init, images=%u",
           getpid(), geteuid(), getuid(), _dyld_image_count());
    _dyld_register_func_for_add_image(patch_image);
}
CEOF

# setuid-root launcher (a setuid main binary cannot use @rpath expansions,
# and the app's Qt dependencies are @rpath — so the real binary runs non-setuid
# and just inherits euid=0 from this wrapper)
cat > "$WORK/prl_vm_app_wrapper.c" <<'CEOF2'
#include <mach-o/dyld.h>
#include <unistd.h>
#include <stdio.h>
#include <libgen.h>
#include <limits.h>

int main(int argc, char **argv) {
    char exe[PATH_MAX];
    uint32_t sz = sizeof(exe);
    if (_NSGetExecutablePath(exe, &sz) != 0) return 126;
    char bin[PATH_MAX];
    if (snprintf(bin, sizeof(bin), "%s/prl_vm_app.bin", dirname(exe)) >= (int)sizeof(bin))
        return 126;
    execv(bin, argv);
    perror("prl_vm_app wrapper: execv");
    return 127;
}
CEOF2

VMM="$DST_APP/$VMA_REL/Contents/MacOS"
clang -arch arm64 -dynamiclib -O2 -mmacosx-version-min=14.0 \
  -install_name @rpath/libprlqtfix.dylib -o "$WORK/libprlqtfix.dylib" "$WORK/libprlqtfix.c" \
  || fail "could not compile libprlqtfix.dylib"
codesign --force --sign "$SIGN_ID" --timestamp=none "$WORK/libprlqtfix.dylib" || fail "codesign dylib failed"
cp "$WORK/libprlqtfix.dylib" "$VMM/libprlqtfix.dylib"
chown root:wheel "$VMM/libprlqtfix.dylib"; chmod 755 "$VMM/libprlqtfix.dylib"

python3 "$WORK/patch.py" inject "$DST_APP/$VMAPP_REL" "@loader_path/libprlqtfix.dylib" || fail "dylib injection failed"

clang -arch arm64 -O2 -mmacosx-version-min=14.0 -o "$WORK/prl_vm_app_wrapper" "$WORK/prl_vm_app_wrapper.c" \
  || fail "could not compile prl_vm_app wrapper"
codesign --force --sign "$SIGN_ID" --timestamp=none "$WORK/prl_vm_app_wrapper" || fail "codesign wrapper failed"

mv "$DST_APP/$VMAPP_REL" "$DST_APP/$VMAPP_REL.bin"
cp "$WORK/prl_vm_app_wrapper" "$DST_APP/$VMAPP_REL"
chown root:wheel "$DST_APP/$VMAPP_REL" "$DST_APP/$VMAPP_REL.bin"
chmod 755 "$DST_APP/$VMAPP_REL.bin"

# Sign the real binary at its FINAL, non-main-executable path: signing it while
# it was still the bundle's main executable would embed the bundle Info.plist
# slot into its signature, which strict verification then rejects for a
# non-main nested executable.
codesign --force --sign "$SIGN_ID" --timestamp=none \
  --entitlements "$WORK/ents_vm.plist" "$DST_APP/$VMAPP_REL.bin" || fail "codesign VM app failed"

echo "      VM app patched; wrapper + libprlqtfix installed"

step "6/9" "Re-sealing bundles and signing the GUI client (reduced entitlements)"
# Parallels VM.app: main exe is now the wrapper (real binary at prl_vm_app.bin)
codesign --force --sign "$SIGN_ID" --timestamp=none \
  --entitlements "$WORK/ents_vm.plist" "$DST_APP/$VMA_REL" || fail "Parallels VM.app reseal failed"
chmod 4755 "$DST_APP/$VMAPP_REL"
codesign --verify --strict "$DST_APP/$VMA_REL" >/dev/null 2>&1 || fail "Parallels VM.app verification failed"

# Outer bundle: re-signs prl_client_app (GUI) with the reduced entitlement set
# (the original set contains TeamID-restricted entitlements that do not survive
# re-signing; the GUI is killed at exec with the full set).
if codesign --force --sign "$SIGN_ID" --timestamp=none \
     --entitlements "$WORK/ents_client.plist" "$DST_APP"; then
  echo "      outer bundle re-sealed (client: reduced entitlements)"
else
  echo "      WARNING: outer bundle re-seal failed — client keeps its original signature (usually fine)"
fi
# Parallels Service.app contains an official symlink that points outside the
# bundle; codesign refuses to re-seal it. Sign the dispatcher binary (done in
# step 4) — that is what the kernel checks at exec. Expected, not an error.

step "7/9" "Installing offline license and blocking phone-home domains"
mkdir -p /Library/Preferences/Parallels
if [ -e "$LIC_DST" ]; then
  chflags -R 0 "$LIC_DST" >/dev/null 2>&1 || true
  chmod u+w "$LIC_DST" >/dev/null 2>&1 || true
  rm -f "$LIC_DST" || fail "could not remove existing licenses.json"
fi
cp "$LIC_SRC" "$LIC_DST" || fail "could not install licenses.json"
chown root:wheel "$LIC_DST"; chmod 444 "$LIC_DST"
chflags uchg "$LIC_DST" >/dev/null 2>&1 || true
chflags schg "$LIC_DST" >/dev/null 2>&1 || true
echo "      licenses.json installed (root:wheel 444, immutable)"

# The block is (re)written unconditionally. A previous debug session once left
# the entries commented out (block "present" but blocking disabled); the old
# presence check then kept it disabled. Strip any existing block, append the
# active one.
[ -f /etc/hosts.parallels-patch.bak ] || cp /etc/hosts /etc/hosts.parallels-patch.bak 2>/dev/null || true
if grep -q "PARALLELS-BLOCK-BEGIN" /etc/hosts 2>/dev/null; then
  python3 -c 'import re; p="/etc/hosts"; s=open(p).read(); open(p,"w").write(re.sub(r"(?ms)\n*^# PARALLELS-BLOCK-BEGIN.*?^# PARALLELS-BLOCK-END\n*", "", s))' \
    || fail "could not rewrite the Parallels hosts block"
fi
cat >> /etc/hosts <<'HOSTS'

# PARALLELS-BLOCK-BEGIN (Parallels activation/update/telemetry endpoints, .com + .cn)
0.0.0.0 parallels.com
0.0.0.0 www.parallels.com
0.0.0.0 my.parallels.com
0.0.0.0 account.parallels.com
0.0.0.0 access.parallels.com
0.0.0.0 desktop.parallels.com
0.0.0.0 update.parallels.com
0.0.0.0 static.parallels.com
0.0.0.0 reportus.parallels.com
0.0.0.0 pda-api.parallels.com
0.0.0.0 download.parallels.com
0.0.0.0 link.parallels.com
0.0.0.0 kb.parallels.com
0.0.0.0 support.parallels.com
0.0.0.0 forum.parallels.com
0.0.0.0 forum-staging.prls.net
# .cn mirrors: the dispatcher's URL templates substitute the brand token with
# "parallels.cn" too (observed live: account.parallels.cn -> 104.18.8.96:443)
0.0.0.0 parallels.cn
0.0.0.0 www.parallels.cn
0.0.0.0 my.parallels.cn
0.0.0.0 account.parallels.cn
0.0.0.0 access.parallels.cn
0.0.0.0 desktop.parallels.cn
0.0.0.0 pda-api.parallels.cn
0.0.0.0 reportus.parallels.cn
0.0.0.0 static.parallels.cn
# PARALLELS-BLOCK-END
HOSTS
dscacheutil -flushcache >/dev/null 2>&1 || true
killall -HUP mDNSResponder >/dev/null 2>&1 || true
echo "      hosts block active (backup: /etc/hosts.parallels-patch.bak)"

step "8/9" "Initializing and starting the Parallels service"
"$DST_APP/Contents/MacOS/inittool2" init -b "$DST_APP" >/dev/null 2>&1 || \
  echo "      note: inittool2 init returned non-zero (continuing)"
launchctl kickstart -k system/com.parallels.desktop.launchdaemon >/dev/null 2>&1 || true
if ! launchctl print system/com.parallels.desktop.launchdaemon >/dev/null 2>&1; then
  launchctl bootstrap system \
    "$DST_APP/Contents/MacOS/Parallels Service.app/Contents/Resources/com.parallels.desktop.launchdaemon.plist" >/dev/null 2>&1 || true
  launchctl kickstart -k system/com.parallels.desktop.launchdaemon >/dev/null 2>&1 || true
fi
for _i in 1 2 3 4 5 6 7 8 9 10; do
  if [ -s /var/run/prl_disp_service.pid ] && kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null; then
    break
  fi
  sleep 1
done
if ! kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null; then
  echo "      launchd job not active — starting service supervisor directly"
  nohup "$DST_APP/Contents/MacOS/Parallels Service" start >/dev/null 2>&1 &
  for _i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
    kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null && break
    sleep 1
  done
fi
kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null \
  && echo "      dispatcher running (pid $(cat /var/run/prl_disp_service.pid))" \
  || echo "      WARNING: dispatcher not confirmed running — open Parallels Desktop once or run:
        sudo \"$DST_APP/Contents/MacOS/Parallels Service\" start"

if [ -x "$DST_APP/Contents/MacOS/prlsrvctl" ]; then
  "$DST_APP/Contents/MacOS/prlsrvctl" set --cep off >/dev/null 2>&1 && echo "      telemetry (CEP) disabled"
  "$DST_APP/Contents/MacOS/prlsrvctl" set --allow-attach-screenshots off >/dev/null 2>&1 || true
fi

step "9/9" "Post-install verification"
# Re-assert the setuid bit as the very last action before checking: Parallels
# bootstrap actions may normalize file modes during install; the final state is
# what matters for the vmnet daemon.
chmod 4755 "$DST_APP/$VMAPP_REL"
python3 "$WORK/patch.py" disp "$DST_APP/$DISP_REL" >/dev/null 2>&1 \
  && codesign --verify "$DST_APP/$DISP_REL" >/dev/null 2>&1 \
  && echo "      dispatcher: patched + signature OK" || fail "dispatcher verification failed"
python3 "$WORK/patch.py" vmapp "$DST_APP/$VMAPP_REL.bin" >/dev/null 2>&1 \
  && codesign --verify --strict "$DST_APP/$VMAPP_REL.bin" >/dev/null 2>&1 \
  && echo "      VM app: patched + signature OK" || fail "VM app verification failed"
codesign --verify --strict "$DST_APP/$VMAPP_REL" >/dev/null 2>&1 \
  && echo "      wrapper: signature OK" || fail "wrapper verification failed"
codesign --verify --strict "$VMM/libprlqtfix.dylib" >/dev/null 2>&1 \
  && echo "      libprlqtfix: signature OK" || fail "dylib verification failed"
otool -l "$DST_APP/$VMAPP_REL.bin" 2>/dev/null | grep -q 'libprlqtfix.dylib' \
  && echo "      LC_LOAD_DYLIB present" || fail "injection not present"
[ "$(ls -ln "$DST_APP/$VMAPP_REL" | awk '{print $1}' | cut -c4)" = "s" ] \
  && echo "      wrapper is setuid" || fail "wrapper is not setuid"
codesign --verify "$DST_APP" >/dev/null 2>&1 \
  && echo "      outer app: valid signature" \
  || echo "      WARNING: outer app verification reported issues (check manually)"

# Service stability at the very END of the run: a dispatcher has been seen to
# exit seconds after the step-8 check passed, leaving clients with "Unable to
# connect to Parallels Service". Re-assert liveness here, and if anything is
# missing fall back to the same supervisor launchd runs.
sleep 3
if ! kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null || \
   ! pgrep -x prl_naptd >/dev/null 2>&1; then
  echo "      service not fully stable - re-asserting (supervisor + net daemon)"
  nohup "$DST_APP/Contents/MacOS/Parallels Service" start >/dev/null 2>&1 &
  for _i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
    kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null && break
    sleep 1
  done
  pgrep -x prl_naptd >/dev/null 2>&1 || \
    nohup "$DST_APP/Contents/MacOS/watchdog" start 60 20 "$DST_APP/Contents/MacOS/prl_naptd" start >/dev/null 2>&1 &
  sleep 2
fi
if kill -0 "$(cat /var/run/prl_disp_service.pid 2>/dev/null)" 2>/dev/null && \
   pgrep -x prl_naptd >/dev/null 2>&1; then
  echo "      final check: service stable (dispatcher $(cat /var/run/prl_disp_service.pid), net daemon $(pgrep -x prl_naptd))"
else
  echo "      WARNING: service not fully confirmed - see README, Traps item 7"
fi

cat <<'DONE'

Installation finished.

  * Open "Parallels Desktop" from /Applications and start a VM.
  * Guest networking works without Apple-provisioned entitlements (see README).
  * If a guest gets no DHCP lease after unusual system churn, restart the
    network daemon:  sudo kill $(pgrep -f 'prl_naptd start')
  * Do NOT update Parallels Desktop from inside the app; updates replace the
    patched components.
DONE
