import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../core/animations/animations.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView> with SingleTickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkScaleAnimation;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _checkScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );

    _checkController.forward();
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.isRegistered<CheckoutController>()
        ? Get.find<CheckoutController>()
        : Get.put(CheckoutController());
    final NavController navController = Get.isRegistered<NavController>()
        ? Get.find<NavController>()
        : Get.put(NavController());
    final order = checkoutController.latestOrder.value;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          navController.changeTab(0);
          Get.offAllNamed(AppRoutes.mainNav);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.navyDark,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s24,
                  vertical: AppSpacing.s16,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.s24),

                        // Animated Glowing Green Success Icon with Spring Pop & Pulse
                        Center(
                          child: PulseGlow(
                            minScale: 0.95,
                            maxScale: 1.05,
                            duration: const Duration(milliseconds: 1500),
                            child: ScaleTransition(
                              scale: _checkScaleAnimation,
                              child: Container(
                                width: 88,
                                height: 88,
                                decoration: BoxDecoration(
                                  color: const Color(0x1A16A34A),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.successGreen.withValues(alpha: 0.35),
                                    width: 2.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.successGreen.withValues(alpha: 0.25),
                                      blurRadius: 24,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: const BoxDecoration(
                                      color: Color(0x3316A34A),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: AppColors.successGreen,
                                      size: 34,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),

                        FadeSlideIn(
                          delay: const Duration(milliseconds: 250),
                          child: Text(
                            'Order Placed Successfully!',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h2ProductTitle.copyWith(
                              color: AppColors.cardWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s8),

                        FadeSlideIn(
                          delay: const Duration(milliseconds: 350),
                          child: Text(
                            'We will call you shortly to confirm your delivery address.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: const Color(0xFF94A3B8),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.s20),

                        // Dark Recapped Order Card with staggered fade-slide
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 450),
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.s16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF131D2E),
                              borderRadius: AppRadius.radiusAll16,
                              border: Border.all(color: const Color(0xFF1E293B)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order Number',
                                      style: AppTextStyles.caption.copyWith(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      order != null ? '#FG-${order.orderId}' : '#FG-20240315',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.cardWhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.s12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: AppTextStyles.caption.copyWith(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      order != null
                                          ? CurrencyFormatter.format(order.totalAmount)
                                          : '৳26,118',
                                      style: AppTextStyles.price(size: 15.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.s12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payment Method',
                                      style: AppTextStyles.caption.copyWith(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      order?.paymentMethod ?? 'Cash on Delivery',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.cardWhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.s12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order Status',
                                      style: AppTextStyles.caption.copyWith(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0x26F59E0B),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Processing',
                                        style: AppTextStyles.badgeText.copyWith(
                                          color: const Color(0xFFF59E0B),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.s20),

                        // Bullet steps as designed in Figma
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 550),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
                            child: Column(
                              children: [
                                _buildBulletItem('We call you to confirm order'),
                                const SizedBox(height: AppSpacing.s10),
                                _buildBulletItem('We pack and ship your gadget'),
                                const SizedBox(height: AppSpacing.s10),
                                _buildBulletItem('You pay on delivery (Dhaka/COD)'),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),
                        const SizedBox(height: AppSpacing.s20),

                        // Action Buttons with staggered entrance
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 650),
                          child: Column(
                            children: [
                              CustomButton(
                                text: 'Continue Shopping',
                                height: 52,
                                hasShadow: false,
                                onPressed: () {
                                  checkoutController.resetSteps();
                                  navController.changeTab(0);
                                  Get.offAllNamed(AppRoutes.mainNav);
                                },
                              ),
                              const SizedBox(height: AppSpacing.s12),
                              Bounceable(
                                onTap: () {
                                  checkoutController.resetSteps();
                                  Get.offNamed(AppRoutes.orders);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 52.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFF334155), width: 1.5),
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'View My Orders',
                                    style: AppTextStyles.outfitTitleSmall.copyWith(
                                      color: AppColors.cardWhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s8),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.primaryOrange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: const Color(0xFF94A3B8),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
