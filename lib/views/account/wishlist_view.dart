import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../routes/app_routes.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final CartController cartController = Get.find<CartController>();

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
        title: Text('My Wishlist', style: AppTextStyles.h3Section),
      ),
      body: Obx(() {
        if (authController.wishlist.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite_border_rounded, size: 64, color: AppColors.textDisabled),
                const SizedBox(height: AppSpacing.s12),
                Text('Your Wishlist is Empty', style: AppTextStyles.h3Section),
                const SizedBox(height: AppSpacing.s8),
                Text('Tap the heart icon on any gadget to save it here.', style: AppTextStyles.caption),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.s16),
          itemCount: authController.wishlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.s12,
            mainAxisSpacing: AppSpacing.s12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = authController.wishlist[index];
            return ProductCard(
              product: product,
              onTap: () {
                Get.toNamed(AppRoutes.productDetail, arguments: product);
              },
              onAddToCart: () {
                cartController.addItem(product);
              },
            );
          },
        );
      }),
    );
  }
}
