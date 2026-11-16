import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/animations/animations.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  Timer? _delayTimer;
  Timer? _stepTimer;
  bool _isNavigated = false;

  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _logoController.forward();
    _startLoading();
  }

  void _startLoading() {
    _delayTimer?.cancel();
    _stepTimer?.cancel();

    // Smooth single-run timer from 0% to 100%
    _delayTimer = Timer(const Duration(milliseconds: 350), () {
      if (!mounted || _isNavigated) return;

      const int totalSteps = 100;
      const Duration stepDuration = Duration(milliseconds: 28);
      int currentStep = 0;

      _stepTimer = Timer.periodic(stepDuration, (timer) {
        if (!mounted || _isNavigated) {
          timer.cancel();
          return;
        }

        currentStep++;
        setState(() {
          _progress = currentStep / totalSteps;
        });

        if (currentStep >= totalSteps) {
          timer.cancel();
          _isNavigated = true;
          Get.offAllNamed(AppRoutes.mainNav);
        }
      });
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _stepTimer?.cancel();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (_progress * 100).toInt().clamp(0, 100);

    return Scaffold(
      backgroundColor: AppColors.navyDark,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Splash Center: Animated Logo and Tagline
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: SvgPicture.asset(
                        AppAssets.logoWhite,
                        height: 48.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeSlideIn(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 600),
                    distance: 16,
                    child: Text(
                      'Gadgets you love.\nCash on Delivery BD.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 14.0,
                        color: AppColors.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Splash Bottom: Progress Bar and Version Info
            FadeSlideIn(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
              distance: 12,
              child: Column(
                children: [
                  // Progress Bar Container
                  Container(
                    width: 160,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 28),
                        width: 160 * _progress,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            if (_progress > 0.02)
                              BoxShadow(
                                color: AppColors.primaryOrange.withValues(alpha: 0.7),
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Live Percentage Display
                  Text(
                    '$percentage%',
                    style: AppTextStyles.small.copyWith(
                      color: percentage == 100
                          ? AppColors.primaryOrange
                          : AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Version 4.2.1',
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.textMuted.withValues(alpha: 0.6),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
