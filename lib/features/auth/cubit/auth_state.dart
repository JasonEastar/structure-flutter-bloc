// lib/features/auth/cubit/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:them/domain/entities/auth/user_entity.dart';

/// Các trạng thái có thể có của quá trình xác thực
enum AuthStatus {
  initial,       // Trạng thái khởi tạo
  loading,       // Đang xử lý
  authenticated, // Đã xác thực
  unauthenticated, // Chưa xác thực
  error,         // Có lỗi
}

/// State cho quản lý xác thực
class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  /// Constructor tạo state ban đầu
  const AuthState.initial()
      : status = AuthStatus.initial,
        user = null,
        errorMessage = null;

  /// Kiểm tra nhanh trạng thái đăng nhập
  bool get isAuthenticated => status == AuthStatus.authenticated;

  /// Tạo state mới với một số trường được thay đổi
  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}