import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
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
        backgroundColor: AppColors.pageBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Success Icon
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.successGreenLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.successGreen, width: 2),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.successGreen,
                    size: 52,
                  ),
                ),
                const SizedBox(height: AppSpacing.s24),

                Text(
                  'Order Placed Successfully!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 24),
                ),
                const SizedBox(height: AppSpacing.s8),

                if (order != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.softPeach,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Order ID: ${order.orderId}',
                      style: AppTextStyles.outfitTitleSmall.copyWith(
                        color: AppColors.primaryOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: AppSpacing.s16),

                Text(
                  'Thank you for shopping with Famous Gadget BD! Your items will be packed and delivered right to your door with Cash on Delivery.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),

                const SizedBox(height: AppSpacing.s24),

                // Order details recap
                if (order != null)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.s16),
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: AppRadius.radiusAll16,
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Payment Method', style: AppTextStyles.caption),
                            Text('Cash on Delivery',
                                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Deliver To', style: AppTextStyles.caption),
                            Text(
                              '${order.address.name} (${order.address.district})',
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount', style: AppTextStyles.caption),
                            Text(
                              '৳${order.totalAmount.toStringAsFixed(0)}',
                              style: AppTextStyles.price(size: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                const Spacer(),

                CustomButton(
                  text: 'Continue Shopping',
                  onPressed: () {
                    checkoutController.resetSteps();
                    navController.changeTab(0);
                    Get.offAllNamed(AppRoutes.mainNav);
                  },
                ),
                const SizedBox(height: AppSpacing.s16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
