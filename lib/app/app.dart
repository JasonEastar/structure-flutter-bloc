import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:them/app/cubit/locale_cubit.dart';
import 'package:them/app/localization/l10n.dart';
import 'package:them/app/router/app_router.dart';
import 'package:them/config/theme/app_theme.dart';
import 'package:them/injection.dart';

/// Widget gốc của ứng dụng
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Thèm',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            locale: state.language, // Lấy locale từ state
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: getIt<AppRouter>().router,
          );
        },
      ),
    );
  }
}