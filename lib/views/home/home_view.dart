import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final CartController cartController = Get.put(CartController());
    final NavController navController = Get.find<NavController>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: AppSpacing.s16,
        title: Row(
          children: [
            Image.asset(
              AppAssets.logo,
              height: 28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Row(
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      color: AppColors.primaryOrange,
                      size: 26,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'FAMOUS GADGET',
                      style: AppTextStyles.h3Section.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        actions: [
          _buildCircleAction(
            icon: Icons.search_rounded,
            onTap: () => Get.toNamed(AppRoutes.search),
          ),
          const SizedBox(width: AppSpacing.s12),
          _buildCircleAction(
            icon: Icons.notifications_none_rounded,
            onTap: () {
              Get.snackbar(
                'Notifications',
                'No new notifications at this time.',
                snackPosition: SnackPosition.TOP,
              );
            },
          ),
          const SizedBox(width: AppSpacing.s16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.s16),

            // 1. Promo Banner Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              child: Container(
                height: 168.0,
                decoration: BoxDecoration(
                  gradient: AppColors.bannerGradient,
                  borderRadius: AppRadius.radiusAll24,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x200B1220),
                      offset: Offset(0, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(AppSpacing.s20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.cardWhite,
                                  borderRadius: AppRadius.radiusAll8,
                                ),
                                child: Text(
                                  'WINTER DEAL',
                                  style: AppTextStyles.badgeText.copyWith(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryOrange,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.s6),
                              Text(
                                'Up to 40% Off Smart Watches',
                                style: AppTextStyles.outfitTitleSmall.copyWith(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.cardWhite,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => navController.changeTab(1),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s16,
                                    vertical: AppSpacing.s8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryOrange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Shop Now',
                                    style: AppTextStyles.badgeText.copyWith(
                                      color: AppColors.cardWhite,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.s12),
                              // Dots indicator
                              Row(
                                children: [
                                  _buildDot(isActive: true),
                                  const SizedBox(width: 4),
                                  _buildDot(isActive: false),
                                  const SizedBox(width: 4),
                                  _buildDot(isActive: false),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    // Banner Image
                    ClipRRect(
                      borderRadius: AppRadius.radiusAll12,
                      child: Container(
                        width: 100,
                        height: 128,
                        color: Colors.white12,
                        child: Image.network(
                          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400&auto=format&fit=crop&q=80',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.watch_rounded,
                            size: 48,
                            color: AppColors.cardWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.s24),

            // 2. Categories Section
            _buildSectionHeader(
              title: 'Categories',
              actionTitle: 'See all',
              onActionTap: () => navController.changeTab(1),
            ),
            const SizedBox(height: AppSpacing.s12),
            SizedBox(
              height: 94.0,
              child: Obx(
                () => ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.s12),
                  itemBuilder: (context, index) {
                    final category = homeController.categories[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.productList,
                          arguments: category.name,
                        );
                      },
                      child: SizedBox(
                        width: 72.0,
                        child: Column(
                          children: [
                            Container(
                              width: 56.0,
                              height: 57.0,
                              decoration: BoxDecoration(
                                color: AppColors.softPeach,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Icon(
                                _getCategoryIcon(category.icon),
                                size: 26.0,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s8),
                            Text(
                              category.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.small.copyWith(
                                color: AppColors.navyDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.s24),

            // 3. Featured Products Section
            _buildSectionHeader(
              title: 'Featured Products',
              actionTitle: 'See all',
              onActionTap: () {
                Get.toNamed(
                  AppRoutes.productList,
                  arguments: 'Featured Products',
                );
              },
            ),
            const SizedBox(height: AppSpacing.s12),
            SizedBox(
              height: 230.0,
              child: Obx(
                () => ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.featuredProducts.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.s12),
                  itemBuilder: (context, index) {
                    final product = homeController.featuredProducts[index];
                    return ProductCard(
                      product: product,
                      width: 156.0,
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
            ),

            const SizedBox(height: AppSpacing.s24),

            // 4. Best Sellers Section
            _buildSectionHeader(
              title: 'Best Sellers',
              actionTitle: 'See all',
              onActionTap: () {
                Get.toNamed(
                  AppRoutes.productList,
                  arguments: 'Best Sellers',
                );
              },
            ),
            const SizedBox(height: AppSpacing.s12),
            SizedBox(
              height: 230.0,
              child: Obx(
                () => ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.bestSellers.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.s12),
                  itemBuilder: (context, index) {
                    final product = homeController.bestSellers[index];
                    return ProductCard(
                      product: product,
                      width: 156.0,
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
            ),

            const SizedBox(height: AppSpacing.s24),

            // 5. Hot Deals Grid
            _buildSectionHeader(
              title: 'Hot Deals',
              actionTitle: 'See all',
              onActionTap: () {
                Get.toNamed(
                  AppRoutes.productList,
                  arguments: 'Hot Deals',
                );
              },
            ),
            const SizedBox(height: AppSpacing.s12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
              child: Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeController.hotDeals.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.s12,
                    mainAxisSpacing: AppSpacing.s12,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = homeController.hotDeals[index];
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String actionTitle,
    required VoidCallback onActionTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.h3Section),
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionTitle,
              style: AppTextStyles.uiSemiBold.copyWith(
                fontSize: 13.0,
                color: AppColors.primaryOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAction({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.0,
        height: 36.0,
        decoration: const BoxDecoration(
          color: AppColors.pageBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.0, color: AppColors.navyDark),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 16 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryOrange : Colors.white38,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  IconData _getCategoryIcon(String icon) {
    switch (icon) {
      case 'watch':
        return Icons.watch_rounded;
      case 'camera':
        return Icons.photo_camera_rounded;
      case 'videocam':
        return Icons.videocam_rounded;
      case 'headphones':
        return Icons.headphones_rounded;
      case 'mic':
        return Icons.mic_rounded;
      case 'router':
        return Icons.router_rounded;
      case 'tablet_mac':
        return Icons.tablet_mac_rounded;
      default:
        return Icons.devices_other_rounded;
    }
  }
}
