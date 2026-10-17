# Parallels Desktop 27.0.3 — patched build for Apple Silicon macOS

Offline-patched rebuild of **Parallels Desktop 27.0.3 (58680)** for Apple
Silicon Macs. License checks are bypassed (a shipped offline Business Edition
license is accepted — no sign-in, no trial timer, no purchase windows), guest
networking works without Apple-provisioned `vmnet` entitlements, and Parallels'
activation / update / telemetry endpoints are blocked at the system level.

Verified end-to-end on macOS 26 (Apple Silicon): installer run, VM boot, guest
DHCP/DNS/NAT, and zero outbound Parallels connections.

> **Read first**
> * For **personal use** on **Apple Silicon** Macs only (M1 or newer — Intel is
>   not supported).
> * **Do not update Parallels Desktop afterwards** — an update replaces the
>   patched files with the original ones. Re-run the installer instead.
> * The installer replaces `/Applications/Parallels Desktop.app`. Your VMs in
>   `~/Parallels` are never touched, but running VMs are stopped during install.

## What you get

* Parallels Desktop rebuilt **on your Mac** from the pristine Parallels DMG
  (SHA-256-pinned), byte-patched and re-signed locally — nothing is pre-signed
  on a third-party machine.
* The app opens straight to your VM list: no sign-in, no trial, no "Get Genuine
  Copy" dialogs.
* Working VM networking without special entitlements (setuid launcher + in-memory
  Qt fix — see `evidence/netfix/NETWORK-FIX.md`).
* An offline Business Edition `licenses.json`, installed read-only + immutable,
  and a `PARALLELS-BLOCK` section in `/etc/hosts` that points Parallels'
  activation/update/telemetry domains (`.com` and `.cn`) at `0.0.0.0`.

## Requirements

