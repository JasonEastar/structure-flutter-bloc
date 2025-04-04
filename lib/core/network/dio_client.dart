// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:them/config/constants/api_constants.dart';
import 'package:them/core/network/interceptors/auth_interceptor.dart';
import 'package:them/core/network/interceptors/logging_interceptor.dart';

/// Client HTTP dùng Dio cho các request API
@singleton
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiUrl + ApiConstants.versionAPI, // URL API
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );
    _setupInterceptors();
  }

  /// Thiết lập các interceptor cho Dio
  void _setupInterceptors() {
    _dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
    ]);
  }

  /// Getter để truy cập instance Dio
  Dio get dio => _dio;
}
