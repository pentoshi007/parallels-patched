# Parallels Desktop 27.0.3 (58680) — patched build (Apple Silicon)

Offline-patched build of **Parallels Desktop 27 for Apple Silicon Macs**.
The installer rebuilds the patched app **from the pristine Parallels DMG**
(checksum-verified) — it never relies on modified copies carried over from
another machine.

What this build does:

* bypasses the license-signature check in the Parallels service
  (`prl_disp_service`) and forces its license-credentials accessor to return
  "valid" — so the shipped offline license is accepted and the
  purchase/activation/trial UI stays away;
* installs a forged **Business Edition** offline license
  (`/Library/Preferences/Parallels/licenses.json`, root-owned, immutable),
  exactly like genuine offline activations;
* fixes **VM guest networking** without Apple-provisioned vmnet entitlements:
  the VM process is launched with `euid=0` (setuid launcher) and Qt's
  "running setuid" refusal is neutralized **in memory only** — the Qt framework
  on disk stays byte-identical to Parallels' original so the rest of the
  product keeps working (details below);
* blocks Parallels activation/update/telemetry endpoints via `/etc/hosts`
  (`PARALLELS-BLOCK` section);
* disables CEP telemetry via `prlsrvctl set --cep off`.

## Requirements

* Apple Silicon Mac, macOS 14 or newer.
* Xcode **Command Line Tools** (`xcode-select --install`) — the installer
  compiles two small helper binaries (`clang`, `python3`).
* The original DMG **`ParallelsDesktop-27.0.3-58680.dmg`** — checksum is
  pinned in the installer:
  `301175ad94bc8575adb3f4ced24e9707a328c0e4220330cc4e92bd1da6da6bea`.
  Put it next to `install.command`, or keep it in `../source/` as in this
  project folder.
* A local code-signing identity named **“PDLocal Code Sign”**. The original
  build used SHA-1 `F9E378C5241D0AEEE6F0EE77E095E70CBD974526`; the installer
  prefers it and otherwise picks any identity with that name. If the identity
  is missing, create one once:

      # keychain + self-signed code-signing certificate (no Apple account needed)
      security create-keychain -p pdlocal /Library/Keychains/pdlocal.keychain-db
      security unlock-keychain -p pdlocal /Library/Keychains/pdlocal.keychain-db
      openssl req -x509 -newkey rsa:2048 -keyout /tmp/pdl.key -out /tmp/pdl.crt \
        -days 3650 -nodes -subj "/CN=PDLocal Code Sign" \
        -addext "keyUsage=digitalSignature" -addext "extendedKeyUsage=codeSigning"
      openssl pkcs12 -export -inkey /tmp/pdl.key -in /tmp/pdl.crt -out /tmp/pdl.p12 -passout pass:pdlocal
      security import /tmp/pdl.p12 -k /Library/Keychains/pdlocal.keychain-db -P pdlocal -T /usr/bin/codesign
      security set-key-partition-list -S apple-tool:,apple:,codesign: -s \
        -k pdlocal /Library/Keychains/pdlocal.keychain-db

  (The installer finds identities in any keychain on the search list; a
  dedicated keychain like the above works fine.) `setup-signing-identity.command`
  in this folder automates this (user-domain keychain, no admin needed), and
  `../bootstrap.command` runs it automatically when the identity is missing.

## Install

1. Clone the repo and run `bash bootstrap.command` from the repo root (fetches
   the DMG and creates the signing identity for you), or copy this folder plus
   the DMG manually.
2. In Terminal:

       cd <folder>/deliverable
       bash install.command

3. Enter your administrator password when asked. The installer stops any
   running Parallels processes and **running VMs are stopped** (hard stop).
   Installation takes 1–3 minutes (the app is copied from the DMG).
4. Start **Parallels Desktop** from `/Applications` and start a VM.

The installer replaces `/Applications/Parallels Desktop.app`. Virtual machines
in `~/Parallels` are not touched.

## Verify after install

