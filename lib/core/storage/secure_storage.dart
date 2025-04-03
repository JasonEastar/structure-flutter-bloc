// lib/core/storage/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Service lưu trữ bảo mật cho thông tin nhạy cảm như token
@singleton
class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Lưu giá trị vào secure storage
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Đọc giá trị từ secure storage
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Xóa một giá trị cụ thể
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Xóa tất cả giá trị
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}