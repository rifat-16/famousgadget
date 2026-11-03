import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/app_routes.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('My Account', style: AppTextStyles.h3Section),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s16,
          AppSpacing.s16,
          120.0,
        ),
        child: Column(
          children: [
            // 1. User Hero Card as designed in Figma
            Obx(() {
              final user = authController.user.value;
              if (user == null || !authController.isLoggedIn.value) {
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.s20),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: AppRadius.radiusAll20,
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: AppColors.pageBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person_outline_rounded,
                            size: 32, color: AppColors.textMuted),
                      ),
                      const SizedBox(width: AppSpacing.s16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome Guest',
                                style: AppTextStyles.outfitTitleSmall
                                    .copyWith(fontSize: 16)),
                            const SizedBox(height: 2),
                            Text('Sign in to track orders and save addresses',
                                style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.toNamed(AppRoutes.login),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(AppSpacing.s20),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: AppRadius.radiusAll20,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    // Avatar circle with initials
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        user.initials,
                        style: AppTextStyles.h3Section.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: AppTextStyles.h3Section.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${user.email} • ${user.city}, ${user.country}',
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.phone,
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: AppSpacing.s16),

            // 2. Menu Items
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: AppRadius.radiusAll20,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.local_shipping_outlined,
                    title: 'My Orders',
                    onTap: () => Get.toNamed(AppRoutes.orders),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.favorite_border_rounded,
                    title: 'My Wishlist',
                    onTap: () => Get.toNamed(AppRoutes.wishlist),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Saved Addresses',
                    onTap: () => Get.toNamed(AppRoutes.addresses),
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Profile',
                    onTap: () {
                      Get.snackbar('Profile', 'Profile edit screen');
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.lock_outline_rounded,
                    title: 'Change Password',
                    onTap: () {
                      Get.snackbar('Security', 'Change password screen');
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Customer Support',
                    onTap: () {
                      Get.snackbar('Support', 'Famous Gadget BD Hotline: +880 1712 345678');
                    },
                  ),
                  _buildDivider(),
                  _buildMenuItem(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    textColor: AppColors.dangerRed,
                    iconColor: AppColors.dangerRed,
                    onTap: () {
                      authController.logout();
                      Get.snackbar('Logged Out', 'You have been logged out.');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor ?? AppColors.navyDark, size: 22),
      title: Text(
        title,
        style: AppTextStyles.outfitTitleSmall.copyWith(
          color: textColor ?? AppColors.navyDark,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded,
          color: AppColors.textMuted, size: 20),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 16, endIndent: 16, color: AppColors.borderLight);
  }
}
