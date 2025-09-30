#!/usr/bin/with-contenv bash
set -euo pipefail
echo "🔄 cont-init: applying custom config.js …"

cat >/usr/share/jitsi-meet/config.js <<'JS'
var config = {};

// XMPP hosts
config.hosts = {
  domain: 'meet.jitsi',
  muc: 'muc.meet.jitsi',
  anonymousdomain: 'guest.meet.jitsi'
};

// Transport (BOSH only – stable)
config.bosh = 'https://dev-moodle.digitalschool.tech:8443/http-bind';

// Auth: moderator must log in; guests allowed
config.authentication = 'login';
config.disableAutoLogin = true;
config.prejoinConfig = { enabled: true };
config.enableLobby = true;

// Keep only these buttons (bottom + overflow)
config.toolbarButtons = [
  'microphone','camera','desktop','chat','raisehand','tileview',
  'participants-pane','participants','hangup',
  'fullscreen','stats','settings','shortcuts'
];

// 🔒 hide extra items from the overflow menu
config.disableInviteFunctions     = true;   // hides “Invite people”
config.disableSharedVideo         = true;   // hides “Share video (YouTube)”
config.disableAudioInputSharing   = true;   // hides “Share audio”
config.securityUi                 = false;  // hides “Security options”

// ⛔ also disable recording (removes “Start recording”)
config.localRecording = { disable: true };  // local recording menu off
// (file/live recording are off unless explicitly enabled via env,
// but the above guarantees no “Start recording” item.)

// A couple of safe defaults
config.resolution = 720;
config.videoQuality = { enableAdaptiveMode: true };
JS

chown www-data:www-data /usr/share/jitsi-meet/config.js
chmod 0644 /usr/share/jitsi-meet/config.js
echo "✅ config.js applied."
