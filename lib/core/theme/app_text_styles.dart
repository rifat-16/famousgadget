import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  /// Outfit H1 Display - Outfit ExtraBold / 32px / tracking 0%
  static TextStyle get h1Display => GoogleFonts.outfit(
    fontSize: 32.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.0,
    color: AppColors.navyDark,
  );

  /// Outfit H2 Product Title - Outfit Bold / 22px
  static TextStyle get h2ProductTitle => GoogleFonts.outfit(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: AppColors.navyDark,
  );

  /// Outfit H3 Section Header - Outfit Bold / 18px
  static TextStyle get h3Section => GoogleFonts.outfit(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.navyDark,
  );

  /// Outfit Card/Item Title - Outfit SemiBold / 14px
  static TextStyle get outfitTitleSmall => GoogleFonts.outfit(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.navyDark,
  );

  /// Geist UI Semibold - Geist / 16px / SemiBold
  static TextStyle get uiSemiBold => const TextStyle(
    fontFamily: 'Geist',
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.navyDark,
  );

  /// Geist Body regular - Geist / 14px / Regular / line-height 1.5
  static TextStyle get bodyRegular => const TextStyle(
    fontFamily: 'Geist',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.navyDark,
  );

  /// Geist Medium - Geist / 13px / Medium
  static TextStyle get bodyMedium => const TextStyle(
    fontFamily: 'Geist',
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    color: AppColors.navyDark,
  );

  /// Geist Caption - Geist / 12px / Regular
  static TextStyle get caption => const TextStyle(
    fontFamily: 'Geist',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  /// Geist Small - Geist / 10-11px
  static TextStyle get small => const TextStyle(
    fontFamily: 'Geist',
    fontSize: 11.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // ---------------------
  // Interactive & Badges
  // ---------------------

  /// Badge Text - Outfit Bold / 11-12px
  static TextStyle get badgeText => GoogleFonts.outfit(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );

  /// Status tags text - Geist SemiBold / 12px
  static TextStyle get statusTagText => const TextStyle(
    fontFamily: 'Geist',
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  /// Primary Active Button - Outfit Bold / 16px
  static TextStyle get primaryActiveButton => GoogleFonts.outfit(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColors.cardWhite,
  );

  /// Primary Disabled Button - Outfit Bold / 16px
  static TextStyle get primaryDisabledButton => GoogleFonts.outfit(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDisabled,
  );

  /// Secondary Outline Button - Outfit Bold / 14px
  static TextStyle get secondaryOutlineButton => GoogleFonts.outfit(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryOrange,
  );

  /// Price Text Bold - Outfit Bold
  static TextStyle price({double size = 15.0, Color color = AppColors.primaryOrange}) =>
      GoogleFonts.outfit(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      );

  /// Old Price Strikethrough text - Outfit Regular
  static TextStyle oldPrice({double size = 11.0}) => GoogleFonts.outfit(
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    decoration: TextDecoration.lineThrough,
  );
}
