// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:them/app/app.dart';
import 'package:them/app/app_bloc_observer.dart';
import 'package:them/features/auth/cubit/auth_cubit.dart';
import 'package:them/injection.dart';

void main() {
  // Đảm bảo Flutter binding đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  
  // Thiết lập dependency injection
  setupDependencies();
  
  // Đặt BlocObserver để log các sự kiện BLoC/Cubit
  Bloc.observer = AppBlocObserver();
  
  // Kiểm tra trạng thái đăng nhập khi khởi động
  getIt<AuthCubit>().checkAuthStatus();
  
  // Chạy ứng dụng
  runApp(
    // Cung cấp AuthCubit cho toàn bộ ứng dụng
    BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: const App(),
    ),
  );
}