import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:them/features/auth/cubit/auth_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Xin chào, ${authCubit.state.user?.name ?? 'Người dùng'}!'),
            Image.network(
              authCubit.state.user?.profilePicture ?? '',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 100);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => authCubit.logout(),
              child: const Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
