import 'package:flutter/material.dart';

/// App-wide 8-point grid spacing system
abstract final class AppSpacing {
  static const double s2 = 2.0;
  static const double s4 = 4.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
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
  static const double r4 = 4.0;
  static const double r8 = 8.0;   // Status tags, badges, text fields, mini action buttons
  static const double r12 = 12.0; // Table rows, swatch cards
  static const double r14 = 14.0; // Image containers
  static const double r16 = 16.0; // Color pills, review cards
  static const double r20 = 20.0; // Product cards, Category card
  static const double r22 = 22.0; // Quantity counters, active tab capsule
  static const double r24 = 24.0; // Banners, Featured sections
  static const double r26 = 26.0; // Buttons (Pill shaped for 52px height)
  static const double r34 = 34.0; // Floating navigation bar (Pill shaped for 68px height)
  static const double r40 = 40.0; // Screen top modal corners

  // Helpful BorderRadius presets
  static final BorderRadius radiusAll8 = BorderRadius.circular(r8);
  static final BorderRadius radiusAll12 = BorderRadius.circular(r12);
  static final BorderRadius radiusAll16 = BorderRadius.circular(r16);
  static final BorderRadius radiusAll20 = BorderRadius.circular(r20);
  static final BorderRadius radiusAll24 = BorderRadius.circular(r24);
  static final BorderRadius radiusAll26 = BorderRadius.circular(r26);
  static final BorderRadius radiusAll34 = BorderRadius.circular(r34);
}
