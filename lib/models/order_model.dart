import 'cart_item_model.dart';
import 'address_model.dart';

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class OrderModel {
  final String orderId;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;
  final OrderStatus status;
  final AddressModel address;
  final DateTime orderDate;
  final String paymentMethod;

  const OrderModel({
    required this.orderId,
    required this.items,
    required this.subtotal,
    this.deliveryFee = 100.0,
    required this.totalAmount,
    this.status = OrderStatus.processing,
    required this.address,
    required this.orderDate,
    this.paymentMethod = 'Cash on Delivery',
  });

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
