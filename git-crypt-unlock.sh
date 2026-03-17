#!/bin/bash
# Retrieves the git-crypt key from macOS Keychain and unlocks the repo.
# The login keychain auto-unlocks at login, so no prompt during a session.
# After reboot, logging in is the only "prompt" needed.

set -euo pipefail

TMPKEY=$(mktemp)
trap 'rm -f "$TMPKEY"' EXIT

security find-generic-password -a "git-crypt" -s "cryptdemo-key" -w \
  | base64 -d > "$TMPKEY"

git-crypt unlock "$TMPKEY"
