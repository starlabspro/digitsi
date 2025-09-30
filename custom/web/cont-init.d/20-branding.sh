#!/usr/bin/with-contenv bash
set -euo pipefail
echo "🎨 cont-init: applying Jitsi branding (backgrounds + watermark)…"

# ---- Virtual backgrounds ----
SRC_BG="/custom/backgrounds"
DST_BG="/usr/share/jitsi-meet/images/virtual-background"

if [ -d "$SRC_BG" ]; then
  mkdir -p "$DST_BG"

  # If you have files named school-1.jpg .. school-7.jpg we’ll map them onto the
  # built-in names so we **don’t** need to modify app.bundle.js.
  for i in 1 2 3 4 5 6 7; do
    if [ -f "$SRC_BG/school-$i.jpg" ]; then
      cp -f "$SRC_BG/school-$i.jpg" "$DST_BG/background-$i.jpg"
    fi
  done

  # Also copy any extra images (they’ll show up in the picker if referenced)
  find "$SRC_BG" -maxdepth 1 -type f -name '*.jpg' -not -name 'school-*.jpg' -exec cp -f {} "$DST_BG"/ \;

  chown -R www-data:www-data "$DST_BG"
  chmod -R 0755 "$DST_BG"
  echo "✅ Backgrounds updated in $DST_BG"
else
  echo "ℹ️  No /custom/backgrounds directory found; skipping backgrounds"
fi

# ---- Watermark / logo ----
if [ -f /custom/custom-logo.svg ]; then
  # Backup once
  if [ ! -f /usr/share/jitsi-meet/images/watermark.svg.bak ]; then
    cp -f /usr/share/jitsi-meet/images/watermark.svg /usr/share/jitsi-meet/images/watermark.svg.bak || true
  fi
  cp -f /custom/custom-logo.svg /usr/share/jitsi-meet/images/watermark.svg
  chown www-data:www-data /usr/share/jitsi-meet/images/watermark.svg
  chmod 0644 /usr/share/jitsi-meet/images/watermark.svg
  echo "✅ Custom watermark applied"
else
  echo "ℹ️  No /custom/custom-logo.svg found; skipping watermark"
fi

echo "🎉 Branding complete."

