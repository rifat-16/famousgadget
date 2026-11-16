import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkout_controller.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/currency_formatter.dart';
import '../../models/order_model.dart';
import '../../routes/app_routes.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final List<String> _tabs = [
    'All',
    'Processing',
    'Shipping',
    'Delivered',
    'Cancelled'
  ];
  String _selectedTab = 'All';

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
          'My Orders',
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
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 56.0,
            color: AppColors.cardWhite,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final tab = _tabs[index];
                final isSelected = tab == _selectedTab;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = tab;
                    });
                  },
                  child: Container(
                    height: 32.0,
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryOrange
                          : AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      border: isSelected
                          ? null
                          : Border.all(color: AppColors.borderLight),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tab,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 13.0,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textMuted,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Orders List
          Expanded(
            child: Obx(() {
              final allOrders = checkoutController.orders;
              final filteredOrders = _selectedTab == 'All'
                  ? allOrders
                  : allOrders
                      .where((o) =>
                          o.statusText.toLowerCase() ==
                          _selectedTab.toLowerCase())
                      .toList();

              if (filteredOrders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: const BoxDecoration(
                          color: AppColors.softPeach,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          size: 40.0,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s16),
                      Text('No $_selectedTab Orders', style: AppTextStyles.h3Section),
                      const SizedBox(height: AppSpacing.s8),
                      Text(
                        'You don\'t have any orders in this category.',
                        style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.s16),
                itemCount: filteredOrders.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s12),
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return _buildOrderCard(order);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    final statusColor = _getStatusColor(order.status);
    final statusBg = _getStatusBg(order.status);
    final dateStr = _formatDate(order.orderDate);
    final itemCountStr =
        '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}';
    final amountStr = CurrencyFormatter.format(order.totalAmount);

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.orderDetail, arguments: order);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.6)),
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
          children: [
            // Top Row: ID and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${order.orderId}',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navyDark,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
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
            const SizedBox(height: 12.0),
            Divider(
              height: 1.0,
              color: AppColors.borderLight.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 12.0),

            // Bottom Row: Date/Count and Total Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Placed on $dateStr',
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 12.0,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      itemCountStr,
                      style: const TextStyle(
                        fontFamily: 'Geist',
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
                      'Total Amount',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        fontSize: 11.0,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      amountStr,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
