import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

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
                        const SizedBox(height: AppSpacing.s16),

                        // Glowing Green Success Icon (matching Figma)
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0x1A16A34A),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.successGreen.withValues(alpha: 0.3),
                              width: 2.5,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: const BoxDecoration(
                                color: Color(0x3316A34A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: AppColors.successGreen,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s20),

                        Text(
                          'Order Placed Successfully!',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2ProductTitle.copyWith(
                            color: AppColors.cardWhite,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s8),

                        Text(
                          'We will call you shortly to confirm your delivery address.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyRegular.copyWith(
                            color: const Color(0xFF94A3B8),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.s20),

                        // Dark Recapped Order Card (matching Figma)
                        Container(
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

                        const SizedBox(height: AppSpacing.s20),

                        // Bullet steps as designed in Figma
                        Padding(
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

                        const Spacer(),
                        const SizedBox(height: AppSpacing.s20),

                        // Action Buttons
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
                        SizedBox(
                          width: double.infinity,
                          height: 52.0,
                          child: OutlinedButton(
                            onPressed: () {
                              checkoutController.resetSteps();
                              Get.offNamed(AppRoutes.orders);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF334155), width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
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