```bash
APP="/Applications/Parallels Desktop.app"
SVC="$APP/Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service"
VMM="$APP/Contents/MacOS/Parallels VM.app/Contents/MacOS"

# 1. patched components verify with codesign
codesign --verify --strict "$SVC" && echo dispatcher OK
codesign --verify --strict "$VMM/prl_vm_app.bin" && echo vm-app OK
codesign --verify --strict "$VMM/prl_vm_app" && echo wrapper OK
codesign --verify --strict "$VMM/libprlqtfix.dylib" && echo dylib OK

# 2. wrapper is setuid; real binary is not
ls -ln "$VMM/prl_vm_app" "$VMM/prl_vm_app.bin"

# 3. in-memory Qt fix applied on each VM start (pid/euid + patched guard bytes)
cat /tmp/prl_qtfix.log

# 4. license + phone-home block
sudo ls -lO /Library/Preferences/Parallels/licenses.json   # expect 444 + schg,uchg
grep PARALLELS-BLOCK -A3 /etc/hosts

# 5. service up, VMs listed
sudo launchctl print system/com.parallels.desktop.launchdaemon | head -5
prlctl list -a

# 6. guest networking (inside a booted guest)
#    Kali:     ip -brief addr ; ping -c2 1.1.1.1
#    Windows:  ipconfig        ; ping -n 2 1.1.1.1
```

## Uninstall

    bash uninstall.command

Removes the app, the license file and the hosts block. VMs are not touched.

## Technical notes — what exactly was patched

All offsets are file offsets of the **thin arm64** binaries.

`Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service`
(pristine sha256 `d9f2fff8…`):

| offset | meaning | change |
|---|---|---|
| `0x279b88` | license-signature check branch (`tbz w0`) | → `nop` (result ignored) |
| `0x90b98` | license-credentials accessor prologue | → `mov w0,#1; ret` (always “valid”) |
| `0x90bd8` | branch inside the same accessor | → `nop` |
| `0x31ab04` | branch in the license getter (`cbnz w20`) | rewritten in the verified working build; **reproduced byte-exact** for reproducibility (see “Traps”, item 6) |

After patching, the dispatcher is re-signed with the local identity, preserving
the `com.apple.security.smartcard` entitlement. The signing **invalidates the
`Parallels Service.app` bundle seal** — this is expected: the app contains an
official symlink (`Contents/Frameworks → ../../../../Contents/Frameworks`)
that points outside the bundle and `codesign` refuses to re-seal it. The kernel
only validates the executed binary's signature, which is valid.

`Contents/MacOS/Parallels VM.app/Contents/MacOS/prl_vm_app.bin` (pristine
sha256 `79afaead…`):

| offset | meaning | change |
|---|---|---|
| `0x4bea0` | peer-process check branch (`cbz`) | → `b #0x50` (always accepted path) |
| `0x589cc` | license gate branch (`cbnz`) | → `nop` |
| load commands | injected `LC_LOAD_DYLIB` | `@loader_path/libprlqtfix.dylib` |

### The networking fix (why it looks like this)

Parallels' VM process asks the system **vmnet daemon**
(`/usr/libexec/InternetSharing`) for the virtual NIC. The daemon accepts a
client only if it is **root (euid 0)** or carries the Apple-provisioned
entitlements `com.apple.vm.networking` / `com.apple.developer.networking.vmnet`.
Those entitlements cannot be used with a self-signed certificate (AMFI kills
the process: `-413 No matching profile found`), and the re-signed app runs as
the normal user — so guests got no network and Parallels showed
*“Network initialization failed.”*.

The fix:

1. `prl_vm_app` is now a tiny **setuid-root launcher** (root:wheel 4755) that
   execs the real binary `prl_vm_app.bin` beside it, so the VM process runs
   `euid=0` with the user still as **ruid** (user context preserved — the app's
   per-user state stays correct, and the vmnet daemon accepts the client).
   A wrapper is required: a setuid *main* binary may not use `@rpath`
   expansions (`security policy does not allow @ path expansion`) and the
   app's Qt libraries are linked via `@rpath`.
2. Qt 5.15 refuses to start under setuid (`FATAL: The application binary
   appears to be running setuid…` in `QCoreApplicationPrivate`). The injected
   `libprlqtfix.dylib` finds `QtCore.framework` in the process's loaded images
   and, **in memory only**, sets the cached “setuid allowed” byte and NOPs the
   fatal branch. QtCore on disk is **pristine** (`2ab8836b…`): re-signing it
   with a local certificate breaks library validation in other Parallels
   binaries (`prl_net_start`, `ParallelsVirtualizationSDK` — “different Team
   IDs”), which would break the service.

`libprlqtfix.dylib` logs each application to `/tmp/prl_qtfix.log`
(pid, euid, guard bytes before/after).

**DHCP/DNS/NAT** on the `10.211.55.0/24` shared network is served by
`prl_naptd` (supervised by `Contents/MacOS/watchdog`). If a guest never gets a
lease (stuck at “getting IP configuration”), restart the daemon —
`sudo kill $(pgrep -f 'prl_naptd start')` (the watchdog respawns it).

