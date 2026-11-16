import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/app_routes.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    return Obx(() {
      final isLoggedIn = authController.isLoggedIn.value;

      return Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.cardWhite,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            isLoggedIn ? 'My Account' : 'My Profile',
            style: AppTextStyles.h3Section.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navyDark,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.borderLight,
              height: 1.0,
            ),
          ),
        ),
        body: isLoggedIn
            ? _buildLoggedInBody(context, authController)
            : _buildGuestBody(context),
      );
    });
  }

  // ==================== 1. GUEST VIEW (account-guest) ====================
  Widget _buildGuestBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Guest Hero Box
          Container(
            width: double.infinity,
            color: AppColors.cardWhite,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: const BoxDecoration(
                    color: AppColors.pageBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 40.0,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Welcome, Guest',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navyDark,
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  'Login to unlock seamless gadget shopping',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.login),
                        child: Container(
                          height: 44.0,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: Container(
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.0),
                            border: Border.all(
                              color: AppColors.primaryOrange,
                              width: 1.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Locked Menu Items
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
            child: Column(
              children: [
                _buildLockedMenuItem(
                  title: 'My Orders',
                  subtitle: 'Track active & past shipments',
                  onTap: () => _promptLogin(),
                ),
                const SizedBox(height: 12.0),
                _buildLockedMenuItem(
                  title: 'Wishlist',
                  subtitle: 'View saved items to buy later',
                  onTap: () => _promptLogin(),
                ),
                const SizedBox(height: 12.0),
                _buildLockedMenuItem(
                  title: 'Saved Addresses',
                  subtitle: 'Manage Dhaka delivery zones',
                  onTap: () => _promptLogin(),
                ),
                const SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: AppColors.softPeach,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Text(
                    '🔒 Account login is required to proceed with Cash on Delivery checkouts.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedMenuItem({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.lock_outline_rounded,
              size: 20.0,
              color: AppColors.textMuted,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'LOCKED',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _promptLogin() {
    Get.snackbar(
      'Login Required',
      'Please login to access your orders, wishlist, and saved addresses.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.navyDark,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 16.0,
      mainButton: TextButton(
        onPressed: () => Get.toNamed(AppRoutes.login),
        child: const Text(
          'Login',
          style: TextStyle(
            color: AppColors.primaryOrange,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ==================== 2. LOGGED IN VIEW (account-logged-in) ====================
  Widget _buildLoggedInBody(BuildContext context, AuthController authController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // User Hero
          Obx(() {
            final user = authController.user.value;
            final name = user?.name ?? 'Arif Rahman';
            final email = user?.email ?? 'arif@gmail.com';
            final city = user?.city ?? 'Dhaka';
            final country = user?.country ?? 'BD';
            final phone = user?.phone ?? '+880 1712 345678';
            final initials = user?.initials ?? 'AR';

            return Container(
              width: double.infinity,
              color: AppColors.cardWhite,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryOrange,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navyDark,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '$email • $city, $country',
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          phone,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          // Menu List
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
            child: Column(
              children: [
                // Card 1: Profile & Orders
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: AppColors.borderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildMenuRow(
                        icon: Icons.person_outline_rounded,
                        title: 'Edit Profile',
                        onTap: () => Get.toNamed(AppRoutes.editProfile),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.lock_outline_rounded,
                        title: 'Change Password',
                        onTap: () => Get.toNamed(AppRoutes.changePassword),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.location_on_outlined,
                        title: 'My Addresses',
                        onTap: () => Get.toNamed(AppRoutes.addresses),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.local_shipping_outlined,
                        title: 'My Orders',
                        onTap: () => Get.toNamed(AppRoutes.orders),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.favorite_border_rounded,
                        title: 'My Wishlist',
                        onTap: () => Get.toNamed(AppRoutes.wishlist),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),

                // Card 2: Settings & Support
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: AppColors.borderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildMenuRow(
                        icon: Icons.tune_rounded,
                        title: 'App Settings',
                        onTap: () => _showAppSettingsSheet(context),
                      ),
                      _buildDivider(),
                      _buildMenuRow(
                        icon: Icons.help_outline_rounded,
                        title: 'Help & Support',
                        onTap: () => _showHelpSupportSheet(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),

                // Card 3: Logout
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: AppColors.borderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  child: _buildMenuRow(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    textColor: AppColors.dangerRed,
                    iconColor: AppColors.dangerRed,
                    showChevron: false,
                    onTap: () {
                      _showLogoutDialog(context, authController);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = AppColors.navyDark,
    Color iconColor = AppColors.navyDark,
    bool showChevron = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(icon, size: 20.0, color: iconColor),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                size: 18.0,
                color: Color(0xFF9CA3AF),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.0,
      thickness: 1.0,
      indent: 16.0,
      endIndent: 16.0,
      color: AppColors.borderLight.withValues(alpha: 0.6),
    );
  }

  // ==================== 3. MODALS (Help & Support / App Settings / Logout) ====================
  void _showHelpSupportSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Help & Support',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: AppColors.navyDark,
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'We are here 24/7 to assist with your gadget orders.',
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: 13.0,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildSupportTile(
              icon: Icons.phone_in_talk_rounded,
              title: 'Customer Hotline',
              subtitle: '+880 1712 345678 (Toll Free)',
              onTap: () {
                Get.back();
                Get.snackbar('Hotline', 'Calling +880 1712 345678');
              },
            ),
            const SizedBox(height: 12.0),
            _buildSupportTile(
              icon: Icons.mail_outline_rounded,
              title: 'Email Support',
              subtitle: 'support@famousgadget.com',
              onTap: () {
                Get.back();
                Get.snackbar('Email', 'Emailing support@famousgadget.com');
              },
            ),
            const SizedBox(height: 12.0),
            _buildSupportTile(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Live WhatsApp Chat',
              subtitle: 'Average reply time: 5 minutes',
              onTap: () {
                Get.back();
                Get.snackbar('WhatsApp', 'Opening WhatsApp Support');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: AppColors.softPeach,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.0, color: AppColors.primaryOrange),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navyDark,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.0,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  void _showAppSettingsSheet(BuildContext context) {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setSheetState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'App Settings',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navyDark,
                  ),
                ),
                const SizedBox(height: 16.0),
                SwitchListTile(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.primaryOrange,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Push Notifications',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navyDark,
                    ),
                  ),
                  subtitle: const Text(
                    'Get alerts on order delivery and offers',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                Divider(color: AppColors.borderLight.withValues(alpha: 0.6)),
                SwitchListTile(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.primaryOrange,
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Order Status Updates',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navyDark,
                    ),
                  ),
                  subtitle: const Text(
                    'SMS and In-App shipment tracking',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                const Center(
                  child: Text(
                    'Famous Gadget BD • v1.0.4',
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.navyDark.withValues(alpha: 0.12),
                blurRadius: 28.0,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Icon Badge
              Container(
                width: 64.0,
                height: 64.0,
                decoration: const BoxDecoration(
                  color: AppColors.softPeach,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.logout_rounded,
                    color: AppColors.primaryOrange,
                    size: 28.0,
                  ),
                ),
              ),
              const SizedBox(height: 18.0),

              // Title
              const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navyDark,
                ),
              ),
              const SizedBox(height: 8.0),

              // Subtitle / Description
              const Text(
                'Are you sure you want to log out of your account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 14.0,
                  height: 1.45,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24.0),

              // Action Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.pageBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            side: const BorderSide(
                              color: AppColors.borderLight,
                              width: 1.0,
                            ),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navyDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),

                  // Logout Button
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(14.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryOrange.withValues(alpha: 0.35),
                              blurRadius: 10.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14.0),
                            onTap: () {
                              Get.back();
                              authController.logout();
                              Get.snackbar(
                                'Logged Out',
                                'You have been logged out successfully.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: AppColors.navyDark,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(16.0),
                                borderRadius: 16.0,
                              );
                            },
                            child: const Center(
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
