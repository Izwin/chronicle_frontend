import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: const TextTheme(
            bodySmall: AppTextStyles.bodySmall,
            bodyMedium: AppTextStyles.bodyMedium,
            bodyLarge: AppTextStyles.bodyLarge,
            headlineSmall: AppTextStyles.headlineSmall,
            headlineMedium: AppTextStyles.headlineMedium,
            headlineLarge: AppTextStyles.headlineLarge),
        colorScheme: const ColorScheme(
            primary: AppColors.primary,
            onPrimary: AppColors.background,
            secondary: AppColors.secondary,
            onSecondary: AppColors.background,
            error: AppColors.errorColor,
            onError: AppColors.surface,
            surface: AppColors.background,
            onSurface: AppColors.textColor,
            brightness: Brightness.light),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
                elevation: 0,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
                textStyle: AppTextStyles.button)));
  }
}
