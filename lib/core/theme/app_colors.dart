import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand & Accent Colors
  static const Color primaryOrange = Color(0xFFFF6A00); // CTA / Highlights
  static const Color darkOrange = Color(0xFFE05A00);    // Button Hover / Active states
  static const Color navyDark = Color(0xFF0B1220);      // Headers / Body base / Splash bg

  // Linear Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryOrange, darkOrange],
  );

  static const LinearGradient bannerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [navyDark, primaryOrange],
  );

  static const LinearGradient promoOrangeGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryOrange, Color(0xFFFFA100)],
  );

  static const LinearGradient promoDarkGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [navyDark, Color(0xFF1D2C40)],
  );

  // Surface & Backgrounds
  static const Color pageBackground = Color(0xFFF4F5FA); // App-wide scaffold background (soft off-white)
  static const Color cardWhite = Color(0xFFFFFFFF);     // Product & item cards
  static const Color softPeach = Color(0xFFFFF1E8);     // Save / Discount badges & category circle

  // Status & Feedback Colors
  static const Color successGreen = Color(0xFF16A34A);  // In-stock states & confirmation
  static const Color successGreenLight = Color(0x1416A34A); // rgba(22, 163, 74, 0.08)
  static const Color dangerRed = Color(0xFFE11D48);     // Out of stock / alerts
  static const Color dangerRedLight = Color(0xFFFFECEF); // Soft red/pink for OUT OF STOCK badge
  static const Color amber = Color(0xFFF59E0B);         // Ratings & stars
  static const Color amberLight = Color(0x14F59E0B);     // rgba(245, 158, 11, 0.08)

  // Badge Specific Colors
  static const Color purple = Color(0xFF7C3AED);        // COD tag text
  static const Color purpleLight = Color(0x147C3AED);   // rgba(124, 58, 237, 0.08)

  // Neutrals & Borders
  static const Color textMuted = Color(0xFF6B7280);     // Subtitles, metadata, reviews count (#6B7280)
  static const Color textDisabled = Color(0xFF999EA6);  // Disabled button label
  static const Color buttonDisabled = Color(0xFFD1D5DB);// Primary disabled button bg (#D1D5DB)
  static const Color borderLight = Color(0xFFE5E7EB);   // Dividers & card borders (#E5E7EB)

  // Shadows
  static const Color shadow = Color(0x0A0B1220);        // rgba(11, 18, 32, 0.04)
}
