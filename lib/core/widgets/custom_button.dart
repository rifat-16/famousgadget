import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum ButtonType { primaryActive, primaryDisabled, secondaryOutline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final Widget? icon;
  final double? width;
  final double height;
  final bool hasShadow;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primaryActive,
    this.icon,
    this.width,
    this.height = 52.0,
    this.hasShadow = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = type == ButtonType.primaryDisabled || onPressed == null;

    if (type == ButtonType.secondaryOutline) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: AppSpacing.s8)],
              Flexible(
                child: Text(
                  text,
                  style: textStyle ?? AppTextStyles.secondaryOutlineButton,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (isDisabled) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.buttonDisabled,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: AppSpacing.s8)],
              Flexible(
                child: Text(
                  text,
                  style: textStyle ?? AppTextStyles.primaryDisabledButton,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Active button with primary gradient from Figma tokens
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: hasShadow
              ? const [
                  BoxShadow(
                    color: Color(0x33FF6A00),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: AppColors.cardWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height / 2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: AppSpacing.s8)],
              Flexible(
                child: Text(
                  text,
                  style: textStyle ?? AppTextStyles.primaryActiveButton,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
