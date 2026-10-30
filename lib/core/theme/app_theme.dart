import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFF0F1419);
  static const surface = Color(0xFF171C21);
  static const surfaceHigh = Color(0xFF252A30);
  static const preview = Color(0xFF0A0F14);
  static const accent = Color(0xFF00B4F7);
  static const accentLight = Color(0xFF82CFFF);
  static const textPrimary = Color(0xFFDEE3EA);
  static const textSecondary = Color(0xFFC2C6D2);
  static const textMuted = Color(0xFF8C919C);
  static const green = Color(0xFF6FFBBE);
}

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.accentLight,
          surface: AppColors.surface,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
        ),
        dividerColor: AppColors.surfaceHigh,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          hintStyle: const TextStyle(color: AppColors.textMuted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.accent, width: 1),
          ),
        ),
      );
}
