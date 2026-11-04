import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreeToTerms = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_agreeToTerms) {
      Get.snackbar('Terms & Conditions', 'Please agree to the Terms & Conditions to proceed.');
      return;
    }
    final phone = _phoneController.text.trim().isEmpty
        ? '+880 1712345678'
        : _phoneController.text.trim();
    Get.toNamed(AppRoutes.otpVerify, arguments: {
      'phone': phone,
      'name': '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
    });
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
              padding: const EdgeInsets.fromLTRB(AppSpacing.s20, AppSpacing.s16, AppSpacing.s20, AppSpacing.s20),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s8),
                  SvgPicture.asset(
                    AppAssets.logoWhite,
                    height: 28.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: AppSpacing.s24),
                  Text(
                    'Create Account',
                    style: AppTextStyles.h1Display.copyWith(
                      color: AppColors.cardWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s4),
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
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Name & Last Name Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              label: 'First Name',
                              controller: _firstNameController,
                              hint: 'Adnan',
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s12),
                          Expanded(
                            child: _buildInputField(
                              label: 'Last Name',
                              controller: _lastNameController,
                              hint: 'Sarker',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s14),

                      // Phone Number
                      _buildInputField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        hint: '+880  1712345678',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: AppSpacing.s14),

                      // Email Address
                      _buildInputField(
                        label: 'Email Address',
                        controller: _emailController,
                        hint: 'example@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSpacing.s14),

                      // Password
                      Text(
                        'Password',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.navyDark,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s6),
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: '••••••••••••',
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

                      const SizedBox(height: AppSpacing.s16),

                      // Terms Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _agreeToTerms = !_agreeToTerms;
                              });
                            },
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: _agreeToTerms ? AppColors.primaryOrange : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _agreeToTerms ? AppColors.primaryOrange : const Color(0xFFCBD5E1),
                                  width: 1.5,
                                ),
                              ),
                              child: _agreeToTerms
                                  ? const Icon(
                                      Icons.check_rounded,
                                      size: 14,
                                      color: AppColors.cardWhite,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s8),
                          Expanded(
                            child: Text(
                              'I agree to the Terms & Conditions and Privacy Policy',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Register Button
                      CustomButton(
                        text: 'Register',
                        height: 48,
                        onPressed: _onRegister,
                      ),

                      const SizedBox(height: AppSpacing.s16),

                      // Already have an account? Login
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: AppTextStyles.caption.copyWith(
                                color: const Color(0xFF64748B),
                                fontSize: 12.5,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login',
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
                      const SizedBox(height: AppSpacing.s16),
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.navyDark,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
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
      ],
    );
  }
}
