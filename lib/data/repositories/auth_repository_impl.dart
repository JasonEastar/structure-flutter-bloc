// lib/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/exceptions.dart';
import 'package:them/core/error/failures.dart';
import 'package:them/data/datasources/local/auth_local_datasource.dart';
import 'package:them/data/datasources/remote/auth_remote_datasource.dart';
import 'package:them/domain/entities/auth/token_entity.dart';
import 'package:them/domain/entities/auth/user_entity.dart';
import 'package:them/domain/repositories/auth_repository.dart';

/// Triển khai của AuthRepository sử dụng AuthRemoteDataSource và AuthLocalDataSource
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      // 1. Gọi API đăng nhập
      final loginResponse = await remoteDataSource.login(email, password);
      
      // 2. Lưu thông tin token vào local storage
      await localDataSource.saveToken(loginResponse.token);
      
      // 3. Lưu thông tin người dùng vào local storage
      await localDataSource.saveUser(loginResponse.user);
      
      // 4. Trả về thông tin người dùng
      return Right(loginResponse.user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // 1. Xóa thông tin token
      await localDataSource.removeToken();
      
      // 2. Xóa thông tin người dùng
      await localDataSource.removeUser();
      
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      // Lấy thông tin người dùng từ local storage
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      // Kiểm tra xem có token không
      return Right(await localDataSource.hasToken());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken) async {
    try {
      // 1. Gọi API refresh token
      final newToken = await remoteDataSource.refreshToken(refreshToken);
      
      // 2. Lưu token mới
      await localDataSource.saveToken(newToken);
      
      return Right(newToken);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}