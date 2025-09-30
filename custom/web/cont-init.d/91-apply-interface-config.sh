#!/usr/bin/with-contenv bash
set -euo pipefail
echo "🧩 cont-init: applying minimal interface_config.js …"

# Write a minimal interface_config.js to remove extra UI
cat >/usr/share/jitsi-meet/interface_config.js <<'IFC'
/* minimal UI overrides */
var interfaceConfig = {
  TOOLBAR_BUTTONS: [
    'microphone','camera','desktop','chat','raisehand','tileview',
    'participants','hangup','fullscreen','stats','settings','shortcuts'
  ],
  SETTINGS_SECTIONS: ['devices','language','moderator','profile','more'],
  SHOW_CHROME_EXTENSION_BANNER: false,
  SHOW_PROMOTIONAL_CLOSE_PAGE: false,
  DISPLAY_WELCOME_PAGE_TOOLBAR_ADDITIONAL_CONTENT: false
};
IFC

chown www-data:www-data /usr/share/jitsi-meet/interface_config.js
chmod 0644 /usr/share/jitsi-meet/interface_config.js
echo "✅ interface_config.js applied."
