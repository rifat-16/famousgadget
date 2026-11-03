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

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final RxList<ProductModel> _results = <ProductModel>[].obs;
  late final List<ProductModel> _allProducts;

  @override
  void initState() {
    super.initState();
    final HomeController homeController = Get.find<HomeController>();
    _allProducts = {
      ...homeController.featuredProducts,
      ...homeController.bestSellers,
      ...homeController.hotDeals,
    }.toList();
    _results.assignAll(_allProducts);
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      _results.assignAll(_allProducts);
    } else {
      _results.assignAll(
        _allProducts.where((p) =>
            p.title.toLowerCase().contains(query.toLowerCase()) ||
            p.category.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Container(
          height: 44.0,
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(22),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Search gadgets, audio, watches...',
              hintStyle: AppTextStyles.caption,
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.textMuted),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: Obx(
        () => _results.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search_off_rounded, size: 64, color: AppColors.textDisabled),
                    const SizedBox(height: AppSpacing.s12),
                    Text('No matching gadgets found', style: AppTextStyles.h3Section),
                    const SizedBox(height: AppSpacing.s8),
                    Text('Try searching with different keywords.', style: AppTextStyles.caption),
                  ],
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(AppSpacing.s16),
                itemCount: _results.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.s12,
                  mainAxisSpacing: AppSpacing.s12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = _results[index];
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
      ),
    );
  }
}
