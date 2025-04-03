// lib/data/models/auth/token_model.dart
import 'package:them/domain/entities/auth/token_entity.dart';

/// Model cho dữ liệu token từ API
class TokenModel extends TokenEntity {
  const TokenModel({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );

  /// Tạo TokenModel từ JSON
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresAt: DateTime.fromMillisecondsSinceEpoch(json['expires_at']),
    );
  }

  /// Chuyển TokenModel thành JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.millisecondsSinceEpoch,
    };
  }
}