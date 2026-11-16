import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/address_model.dart';
import '../../routes/app_routes.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController =
        Get.isRegistered<CheckoutController>()
            ? Get.find<CheckoutController>()
            : Get.put(CheckoutController());

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Center(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                color: AppColors.pageBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20.0,
                color: AppColors.navyDark,
              ),
            ),
          ),
        ),
        title: Text(
          'My Addresses',
          style: AppTextStyles.h3Section.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: AppColors.navyDark,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.borderLight,
            height: 1.0,
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: Column(
            children: [
              ...checkoutController.addresses.map((address) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildAddressCard(context, address, checkoutController),
                );
              }),
              const SizedBox(height: 12.0),

              // Add New Address Button
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.addAddress),
                child: Container(
                  width: double.infinity,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(22.0),
                    border: Border.all(
                      color: AppColors.primaryOrange,
                      width: 1.0,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 18.0,
                        color: AppColors.primaryOrange,
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        'Add New Address',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAddressCard(
    BuildContext context,
    AddressModel address,
    CheckoutController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.borderLight.withValues(alpha: 0.6),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060B1220),
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title, Default Badge, and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${address.name} (${address.label})',
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyDark,
                    ),
                  ),
                  if (address.isDefault) ...[
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softPeach,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Text(
                        'DEFAULT',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 9.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.addAddress, arguments: address);
                    },
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 18.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  GestureDetector(
                    onTap: () {
                      controller.deleteAddress(address.id);
                      Get.snackbar(
                        'Address Deleted',
                        '${address.label} address has been removed.',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      size: 18.0,
                      color: AppColors.dangerRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Divider(
            height: 1.0,
            color: AppColors.borderLight.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 12.0),

          // Bottom: Phone and Full Address
          Text(
            address.phone,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 13.0,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            address.fullAddress,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 13.0,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
