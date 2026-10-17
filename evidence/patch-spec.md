# Patch specification — Parallels Desktop 27.0.3 (58680), prl_disp_service (arm64)

Binary: `Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service`

* original sha256: `d9f2fff825b4e97400bfffb110b96b242d246d93aa3f4da05308f3e4319d6c26`
* patched sha256:  `4950b8cfc825d5d8b0de4a5a4bd3ee51fe64ae6293f4db0334a534b0f19fdbf3`
* identifier: `com.parallels.desktop.dispatcher` (ad-hoc re-signed; original
  runtime/library-validation flags cleared; entitlement
  `com.apple.security.smartcard` preserved, XML+DER)
* signature verified: all 1926 SHA-256 page hashes match the CodeDirectory.

## P1 — license signature check bypass (applied)

* vm `0x100279b88`, inside the license validator function `0x100279b54`
* original: `tbz w0, #0, #0x100279c9c` (takes failure branch when the
  signature verifier `bl 0x1004626ac` returns "bad")
* patched: `nop` (the verification result is ignored; validation continues)
* failure log string nearby, at file offset `0x63d9a4`:
  `"Signature check failed for license info"` → error code `-0xdeaa`
* related messages: `0x63d9cc "unable to parse license info"` (→ `-0xdeab`),
  `0x63da05 "Can't load license info."` (→ `-0xdea8`)

## P2 — license state getter forced valid (applied)

* vm `0x100279b3c` — public validity getter, 29 call sites; return code
  convention: `0` = valid (callers use `cbz w0` / `cmp w0,#0; cset eq`)
* original: `ldrb w8, [x0, #0x38]` (checks an "invalid" flag byte) followed by
  `tbz`; on flag set returns `-0xdeb2`
* patched: `mov w0, #0` + `ret`

## License storage (byte-level evidence)

* path (from `ParallelsDirs` strings): `/Library/Preferences/Parallels/licenses.json`
  (file offset `0x67d2fe`, used by the config-dir builder at `0x100513660`)
* keys resolved from dyld bindings + GOT slots:
  * `0x1006ef6d0` → `"license"`  (JSON **text** — parsed via
    `QString::toUtf8` → `QJsonDocument::fromJson` → `QVariant` map; must be a JSON **object**)
  * `0x1006ef6d8` → `"signature"` (hex string — two hex chars per byte;
    hex decoder is inside verifier `0x1004626ac`, output buffer = len*2 worst case)
* load path: `DspLicense::load` `0x100279f58` (only caller: dispatcher init at
  `0x10002acc4`) → fetch both fields → validator `0x100279b54(A, B, flags=0)`
* validator stores claims into `this+0x18` (QJsonObject) and clears the
  "invalid" flag byte `strb wzr, [x19, #0x38]`
* pre-patch getter semantics (`0x10031a878`, entry via `0x100279b3c`):
  * requires `QJsonObject::isEmpty() == false`
  * reads claim `"offline"`; if present takes the offline path
  * checks `0x1003199dc` (reads claim `"product_version"`, regex `^(\d+)\.`)
  * checks claim `"is_beta"` (present → error `-0x2b03`)
  * checks claim `"platform"` (compared against a value; absent is OK)
  * final gate `0x10002d8c8` — QDateTime comparisons (expiry checks) built
    from claim dates via `0x100033a24` / `0x100033bc8`

## Claim keys observed in the binary's string table (region 0x632425–0x633700)

offline, is_trial, license_key, subscription, signature, activated_hosts,
forced_hwid, sso_session_id, deactivate_hw_id, subscription_uuid,
expiration_date, expiration_date_deferred, main_period_ends_at,
grace_period_ends_at, expires_at, activated_at, activation_type,
product_version, platform, lic_edition, lic_product, lic_platform, is_beta,
is_active, auto_renewable, is_auto_renewable, hw_id_list, product_name,
universalKeys, licensedProducts, keyName, available_for_extend,
pdfm_by_subscription, pdfm_pro_by_subscription, pdb_by_subscription,
pde_by_subscription, encrypted_license_based

Editions seen: Standard / Enterprise / Business / Professional.

## Network endpoints (blocked via /etc/hosts)

