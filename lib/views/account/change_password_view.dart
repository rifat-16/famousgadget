import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMinLength => _newPasswordController.text.length >= 8;
  bool get _hasUpperLower =>
      _newPasswordController.text.contains(RegExp(r'[A-Z]')) &&
      _newPasswordController.text.contains(RegExp(r'[a-z]'));
  bool get _hasNumber => _newPasswordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecial =>
      _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  void _onUpdate() {
    Get.snackbar(
      'Password Updated',
      'Your password has been changed successfully.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.navyDark,
      colorText: Colors.white,
      margin: const EdgeInsets.all(AppSpacing.s16),
      borderRadius: 16.0,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Center(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                color: AppColors.pageBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20.0,
                color: AppColors.navyDark,
              ),
            ),
          ),
        ),
        title: Text(
          'Change Password',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Password
            _buildPasswordField(
              label: 'Current Password',
              controller: _currentPasswordController,
              isObscured: _obscureCurrent,
              hint: 'Enter current password',
              onToggleVisibility: () {
                setState(() => _obscureCurrent = !_obscureCurrent);
              },
            ),
            const SizedBox(height: 16.0),

            // New Password Group with Strength Bars
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPasswordField(
                  label: 'New Password',
                  controller: _newPasswordController,
                  isObscured: _obscureNew,
                  hint: 'Enter new password',
                  onToggleVisibility: () {
                    setState(() => _obscureNew = !_obscureNew);
                  },
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8.0),
                // Strength bars
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: _hasMinLength
                              ? AppColors.successGreen
                              : AppColors.borderLight,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Container(
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: _hasUpperLower && _hasMinLength
                              ? AppColors.successGreen
                              : AppColors.borderLight,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Container(
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: _hasNumber && _hasSpecial
                              ? AppColors.successGreen
                              : AppColors.borderLight,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_newPasswordController.text.isNotEmpty) ...[
                  const SizedBox(height: 6.0),
                  Text(
                    _hasMinLength && _hasUpperLower && _hasNumber && _hasSpecial
                        ? 'Strong Password'
                        : (_hasMinLength ? 'Moderate Password' : 'Weak Password'),
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: _hasMinLength && _hasUpperLower && _hasNumber && _hasSpecial
                          ? AppColors.successGreen
                          : AppColors.primaryOrange,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16.0),

            // Confirm New Password
            _buildPasswordField(
              label: 'Confirm New Password',
              controller: _confirmPasswordController,
              isObscured: _obscureConfirm,
              hint: 'Re-enter new password',
              onToggleVisibility: () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              },
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 20.0),

            // Requirements Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.s16),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password Requirements',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navyDark,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  _buildRequirementRow(
                    met: _hasMinLength,
                    text: 'At least 8 characters long',
                  ),
                  const SizedBox(height: 8.0),
                  _buildRequirementRow(
                    met: _hasUpperLower,
                    text: 'Includes uppercase & lowercase letters',
                  ),
                  const SizedBox(height: 8.0),
                  _buildRequirementRow(
                    met: _hasNumber,
                    text: 'Includes at least one number',
                  ),
                  const SizedBox(height: 8.0),
                  _buildRequirementRow(
                    met: _hasSpecial,
                    text: 'Includes a special character (e.g. ! @ #)',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),

            // Update Password Button
            GestureDetector(
              onTap: _onUpdate,
              child: Container(
                width: double.infinity,
                height: 52.0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(26.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33FF6A00),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Update Password',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isObscured,
    required VoidCallback onToggleVisibility,
    String? hint,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 48.0,
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.borderLight),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isObscured,
                  onChanged: onChanged,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.navyDark,
                  ),
                  cursorColor: AppColors.primaryOrange,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onToggleVisibility,
                child: Text(
                  isObscured ? 'Show' : 'Hide',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementRow({
    required bool met,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle_rounded : Icons.cancel_rounded,
          size: 14.0,
          color: met ? AppColors.successGreen : AppColors.dangerRed,
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: met ? AppColors.navyDark : AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
