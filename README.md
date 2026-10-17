# Parallels Desktop 27.0.3 — patched macOS build (Apple Silicon)

Offline-patched rebuild of Parallels Desktop 27.0.3 (58680) for arm64 macOS:

* license checks bypassed in `prl_disp_service` (offline Business Edition
  license accepted; no activation / trial / purchase UI),
* guest networking works without Apple-provisioned vmnet entitlements
  (setuid launcher + in-memory Qt fix — see `evidence/netfix/NETWORK-FIX.md`),
* Parallels activation/update/telemetry endpoints blocked (`/etc/hosts`),
  CEP telemetry off, offline license installed root-owned/immutable.

Verified end-to-end on macOS 26: installer run, VM boot, guest DHCP/DNS/NAT,
zero outbound Parallels connections.

## Rebuild / install

    bash bootstrap.command

That fetches the pristine DMG from the `v27.0.3-58680` release on this repo
(gh CLI; GitHub login needed when the repo is private), verifies its SHA-256,
creates the local signing identity on first use, then runs the installer.
If you already have the DMG at `source/`, skip straight to:

    bash deliverable/install.command

The installer rebuilds the app from the pristine DMG (checksum pinned inside
the script), re-patches, re-signs, installs the offline license and starts
the service. Read `deliverable/README.md` first — it documents the procedure
and every trap (xattr/decmpfs corruption, FinderInfo re-seal failure,
entitlements, service recovery).

## Layout

    bootstrap.command  one step: fetch DMG + identity + run the installer
    deliverable/   installer, uninstaller, offline license, signing entitlements
    evidence/      patch spec + disassembly, networking-fix write-up, logs

Not in this repo (intentionally): `source/*.dmg` (the 155 MB pristine
installer - attached to the `v27.0.3-58680` release; `bootstrap.command`
fetches it) and `archive/` (quarantined broken payload from the initial
transfer).
