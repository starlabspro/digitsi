var config = {

	bosh: 'https://digitsi.dev-moodle.digitalschool.tech/http-bind',

};

config.hosts = {
  domain: 'meet.jitsi',
  muc: 'muc.meet.jitsi',
  anonymousdomain: 'guest.meet.jitsi'
};



config.authentication = 'login';
config.disableAutoLogin = true;
config.prejoinConfig = { enabled: true };
config.enableLobby = true;
preferLargeVideo: true;

config.toolbarButtons = [
  'microphone','camera','desktop','chat','raisehand','tileview',
  'participants-pane','participants','hangup',
  'fullscreen','stats','settings','shortcuts'
];

config.disableInviteFunctions = true;
config.disableRecord = true;
config.disableSharedVideo = true;
config.disableAudioInputSharing = true;
config.securityUi = false;
disableTileEnlargement: true

config.resolution = 720;
config.videoQuality = { enableAdaptiveMode: true };
