// lib/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:them/core/error/failures.dart';
import 'package:them/domain/entities/auth/token_entity.dart';
import 'package:them/domain/entities/auth/user_entity.dart';

/// Repository interface cho các chức năng xác thực
abstract class AuthRepository {
  /// Đăng nhập với email và mật khẩu
  Future<Either<Failure, UserEntity>> login(String email, String password);
  
  /// Đăng xuất người dùng hiện tại
  Future<Either<Failure, void>> logout();
  
  /// Lấy thông tin người dùng hiện tại
  Future<Either<Failure, UserEntity>> getCurrentUser();
  
  /// Kiểm tra xem người dùng đã đăng nhập chưa
  Future<Either<Failure, bool>> isLoggedIn();
  
  /// Làm mới token khi token cũ hết hạn
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken);
}