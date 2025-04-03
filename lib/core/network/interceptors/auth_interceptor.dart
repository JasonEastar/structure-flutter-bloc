// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:them/data/datasources/local/auth_local_datasource.dart';
import 'package:them/injection.dart';

/// Interceptor tự động thêm token vào header của request
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authLocalDataSource = getIt<AuthLocalDataSource>();
    
    try {
      if (await authLocalDataSource.hasToken()) {
        final token = await authLocalDataSource.getToken();
        options.headers['Authorization'] = 'Bearer ${token.accessToken}';
      }
    } catch (e) {
      // Bỏ qua lỗi nếu không lấy được token
    }
    
    handler.next(options);
  }
}