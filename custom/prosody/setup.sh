#!/bin/bash
set -euo pipefail
echo "🔐 Ensuring teacher@meet.jitsi exists …"

CFG=/config/prosody.cfg.lua
USER="teacher"
DOM="meet.jitsi"
PASS="letmein2020"

# delete if exists then create
prosodyctl --config "$CFG" deluser "${USER}@${DOM}" 2>/dev/null || true
prosodyctl --config "$CFG" register "$USER" "$DOM" "$PASS" || true

echo "✅ Prosody user ${USER}@${DOM} ready"
