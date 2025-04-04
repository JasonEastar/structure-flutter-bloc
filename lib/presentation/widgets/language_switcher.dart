import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:them/app/cubit/locale_cubit.dart';
import 'package:them/app/localization/l10n.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lấy ngôn ngữ hiện tại từ LocaleCubit
    final currentLocale = context
        .select((LocaleCubit cubit) => cubit.state.language.languageCode);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: AppLocalizations.of(context).changeLanguage,
      onSelected: (String languageCode) {
        // Khi chọn ngôn ngữ, gọi phương thức changeLocale của LocaleCubit
        context.read<LocaleCubit>().changeLocale(languageCode);
      },
      itemBuilder: (context) => [
        // Menu tiếng Anh
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              // Hiển thị dấu tích nếu đang chọn tiếng Anh
              if (currentLocale == 'en')
                const Icon(Icons.check, color: Colors.green),
              const SizedBox(width: 8),
              const Text('English'),
            ],
          ),
        ),
        // Menu tiếng Việt
        PopupMenuItem(
          value: 'vi',
          child: Row(
            children: [
              // Hiển thị dấu tích nếu đang chọn tiếng Việt
              if (currentLocale == 'vi')
                const Icon(Icons.check, color: Colors.green),
              const SizedBox(width: 8),
              const Text('Tiếng Việt'),
            ],
          ),
        ),
      ],
    );
  }
}
