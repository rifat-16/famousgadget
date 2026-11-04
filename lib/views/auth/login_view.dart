import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onLogin() {
    final phone = _phoneController.text.trim().isEmpty
        ? '+880 1712345678'
        : _phoneController.text.trim();
    Get.toNamed(AppRoutes.otpVerify, arguments: {'phone': phone});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyDark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Dark Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.s20, AppSpacing.s20, AppSpacing.s20, AppSpacing.s24),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s8),
                  // Centered White SVG Logo
                  SvgPicture.asset(
                    AppAssets.logoWhite,
                    height: 28.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  Text(
                    'Welcome Back',
                    style: AppTextStyles.h1Display.copyWith(
                      color: AppColors.cardWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s6),
                  Text(
                    'Login to unlock premium gadget benefits',
                    style: AppTextStyles.caption.copyWith(
                      color: const Color(0xFF94A3B8),
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                ],
              ),
            ),

            // Off-White Rounded Bottom Sheet
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.s4),

                      // Phone Number Field
                      Text(
                        'Phone Number',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.navyDark,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: '+880 1XXXXXXXXX',
                              hintStyle: AppTextStyles.caption.copyWith(
                                color: const Color(0xFF94A3B8),
                                fontSize: 13.5,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s24),

                      // Login Button
                      CustomButton(
                        text: 'Login',
                        height: 48,
                        onPressed: _onLogin,
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Don't have an account? Register
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.register),
                          child: Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: AppTextStyles.caption.copyWith(
                                color: const Color(0xFF64748B),
                                fontSize: 12.5,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primaryOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
