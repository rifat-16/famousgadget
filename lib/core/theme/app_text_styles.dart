import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  /// Outfit H1 Display - Outfit Bold / 32px / tracking 0%
  static TextStyle get h1Display => GoogleFonts.outfit(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.0,
    color: AppColors.navyDark,
  );

  static TextStyle get h2ProductTitle => GoogleFonts.outfit(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.navyDark,
  );

  /// Geist UI Semibold - Geist / 16px / SemiBold
  static TextStyle get uiSemiBold => GoogleFonts.getFont(
    'Geist',
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.navyDark,
  );

  /// Geist Body regular - Geist / 14px / Regular / line-height 1.5
  static TextStyle get bodyRegular => GoogleFonts.getFont(
    'Geist',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.navyDark,
  );

  // ---------------------
  // Extra Helpful Styles
  // ---------------------

  /// Badge
  static TextStyle get badgeText => GoogleFonts.outfit(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
  );

  /// Status tags bg
  static TextStyle get statusTagText => GoogleFonts.getFont(
    'Geist',
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  /// Primary Active Button
  static TextStyle get  primaryActiveButton => GoogleFonts.outfit(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColors.cardWhite,
  );
  /// Primary Disabled Button
  static TextStyle get  primaryDisabledButton => GoogleFonts.outfit(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDisabled,
  );

  /// Old Price Strikethrough text
  static TextStyle get oldPriceText => GoogleFonts.getFont(
    'Geist',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
    decoration: TextDecoration.lineThrough,
  );
}