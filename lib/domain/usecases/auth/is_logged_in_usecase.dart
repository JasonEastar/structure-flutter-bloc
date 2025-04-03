// lib/domain/usecases/auth/is_logged_in_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/failures.dart';
import 'package:them/domain/repositories/auth_repository.dart';

/// Usecase kiểm tra trạng thái đăng nhập
@injectable
class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  /// Thực hiện kiểm tra người dùng đã đăng nhập chưa
  Future<Either<Failure, bool>> call() async {
    return await repository.isLoggedIn();
  }
}