#!/bin/bash
set -euo pipefail
SRC="/custom/config.js"
DST="/usr/share/jitsi-meet/config.js"

echo "🔄 Using custom config: $SRC -> $DST"
if [ -f "$SRC" ]; then
  cp -f "$SRC" "$DST"
  chmod 0644 "$DST"
  chown www-data:www-data "$DST" 2>/dev/null || true
  echo "✅ Applied $DST"
else
  echo "❌ $SRC not found"
fi
