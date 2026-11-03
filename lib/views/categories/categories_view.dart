import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/app_routes.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Categories', style: AppTextStyles.h2ProductTitle),
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
          AppSpacing.s16,
          AppSpacing.s16,
          120.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeController.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.s12,
                  mainAxisSpacing: AppSpacing.s12,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (context, index) {
                  final category = homeController.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.productList,
                        arguments: category.name,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
                        borderRadius: AppRadius.radiusAll20,
                        border: Border.all(
                          color: AppColors.borderLight.withValues(alpha: 0.5),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A0B1220),
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(AppSpacing.s16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: AppColors.softPeach,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              _getCategoryIcon(category.icon),
                              size: 26.0,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          Text(
                            category.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.outfitTitleSmall.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s4),
                          Text(
                            '${category.itemCount} items',
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
      default:
        return Icons.devices_other_rounded;
    }
  }
}
