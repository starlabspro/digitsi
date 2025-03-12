#!/bin/bash
echo "🔄 Changing Jitsi Logo..."

# Backup original logo (only if not already backed up)
if [ ! -f /usr/share/jitsi-meet/images/watermark-bak.png ]; then
    cp /usr/share/jitsi-meet/images/watermark.png /usr/share/jitsi-meet/images/watermark-bak.png
fi

# Replace Jitsi logo with our custom one
cp /custom/custom-logo.svg /usr/share/jitsi-meet/images/watermark.svg

echo "✅ Jitsi logo updated!"
