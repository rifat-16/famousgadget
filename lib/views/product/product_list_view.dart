import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/home_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String? ?? 'Products';
    final HomeController homeController = Get.find<HomeController>();
    final CartController cartController = Get.find<CartController>();

    // Filter or aggregate products based on argument
    final List<ProductModel> allProducts = [
      ...homeController.featuredProducts,
      ...homeController.bestSellers,
      ...homeController.hotDeals,
    ];

    final List<ProductModel> filtered = allProducts
        .where((p) =>
            title == 'Products' ||
            title == 'Featured Products' ||
            title == 'Best Sellers' ||
            title == 'Hot Deals' ||
            p.category.toLowerCase().contains(title.toLowerCase()))
        .toSet()
        .toList();

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
        title: Text(title, style: AppTextStyles.h3Section),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppColors.navyDark),
            onPressed: () => Get.toNamed(AppRoutes.search),
          ),
          const SizedBox(width: AppSpacing.s8),
        ],
      ),
      body: filtered.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.textDisabled),
                  const SizedBox(height: AppSpacing.s12),
                  Text('No products found', style: AppTextStyles.h3Section),
                  const SizedBox(height: AppSpacing.s8),
                  Text('Check back later for new arrivals in $title.', style: AppTextStyles.caption),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.s16),
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.s12,
                mainAxisSpacing: AppSpacing.s12,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final product = filtered[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.productDetail,
                      arguments: product,
                    );
                  },
                  onAddToCart: () {
                    cartController.addItem(product);
                  },
                );
              },
            ),
    );
  }
}
