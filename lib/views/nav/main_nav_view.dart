import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../account/account_view.dart';
import '../cart/cart_view.dart';
import '../categories/categories_view.dart';
import '../home/home_view.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    final CartController cartController = Get.put(CartController());

    final List<Widget> pages = [
      const HomeView(),
      const CategoriesView(),
      const CartView(),
      const AccountView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Stack(
        children: [
          // Current Page
          Obx(() => IndexedStack(
                index: navController.currentIndex.value,
                children: pages,
              )),

          // Floating Navigation Bar as designed in Figma
          Positioned(
            left: AppSpacing.s16,
            right: AppSpacing.s16,
            bottom: AppSpacing.s16,
            child: Obx(
              () => Container(
                height: 68.0,
                decoration: BoxDecoration(
                  color: AppColors.navyDark,
                  borderRadius: AppRadius.radiusAll34,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000), // rgba(0,0,0,0.25)
                      offset: Offset(0, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      index: 0,
                      label: 'Home',
                      icon: Icons.home_rounded,
                      activeIcon: Icons.home_rounded,
                      selectedIndex: navController.currentIndex.value,
                      onTap: () => navController.changeTab(0),
                    ),
                    _buildNavItem(
                      index: 1,
                      label: 'Shop',
                      icon: Icons.grid_view_rounded,
                      activeIcon: Icons.grid_view_rounded,
                      selectedIndex: navController.currentIndex.value,
                      onTap: () => navController.changeTab(1),
                    ),
                    _buildNavItem(
                      index: 2,
                      label: 'Cart',
                      icon: Icons.shopping_cart_outlined,
                      activeIcon: Icons.shopping_cart_rounded,
                      selectedIndex: navController.currentIndex.value,
                      badgeCount: cartController.totalItemCount,
                      onTap: () => navController.changeTab(2),
                    ),
                    _buildNavItem(
                      index: 3,
                      label: 'Account',
                      icon: Icons.person_outline_rounded,
                      activeIcon: Icons.person_rounded,
                      selectedIndex: navController.currentIndex.value,
                      onTap: () => navController.changeTab(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData activeIcon,
    required int selectedIndex,
    required VoidCallback onTap,
    int badgeCount = 0,
  }) {
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        height: 44.0,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppSpacing.s16 : AppSpacing.s12,
          vertical: AppSpacing.s8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.r22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  size: 20.0,
                  color: isSelected ? AppColors.cardWhite : AppColors.textMuted,
                ),
                if (badgeCount > 0 && !isSelected)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      width: 16,
                      height: 16,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: AppColors.cardWhite,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(width: AppSpacing.s8),
              Text(
                label,
                style: AppTextStyles.outfitTitleSmall.copyWith(
                  color: AppColors.cardWhite,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
