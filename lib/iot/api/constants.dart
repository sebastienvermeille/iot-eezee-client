class ApiConstants {
  static String baseUrl = 'http://7.7.7.77:1880/api';
  static String temperatureSensorEndpoint = '/sensors/temperature';
  static String musicVolumeEndpoint = '/media/audio/volume';
  static String musicTrackEndpoint = '/media/audio/track';
  static String musicPlayerStatusEndpoint = '/media/audio/status';
  static String musicPlayerPlaylistsEndpoint = '/media/audio/playlists';
  static String meteoTodayEndpoint = '/meteo/today';
  static String meteoForecastEndpoint = '/meteo/forecast';
  static String doorSensorEndpoint = '/sensors/door';
  static String doorUnlockEndpoint = '/doors/unlock';

  static String binaryEndpoint = '/assets?url=';

  // SSE
  // static String sseSubscribeSensorsTemperature = '/subscribe/sensors/temperature';

  // Websockets
  static String wsBaseUrl = 'ws://7.7.7.77:1880/api/ws';
}