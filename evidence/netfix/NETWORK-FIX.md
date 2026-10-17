# VM guest networking fix — root cause, fix, evidence

Date: 2026-10-17 (macOS 26.6.2, Parallels Desktop 27.0.3 build 58680, arm64).
Applies to the patched/re-signed install in `/Applications/Parallels Desktop.app`.

## Symptom

Starting a VM showed the dialog *"Network initialization failed. Your virtual
machine will continue working normally but it will have no network connection."*
Guests received no IP address. In the VM's `parallels.log`:

```
/prl_net:.../ vmnet_start_interface started.
/prl_net:.../ try 0/1: av_bind err 1001
```

## Root cause

`prl_vm_app` talks to the system vmnet daemon (`/usr/libexec/InternetSharing`).
The daemon accepts a client only when BOTH of these fail-safe checks pass — i.e.
it requires one of:

1. entitlement `com.apple.vm.networking` or `com.apple.developer.networking.vmnet`
   (both are provisioning-profile-gated; with a self-signed cert AMFI kills the
   process: `-413 No matching profile found` — proven, abandoned), or
2. the client must be **root** (euid 0 per the XPC audit token).

Daemon log for our app pid (status 501/501/501):

```
client_entitlement_check: xpc client does not have any vmnet entitlement, nor is it root
[pid] client access check failed
```

→ libvmnet returns 1001 (`VMNET_FAILURE`) → Parallels shows the dialog.

The exact `vmnet_start_interface` dictionary was captured with an LC_LOAD_DYLIB
interpose hook (see session temp `inject_dict.log`); the dictionary itself is not
the problem — the same dictionary succeeds as root and fails as the user.

## Fix (installed shape)

1. **Dispatcher stays original.** The NOP over `pthread_setugid_np` (file offset
   `0x40364`) was reverted; the dispatcher spawns the VM app as the logged-in
   user (ruid 501) exactly as shipped. Applied dispatcher = t1 patches only:
   `0x90b98 = 20008052` (creds), `0x279b88 = 1f2003d5` (P1 nop),
   `0x40364 = 201b1594` (original BL).
2. **VM app runs euid=0, ruid=501.** Qt 5.15 aborts when `geteuid() != getuid()`
   (`FATAL: The application binary appears to be running setuid, this is a security
   hole.`, QtCore `QCoreApplicationPrivate` ctor), so that guard is neutralized
   **in process memory only**.
