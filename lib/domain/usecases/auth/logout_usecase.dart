// lib/domain/usecases/auth/logout_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/failures.dart';
import 'package:them/domain/repositories/auth_repository.dart';

/// Usecase cho chức năng đăng xuất
@injectable
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  /// Thực hiện đăng xuất
  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}