* `https://access.%1/license/api/v1` — activation/license API
* `https://access.%1/agent_api/v1`
* `https://my.%1`, `https://account.%1/api/v1/geoip`, `/webinstaller`
* `https://desktop.%1` (also mentioned in user-facing error text: "make sure
  desktop.parallels.com is accessible through port 443")
* `https://pda-api.%1/api`, `https://reportus.%1/api` (+ `/pdfm/27`)
* `https://static.parallels.com/i`, `https://www.parallels.com/*`, `update.parallels.com`
* licensing RPC names: `licensing/activate`, `licensing/deactivate`,
  `licensing/get_trial`, `licensing/heartbeat`, `licensing/sso_activate`
* .cn mirrors: the dispatcher's URL templates substitute a brand token that can be
  `parallels.cn` too. Live observation (2026-10-17, .com block above active): the
  dispatcher still resolved and connected `account.parallels.cn` -
  104.18.8.96/104.18.9.96:443 (Cloudflare), a long-lived TLS session, alongside
  "First start of statistic reporter" / AutoStatisticReport log lines. After
  mapping `account.parallels.cn` (+ the .cn mirror set) to 0.0.0.0 the connection
  is gone - verified with 60 s of zero ESTABLISHED sockets on the dispatcher FDs.

## Where the GUI-side strings live (for a possible round 2)

* `prl_client_app` (arm64, 29 MB):
  * `0x1001f6ecc` — function containing the "Get Genuine Copy" dialog
    (string ref at `0x1001fcb5c`); 0 direct callers (invoked via vtable/signal)
  * "Continue Trial" refs: `0x1001f7cb4`, `0x10045cde8`
* `ParallelsVirtualizationSDK` (universal; arm64 slice):
  * "This copy of @PRL_PRODUCT_NAME may not be genuine…" at file offset `0x6c651d`
  * hint text incl. "download and install a genuine copy … contact Parallels Support"
* `libPrlGui.3.dylib` — license key entry UI (`CLicenseKeyFormatter`),
  `CTaskCheckForProductUpdate::checkLicense` (symbol table names)

## Final Mac-side patch set (2026-10-17) - installed build

Delivered app: /Applications/Parallels Desktop.app, rebuilt by deliverable/install.command
from the pristine DMG (sha256 301175ad94bc8575adb3f4ced24e9707a328c0e4220330cc4e92bd1da6da6bea),
canonical byte patches, local PDLocal Code Sign re-signature.

Hash note: the transfer-era patched dispatcher sha 4950b8cf... (archived under
archive/broken-transfer-payload-2026-10-17) is NOT the final artifact. The final build is
re-signed locally, which rewrites CodeSignature regions and changes the whole-file sha256.
Final-build acceptance = byte-exact patch sites + valid signature + runtime.

### prl_disp_service (installed)
* path: Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service
* sha256: varies per rebuild - codesign embeds a fresh signing timestamp (e.g.
  21:31Z run 90bdc7b3..., 21:35Z run a96a382a..., 21:40Z run 670bb4f6...).
  Acceptance = byte-exact patch sites + codesign -v + runtime, not a pinned sha.
* 0x279b88: 1f2003d5  (nop; license-signature-check bypass, spec P1)
* 0x90b98: 20008052c0035fd6  (mov w0,#1 ; ret ; creds accessor forced valid, spec P2)
* 0x90bd8: 1f2003d5  (nop; creds accessor secondary branch, spec P2)
* 0x31ab04: 05000535  (cbnz w5,+0x20 ; license-state getter - working-build quirk,
  provenance unknown, reproduced byte-exact from the working transfer build)
* signature: local PDLocal Code Sign; codesign -v OK
* post-install re-verified (final installer run 2026-10-17 21:40 local): all sites byte-for-byte, ALL_SITES_OK; outer codesign OK; wrapper setuid; guest networking OK

### prl_vm_app.bin (installed)
* path: Contents/MacOS/Parallels VM.app/Contents/MacOS/prl_vm_app.bin
* sha256: varies per rebuild (fresh signing timestamp; 21:40Z run: 80b6e95378095af118a75b22536c19f0ea393ff531f1930cf6a0b03f650e969f)
* 0x4bea0: 14000014  (b +0x50 ; peer/validation check skip)
* 0x589cc: 1f2003d5  (nop ; license gate)
* LC_LOAD_DYLIB @loader_path/libprlqtfix.dylib present
* launch path: setuid-root launcher prl_vm_app (root:wheel 4755) -> prl_vm_app.bin with
  euid=0; libprlqtfix neutralizes the Qt5 "running setuid" guard in memory only
  (QtCore stays pristine; see evidence/netfix/NETWORK-FIX.md)

### Other installed-state facts
* QtCore sha256: 2ab8836b93801dda4c194a246e9c10c24dbf8208d2e0cbe7bccbf686c970e015  (pristine, NOT re-signed - Parallels signature required
  for prl_net_start / SDK library validation)
* licenses.json: /Library/Preferences/Parallels/licenses.json, 444 root:wheel,
  flags schg,uchg, sha256 30a707e76a7b0dd475e7d0226556fb753e56becbf77b0b234a7f5f6d3fc23b43  (Business Edition, is_volume:true)
* /etc/hosts: PARALLELS-BLOCK block present (endpoints listed above)
* CEP mechanism: off (prlsrvctl info); License: state='valid'
* no established outbound TCP connections from Parallels processes at sweep time
* vmenet interfaces recycled across VM starts (vmenet0, vmenet1, vmenet3 observed)
