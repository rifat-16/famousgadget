import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand & Accent Colors
  static const Color primaryOrange = Color(0xFFFF6A00); // CTA / Highlights
  static const Color darkOrange = Color(0xFFE05A00);    // Button Hover / Active states
  static const Color navyDark = Color(0xFF0B1220);      // Headers / Body base / Splash bg

  // Surface & Backgrounds
  static const Color pageBackground = Color(0xFFF3F5FA); // App-wide scaffold background
  static const Color cardWhite = Color(0xFFFFFFFF);     // Product & item cards
  static const Color softPeach = Color(0xFFFFF1E8);     // Save / Discount badges

  // Status & Feedback Colors
  static const Color successGreen = Color(0xFF16A34A);  // In-stock states & confirmation
  static const Color successGreenLight = Color(0xFFDCFCE7); // In-stock badge bg
  static const Color dangerRed = Color(0xFFE11D48);     // Out of stock / alerts
  static const Color dangerRedLight = Color(0xFFFFE4E6); // Out of stock badge bg
  static const Color amber = Color(0xFFF59E0B);         // Ratings & stars

  // Badge Specific Colors
  static const Color purple = Color(0xFF9333EA);        // COD tag text
  static const Color purpleLight = Color(0xFFF3E8FF);   // COD tag bg

  // Neutrals & Borders
  static const Color textMuted = Color(0xFF64748B);     // Subtitles, metadata, reviews count
  static const Color textDisabled = Color(0xFF94A3B8);  // Disabled button label
  static const Color buttonDisabled = Color(0xFFCBD5E1);// Primary disabled button bg
  static const Color borderLight = Color(0xFFE2E8F0);   // Dividers & card borders
}