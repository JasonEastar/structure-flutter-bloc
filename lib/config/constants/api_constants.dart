class ApiConstants {
  static const String baseUrl = 'https://api.example.com'; // Thay thế bằng URL thật

  // Auth endpoints
  static const String login = '/auth/login';
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
