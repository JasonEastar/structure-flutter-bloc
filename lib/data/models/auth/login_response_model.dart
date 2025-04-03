// lib/data/models/auth/login_response_model.dart
import 'package:them/data/models/auth/token_model.dart';
import 'package:them/data/models/auth/user_model.dart';

/// Model cho response từ API khi đăng nhập
class LoginResponseModel {
  final UserModel user;
  final TokenModel token;

  LoginResponseModel({
    required this.user,
    required this.token,
  });

  /// Tạo LoginResponseModel từ JSON
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      token: TokenModel.fromJson(json['token']),
    );
  }
}