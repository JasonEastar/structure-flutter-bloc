// lib/data/datasources/local/auth_local_datasource.dart
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/exceptions.dart';
import 'package:them/core/storage/secure_storage.dart';
import 'package:them/data/models/auth/token_model.dart';
import 'package:them/data/models/auth/user_model.dart';

/// Interface cho local data source của authentication
abstract class AuthLocalDataSource {
  /// Lưu thông tin token
  Future<void> saveToken(TokenModel token);
  
  /// Lấy thông tin token
  Future<TokenModel> getToken();
  
  /// Kiểm tra xem có token đã lưu không
  Future<bool> hasToken();
  
  /// Xóa token đã lưu
  Future<void> removeToken();
  
  /// Lưu thông tin người dùng
  Future<void> saveUser(UserModel user);
  
  /// Lấy thông tin người dùng
  Future<UserModel> getUser();
  
  /// Xóa thông tin người dùng
  Future<void> removeUser();
}

/// Triển khai của AuthLocalDataSource sử dụng SecureStorage
@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  // Keys cho secure storage
  static const String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';

  @override
  Future<TokenModel> getToken() async {
    final tokenString = await secureStorage.read(tokenKey);
    if (tokenString != null) {
      try {
        return TokenModel.fromJson(json.decode(tokenString));
      } catch (e) {
        throw CacheException(message: 'Không thể đọc token');
      }
    } else {
      throw CacheException(message: 'Token không tồn tại');
    }
  }

  @override
  Future<bool> hasToken() async {
    final tokenString = await secureStorage.read(tokenKey);
    return tokenString != null;
  }

  @override
  Future<void> removeToken() async {
    await secureStorage.delete(tokenKey);
  }

  @override
  Future<void> saveToken(TokenModel token) async {
    await secureStorage.write(tokenKey, json.encode(token.toJson()));
  }

  @override
  Future<UserModel> getUser() async {
    final userString = await secureStorage.read(userKey);
    if (userString != null) {
      try {
        return UserModel.fromJson(json.decode(userString));
      } catch (e) {
        throw CacheException(message: 'Không thể đọc thông tin người dùng');
      }
    } else {
      throw CacheException(message: 'Thông tin người dùng không tồn tại');
    }
  }

  @override
  Future<void> removeUser() async {
    await secureStorage.delete(userKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await secureStorage.write(userKey, json.encode(user.toJson()));
  }
}