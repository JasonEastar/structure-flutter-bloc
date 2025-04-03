// lib/domain/entities/auth/token_entity.dart
import 'package:equatable/equatable.dart';

/// Entity đại diện cho token xác thực
class TokenEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  /// Kiểm tra xem token đã hết hạn chưa
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  List<Object> get props => [accessToken, refreshToken, expiresAt];
}