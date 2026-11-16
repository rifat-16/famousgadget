import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../core/animations/animations.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/app_routes.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Categories',
          style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppColors.navyDark),
            onPressed: () => Get.toNamed(AppRoutes.search),
          ),
          const SizedBox(width: AppSpacing.s8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s12,
          AppSpacing.s16,
          120.0,
        ),
        child: Obx(
          () => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeController.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: AppSpacing.s12,
              mainAxisSpacing: AppSpacing.s12,
              childAspectRatio: 0.77,
            ),
            itemBuilder: (context, index) {
              final category = homeController.categories[index];
              return FadeSlideIn(
                delay: Duration(milliseconds: (index * 35).clamp(0, 350)),
                distance: 16.0,
                child: Bounceable(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.productList,
                      arguments: category.name,
                    );
                  },
                  scaleFactor: 0.92,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: AppRadius.radiusAll16,
                      border: Border.all(
                        color: AppColors.borderLight.withValues(alpha: 0.6),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x080B1220),
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: const BoxDecoration(
                            color: AppColors.softPeach,
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: category.imageUrl != null
                              ? Image.network(
                                  category.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                    _getCategoryIcon(category.icon),
                                    size: 20.0,
                                    color: AppColors.primaryOrange,
                                  ),
                                )
                              : Icon(
                                  _getCategoryIcon(category.icon),
                                  size: 20.0,
                                  color: AppColors.primaryOrange,
                                ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          category.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.outfitTitleSmall.copyWith(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navyDark,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '${category.itemCount} items',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.small.copyWith(
                            fontSize: 10.0,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
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
      case 'phone_android':
        return Icons.phone_android_rounded;
      default:
        return Icons.devices_other_rounded;
    }
  }
}
