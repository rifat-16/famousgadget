import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final AuthController _authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = _authController.user.value;
    final parts = (user?.name ?? 'Arif Rahman').split(' ');
    final firstName = parts.isNotEmpty ? parts.first : 'Arif';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : 'Rahman';

    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
    _emailController = TextEditingController(text: user?.email ?? 'arif@gmail.com');
    _phoneController = TextEditingController(text: user?.phone ?? '+880 1712 345678');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSave() {
    final first = _firstNameController.text.trim();
    final last = _lastNameController.text.trim();
    final fullName = '$first $last'.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    _authController.updateProfile(
      name: fullName.isNotEmpty ? fullName : 'Arif Rahman',
      email: email.isNotEmpty ? email : 'arif@gmail.com',
      phone: phone.isNotEmpty ? phone : '+880 1712 345678',
    );

    Get.snackbar(
      'Profile Updated',
      'Your profile information has been saved successfully.',
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
          'Edit Profile',
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
          children: [
            // Avatar with camera icon
            Center(
              child: SizedBox(
                width: 90.0,
                height: 90.0,
                child: Stack(
                  children: [
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Obx(() {
                        final initials = _authController.user.value?.initials ?? 'AR';
                        return Text(
                          initials,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 32.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.snackbar(
                            'Change Photo',
                            'Profile photo upload opened.',
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: AppColors.navyDark,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Form Fields
            _buildField(
              label: 'First Name',
              controller: _firstNameController,
              hint: 'Enter first name',
            ),
            const SizedBox(height: 16.0),

            _buildField(
              label: 'Last Name',
              controller: _lastNameController,
              hint: 'Enter last name',
            ),
            const SizedBox(height: 16.0),

            // Email Field with Verified Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildField(
                  label: 'Email Address',
                  controller: _emailController,
                  hint: 'Enter email address',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 6.0),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 14.0,
                        color: AppColors.successGreen,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Verified Account',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            _buildField(
              label: 'Phone Number',
              controller: _phoneController,
              hint: 'Enter phone number (+880 1XXXXXXXXX)',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32.0),

            // Save Changes Button
            GestureDetector(
              onTap: _onSave,
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
                  'Save Changes',
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
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
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
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
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
