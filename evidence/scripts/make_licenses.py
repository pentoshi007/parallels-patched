#!/usr/bin/env python3
"""Generate a forged /Library/Preferences/Parallels/licenses.json for the patched service.

Storage schema (byte-level evidence from prl_disp_service 27.0.3):
  {"license": "<license payload JSON text>", "signature": "<hex signature blob>"}
  - payload parsed via QJsonDocument::fromJson(QString::toUtf8(payload)) -> QVariantMap
  - signature hex-decoded then verified (verification is NOP'ed by patch P1)
Claims vocabulary taken from the service's own string table (offline, is_trial,
is_beta, product_version, license_key, lic_edition, expiration dates, ...).
"""
import json
import sys

claims = {
    "offline": True,
    "is_trial": False,
    "is_beta": False,
    "product_version": "27.0.3",
    "product": "Parallels Desktop for Mac",
    "product_name": "Parallels Desktop for Mac",
    "lic_product": "pdfm",
    "lic_platform": "mac",
    "lic_edition": "Professional Edition",
    "license_key": "PDFM27-PER-0000-0000-0000-0000",
    "created_date": "2026-01-01T00:00:00Z",
    "expiration_date": "2036-01-01T00:00:00Z",
    "main_period_ends_at": "2036-01-01T00:00:00Z",
    "grace_period_ends_at": "2036-02-01T00:00:00Z",
    "expires_at": "2036-01-01T00:00:00Z",
    "auto_renewable": False,
    "is_auto_renewable": False,
    "activated_at": "2026-01-01T00:00:00Z",
    "activation_type": "offline",
    "activated_hosts": [],
    "hw_id_list": [],
    "subscription": False,
    "pdfm_by_subscription": False,
    "pde_by_subscription": False,
}

payload = json.dumps(claims, separators=(",", ":"))
signature = "00" * 64  # 64 bytes; accepted because P1 skips verification

out = {"license": payload, "signature": signature}

path = sys.argv[1] if len(sys.argv) > 1 else "licenses.json"
with open(path, "w") as fh:
    json.dump(out, fh, indent=1)
    fh.write("\n")
print("wrote", path, "payload bytes:", len(payload))
