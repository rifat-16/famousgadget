import 'package:flutter/material.dart';

/// App-wide 8-point grid spacing system
abstract final class AppSpacing {
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s16 = 16.0; // Standard screen padding
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s32 = 32.0;
  static const double s40 = 40.0;
  static const double s48 = 48.0;
  static const double s64 = 64.0;

  // Helpful EdgeInsets presets
  static const EdgeInsets defaultScreenPadding = EdgeInsets.all(s16);
  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: s16);
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: s16);
}

/// App-wide border radius system based on design tokens
abstract final class AppRadius {
  static const double r4 = 4.0;   // Status tags, badges
  static const double r8 = 8.0;   // Small UI elements, text fields
  static const double r12 = 12.0; // Standard Buttons
  static const double r16 = 16.0; // Product Cards, Dialogs
  static const double r20 = 20.0; // Banners, Featured Cards
  static const double r32 = 32.0; // Custom Bottom Navigation Bar

  // Helpful BorderRadius presets
  static final BorderRadius radiusAll4 = BorderRadius.circular(r4);
  static final BorderRadius radiusAll12 = BorderRadius.circular(r12);
  static final BorderRadius radiusAll16 = BorderRadius.circular(r16);
  static final BorderRadius radiusAll20 = BorderRadius.circular(r20);
}