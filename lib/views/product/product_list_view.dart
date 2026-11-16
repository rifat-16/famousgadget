import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../data/mock_database.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments as String? ?? 'Products';
    final CartController cartController = Get.find<CartController>();

    // Retrieve products directly from MockDatabase based on section or category
    final List<ProductModel> filtered = title == 'Products'
        ? MockDatabase.products
        : title == 'Featured Products'
            ? MockDatabase.featuredProducts
            : title == 'Best Sellers'
                ? MockDatabase.bestSellers
                : title == 'Hot Deals'
                    ? MockDatabase.hotDeals
                    : MockDatabase.getProductsByCategory(title);

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
                childAspectRatio: 0.78,
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
