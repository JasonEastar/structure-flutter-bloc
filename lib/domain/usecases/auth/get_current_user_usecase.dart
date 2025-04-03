// lib/domain/usecases/auth/get_current_user_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/failures.dart';
import 'package:them/domain/entities/auth/user_entity.dart';
import 'package:them/domain/repositories/auth_repository.dart';

/// Usecase để lấy thông tin người dùng hiện tại
@injectable
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  /// Thực hiện lấy thông tin người dùng
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getCurrentUser();
  }
}