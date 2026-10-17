#!/bin/bash
# Creates the "PDLocal Code Sign" local code-signing identity used by
# install.command. User-domain keychain, no Apple account or admin needed.
# Safe to re-run: a working existing identity is detected and kept.
#
# Overridable for testing/advanced use:
#   PD_IDENTITY_NAME, PD_KEYCHAIN, PD_KEYCHAIN_PASS
set -u

IDENTITY_NAME="${PD_IDENTITY_NAME:-PDLocal Code Sign}"
KC="${PD_KEYCHAIN:-$HOME/Library/Keychains/pdlocal-sign.keychain-db}"
KC_PASS="${PD_KEYCHAIN_PASS:-pdlocal}"
TMP="$(mktemp -d /tmp/pdlocal-sign.XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

log()  { printf '%s\n' "$*"; }
fail() { printf '\n[!] ERROR: %s\n' "$*"; exit 1; }

[ "$(uname -s)" = "Darwin" ] || fail "This script must be run on macOS."

# Prove an identity can actually sign before trusting it (locked keychain or
# a stale key makes find-identity lie).
works() {
  cp /bin/echo "$TMP/signtest" 2>/dev/null || printf '#!/bin/sh\n' > "$TMP/signtest"
  codesign --force --timestamp=none --sign "$1" "$TMP/signtest" >/dev/null 2>&1
}

H="$(security find-identity -v -p codesigning 2>/dev/null | awk -v n="$IDENTITY_NAME" 'index($0, "\"" n "\"") {print $2; exit}')"
if [ -n "$H" ] && works "$H"; then
  log "Signing identity \"$IDENTITY_NAME\" already present and working ($H)."
  exit 0
fi

log "Creating local signing identity \"$IDENTITY_NAME\" ..."
cat > "$TMP/openssl.cnf" <<EOF
[req]
distinguished_name = dn
x509_extensions = ext
prompt = no
[dn]
CN = $IDENTITY_NAME
[ext]
keyUsage = critical,digitalSignature
extendedKeyUsage = critical,codeSigning
basicConstraints = critical,CA:FALSE
EOF
openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
  -config "$TMP/openssl.cnf" \
  -keyout "$TMP/key.pem" -out "$TMP/cert.pem" >/dev/null 2>&1 || fail "openssl failed"

security delete-keychain "$KC" >/dev/null 2>&1 || true
rm -f "$KC"
security create-keychain -p "$KC_PASS" "$KC" || fail "create-keychain failed"
security set-keychain-settings -lut 21600 "$KC" >/dev/null 2>&1 || true
security unlock-keychain -p "$KC_PASS" "$KC" || fail "unlock-keychain failed"

# OpenSSL 3 defaults to AES-based PKCS#12 that macOS "security import"
# rejects; force the legacy SHA1/3DES scheme first, plain form second.
ok=0
if openssl pkcs12 -export -out "$TMP/id.p12" \
     -inkey "$TMP/key.pem" -in "$TMP/cert.pem" -passout "pass:$KC_PASS" \
     -certpbe PBE-SHA1-3DES -keypbe PBE-SHA1-3DES -macalg sha1 >/dev/null 2>&1; then
  security import "$TMP/id.p12" -k "$KC" -P "$KC_PASS" \
    -T /usr/bin/codesign -T /usr/bin/security >/dev/null 2>&1 && ok=1
fi
if [ "$ok" -eq 0 ]; then
  openssl pkcs12 -export -out "$TMP/id.p12" \
    -inkey "$TMP/key.pem" -in "$TMP/cert.pem" -passout "pass:$KC_PASS" >/dev/null 2>&1
  security import "$TMP/id.p12" -k "$KC" -P "$KC_PASS" \
    -T /usr/bin/codesign -T /usr/bin/security >/dev/null 2>&1 && ok=1
fi
[ "$ok" -eq 1 ] || fail "could not import the identity into the keychain"

# Trust for code signing in the user domain (no admin needed) so
# codesign/find-identity treat it as valid.
security add-trusted-cert -p codeSign -k "$KC" "$TMP/cert.pem" >/dev/null 2>&1 || true
security set-key-partition-list -S apple-tool:,apple:,codesign: \
  -s -k "$KC_PASS" "$KC" >/dev/null 2>&1 || true

# Append to the user keychain search list (never replace it). The listing is
# space- and quote-formatted and may contain stale entries, so normalise
# every line and keep only paths that exist. bash 3.2-safe.
KCLIST=()
while IFS= read -r line; do
  line="$(printf '%s' "$line" | sed -E 's/^[[:space:]]+"?//; s/"?[[:space:]]*$//')"
  case "$line" in ""|"$KC") continue ;; esac
  [ -e "$line" ] && KCLIST+=("$line")
done < <(security list-keychains -d user 2>/dev/null)
if [ "${#KCLIST[@]}" -gt 0 ]; then
  security list-keychains -d user -s "${KCLIST[@]}" "$KC" >/dev/null 2>&1 || true
else
  security list-keychains -d user -s "$KC" >/dev/null 2>&1 || true
fi

H="$(security find-identity -v -p codesigning 2>/dev/null | awk -v n="$IDENTITY_NAME" 'index($0, "\"" n "\"") {print $2; exit}')"
[ -n "$H" ] || fail "identity created but not visible to find-identity"
works "$H" || fail "identity created but codesign cannot use it"
log "Identity ready: \"$IDENTITY_NAME\" ($H)"
