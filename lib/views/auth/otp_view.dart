import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _secondsRemaining = 30;
  Timer? _timer;
  String _phoneNumber = '1712345678';

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['phone'] != null) {
      String raw = args['phone'] as String;
      if (raw.startsWith('+880')) {
        _phoneNumber = raw.replaceFirst('+880', '').trim();
      } else {
        _phoneNumber = raw;
      }
    }
    // Prefill mockup values 5 and 8 as shown in Figma design
    _controllers[0].text = '5';
    _controllers[1].text = '8';
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    final AuthController authController = Get.find<AuthController>();
    authController.login('+880 $_phoneNumber', '123456');
    Get.offAllNamed(AppRoutes.mainNav);
    Get.snackbar(
      'Verification Successful',
      'Welcome to Famous Gadget BD!',
      snackPosition: SnackPosition.TOP,
    );
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
                    'Verify Phone Number',
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
                padding: const EdgeInsets.all(AppSpacing.s24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.s8),

                      // Instructions Text matching Figma exactly
                      Text(
                        'We have sent a 4-digit verification code to +880',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: const Color(0xFF64748B),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _phoneNumber,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.navyDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s32),

                      // 4-Digit OTP Boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          final isCurrent = index == 2; // Active box with orange border as in Figma
                          return Container(
                            width: 54,
                            height: 54,
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: AppColors.cardWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCurrent ? AppColors.primaryOrange : const Color(0xFFE2E8F0),
                                width: isCurrent ? 2.0 : 1.2,
                              ),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: AppTextStyles.h2ProductTitle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navyDark,
                                ),
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 3) {
                                    _focusNodes[index + 1].requestFocus();
                                  } else if (value.isEmpty && index > 0) {
                                    _focusNodes[index - 1].requestFocus();
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: AppSpacing.s24),

                      // Resend Code Countdown
                      Text(
                        'Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                        style: AppTextStyles.caption.copyWith(
                          color: const Color(0xFF94A3B8),
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: _secondsRemaining == 0 ? _startTimer : null,
                        child: Text(
                          'Resend Code',
                          style: AppTextStyles.caption.copyWith(
                            color: _secondsRemaining == 0
                                ? AppColors.primaryOrange
                                : const Color(0xFFFDBA74),
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s32),

                      // Verify Button
                      CustomButton(
                        text: 'Verify',
                        height: 48,
                        onPressed: _onVerify,
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Change Phone Number
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          'Change Phone Number',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
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