| | |
|---|---|
| Mac | Apple Silicon (M1/M2/M3/…), macOS 14 or newer |
| Disk | ~2 GB free (155 MB DMG + ~350 MB installed app + working space) |
| Tools | Xcode **Command Line Tools** — check with `xcode-select -p`; install with `xcode-select --install` if missing (the installer compiles two tiny helper binaries) |
| Rights | your **admin password** once, for the installer (it replaces the app and edits `/etc/hosts`) |
| Network | internet for the first run (downloads the DMG from this repo's release); everything after that is offline |

## Step-by-step install

**1. Get the repo**

```bash
git clone https://github.com/pentoshi007/parallels-patched.git
cd parallels-patched
```

(or use the green **Code** button → *Download ZIP* and unpack it)

**2. Run the bootstrap**

```bash
bash bootstrap.command
```

This does everything, in three stages:

1. **Downloads the pristine DMG** into `source/` and verifies its SHA-256.
   It prefers the `gh` CLI if you have it and are logged in; otherwise it
   falls back to `curl`. (You can also download
   `ParallelsDesktop-27.0.3-58680.dmg` from the
   [release page](https://github.com/pentoshi007/parallels-patched/releases/tag/v27.0.3-58680)
   in a browser and drop it into `source/` beforehand.)
2. **Creates the local signing identity** (`PDLocal Code Sign`) once, in a
   dedicated keychain — no Apple account needed. If macOS shows a keychain
   prompt, allow it (the keychain password is `pdlocal`).
3. **Runs the installer** — it asks for your **admin password**, stops any
   running Parallels processes, rebuilds the app from the DMG, re-signs it,
   installs the offline license, blocks the endpoints and starts the service.
   Takes ~1–3 minutes.

> Save your work in running VMs first — they are hard-stopped by the installer.

**3. Open Parallels Desktop** from `/Applications` and start a VM (existing
ones under `~/Parallels`, or *File → New…*). No sign-in or licensing window
should appear — it goes straight to the VM list.

**4. Sanity check (optional)** — in a VM with Shared Network:

```bash
ping -c2 1.1.1.1        # run INSIDE the VM; expect replies
```

On the Mac, this should show `-rwsr-xr-x root wheel` (the setuid launcher that
makes VM networking work):

```bash
ls -l "/Applications/Parallels Desktop.app/Contents/MacOS/Parallels VM.app/Contents/MacOS/prl_vm_app"
```

## Troubleshooting — issues you might face

**`gh: command not found` / "not logged in"** — fine: the bootstrap falls back
to `curl` automatically. Or install/authenticate: `brew install gh && gh auth login`.

**The installer fails with clang / xcode-select errors** — install the Command
Line Tools first: `xcode-select --install`, accept the GUI prompt, then re-run
`bash bootstrap.command`.

**macOS shows keychain or "codesign wants to use…" prompts** — allow them and
click *Always Allow*. The dedicated keychain's password is `pdlocal`. If identity
creation itself failed, run `bash deliverable/setup-signing-identity.command` and
read its output.

**"Parallels Desktop.app is damaged and can't be opened"** — you're on an old or
broken copy; re-run `bash bootstrap.command` to rebuild and re-sign correctly.
**Never** run `xattr -cr` on the app — it destroys compressed resources.

**"You don't have permission" / installer stops right after sudo** — the sudo
password was wrong or cancelled; just re-run `bash bootstrap.command`.

**A VM complains "Network initialization failed"** — macOS can occasionally
clear the setuid bit of the launcher. Fix it and start the VM again:

```bash
sudo chmod 4755 "/Applications/Parallels Desktop.app/Contents/MacOS/Parallels VM.app/Contents/MacOS/prl_vm_app"
```

Also make sure that VM's network mode is *Shared Network* in its settings.

**A "Sign In" / "Trial" / "Get Genuine Copy" window appears** — the patched
files were replaced (almost always an app update). Do not update Parallels;
re-run `bash bootstrap.command` to restore the patched build.

**The app crashes right after launch** — same as above: re-run the installer and
avoid updating. Crash reports land in `~/Library/Logs/DiagnosticReports`.

**You just upgraded macOS** — re-run `bash bootstrap.command`; it rebuilds from
the DMG already in `source/`.

**Intel Mac** — not supported by this build.

## Uninstall

```bash
bash deliverable/uninstall.command
```

Removes the app, the offline license and the `PARALLELS-BLOCK` hosts section.
Your VMs in `~/Parallels` are never touched.

## Layout

    bootstrap.command   one step: DMG + identity + installer
    deliverable/        installer, uninstaller, offline license, signing entitlements
                        (deliverable/README.md documents every step and trap)
    evidence/           patch spec + disassembly, networking-fix write-up, logs

Not in this repo (intentionally): `source/*.dmg` — the 155 MB pristine Parallels
installer, attached to the `v27.0.3-58680` release instead (the bootstrap fetches
it); and `archive/` (quarantined broken payload from the machine transfer).

## Rebuild only (advanced)

If the DMG is already in `source/` and the identity exists:

```bash
bash deliverable/install.command
```

It verifies the DMG checksum, copies the app out of the DMG (xattr-safe),
applies the byte patches, re-signs everything locally, installs the license
read-only, blocks the endpoints and (re)starts the service.
`deliverable/README.md` documents the full procedure and all the traps that were
hit while building this (xattr/decmpfs corruption, FinderInfo re-seal failure,
entitlement edge cases, service recovery).

## How it works (short version)

* `prl_disp_service` — license-signature check ignored, license-state getter
  forced valid, credentials accessor forced valid (4 byte patches).
* `prl_vm_app` — two license gates patched; a setuid-root launcher
  (`prl_vm_app`, mode 4755) starts the real binary with `euid=0` so macOS's
  `vmnet` daemon accepts it without Apple-provisioned entitlements; a small
  injected dylib neutralizes Qt's "running setuid" refusal **in memory only**
  (QtCore stays pristine, as Parallels' own signature expects).
* Offline Business Edition license, immutable; Parallels' activation / update /
  telemetry hosts mapped to `0.0.0.0`; CEP telemetry switched off.
* Note: the pristine DMG attached to the release is Parallels' copyrighted
  installer — keep everything here to personal use.
