// lib/app/router/app_router.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:them/app/router/app_routes.dart';
import 'package:them/features/auth/cubit/auth_cubit.dart';
import 'package:them/features/auth/pages/login_page.dart';
import 'package:them/features/auth/pages/regsiter_page.dart';
import 'package:them/features/map/pages/map_page.dart';
import 'package:them/features/splash/splash_screen.dart';

/// Router chính của ứng dụng
class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  /// Router configuration
  late final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegsiterPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const MapPage(),
      ),
       GoRoute(
        path: AppRoutes.map,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Trang chính')),
          body: mapPage,
        ),
      ),
    ],
    // Xử lý chuyển hướng trang
    redirect: (context, state) {
      final bool isAuthenticated = authCubit.state.isAuthenticated;
      final bool isLoginRoute = state.matchedLocation == AppRoutes.login;
      final bool isSplashRoute = state.matchedLocation == AppRoutes.splash;

      // Không chuyển hướng khi đang ở splash
      if (isSplashRoute) return null;

      // Nếu chưa đăng nhập và không ở trang login, chuyển đến login
      if (!isAuthenticated) return AppRoutes.login;

      // Nếu đã đăng nhập và đang ở trang login, chuyển đến map
      if (isAuthenticated && isLoginRoute) return AppRoutes.home;

      // Các trường hợp khác giữ nguyên
      return null;
    },
    // Lắng nghe thay đổi từ AuthCubit
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
  );

  get mapPage => null;
}

/// Helper class để lắng nghe sự thay đổi từ stream của BLoC/Cubit
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
