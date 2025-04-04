// lib/app/cubit/locale_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleState {
  final Locale language;
  
  LocaleState(this.language);
}

class LocaleCubit extends Cubit<LocaleState> {
  static const String _localeKey = 'app_locale';
  static const String _defaultLanguage = 'vi'; // Ngôn ngữ mặc định
  
  LocaleCubit() : super(LocaleState(const Locale(_defaultLanguage))) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_localeKey);
    
    if (languageCode != null) {
      emit(LocaleState(Locale(languageCode)));
    }
  }

  Future<void> changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
    
    emit(LocaleState(Locale(languageCode)));
  }
}