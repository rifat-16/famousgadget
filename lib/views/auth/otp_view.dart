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
        _phoneNumber = raw.trim();
      }
    }

    // Add listeners to focus nodes so active orange border dynamically tracks user focus
    for (var f in _focusNodes) {
      f.addListener(() {
        if (mounted) setState(() {});
      });
    }

    // Post-frame request focus on the first digit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
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
      backgroundColor: AppColors.navyDark,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 16.0,
    );
  }

  void _onResend() {
    if (_secondsRemaining == 0) {
      _startTimer();
      Get.snackbar(
        'Code Resent',
        'A new verification code has been sent to +880 $_phoneNumber',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.navyDark,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16.0),
        borderRadius: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyDark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Dark Header Section (height: 204px per Figma hero-banner-container)
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.s20, AppSpacing.s16, AppSpacing.s20, 0),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s12),
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
                  const SizedBox(height: 32.0), // Spacing before curved sheet
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
                padding: const EdgeInsets.fromLTRB(AppSpacing.s24, 28.0, AppSpacing.s24, AppSpacing.s32),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Instructions Text matching Figma exactly
                      Text(
                        'We have sent a 4-digit verification code to',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: const Color(0xFF64748B),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '+880 $_phoneNumber',
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
                          final isFocused = _focusNodes[index].hasFocus;
                          return Focus(
                            onKeyEvent: (node, event) {
                              if (event is KeyDownEvent &&
                                  event.logicalKey == LogicalKeyboardKey.backspace) {
                                if (_controllers[index].text.isEmpty && index > 0) {
                                  _controllers[index - 1].clear();
                                  _focusNodes[index - 1].requestFocus();
                                  setState(() {});
                                  return KeyEventResult.handled;
                                }
                              }
                              return KeyEventResult.ignored;
                            },
                            child: Container(
                              width: 54,
                              height: 54,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: AppColors.cardWhite,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isFocused
                                      ? AppColors.primaryOrange
                                      : const Color(0xFFE2E8F0),
                                  width: isFocused ? 2.0 : 1.2,
                                ),
                                boxShadow: isFocused
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primaryOrange.withValues(alpha: 0.15),
                                          blurRadius: 8.0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: TextField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.primaryOrange,
                                  style: AppTextStyles.h2ProductTitle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.navyDark,
                                  ),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: '•',
                                    hintStyle: AppTextStyles.h2ProductTitle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFCBD5E1),
                                    ),
                                  ),
                                  onTap: () {
                                    // Move cursor to the end
                                    _controllers[index].selection = TextSelection.fromPosition(
                                      TextPosition(offset: _controllers[index].text.length),
                                    );
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      // If user typed multiple digits, take the last one
                                      if (value.length > 1) {
                                        _controllers[index].text = value.substring(value.length - 1);
                                      }
                                      if (index < 3) {
                                        _focusNodes[index + 1].requestFocus();
                                      } else {
                                        _focusNodes[index].unfocus();
                                      }
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 28.0),

                      // Resend Code Section
                      if (_secondsRemaining > 0) ...[
                        Text(
                          'Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                          style: AppTextStyles.caption.copyWith(
                            color: const Color(0xFF94A3B8),
                            fontSize: 12.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Resend Code',
                          style: AppTextStyles.caption.copyWith(
                            color: const Color(0xFFFDBA74),
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                      ] else ...[
                        Text(
                          "Didn't receive code?",
                          style: AppTextStyles.caption.copyWith(
                            color: const Color(0xFF94A3B8),
                            fontSize: 12.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: _onResend,
                          child: Text(
                            'Resend Code',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 32.0),

                      // Verify Button (height: 52px per Figma premium-button)
                      SizedBox(
                        width: double.infinity,
                        height: 52.0,
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
                              onTap: _onVerify,
                              child: const Center(
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24.0),

                      // Change Phone Number
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          'Change Phone Number',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
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
