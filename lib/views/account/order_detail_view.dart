import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/order_model.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController =
        Get.isRegistered<CheckoutController>()
            ? Get.find<CheckoutController>()
            : Get.put(CheckoutController());

    final OrderModel order = Get.arguments is OrderModel
        ? Get.arguments as OrderModel
        : (checkoutController.orders.isNotEmpty
            ? checkoutController.orders.first
            : OrderModel(
                orderId: 'FG-20240315',
                items: const [],
                subtotal: 28878.0,
                totalAmount: 28998.0,
                address: checkoutController.addresses.first,
                orderDate: DateTime(2024, 3, 15),
              ));

    final dateStr = _formatDate(order.orderDate);
    final statusColor = _getStatusColor(order.status);
    final statusBg = _getStatusBg(order.status);

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
          'Order #${order.orderId}',
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
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          children: [
            // 1. Status Banner Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Status',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 11.0,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        order.status == OrderStatus.processing
                            ? 'Order Confirmed'
                            : order.statusText,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navyDark,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      order.statusText,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),

            // 2. Delivery Tracking Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Tracking',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyDark,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimelineStep(
                        title: 'Ordered',
                        date: dateStr,
                        isDone: true,
                        isFirst: true,
                      ),
                      _buildTimelineStep(
                        title: 'Confirmed',
                        date: dateStr,
                        isDone: true,
                      ),
                      _buildTimelineStep(
                        title: 'Shipped',
                        date: order.status == OrderStatus.shipped ||
                                order.status == OrderStatus.delivered
                            ? dateStr
                            : 'Pending',
                        isDone: order.status == OrderStatus.shipped ||
                            order.status == OrderStatus.delivered,
                      ),
                      _buildTimelineStep(
                        title: 'Delivered',
                        date: order.status == OrderStatus.delivered
                            ? dateStr
                            : 'Pending',
                        isDone: order.status == OrderStatus.delivered,
                        isLast: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),

            // 3. Shipping Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipping Address',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyDark,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    order.address.name,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navyDark,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    order.address.fullAddress,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 13.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    order.address.phone,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      fontSize: 13.0,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Divider(
                    height: 1.0,
                    color: AppColors.borderLight.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Option',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 11.0,
                              color: AppColors.textMuted,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Standard Delivery',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.navyDark,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Payment Method',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 11.0,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            order.paymentMethod,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.navyDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),

            // 4. Items Ordered Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Items Ordered',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyDark,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  if (order.items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('No item details available.'),
                    )
                  else
                    ...order.items.map((item) {
                      final itemTotalStr = CurrencyFormatter.format(
                          item.product.price * item.quantity);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: AppColors.pageBackground,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                item.product.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.devices_other_rounded,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.navyDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    'Qty: ${item.quantity} • ${item.selectedColor}',
                                    style: const TextStyle(
                                      fontFamily: 'Geist',
                                      fontSize: 12.0,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              itemTotalStr,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String date,
    required bool isDone,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: isFirst
                    ? const SizedBox()
                    : Container(
                        height: 2.0,
                        color: isDone
                            ? AppColors.primaryOrange
                            : AppColors.borderLight,
                      ),
              ),
              Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.primaryOrange : AppColors.cardWhite,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone
                        ? AppColors.primaryOrange
                        : AppColors.borderLight,
                    width: 2.0,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check, size: 10.0, color: Colors.white)
                    : null,
              ),
              Expanded(
                child: isLast
                    ? const SizedBox()
                    : Container(
                        height: 2.0,
                        color: isDone
                            ? AppColors.primaryOrange
                            : AppColors.borderLight,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 12.0,
              fontWeight: isDone ? FontWeight.w700 : FontWeight.w500,
              color: isDone ? AppColors.navyDark : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            date,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 10.0,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final dayStr = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '${months[date.month - 1]} $dayStr, ${date.year}';
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return AppColors.primaryOrange;
      case OrderStatus.shipped:
        return const Color(0xFF7C3AED);
      case OrderStatus.delivered:
        return AppColors.successGreen;
      case OrderStatus.cancelled:
        return AppColors.dangerRed;
      case OrderStatus.pending:
        return AppColors.amber;
    }
  }

  Color _getStatusBg(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return AppColors.softPeach;
      case OrderStatus.shipped:
        return const Color(0xFFF3E8FF);
      case OrderStatus.delivered:
        return const Color(0xFFDCFCE7);
      case OrderStatus.cancelled:
        return const Color(0xFFFFE4E6);
      case OrderStatus.pending:
        return AppColors.amberLight;
    }
  }
}
