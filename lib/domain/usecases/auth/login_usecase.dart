// lib/domain/usecases/auth/login_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/failures.dart';
import 'package:them/domain/entities/auth/user_entity.dart';
import 'package:them/domain/repositories/auth_repository.dart';

/// Usecase cho chức năng đăng nhập
@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  /// Thực hiện đăng nhập với email và mật khẩu
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

/// Params cho usecase đăng nhập
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });


  @override
  List<Object> get props => [email, password];
}