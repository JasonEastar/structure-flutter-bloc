// lib/data/datasources/remote/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:them/core/error/exceptions.dart';
import 'package:them/data/models/auth/login_response_model.dart';
import 'package:them/data/models/auth/token_model.dart';

/// Interface cho remote data source của authentication
abstract class AuthRemoteDataSource {
  /// Gọi API đăng nhập
  Future<LoginResponseModel> login(String email, String password);
  
  /// Gọi API làm mới token
  Future<TokenModel> refreshToken(String refreshToken);
}

/// Triển khai của AuthRemoteDataSource sử dụng Dio
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Đăng nhập thất bại',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Lỗi kết nối đến server',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TokenModel> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        return TokenModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Làm mới token thất bại',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Lỗi kết nối đến server',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}