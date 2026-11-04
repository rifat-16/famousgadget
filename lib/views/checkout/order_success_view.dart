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
    final CheckoutController checkoutController = Get.find<CheckoutController>();
    final NavController navController = Get.find<NavController>();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Glowing Green Success Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0x1A16A34A),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.successGreen.withValues(alpha: 0.3), width: 3),
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
                        size: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.s24),

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
                  ),
                ),

                const SizedBox(height: AppSpacing.s24),

                // Dark Recapped Order Card
                if (order != null)
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
                              style: AppTextStyles.caption.copyWith(color: const Color(0xFF94A3B8)),
                            ),
                            Text(
                              '#FG-${order.orderId}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.cardWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: AppTextStyles.caption.copyWith(color: const Color(0xFF94A3B8)),
                            ),
                            Text(
                              CurrencyFormatter.format(order.totalAmount),
                              style: AppTextStyles.price(size: 15.0),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Method',
                              style: AppTextStyles.caption.copyWith(color: const Color(0xFF94A3B8)),
                            ),
                            Text(
                              'Cash on Delivery',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.cardWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Status',
                              style: AppTextStyles.caption.copyWith(color: const Color(0xFF94A3B8)),
                            ),
                            Text(
                              'Processing',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.amber,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: AppSpacing.s20),

                // Bullet steps as designed in Figma
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBulletItem('We call you to confirm order'),
                      const SizedBox(height: AppSpacing.s6),
                      _buildBulletItem('We pack and ship your gadget'),
                      const SizedBox(height: AppSpacing.s6),
                      _buildBulletItem('You pay on delivery (Dhaka/COD)'),
                    ],
                  ),
                ),

                const Spacer(),

                // Buttons
                CustomButton(
                  text: 'Continue Shopping',
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
                const SizedBox(height: AppSpacing.s12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      children: [
        const Text(
          '● ',
          style: TextStyle(color: AppColors.primaryOrange, fontSize: 10),
        ),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: const Color(0xFF94A3B8),
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}
