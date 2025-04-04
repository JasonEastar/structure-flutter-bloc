// lib/data/datasources/remote/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:them/config/constants/api_constants.dart';
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
  final Logger _logger = Logger();
  @override
  Future<LoginResponseModel> login(String email, String password) async {
    // if (email == "jason@gmail.com" && password == "123qwe") {
    //   // Trả về dữ liệu giả khi đăng nhập thành công
    //   final fakeData = {
    //     'user': {
    //       'id': '1010',
    //       'name': 'Jason Nguyen',
    //       'email': email,
    //       'profile_picture': 'https://randomuser.me/api/portraits/men/1.jpg'
    //     },
    //     'token': {
    //       'access_token':
    //           'fake_access_token_${DateTime.now().millisecondsSinceEpoch}',
    //       'refresh_token':
    //           'fake_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
    //       'expires_at': DateTime.now()
    //           .add(const Duration(hours: 1))
    //           .millisecondsSinceEpoch
    //     }
    //   };

    //   return LoginResponseModel.fromJson(fakeData);
    // } else {
    //   throw ServerException(message: 'Email hoặc mật khẩu không đúng');
    // }

    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'loginname': email,
          'password': password,
        },
      );

      _logger.i('Đăng nhập thành công: ${response.data}');
      final errorCode = response.data['error_code'];

      if (errorCode == 0) {
        final responseData = <String, dynamic>{};

        responseData['user'] = {
          'id': '121212',
          'name': email,
          'email': email,
          'profile_picture': 'https://randomuser.me/api/portraits/men/1.jpg',
        };

        responseData['token'] = {
          'access_token': response.data['data']['token'],
          'refresh_token': response.data['data']['refeshtoken'],
          'expires_at': DateTime.now()
              .add(const Duration(hours: 1))
              .millisecondsSinceEpoch
        };
        return LoginResponseModel.fromJson(responseData);
      } else {
        throw ServerException(
          message: response.data['msg'] ?? 'Đăng nhập thất bại',
        );
      }
    } on DioException catch (e) {
      _logger.i('Lỗi đăng nhập: ${e.response?.data}');
      throw ServerException(
        message: e.response?.data?['msg'] ?? 'Lỗi kết nối đến server',
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

      if (response.data['error_code'] == 200) {
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