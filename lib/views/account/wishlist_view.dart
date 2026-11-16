import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../core/animations/animations.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());
    final CartController cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Center(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                color: AppColors.pageBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20.0,
                color: AppColors.navyDark,
              ),
            ),
          ),
        ),
        title: Obx(() {
          final count = authController.wishlist.length;
          return Text(
            'My Wishlist ($count)',
            style: AppTextStyles.h3Section.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navyDark,
            ),
          );
        }),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.borderLight,
            height: 1.0,
          ),
        ),
      ),
      body: Obx(() {
        if (authController.wishlist.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PulseGlow(
                    minScale: 0.94,
                    maxScale: 1.06,
                    duration: const Duration(milliseconds: 1500),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        color: AppColors.softPeach,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        size: 48.0,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Your Wishlist is Empty',
                    style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 20.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Explore our latest collection and save your favorite gadgets!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.mainNav),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: const Text(
                      'Start Shopping',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
          itemCount: authController.wishlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final product = authController.wishlist[index];
            return _buildWishlistCard(
              context,
              product,
              authController,
              cartController,
            );
          },
        );
      }),
    );
  }

  Widget _buildWishlistCard(
    BuildContext context,
    ProductModel product,
    AuthController authController,
    CartController cartController,
  ) {
    final priceStr = CurrencyFormatter.format(product.price);

    return Bounceable(
      onTap: () {
        Get.toNamed(AppRoutes.productDetail, arguments: product);
      },
      scaleFactor: 0.96,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.borderLight.withValues(alpha: 0.6),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x060B1220),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack with Heart Button
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Hero(
                      tag: 'product-img-${product.id}',
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            Icons.devices_other_rounded,
                            color: AppColors.textMuted,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: HeartPopButton(
                        isFavorite: true,
                        size: 16.0,
                        onToggle: () => authController.toggleWishlist(product),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            // Title
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: AppColors.navyDark,
              ),
            ),
            const SizedBox(height: 4.0),

            // Price
            Text(
              priceStr,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryOrange,
              ),
            ),
            const SizedBox(height: 8.0),

            // Add To Cart Button
            Bounceable(
              onTap: () {
                cartController.addItem(product);
                Get.snackbar(
                  'Added to Cart',
                  '${product.title} added to your cart',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: AppColors.navyDark,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16.0),
                  borderRadius: 16.0,
                  duration: const Duration(seconds: 2),
                );
              },
              scaleFactor: 0.94,
              child: Container(
                width: double.infinity,
                height: 30.0,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 13.0,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
