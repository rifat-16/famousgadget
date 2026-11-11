import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class CheckoutDeliveryView extends StatefulWidget {
  const CheckoutDeliveryView({super.key});

  @override
  State<CheckoutDeliveryView> createState() => _CheckoutDeliveryViewState();
}

class _CheckoutDeliveryViewState extends State<CheckoutDeliveryView> {
  final _nameController = TextEditingController(text: 'Arif Rahman');
  final _phoneController = TextEditingController(text: '+880 1712 345678');
  final _emailController = TextEditingController(text: 'arif@gmail.com');
  final _streetController = TextEditingController(text: 'House 24, Road 5, Sector 3, Uttara, Dhaka');
  final _cityController = TextEditingController(text: 'Dhaka');
  String _selectedDistrict = 'Uttara';

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.isRegistered<CheckoutController>()
        ? Get.find<CheckoutController>()
        : Get.put(CheckoutController());

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
        title: Text(
          'Checkout',
          style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s12,
          AppSpacing.s16,
          AppSpacing.s24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Step Indicator as designed in Figma
            _buildStepIndicator(activeStep: 1),
            const SizedBox(height: AppSpacing.s20),

            // 2. Deliver To Section
            Text(
              'DELIVER TO',
              style: AppTextStyles.outfitTitleSmall.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: AppColors.navyDark,
              ),
            ),
            const SizedBox(height: AppSpacing.s10),

            // Saved Addresses
            Obx(
              () => Column(
                children: checkoutController.addresses.map((address) {
                  final isSelected =
                      checkoutController.selectedAddress.value?.id == address.id;
                  return GestureDetector(
                    onTap: () => checkoutController.selectAddress(address),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.s12),
                      padding: const EdgeInsets.all(AppSpacing.s14),
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
                        borderRadius: AppRadius.radiusAll16,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryOrange
                              : AppColors.borderLight,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryOrange
                                      : AppColors.borderLight,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: isSelected
                                  ? Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryOrange,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${address.name} (${address.label})',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.navyDark,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (address.isDefault)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.softPeach,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'DEFAULT',
                                          style: AppTextStyles.badgeText.copyWith(
                                            color: AppColors.primaryOrange,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  address.phone,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textMuted,
                                    fontSize: 12.5,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  address.fullAddress,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 13,
                                    color: AppColors.navyDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Add New Address Button (matching Figma dashed outline)
            GestureDetector(
              onTap: () {
                _nameController.clear();
                _phoneController.clear();
                _streetController.clear();
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0x08FF6A00),
                  borderRadius: AppRadius.radiusAll12,
                  border: Border.all(
                    color: AppColors.primaryOrange.withValues(alpha: 0.6),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      color: AppColors.primaryOrange,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Add New Address',
                      style: AppTextStyles.outfitTitleSmall.copyWith(
                        color: AppColors.primaryOrange,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.s20),

            // 3. New Address Form (as displayed in Figma)
            Text(
              'NEW ADDRESS FORM',
              style: AppTextStyles.outfitTitleSmall.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: AppColors.navyDark,
              ),
            ),
            const SizedBox(height: AppSpacing.s10),

            _buildTextField(
              label: 'Full Name',
              controller: _nameController,
              hint: 'Arif Rahman',
            ),
            const SizedBox(height: AppSpacing.s12),

            _buildTextField(
              label: 'Phone Number',
              controller: _phoneController,
              hint: '+880 1XXXXXXXXX',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.s12),

            _buildTextField(
              label: 'Email Address',
              controller: _emailController,
              hint: 'arif@gmail.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppSpacing.s12),

            _buildTextField(
              label: 'Street Address',
              controller: _streetController,
              hint: 'House/Flat No, Road Name, Area',
            ),
            const SizedBox(height: AppSpacing.s12),

            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'City',
                    controller: _cityController,
                    hint: 'Dhaka',
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'District/Zone',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.navyDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: AppRadius.radiusAll12,
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDistrict,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.textMuted,
                              size: 20,
                            ),
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 13,
                              color: AppColors.navyDark,
                            ),
                            items: const [
                              DropdownMenuItem(value: 'Uttara', child: Text('Uttara')),
                              DropdownMenuItem(value: 'Gulshan', child: Text('Gulshan')),
                              DropdownMenuItem(value: 'Banani', child: Text('Banani')),
                              DropdownMenuItem(value: 'Dhanmondi', child: Text('Dhanmondi')),
                              DropdownMenuItem(value: 'Mirpur', child: Text('Mirpur')),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedDistrict = val;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s16),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s12,
          AppSpacing.s16,
          AppSpacing.s16,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: CustomButton(
            text: 'Continue to Confirmation',
            height: 52,
            hasShadow: false,
            onPressed: () {
              if (checkoutController.selectedAddress.value != null) {
                Get.toNamed(AppRoutes.checkoutConfirm);
              } else {
                Get.snackbar('Select Address', 'Please select a delivery address to proceed.');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator({required int activeStep}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepItem(stepNum: '1', title: 'Delivery', isActive: activeStep >= 1),
          _buildStepLine(isActive: activeStep >= 2),
          _buildStepItem(stepNum: '2', title: 'Confirm', isActive: activeStep >= 2),
          _buildStepLine(isActive: activeStep >= 3),
          _buildStepItem(stepNum: '3', title: 'Done', isActive: activeStep >= 3),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required String stepNum,
    required String title,
    required bool isActive,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryOrange : const Color(0xFFE2E8F0),
            shape: BoxShape.circle,
          ),
          child: Text(
            stepNum,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? AppColors.primaryOrange : const Color(0xFF94A3B8),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine({required bool isActive}) {
    return Container(
      width: 32,
      height: 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: isActive ? AppColors.primaryOrange : const Color(0xFFE2E8F0),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: AppRadius.radiusAll12,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 13,
              color: AppColors.navyDark,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.caption.copyWith(
                color: AppColors.textMuted,
                fontSize: 13,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
