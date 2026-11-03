import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_badge.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final double? width;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: AppRadius.radiusAll20,
          border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A0B1220),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.s8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Container
            Stack(
              children: [
                Container(
                  height: 130.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.devices_other_rounded,
                          size: 32,
                          color: AppColors.primaryOrange.withValues(alpha: 0.4),
                        ),
                      );
                    },
                  ),
                ),
                if (product.savePercentage != null)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: CustomBadge.discount('SAVE ${product.savePercentage}%'),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.s6),

            // Product Title
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.navyDark,
                fontSize: 13.0,
              ),
            ),
            const SizedBox(height: AppSpacing.s4),

            // Rating Row
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 13.0,
                  color: AppColors.amber,
                ),
                const SizedBox(width: AppSpacing.s4),
                Text(
                  product.rating.toString(),
                  style: AppTextStyles.small.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.navyDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.s4),
                Text(
                  '(${product.reviewCount})',
                  style: AppTextStyles.small,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s4),

            // Price & Add to Cart button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4.0,
                    children: [
                      Text(
                        product.formattedPrice,
                        style: AppTextStyles.price(size: 14.0),
                      ),
                      if (product.formattedOldPrice != null)
                        Text(
                          product.formattedOldPrice!,
                          style: AppTextStyles.oldPrice(size: 10.0),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onAddToCart,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.s6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: AppRadius.radiusAll8,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 13.0,
                      color: AppColors.cardWhite,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
