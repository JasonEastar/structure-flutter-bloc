// lib/core/error/failures.dart
import 'package:equatable/equatable.dart';

/// Class cơ sở cho tất cả các lỗi trong ứng dụng
abstract class Failure extends Equatable {
  final String message;
  
  const Failure({required this.message});
  
  @override
  List<Object> get props => [message];
}

/// Lỗi từ server API
class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
}

/// Lỗi khi truy cập bộ nhớ local
class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

/// Lỗi liên quan đến xác thực
class AuthFailure extends Failure {
  const AuthFailure({required String message}) : super(message: message);
}

/// Lỗi chung
class GeneralFailure extends Failure {
  const GeneralFailure({required String message}) : super(message: message);
}