import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum BadgeType { discount, inStock, outOfStock, cod, custom }

class CustomBadge extends StatelessWidget {
  final String text;
  final BadgeType type;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;

  const CustomBadge({
    super.key,
    required this.text,
    this.type = BadgeType.custom,
    this.backgroundColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  });

  factory CustomBadge.discount(String text) => CustomBadge(
    text: text,
    type: BadgeType.discount,
    backgroundColor: AppColors.softPeach,
    textColor: AppColors.primaryOrange,
  );

  factory CustomBadge.inStock({String text = 'IN STOCK'}) => CustomBadge(
    text: text,
    type: BadgeType.inStock,
    backgroundColor: AppColors.successGreenLight,
    textColor: AppColors.successGreen,
  );

  factory CustomBadge.outOfStock({String text = 'OUT OF STOCK'}) => CustomBadge(
    text: text,
    type: BadgeType.outOfStock,
    backgroundColor: AppColors.dangerRedLight,
    textColor: AppColors.dangerRed,
  );

  factory CustomBadge.cod({String text = 'COD AVAILABLE'}) => CustomBadge(
    text: text,
    type: BadgeType.cod,
    backgroundColor: AppColors.purpleLight,
    textColor: AppColors.purple,
  );

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case BadgeType.discount:
        bg = AppColors.softPeach;
        fg = AppColors.primaryOrange;
        break;
      case BadgeType.inStock:
        bg = AppColors.successGreenLight;
        fg = AppColors.successGreen;
        break;
      case BadgeType.outOfStock:
        bg = AppColors.dangerRedLight;
        fg = AppColors.dangerRed;
        break;
      case BadgeType.cod:
        bg = AppColors.purpleLight;
        fg = AppColors.purple;
        break;
      case BadgeType.custom:
        bg = backgroundColor ?? AppColors.softPeach;
        fg = textColor ?? AppColors.primaryOrange;
        break;
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.radiusAll8,
      ),
      child: Text(
        text,
        style: AppTextStyles.badgeText.copyWith(color: fg),
      ),
    );
  }
}
