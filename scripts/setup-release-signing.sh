#!/usr/bin/env bash
# Creates NineTailsFlip's release signing key (once) and stores it as GitHub Actions secrets, so
# the Android workflow can sign releases. Run it on your own machine, logged in to gh as an owner
# of the organization:
#
#   scripts/setup-release-signing.sh [key folder] [path to tg9's local.properties]
#
# One key signs every app. Android only installs an update signed with the same key as the
# installed app, so:
#
#   BACK UP THE KEY FOLDER (default ~/NineTailsFlip-signing) SOMEWHERE SAFE AND OFFLINE.
#   If it's lost, no existing install of any of our apps can ever be updated again.
#
# Running it again reuses the existing key and just sets the secrets again.
#
# Secrets it sets:
#   RELEASE_KEYSTORE_BASE64, RELEASE_KEYSTORE_PASSWORD, RELEASE_KEY_ALIAS, RELEASE_KEY_PASSWORD
#     on the organization (all repositories) if your gh token may, else on each app repository.
#   TG9_API_ID, TG9_API_HASH on NineTailsFlip/tg9, from tg9's local.properties, if it's there.
set -euo pipefail

ORG=NineTailsFlip
REPOS=(tg9 g9 l9 c9 p9 m9 setup9 k9 settings9 lock9)
KEY_DIR="${1:-$HOME/NineTailsFlip-signing}"
TG9_PROPERTIES="${2:-$HOME/Documents/GitHub/tg9/local.properties}"
ALIAS=ninetailsflip
KEYSTORE="$KEY_DIR/release.jks"
PROPS="$KEY_DIR/release.properties"

# The first keytool that actually runs: macOS's /usr/bin/keytool is only a stub that fails
# without a system-wide Java, so a JDK's own comes first.
KEYTOOL=""
for candidate in \
    ${JAVA_HOME:+"$JAVA_HOME/bin/keytool"} \
    /opt/homebrew/opt/openjdk*/bin/keytool \
    /usr/local/opt/openjdk*/bin/keytool \
    /Library/Java/JavaVirtualMachines/*/Contents/Home/bin/keytool \
    "$(command -v keytool || true)"; do
    if [ -x "$candidate" ] && "$candidate" -help >/dev/null 2>&1; then
        KEYTOOL="$candidate"
        break
    fi
done
[ -n "$KEYTOOL" ] || { echo "No working keytool: install a JDK (brew install openjdk@21)" >&2; exit 1; }
command -v gh >/dev/null || { echo "gh not found: brew install gh" >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Log in first: gh auth login" >&2; exit 1; }

mkdir -p "$KEY_DIR"
chmod 700 "$KEY_DIR"

if [ -f "$KEYSTORE" ]; then
    echo "Reusing the key in $KEYSTORE"
    # shellcheck disable=SC1090
    PASSWORD="$(sed -n 's/^storePassword=//p' "$PROPS")"
    [ -n "$PASSWORD" ] || { echo "$PROPS has no storePassword" >&2; exit 1; }
else
    echo "Creating the release key in $KEYSTORE"
    PASSWORD="$(openssl rand -base64 48 | tr -dc 'A-Za-z0-9' | head -c 40)"
    # PKCS12 keeps one password for the store and the key.
    "$KEYTOOL" -genkeypair -noprompt \
        -keystore "$KEYSTORE" -storetype PKCS12 \
        -alias "$ALIAS" -keyalg RSA -keysize 4096 -validity 36500 \
        -storepass "$PASSWORD" -keypass "$PASSWORD" \
        -dname "CN=NineTailsFlip, O=NineTailsFlip" >/dev/null
    umask 077
    {
        echo "# NineTailsFlip release signing. Keep with release.jks; never commit."
        echo "storeFile=$KEYSTORE"
        echo "storePassword=$PASSWORD"
        echo "keyAlias=$ALIAS"
        echo "keyPassword=$PASSWORD"
    } > "$PROPS"
    chmod 600 "$KEYSTORE" "$PROPS"
fi

KEYSTORE_B64="$(base64 < "$KEYSTORE" | tr -d '\n')"

set_secrets() { # $@: where, e.g. --org NineTailsFlip --visibility all, or --repo NineTailsFlip/g9
    printf '%s' "$KEYSTORE_B64" | gh secret set RELEASE_KEYSTORE_BASE64 "$@" >/dev/null
    printf '%s' "$PASSWORD" | gh secret set RELEASE_KEYSTORE_PASSWORD "$@" >/dev/null
    printf '%s' "$ALIAS" | gh secret set RELEASE_KEY_ALIAS "$@" >/dev/null
    printf '%s' "$PASSWORD" | gh secret set RELEASE_KEY_PASSWORD "$@" >/dev/null
}

if set_secrets --org "$ORG" --visibility all 2>/dev/null; then
    echo "Signing secrets set on the $ORG organization."
else
    echo "Couldn't set organization secrets (gh needs the admin:org scope: gh auth refresh -s admin:org)."
    echo "Setting them on each repository instead."
    for repo in "${REPOS[@]}"; do
        set_secrets --repo "$ORG/$repo"
        echo "  $ORG/$repo"
    done
fi

if [ -f "$TG9_PROPERTIES" ]; then
    API_ID="$(sed -n 's/^tg9.apiId=//p' "$TG9_PROPERTIES")"
    API_HASH="$(sed -n 's/^tg9.apiHash=//p' "$TG9_PROPERTIES")"
    if [ -n "$API_ID" ] && [ -n "$API_HASH" ]; then
        printf '%s' "$API_ID" | gh secret set TG9_API_ID --repo "$ORG/tg9" >/dev/null
        printf '%s' "$API_HASH" | gh secret set TG9_API_HASH --repo "$ORG/tg9" >/dev/null
        echo "Telegram API credentials set on $ORG/tg9."
    fi
else
    echo "No $TG9_PROPERTIES: set TG9_API_ID and TG9_API_HASH on $ORG/tg9 yourself, or TG9 releases can't sign in."
fi

echo
echo "Done. Now back up $KEY_DIR (release.jks and release.properties) somewhere safe and offline."
echo "Certificate SHA-256, for checking APKs later:"
"$KEYTOOL" -list -keystore "$KEYSTORE" -storepass "$PASSWORD" -alias "$ALIAS" -v 2>/dev/null | sed -n 's/^.*SHA256: //p'
