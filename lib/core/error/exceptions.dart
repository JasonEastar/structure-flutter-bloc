// lib/core/error/exceptions.dart
/// Exception khi gọi API
class ServerException implements Exception {
  final String message;
  
  ServerException({required this.message});
}

/// Exception khi thao tác với bộ nhớ cục bộ
class CacheException implements Exception {
  final String message;
  
  CacheException({required this.message});
}

/// Exception liên quan đến xác thực
class AuthException implements Exception {
  final String message;
  
  AuthException({required this.message});
}