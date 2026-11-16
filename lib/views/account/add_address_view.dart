import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../models/address_model.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final CheckoutController _checkoutController =
      Get.isRegistered<CheckoutController>()
          ? Get.find<CheckoutController>()
          : Get.put(CheckoutController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();

  final List<String> _districts = [
    'Uttara',
    'Banani',
    'Gulshan',
    'Dhanmondi',
    'Mirpur',
    'Mohammadpur',
    'Badda',
  ];
  String _selectedDistrict = 'Uttara';
  bool _isDefault = true;

  @override
  void initState() {
    super.initState();
    if (Get.arguments is AddressModel) {
      final addr = Get.arguments as AddressModel;
      _nameController.text = addr.name;
      _phoneController.text = addr.phone;
      _streetController.text = addr.street;
      _cityController.text = addr.city;
      if (_districts.contains(addr.district)) {
        _selectedDistrict = addr.district;
      }
      _isDefault = addr.isDefault;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    super.dispose();
  }

  void _onSave() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final street = _streetController.text.trim();
    final city = _cityController.text.trim();

    if (name.isEmpty || phone.isEmpty || street.isEmpty) {
      Get.snackbar(
        'Required Fields',
        'Please enter Name, Phone and Street Address.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    _checkoutController.addAddress(
      name: name,
      phone: phone,
      street: street,
      city: city.isNotEmpty ? city : 'Dhaka',
      district: _selectedDistrict,
      label: 'Home',
    );

    if (_isDefault && _checkoutController.addresses.isNotEmpty) {
      _checkoutController
          .setDefaultAddress(_checkoutController.addresses.last.id);
    }

    Get.snackbar(
      'Address Saved',
      'Delivery address has been added successfully.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.navyDark,
      colorText: Colors.white,
      margin: const EdgeInsets.all(AppSpacing.s16),
      borderRadius: 16.0,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Add New Address',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name
            _buildField(
              label: 'Full Name',
              controller: _nameController,
              hint: 'Enter full name',
            ),
            const SizedBox(height: 16.0),

            // Phone Number
            _buildField(
              label: 'Phone Number',
              controller: _phoneController,
              hint: 'Enter phone number (+880 1XXXXXXXXX)',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),

            // Email (Optional)
            _buildField(
              label: 'Email (Optional)',
              controller: _emailController,
              hint: 'Enter email address (e.g. name@example.com)',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),

            // Street Address
            _buildField(
              label: 'Street Address',
              controller: _streetController,
              hint: 'House/Flat No, Road Name, Area',
              maxLines: 2,
              height: 64.0,
            ),
            const SizedBox(height: 16.0),

            // City & Postcode
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    label: 'City',
                    controller: _cityController,
                    hint: 'Enter city (e.g. Dhaka)',
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: _buildField(
                    label: 'Postcode',
                    controller: _postcodeController,
                    hint: 'Enter postcode (e.g. 1230)',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // District / Zone Dropdown
            const Text(
              'District / Zone',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: AppColors.navyDark,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 48.0,
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: AppColors.borderLight),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedDistrict,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.navyDark,
                  ),
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.navyDark,
                  ),
                  items: _districts.map((d) {
                    return DropdownMenuItem<String>(
                      value: d,
                      child: Text(d),
                    );
                  }).toList(),
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
            const SizedBox(height: 16.0),

            // Set as default address toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Set as default address',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navyDark,
                  ),
                ),
                Switch(
                  value: _isDefault,
                  onChanged: (val) {
                    setState(() => _isDefault = val);
                  },
                  activeThumbColor: AppColors.primaryOrange,
                  activeTrackColor: AppColors.softPeach,
                ),
              ],
            ),
            const SizedBox(height: 28.0),

            // Save Address Button
            GestureDetector(
              onTap: _onSave,
              child: Container(
                width: double.infinity,
                height: 52.0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(26.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33FF6A00),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Save Address',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    double height = 48.0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.borderLight),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: AppColors.navyDark,
            ),
            cursorColor: AppColors.primaryOrange,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 14.0,
                color: Color(0xFF9CA3AF),
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: maxLines > 1
                  ? const EdgeInsets.symmetric(vertical: 12.0)
                  : EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
