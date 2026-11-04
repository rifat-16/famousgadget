import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/custom_badge.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class CheckoutConfirmView extends StatelessWidget {
  const CheckoutConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.find<CheckoutController>();
    final CartController cartController = Get.find<CartController>();

    final selectedAddress = checkoutController.selectedAddress.value!;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navyDark),
          onPressed: () => Get.back(),
        ),
        title: Text('Order Confirmation', style: AppTextStyles.h3Section),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Step Indicator
            _buildStepIndicator(activeStep: 2),
            const SizedBox(height: AppSpacing.s24),

            // 2. Delivery Address Review
            Text('Delivery Destination', style: AppTextStyles.h3Section.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.s12),
            Container(
              padding: const EdgeInsets.all(AppSpacing.s16),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: AppRadius.radiusAll16,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.primaryOrange, size: 28),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${selectedAddress.name} (${selectedAddress.label})',
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(selectedAddress.phone, style: AppTextStyles.caption),
                        const SizedBox(height: 2),
                        Text(selectedAddress.fullAddress, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Change', style: AppTextStyles.small.copyWith(color: AppColors.primaryOrange)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s20),

            // 3. Payment Method Card
            Text('Payment Method', style: AppTextStyles.h3Section.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.s12),
            Container(
              padding: const EdgeInsets.all(AppSpacing.s16),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: AppRadius.radiusAll16,
                border: Border.all(color: AppColors.primaryOrange, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.softPeach,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.payments_rounded, color: AppColors.primaryOrange, size: 24),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cash on Delivery (COD)',
                            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text('Pay securely with cash upon delivery', style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  CustomBadge.cod(text: 'ACTIVE'),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s20),

            // 4. Items Review
            Text('Order Items (${cartController.items.length})',
                style: AppTextStyles.h3Section.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.s12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartController.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s8),
              itemBuilder: (context, index) {
                final item = cartController.items[index];
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.s12),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: AppRadius.radiusAll12,
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 50,
                          height: 50,
                          color: AppColors.pageBackground,
                          child: Image.network(
                            item.product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.devices, size: 24, color: AppColors.textMuted),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text('Qty: ${item.quantity} · ${item.selectedColor}',
                                style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(item.totalPrice),
                        style: AppTextStyles.price(size: 14.0),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.s20),

            // 5. Amount Summary
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
                      Text('Subtotal', style: AppTextStyles.caption),
                      Text(CurrencyFormatter.format(cartController.subtotal),
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee (COD)', style: AppTextStyles.caption),
                      Text(CurrencyFormatter.format(cartController.deliveryFee),
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  if (cartController.discount.value > 0) ...[
                    const SizedBox(height: AppSpacing.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Promo Discount',
                            style: AppTextStyles.caption.copyWith(color: AppColors.successGreen)),
                        Text('-${CurrencyFormatter.format(cartController.discount.value)}',
                            style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.successGreen, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.s12),
                    child: Divider(color: AppColors.borderLight, height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount', style: AppTextStyles.h3Section.copyWith(fontSize: 16)),
                      Text(
                        CurrencyFormatter.format(cartController.total),
                        style: AppTextStyles.price(size: 20.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.s24),

            // Confirm Button
            CustomButton(
              text: 'Place Order',
              onPressed: () {
                checkoutController.placeOrder(cartController);
                Get.offNamed(AppRoutes.orderSuccess);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator({required int activeStep}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepItem(stepNum: '✓', title: 'Delivery', isActive: true),
        _buildStepLine(isActive: true),
        _buildStepItem(stepNum: '2', title: 'Confirm', isActive: true),
        _buildStepLine(isActive: false),
        _buildStepItem(stepNum: '3', title: 'Done', isActive: false),
      ],
    );
  }

  Widget _buildStepItem({
    required String stepNum,
    required String title,
    required bool isActive,
  }) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryOrange : AppColors.buttonDisabled,
            shape: BoxShape.circle,
          ),
          child: Text(
            stepNum,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? AppColors.navyDark : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine({required bool isActive}) {
    return Container(
      width: 28,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: isActive ? AppColors.primaryOrange : AppColors.borderLight,
    );
  }
}
