class ApiConstants {
  static const String apiUrl = 'http://localhost:3000'; // Thay thế bằng URL thật
  static const String versionAPI = '/api/v1'; // Thay thế bằng URL thật

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
