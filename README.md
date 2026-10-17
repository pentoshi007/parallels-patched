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

    bash deliverable/install.command

The installer rebuilds the app from the pristine DMG (checksum pinned inside
the script), re-patches, re-signs, installs the offline license and starts
the service. Read `deliverable/README.md` first — it documents the procedure
and every trap (xattr/decmpfs corruption, FinderInfo re-seal failure,
entitlements, service recovery).

## Layout

    deliverable/   installer, uninstaller, offline license, signing entitlements
    evidence/      patch spec + disassembly, networking-fix write-up, logs
    NEXT-STEPS.md  original machine-transfer continuation notes

Not in this repo (intentionally): `source/*.dmg` (the pristine installer
image) and `archive/` (quarantined broken payload from the initial transfer).
