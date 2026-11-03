import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.put(CheckoutController());

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
        title: Text('Saved Addresses', style: AppTextStyles.h3Section),
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.s16),
          itemCount: checkoutController.addresses.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s12),
          itemBuilder: (context, index) {
            final address = checkoutController.addresses[index];
            return Container(
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
                        Row(
                          children: [
                            Text(
                              '${address.name} (${address.label})',
                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                            if (address.isDefault) ...[
                              const SizedBox(width: AppSpacing.s8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.softPeach,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'DEFAULT',
                                  style: AppTextStyles.badgeText.copyWith(
                                    color: AppColors.primaryOrange,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(address.phone, style: AppTextStyles.caption),
                        const SizedBox(height: 2),
                        Text(address.fullAddress, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
