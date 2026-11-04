import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/custom_badge.dart';
import '../../core/widgets/custom_button.dart';
import '../../data/mock_database.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments as ProductModel;
    final ProductDetailController controller = Get.put(ProductDetailController());
    final CartController cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    final AuthController authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    controller.init(product);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navyDark),
          onPressed: () => Get.back(),
        ),
        title: Text('Product Details', style: AppTextStyles.outfitTitleSmall.copyWith(fontSize: 16)),
        actions: [
          Obx(
            () {
              final isFav = authController.isInWishlist(product.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFav ? AppColors.dangerRed : AppColors.navyDark,
                ),
                onPressed: () => authController.toggleWishlist(product),
              );
            },
          ),
          const SizedBox(width: AppSpacing.s8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Image Carousel (Interactive Swipeable)
                Container(
                  height: 280.0,
                  width: double.infinity,
                  color: AppColors.cardWhite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        itemCount: product.galleryImages.length,
                        onPageChanged: controller.setImageIndex,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(AppSpacing.s16),
                            child: Image.network(
                              product.galleryImages[index],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.devices, size: 80, color: AppColors.textMuted),
                            ),
                          );
                        },
                      ),
                      if (product.galleryImages.length > 1)
                        Positioned(
                          top: AppSpacing.s12,
                          child: Obx(
                            () => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                product.galleryImages.length,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    color: controller.currentImageIndex.value == index
                                        ? AppColors.primaryOrange
                                        : const Color(0xFFE2E8F0),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // 2. Product Detail Sheet
                Container(
                  color: AppColors.cardWhite,
                  padding: const EdgeInsets.all(AppSpacing.s20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Row
                      Row(
                        children: [
                          if (product.savePercentage != null) ...[
                            CustomBadge.discount('SAVE ${product.savePercentage}%'),
                            const SizedBox(width: AppSpacing.s8),
                          ],
                          if (product.inStock) ...[
                            CustomBadge.inStock(),
                            const SizedBox(width: AppSpacing.s8),
                            CustomBadge.cod(),
                          ] else ...[
                            CustomBadge.outOfStock(),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s12),

                      // Title
                      Text(
                        product.title,
                        style: AppTextStyles.h2ProductTitle.copyWith(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s8),

                      // Rating & Reviews (only when reviews exist)
                      if (product.reviewCount > 0) ...[
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) => const Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: AppColors.amber,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s8),
                            Text(
                              product.rating.toString(),
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s4),
                            Text(
                              '(${product.reviewCount} Reviews)',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s16),
                      ],

                      // Pricing
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            product.formattedPrice,
                            style: AppTextStyles.price(
                              size: 28.0,
                              color: product.inStock
                                  ? AppColors.primaryOrange
                                  : AppColors.navyDark,
                            ),
                          ),
                          if (product.formattedOldPrice != null) ...[
                            const SizedBox(width: AppSpacing.s12),
                            Text(
                              product.formattedOldPrice!,
                              style: AppTextStyles.oldPrice(size: 18.0),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s16),
                      const Divider(color: AppColors.borderLight, height: 1),
                      const SizedBox(height: AppSpacing.s20),

                      // Color Selector
                      if (product.colors.isNotEmpty) ...[
                        Text('Select Color', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                        const SizedBox(height: AppSpacing.s8),
                        Obx(
                          () => Wrap(
                            spacing: AppSpacing.s12,
                            runSpacing: AppSpacing.s10,
                            children: product.colors.map((color) {
                              final isSelected = controller.selectedColor.value == color;
                              return GestureDetector(
                                onTap: () => controller.setColor(color),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.softPeach : AppColors.pageBackground,
                                    borderRadius: BorderRadius.circular(AppRadius.r16),
                                    border: Border.all(
                                      color: isSelected ? AppColors.primaryOrange : Colors.transparent,
                                    ),
                                  ),
                                  child: Text(
                                    color,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: isSelected ? AppColors.primaryOrange : AppColors.navyDark,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),
                      ],

                      // Specifications Table
                      if (product.specifications.isNotEmpty) ...[
                        Text('Full Key Specifications', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                        const SizedBox(height: AppSpacing.s12),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderLight),
                            borderRadius: AppRadius.radiusAll12,
                          ),
                          child: Column(
                            children: product.specifications.entries.map((entry) {
                              final index = product.specifications.keys.toList().indexOf(entry.key);
                              final isEven = index % 2 == 0;
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isEven ? AppColors.cardWhite : AppColors.pageBackground,
                                  borderRadius: index == 0
                                      ? const BorderRadius.vertical(top: Radius.circular(12))
                                      : index == product.specifications.length - 1
                                          ? const BorderRadius.vertical(bottom: Radius.circular(12))
                                          : BorderRadius.zero,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 120),
                                      child: Text(
                                        entry.key,
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.s12),
                                    Expanded(
                                      child: Text(
                                        entry.value,
                                        textAlign: TextAlign.end,
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.0,
                                          color: AppColors.navyDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),
                      ],

                      // Overview
                      Text('Overview', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                      const SizedBox(height: AppSpacing.s8),
                      Text(
                        product.description,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.navyDark.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s24),

                      // Reviews Section (only when reviews exist)
                      if (product.reviewCount > 0) ...[
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reviews', style: AppTextStyles.outfitTitleSmall.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(Icons.star_rounded, size: 14, color: AppColors.amber),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.s6),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                              const SizedBox(width: AppSpacing.s4),
                              Text(
                                '(${product.reviewCount} Reviews)',
                                style: AppTextStyles.small.copyWith(color: AppColors.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s12),

                      // Top 3 Review Cards
                      ...MockDatabase.productReviews.take(3).map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.s12),
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.s16),
                            decoration: BoxDecoration(
                              color: AppColors.cardWhite,
                              borderRadius: AppRadius.radiusAll16,
                              border: Border.all(color: AppColors.borderLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              review.author,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.bodyMedium.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.navyDark,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: AppSpacing.s8),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (index) => Icon(
                                                Icons.star_rounded,
                                                size: 13,
                                                color: index < review.rating
                                                    ? AppColors.amber
                                                    : AppColors.borderLight,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.s8),
                                    Text(
                                      review.date,
                                      style: AppTextStyles.small.copyWith(
                                        color: AppColors.textMuted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.s8),
                                Text(
                                  review.comment,
                                  style: AppTextStyles.bodyRegular.copyWith(
                                    color: AppColors.navyDark,
                                    height: 1.4,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      // "See All Reviews" Outline Button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.allReviews, arguments: product);
                        },
                        child: Container(
                          height: 48.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.cardWhite,
                            borderRadius: AppRadius.radiusAll16,
                            border: Border.all(color: AppColors.primaryOrange, width: 1.2),
                          ),
                          child: Text(
                            'See All ${product.reviewCount} Reviews',
                            style: AppTextStyles.secondaryOutlineButton.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Sticky Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 84.0,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                border: const Border(top: BorderSide(color: AppColors.borderLight)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x100B1220),
                    offset: Offset(0, -4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: product.inStock
                  ? Row(
                      children: [
                        // Quantity
                        Container(
                          height: 48.0,
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                          decoration: BoxDecoration(
                            color: AppColors.pageBackground,
                            borderRadius: BorderRadius.circular(AppRadius.r24),
                          ),
                          child: Obx(
                            () => Row(
                              children: [
                                GestureDetector(
                                  onTap: controller.decrement,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: Text('-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                                  child: Text(
                                    '${controller.quantity.value}',
                                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.increment,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: Text('+', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s12),

                        // Add to Cart Button
                        Expanded(
                          child: Obx(
                            () {
                              final totalCurrentPrice = product.price * controller.quantity.value;
                              return CustomButton(
                                text: 'Add to Cart · ${CurrencyFormatter.format(totalCurrentPrice)}',
                                height: 48.0,
                                onPressed: () {
                                  cartController.addItem(
                                    product,
                                    color: controller.selectedColor.value,
                                    quantity: controller.quantity.value,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 48.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(AppRadius.r24),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Out of Stock',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