## Traps (learned the hard way — do not repeat)

1. **Never `xattr -cr` the app.** Many app files use HFS/APFS decmpfs
   compression: their content lives in the `com.apple.decmpfs` xattr. Clearing
   all xattrs empties ~66 files and breaks binaries/signatures. Only ever
   `xattr -dr com.apple.quarantine` (removes that one attribute).
1a. **The DMG root-dir FinderInfo breaks re-signing.** The pristine app's root
   directory carries a non-empty `com.apple.FinderInfo` xattr and a `hidden`
   flag. `codesign` refuses to re-seal any bundle whose root has FinderInfo
   ("resource fork, Finder information, or similar detritus not allowed") and
   the attribute is protected against removal (`Operation not permitted`).
   The installer rebuilds the root directory (contents moved into a fresh
   dir - renames, no copies) before signing. If the app ever shows
   *"Parallels Desktop.app is damaged"*, this is the first thing to check.
2. **Never `rm -rf` the app in place before copying.** Install by `ditto` from
   the DMG into a full replacement — `ditto` preserves xattrs/compression.
3. **Do not re-sign `QtCore.framework`.** It must keep its Parallels Developer
   ID signature or every library-validation-enforcing Parallels binary refuses
   to load it. Patch the process's memory instead (see above).
4. **Never sign with the original entitlement sets.** Entitlements like
   `application-identifier`, `keychain-access-groups`, `team-identifier`,
   `com.apple.developer.networking.vmnet` require Apple provisioning; carrying
   them on a self-signed binary gets the process killed at exec (`-413`).
   Use the reduced sets: client `{automation, audio-input, camera, addressbook,
   virtualization}`; VM app `{allow-unsigned-executable-memory, hypervisor}`;
   dispatcher `{smartcard}`.
5. **A setuid binary cannot use `@rpath`/`@loader_path`** for its own
   dependencies. Hence the launcher + non-setuid real binary.
6. **Dispatcher patch `0x31ab04` quirk:** the verified working build carries a
   rewritten branch here (`cbnz w5, …` instead of the stock `cbnz w20, …`).
   Its provenance is not fully understood; it is faithfully reproduced so the
   installer rebuilds the exact verified binary, and it has never misbehaved.
   If you rebuild from source logic, review this site first.
7. **Service start is launchd-managed** (`com.parallels.desktop.launchdaemon`
   → `/Library/Parallels/Parallels Desktop/launchd_wrapper`). The installer
   stops the job before replacing the app and starts it again afterwards. It
   also stops running VMs cleanly first and deletes stale
   `/var/run/prl_disp_service.pid`, `/var/run/prl_naptd.pid` and
   `/var/run/prl_watchdog-*.pid` files: a SIGKILLed service leaves these
   behind and the supervisor then skips starting daemons it believes are
   still alive (seen once: dispatcher up, no `prl_naptd`, no guest DHCP).
   If a client still reports *"Unable to connect to Parallels Service"*:
   `sudo launchctl bootout system/com.parallels.desktop.launchdaemon`
   `sudo launchctl bootstrap system "/Applications/Parallels Desktop.app/Contents/MacOS/Parallels Service.app/Contents/Resources/com.parallels.desktop.launchdaemon.plist"`
   `sudo launchctl kickstart -k system/com.parallels.desktop.launchdaemon`
   (use the full bootout -> bootstrap -> kickstart sequence; a bare `kickstart -k`
   can leave the dispatcher down) — or spawn it directly:
   `sudo "/Applications/Parallels Desktop.app/Contents/MacOS/Parallels Service" start`.
8. **Do not update Parallels from inside the app** — an update replaces the
   patched components and the network launcher.
9. After heavy experiments with vmnet, `sudo killall InternetSharing` resets
   all vmnet state (the daemon restarts on demand).

## Files

    deliverable/
      install.command      — rebuilds everything from the DMG (this file's name is the entry point)
      uninstall.command    — removes app, license, hosts block
      licenses.json        — the offline Business Edition license that gets installed
      setup-signing-identity.command — creates the "PDLocal Code Sign" identity
      signatures/          — entitlement sets used for signing (see signatures/README.txt)
      README.md            — this file

    source/ParallelsDesktop-27.0.3-58680.dmg  — pristine installer (checksum-pinned)

    archive/               — quarantined broken payload from the machine transfer (not used)

    evidence/              — the research trail: patch spec, disassembly, vmnet
                             daemon diagnostics, the networking fix write-up
                             (evidence/netfix/NETWORK-FIX.md) and helper sources
