import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_badge.dart';
import '../../core/widgets/custom_button.dart';
import '../../models/product_model.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments as ProductModel;
    final ProductDetailController controller = Get.put(ProductDetailController());
    final CartController cartController = Get.find<CartController>();
    final AuthController authController = Get.find<AuthController>();

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
                          bottom: AppSpacing.s16,
                          child: Obx(
                            () => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                product.galleryImages.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                                  width: controller.currentImageIndex.value == index ? 18.0 : 6.0,
                                  height: 6.0,
                                  decoration: BoxDecoration(
                                    color: controller.currentImageIndex.value == index
                                        ? AppColors.primaryOrange
                                        : AppColors.borderLight,
                                    borderRadius: BorderRadius.circular(3),
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
                          CustomBadge.inStock(
                            text: product.inStock ? 'IN STOCK' : 'OUT OF STOCK',
                          ),
                          const SizedBox(width: AppSpacing.s8),
                          CustomBadge.cod(),
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

                      // Rating & Reviews
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

                      // Pricing
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            product.formattedPrice,
                            style: AppTextStyles.price(size: 28.0),
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
                      const SizedBox(height: AppSpacing.s20),

                      // Color Selector
                      if (product.colors.isNotEmpty) ...[
                        Text('Select Color', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                        const SizedBox(height: AppSpacing.s8),
                        Obx(
                          () => Wrap(
                            spacing: AppSpacing.s8,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(entry.key, style: AppTextStyles.caption),
                                    Text(
                                      entry.value,
                                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),
                      ],

                      // Description
                      Text('Description', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                      const SizedBox(height: AppSpacing.s8),
                      Text(
                        product.description,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.navyDark.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s24),

                      // Customer Reviews Card
                      Text('Customer Reviews', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                      const SizedBox(height: AppSpacing.s12),
                      Container(
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
                                Row(
                                  children: [
                                    Text(
                                      'Priya Sengupta',
                                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: AppSpacing.s8),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => const Icon(
                                          Icons.star_rounded,
                                          size: 13,
                                          color: AppColors.amber,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text('02 Mar 2026', style: AppTextStyles.small),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.s8),
                            Text(
                              'Perfect for daily use. The audio clarity and noise cancellation are outstanding! Highly recommended for gadget lovers.',
                              style: AppTextStyles.bodyMedium.copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
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
              child: Row(
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
                          text: 'Add to Cart · ৳${totalCurrentPrice.toStringAsFixed(0)}',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
