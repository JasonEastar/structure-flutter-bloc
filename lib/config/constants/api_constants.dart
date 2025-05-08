import 'package:them/config/env/env_constants.dart';

class ApiConstants {
  static String apiUrl = EnvConstants.apiBaseUrl; // URL call API
  static const String versionAPI = '/api/v1'; // Version API (endpoint)

// Auth0
  static String auth0Domain = EnvConstants.auth0Domain; // AUTH0 DOMAIN
  static String auth0ClientId = EnvConstants.auth0ClientId; // AUTH0 CLIENT ID

  // Auth endpoints
  static const String login = '/user/public/admin/login'; //user/public/login
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';

  // Post endpoints
  static const String posts = '/posts';
  static const String nearbyPosts = '/posts/nearby';

  // Livestream endpoints
  static const String createRoom = '/livestream/create';
  static const String joinRoom = '/livestream/join';
  static const String endStream = '/livestream/end';
}
