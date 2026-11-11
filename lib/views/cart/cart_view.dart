import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    final TextEditingController promoController = TextEditingController();
    final NavController navController = Get.isRegistered<NavController>()
        ? Get.find<NavController>()
        : Get.put(NavController());

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Obx(
          () => Text(
            'My Cart (${cartController.totalItemCount} Items)',
            style: AppTextStyles.h2ProductTitle.copyWith(fontSize: 20),
          ),
        ),
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                child: Column(
                  children: [
                    const SizedBox(height: 32.0),
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: const BoxDecoration(
                        color: AppColors.softPeach,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.string(
                        '''<svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#FF6A00" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="9" cy="21" r="1"></circle>
  <circle cx="20" cy="21" r="1"></circle>
  <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
</svg>''',
                        width: 48.0,
                        height: 48.0,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'Your Cart is Empty',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h2ProductTitle.copyWith(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Looks like you haven\'t added any gadgets yet.\nExplore our latest collection now!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyRegular.copyWith(
                        fontSize: 13.0,
                        height: 1.45,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    CustomButton(
                      text: 'Start Shopping',
                      width: 220.0,
                      height: 52.0,
                      hasShadow: false,
                      onPressed: () => navController.changeTab(0),
                    ),
                    const SizedBox(height: 120.0),
                  ],
                ),
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s16,
            AppSpacing.s16,
            AppSpacing.s16,
            120.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cart Items List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartController.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s12),
                itemBuilder: (context, index) {
                  final cartItem = cartController.items[index];
                  return Container(
                    padding: const EdgeInsets.all(AppSpacing.s12),
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: AppRadius.radiusAll20,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x050B1220),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: AppRadius.radiusAll12,
                          child: Container(
                            width: 80,
                            height: 80,
                            color: AppColors.pageBackground,
                            child: Image.network(
                              cartItem.product.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.devices, color: AppColors.textMuted),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s12),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.outfitTitleSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.s4),
                              Text(
                                cartItem.selectedColor,
                                style: AppTextStyles.caption,
                              ),
                              const SizedBox(height: AppSpacing.s8),

                              // Quantity & Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Quantity Counter
                                  Container(
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.pageBackground,
                                      borderRadius: BorderRadius.circular(AppRadius.r14),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => cartController.decrementQuantity(index),
                                          child: const Text(
                                            '-',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.navyDark,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            '${cartItem.quantity}',
                                            style: AppTextStyles.small.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.navyDark,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => cartController.incrementQuantity(index),
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.navyDark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Price
                                  Text(
                                    CurrencyFormatter.format(cartItem.totalPrice),
                                    style: AppTextStyles.price(size: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: AppSpacing.s16),

              // 2. Promo Code Box
              Container(
                padding: const EdgeInsets.all(AppSpacing.s8),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: AppRadius.radiusAll20,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.s12),
                        child: TextField(
                          controller: promoController,
                          decoration: InputDecoration(
                            hintText: 'Enter Promo Code (DEVNIQ)',
                            hintStyle: AppTextStyles.caption.copyWith(fontSize: 13),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => cartController.applyPromoCode(promoController.text),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.navyDark,
                          borderRadius: BorderRadius.circular(AppRadius.r14),
                        ),
                        child: Text(
                          'Apply',
                          style: AppTextStyles.outfitTitleSmall.copyWith(
                            color: AppColors.cardWhite,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.s16),

              // 3. Order Summary Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.s16),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: AppRadius.radiusAll20,
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Summary', style: AppTextStyles.h3Section.copyWith(fontSize: 15)),
                    const SizedBox(height: AppSpacing.s12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: AppTextStyles.caption.copyWith(fontSize: 13)),
                        Text(
                          CurrencyFormatter.format(cartController.subtotal),
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping (Cash on Delivery)',
                            style: AppTextStyles.caption.copyWith(fontSize: 13)),
                        Text(
                          CurrencyFormatter.format(cartController.deliveryFee.value),
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (cartController.discount.value > 0) ...[
                      const SizedBox(height: AppSpacing.s8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Promo Discount',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 13,
                                color: AppColors.successGreen,
                              )),
                          Text(
                            '-${CurrencyFormatter.format(cartController.discount.value)}',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.successGreen,
                            ),
                          ),
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
                        Text('Total', style: AppTextStyles.h3Section.copyWith(fontSize: 16)),
                        Text(
                          CurrencyFormatter.format(cartController.total),
                          style: AppTextStyles.price(size: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.s20),

              // 4. Checkout Button
              CustomButton(
                text: 'Checkout (Cash on Delivery)',
                onPressed: () {
                  Get.toNamed(AppRoutes.checkoutDelivery);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
