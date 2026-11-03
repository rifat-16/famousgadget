import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
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
  final _emailController = TextEditingController(text: 'arif@gmail.com');
  final _passwordController = TextEditingController(text: '123456');
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navyDark),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  height: 48,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.bolt_rounded, size: 48, color: AppColors.primaryOrange),
                ),
              ),
              const SizedBox(height: AppSpacing.s32),

              Text('Welcome Back', style: AppTextStyles.h1Display.copyWith(fontSize: 28)),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Sign in to access your orders, wishlist, and saved addresses.',
                style: AppTextStyles.caption.copyWith(fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.s32),

              // Email Input
              Text('Email Address', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.s8),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: AppRadius.radiusAll12,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s16),

              // Password Input
              Text('Password', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.s8),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: AppRadius.radiusAll12,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        size: 20,
                        color: AppColors.textMuted,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.s32),

              // Submit Button
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                    authController.login(_emailController.text, _passwordController.text);
                    Get.offAllNamed(AppRoutes.mainNav);
                    Get.snackbar('Welcome', 'Logged in as ${_emailController.text}');
                  } else {
                    Get.snackbar('Error', 'Please enter email and password');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
