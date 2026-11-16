import 'package:flutter/material.dart';
import '../animations/bounceable.dart';
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
      final outlineContent = Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: isDisabled ? AppColors.buttonDisabled : AppColors.primaryOrange,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: AppSpacing.s8)],
            Flexible(
              child: Text(
                text,
                style: textStyle ??
                    AppTextStyles.secondaryOutlineButton.copyWith(
                      color: isDisabled ? AppColors.textDisabled : AppColors.primaryOrange,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

      if (isDisabled) {
        return outlineContent;
      }
      return Bounceable(
        onTap: onPressed,
        child: outlineContent,
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

    // Active button with primary gradient from Figma tokens & micro-bounce
    final activeContent = Container(
      width: width ?? double.infinity,
      height: height,
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      alignment: Alignment.center,
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
    );

    return Bounceable(
      onTap: onPressed,
      child: activeContent,
    );
  }
}
