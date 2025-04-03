import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:them/app/router/app_routes.dart';
import 'package:them/config/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Đợi 2 giây rồi chuyển sang trang login
    // Sau này có thể thay bằng logic kiểm tra đăng nhập
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 120,
              height: 120,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image, size: 120),
            ),
            const SizedBox(height: 24),
            const Text(
              'Thèm gì cứ kiếm tôi!',
              style: AppTextStyles.headingLarge,
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
