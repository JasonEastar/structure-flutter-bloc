// lib/features/auth/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:them/app/localization/l10n.dart';
import 'package:them/app/router/app_routes.dart';
import 'package:them/features/auth/cubit/auth_cubit.dart';
import 'package:them/features/auth/cubit/auth_state.dart';
import 'package:them/presentation/widgets/language_switcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers để lấy giá trị nhập
  final _emailController = TextEditingController(text: 'jasonadmin');
  final _passwordController = TextEditingController(text: '123qwe');

  // Key cho form validation
  final _formKey = GlobalKey<FormState>();

  // Trạng thái hiển thị mật khẩu
  bool _obscurePassword = true;

  final logger = Logger();

  @override
  void dispose() {
    // Giải phóng tài nguyên khi widget bị hủy
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

// / Kiểm tra trạng thái xác thực và chuyển hướng
  void checkAuthStatusRedirect(context, state) {
    // Xử lý khi trạng thái thay đổi
    if (state.status == AuthStatus.authenticated) {
      // Chuyển đến màn hình chính nếu đăng nhập thành công
      GoRouter.of(context).go(AppRoutes.home);
    } else if (state.status == AuthStatus.error && state.errorMessage != null) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        actions: const [
          LanguageSwitcher(), // Thêm nút chuyển đổi ngôn ngữ vào AppBar
        ],
      ),
      // Bắt sự kiện từ AuthCubit
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          checkAuthStatusRedirect(context, state);
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    // Logo ứng dụng
                    const Icon(
                      Icons.restaurant,
                      size: 100,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 32),
                    // Tên ứng dụng
                    Text(
                      l10n.appTitle,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    // Form đăng nhập
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.emailHint,
                        hintText: 'Nhập email của bạn',
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập email';
                        }
                        if (value.length < 6) {
                          return 'Email phải có ít nhất 6 ký tự';
                        }
                        // if (!value.contains('@')) {
                        //   return 'Email không hợp lệ';
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.passwordHint,
                        hintText: 'Nhập mật khẩu của bạn',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Nút đăng nhập
                    ElevatedButton(
                      onPressed: state.status == AuthStatus.loading
                          ? null // Vô hiệu hóa nút khi đang loading
                          : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state.status == AuthStatus.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Đăng nhập'),
                    ),
                    const SizedBox(height: 16),
                    // Link đăng ký
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Chưa có tài khoản?'),
                        TextButton(
                          onPressed: () {
                            // Chuyển đến trang đăng ký (sẽ thêm sau)
                            context.go(AppRoutes.map);
                          },
                          child: const Text('Đăng ký'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Xử lý khi người dùng nhấn nút đăng nhập
  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // Gọi cubit để đăng nhập khi form hợp lệ
      context.read<AuthCubit>().login(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }
}