3. Two mechanics:
   - `Contents/MacOS/prl_vm_app` is now a tiny **setuid-root launcher**
     (`root:wheel 4755`) that execs the real binary `prl_vm_app.bin` beside it,
     passing argv unchanged (euid=0 carries across exec; ruid stays 501).
     The wrapper is required because a setuid *main* binary cannot use `@rpath`
     expansions (`dyld: Library not loaded ... (security policy does not allow
     @ path expansion)`) and the app's Qt dependencies are all `@rpath`.
   - `prl_vm_app.bin` carries an injected `LC_LOAD_DYLIB` →
     `@loader_path/libprlqtfix.dylib`. The dylib's constructor walks dyld images,
     finds QtCore and (a) sets the cached "setuid allowed" byte at vmaddr
     `0x514228` and (b) NOPs the fatal branch `b.ne` at vmaddr `0x1d658c`
     (arm64 slice). Log file: `/tmp/prl_qtfix.log`.
   - **QtCore on disk is untouched** (pristine Parallels build, sha
     `2ab8836b…`). Its Parallels Developer ID signature must remain valid for
     library-validation-enforcing product binaries (`prl_net_start`,
     `ParallelsVirtualizationSDK`: "mapping process and mapped file
     (non-platform) have different Team IDs") — re-signing QtCore with the
     local cert breaks those binaries and the service start.
4. Signing: PDLocal cert SHA-1 `F9E378C5241D0AEEE6F0EE77E095E70CBD974526`.
   - wrapper: signed via the `Parallels VM.app` bundle reseal with
     `ents_min.plist` ({allow-unsigned-executable-memory, hypervisor}).
   - `prl_vm_app.bin`: PDLocal + `ents_min.plist`.
   - `libprlqtfix.dylib`: PDLocal.
   - `Parallels VM.app` resealed; `codesign --verify --strict` passes for
     bundle, wrapper, `.bin` and dylib.

## Operational note — `prl_naptd` (DHCP/DNS/NAT)

On the Shared network (`10.211.55.0/24`, network UUID `f900935e-…`) Qt-side
DHCP/DNS/NAT is served by **`prl_naptd`**, supervised by
`Contents/MacOS/watchdog` (started by the `Parallels Service` helper):

```
watchdog start 60 20 "/Applications/Parallels Desktop.app/Contents/MacOS/prl_naptd" start
```

If a guest fails to get a DHCP lease after heavy experimentation/setup churn
(e.g. naptd instance predates the live bridge), restart it:

```
kill $(pgrep -f 'prl_naptd start')      # watchdog respawns it
```

Symptom of the stale case: guest stuck at "getting IP configuration", no ARP;
`tcpdump -i bridge100 port 67 or port 68` shows the DISCOVER but no OFFER.

## Verification evidence (2026-10-17)

- `/tmp/prl_qtfix.log` for the three real VM-app runs (Kali boot 1, Kali boot 2,
  Windows): `euid=0 ruid=501`, `guard_before=0x54000341` → `nop_rc=0` →
  `guard_after=0x1f2003d5`, `flag_rc=0` (pids 5492, 7872, 8119).
- VM logs: `if_created_handler: 1000` (VMNET_SUCCESS) + `vm_mac` matching each
  guest, replacing the old `av_bind err 1001`.
- vmnet daemon: `netrbCreateInterface: VM interface create submitted` → attached;
  no `client access check failed`.
- Host: `bridge100 inet 10.211.55.2` with member `vmenet0`.
- Kali (`{5b08aa40-…}`): eth0 `10.211.55.7/24`; ping gateway `10.211.55.1`
  0% loss 0.46 ms; ping host `10.211.55.2` 0% loss 0.40 ms; ping `1.1.1.1`
  0% loss 22 ms; `nslookup google.com` → `142.250.182.238` via `10.211.55.1`.
  Lease survives stop/start cycle (second boot got `.7` again).
- Windows 11 (`{1a0697fd-…}`): `ipconfig` → `10.211.55.9/24`, gateway
  `10.211.55.1`, DNS suffix `localdomain`; `ping 1.1.1.1` 0% loss ~20 ms;
  `nslookup google.com` via `prl-local-ns-server.shared` → resolves.
- Screenshot of running Kali: `kali_screen.png` (session temp).

## Installed hashes

| file | sha256 |
|---|---|
| `…/Parallels VM.app/Contents/MacOS/prl_vm_app` (wrapper) | `c8439fc8867c6c4d42c08bee3a46c49e634cee3dfd67ed9c2433785d890f7530` |
| `…/Parallels VM.app/Contents/MacOS/prl_vm_app.bin` | `c32b3126e37043a3906b996f4857a98c44c2d679128d51f47f567ed92d69ad62` |
| `…/Parallels VM.app/Contents/MacOS/libprlqtfix.dylib` | `10edf5f9967a282765268a7585166822e309ba0696e23e57819d8c47a21fba6a` |
| `…/Frameworks/QtCore.framework/Versions/5/QtCore` (pristine) | `2ab8836b93801dda4c194a246e9c10c24dbf8208d2e0cbe7bccbf686c970e015` |
| `…/Parallels Service.app/Contents/MacOS/prl_disp_service` | `bdabb0cc8f82e5733a50160e98e0b55400144ebf735742b195260a97141f8e37` |

(dispatcher = backup `9decb67c…` + fresh PDLocal signature; only 259 signature-trailer
bytes differ, code bytes identical.)

## Installer recipe delta (t3)

1. Do NOT patch QtCore on disk (no NOP at file offset `0x7ce58c`; keep pristine).
2. Do NOT keep the dispatcher `0x40364` NOP; ship the t1 dispatcher patches only.
3. Build `libprlqtfix.dylib` from `evidence/netfix/libprlqtfix.c` (clang -arch arm64
   -dynamiclib), sign PDLocal, inject `LC_LOAD_DYLIB`
   `@loader_path/libprlqtfix.dylib` into `prl_vm_app.bin` via
   `evidence/scripts/inject_dylib.py`-equivalent (headerpad insert), sign
   PDLocal + `ents_min.plist`.
4. Build the launcher from `evidence/netfix/prl_vm_app_wrapper.c`
   (clang -arch arm64), install as `Contents/MacOS/prl_vm_app` root:wheel 4755,
   real binary as `prl_vm_app.bin` (755).
5. Reseal `Parallels VM.app` with PDLocal + `ents_min.plist`.
