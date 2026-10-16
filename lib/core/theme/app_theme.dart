import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.pageBackground,
      primaryColor: AppColors.primaryOrange,

      // Color Scheme setup
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryOrange,
        secondary: AppColors.darkOrange,
        surface: AppColors.cardWhite,
        error: AppColors.dangerRed,
        onPrimary: AppColors.cardWhite,
        onSurface: AppColors.navyDark,
      ),

      // AppBar global configuration
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.navyDark),
        titleTextStyle: AppTextStyles.h2ProductTitle,
      ),

      // Text Theme configuration
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1Display,
        titleLarge: AppTextStyles.h2ProductTitle,
        bodyLarge: AppTextStyles.uiSemiBold,
        bodyMedium: AppTextStyles.bodyRegular,
      ),
    );
  }
}