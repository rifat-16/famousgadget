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
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController(text: 'Dhaka');
  final _districtController = TextEditingController(text: 'Uttara');
  bool _showNewAddressForm = false;

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
        title: Text('Checkout', style: AppTextStyles.h3Section),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Step Indicator as designed in Figma
            _buildStepIndicator(activeStep: 1),
            const SizedBox(height: AppSpacing.s24),

            // 2. Deliver To Section
            Text('Deliver To', style: AppTextStyles.h3Section.copyWith(fontSize: 16)),
            const SizedBox(height: AppSpacing.s12),

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
                      padding: const EdgeInsets.all(AppSpacing.s16),
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
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_off_rounded,
                            color: isSelected
                                ? AppColors.primaryOrange
                                : AppColors.textDisabled,
                            size: 20,
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
                                      ),
                                    ),
                                    if (address.isDefault) ...[
                                      const SizedBox(width: AppSpacing.s8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
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
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.s4),
                                Text(address.phone, style: AppTextStyles.caption),
                                const SizedBox(height: AppSpacing.s4),
                                Text(address.fullAddress,
                                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
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

            // Add New Address Toggle
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _showNewAddressForm = !_showNewAddressForm;
                });
              },
              icon: Icon(
                _showNewAddressForm ? Icons.remove_rounded : Icons.add_rounded,
                color: AppColors.primaryOrange,
                size: 18,
              ),
              label: Text(
                _showNewAddressForm ? 'Hide Form' : 'Add New Address',
                style: AppTextStyles.secondaryOutlineButton.copyWith(fontSize: 13),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
                side: const BorderSide(color: AppColors.primaryOrange),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.radiusAll12,
                ),
              ),
            ),

            // New Address Form
            if (_showNewAddressForm) ...[
              const SizedBox(height: AppSpacing.s20),
              Text('New Address Details', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
              const SizedBox(height: AppSpacing.s12),
              Container(
                padding: const EdgeInsets.all(AppSpacing.s16),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: AppRadius.radiusAll16,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    _buildTextField('Full Name', _nameController, 'e.g. Arif Rahman'),
                    const SizedBox(height: AppSpacing.s12),
                    _buildTextField('Phone Number', _phoneController, '+880 1XXXXXXXXX'),
                    const SizedBox(height: AppSpacing.s12),
                    _buildTextField('Email Address', _emailController, 'arif@gmail.com'),
                    const SizedBox(height: AppSpacing.s12),
                    _buildTextField(
                      'Street Address',
                      _streetController,
                      'House/Flat No, Road Name, Area',
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('City', _cityController, 'Dhaka'),
                        ),
                        const SizedBox(width: AppSpacing.s12),
                        Expanded(
                          child: _buildTextField('District/Zone', _districtController, 'Uttara'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    CustomButton(
                      text: 'Save & Use Address',
                      height: 44,
                      onPressed: () {
                        if (_nameController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty &&
                            _streetController.text.isNotEmpty) {
                          checkoutController.addAddress(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            street: _streetController.text,
                            city: _cityController.text,
                            district: _districtController.text,
                          );
                          setState(() {
                            _showNewAddressForm = false;
                          });
                        } else {
                          Get.snackbar('Incomplete', 'Please fill in name, phone, and street address.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.s32),

            // Proceed Button
            CustomButton(
              text: 'Proceed to Confirm',
              onPressed: () {
                if (checkoutController.selectedAddress.value != null) {
                  Get.toNamed(AppRoutes.checkoutConfirm);
                } else {
                  Get.snackbar('Select Address', 'Please select a delivery address to proceed.');
                }
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
        _buildStepItem(stepNum: '1', title: 'Delivery', isActive: activeStep >= 1),
        _buildStepLine(isActive: activeStep >= 2),
        _buildStepItem(stepNum: '2', title: 'Confirm', isActive: activeStep >= 2),
        _buildStepLine(isActive: activeStep >= 3),
        _buildStepItem(stepNum: '3', title: 'Done', isActive: activeStep >= 3),
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

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: AppRadius.radiusAll8,
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.caption,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
