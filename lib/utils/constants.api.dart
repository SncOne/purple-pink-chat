part of 'constants.dart';

class _Api {
  const _Api();

  /// Firebase Project ID
  /// https://console.firebase.google.com
  static const _projectID = 'temple-32460';

  static const _githubUrl = 'https://raw.githubusercontent.com';

  String get telegramUrl => '';

  String get notifUrl =>
      'https://fcm.googleapis.com/v1/projects/$_projectID/messages:send';

  String get langsJsonPath =>
      '$_githubUrl/annexare/Countries/57f7c26ad89932cc10cb4ff1412acb93e637576f/dist/languages.all.min.json';

  String get flagImagePath =>
      '$_githubUrl/HatScripts/circle-flags/gh-pages/flags/{}.svg';

  String get baseUrl => '';
  String get localhost => 'http://localhost:3000/';
}
