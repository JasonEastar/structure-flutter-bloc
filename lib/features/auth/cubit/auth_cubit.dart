// lib/features/auth/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:them/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:them/domain/usecases/auth/is_logged_in_usecase.dart';
import 'package:them/domain/usecases/auth/login_usecase.dart';
import 'package:them/domain/usecases/auth/logout_usecase.dart';
import 'package:them/features/auth/cubit/auth_state.dart';

/// Cubit quản lý trạng thái xác thực
@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required IsLoggedInUseCase isLoggedInUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _isLoggedInUseCase = isLoggedInUseCase,
       super(const AuthState.initial());

  /// Kiểm tra trạng thái đăng nhập
  Future<void> checkAuthStatus() async {
    emit(state.copyWith(status: AuthStatus.loading));
    
    // Kiểm tra xem người dùng đã đăng nhập chưa
    final result = await _isLoggedInUseCase();
    
    result.fold(
      // Xử lý khi có lỗi
      (failure) => emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: failure.message,
      )),
      // Xử lý khi kiểm tra thành công
      (isLoggedIn) async {
        if (isLoggedIn) {
          // Nếu đã đăng nhập, lấy thông tin người dùng
          final userResult = await _getCurrentUserUseCase();
          userResult.fold(
            (failure) => emit(state.copyWith(
              status: AuthStatus.unauthenticated,
              errorMessage: failure.message,
            )),
            (user) => emit(state.copyWith(
              status: AuthStatus.authenticated,
              user: user,
            )),
          );
        } else {
          // Nếu chưa đăng nhập
          emit(state.copyWith(status: AuthStatus.unauthenticated));
        }
      },
    );
  }

  /// Đăng nhập với email và mật khẩu
  Future<void> login({required String email, required String password}) async {
    // Kiểm tra dữ liệu đầu vào
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Email và mật khẩu không được để trống',
      ));
      return;
    }

    // Bắt đầu quá trình đăng nhập
    emit(state.copyWith(status: AuthStatus.loading));
    
    // Gọi usecase đăng nhập
    final params = LoginParams(email: email, password: password);
    
    final result = await _loginUseCase(params);

    // Xử lý kết quả
    result.fold(
      // Xử lý khi đăng nhập thất bại
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      // Xử lý khi đăng nhập thành công
      (user) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      )),
    );
  }

  /// Đăng xuất người dùng hiện tại
  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    
    // Gọi usecase đăng xuất
    final result = await _logoutUseCase();
    
    // Xử lý kết quả
    result.fold(
      // Xử lý khi đăng xuất thất bại
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      )),
      // Xử lý khi đăng xuất thành công
      (_) => emit(state.copyWith(status: AuthStatus.unauthenticated)),
    );
  }
}