import 'package:get/get.dart';
import '../data/mock_database.dart';
import '../models/address_model.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  final RxInt currentStep = 0.obs; // 0: Delivery, 1: Confirm, 2: Done
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final Rxn<AddressModel> selectedAddress = Rxn<AddressModel>();
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final Rxn<OrderModel> latestOrder = Rxn<OrderModel>();

  @override
  void onInit() {
    super.onInit();
    _loadAddresses();
    _loadOrders();
  }

  void _loadAddresses() {
    final defaultAddr = const AddressModel(
      id: 'addr_1',
      name: 'Arif Rahman',
      label: 'Home',
      phone: '+880 1712 345678',
      street: 'House 24, Road 5, Sector 3',
      city: 'Dhaka',
      district: 'Uttara',
      isDefault: true,
    );

    addresses.assignAll([
      defaultAddr,
      const AddressModel(
        id: 'addr_2',
        name: 'Arif Rahman',
        label: 'Office',
        phone: '+880 1712 345678',
        street: 'Level 12, Tower B, Bashundhara City',
        city: 'Dhaka',
        district: 'Panthapath',
        isDefault: false,
      ),
    ]);

    selectedAddress.value = defaultAddr;
  }

  void _loadOrders() {
    final addr = addresses.first;
    orders.assignAll([
      OrderModel(
        orderId: 'FG-20240315',
        items: [
          CartItemModel(
            product: MockDatabase.products.firstWhere((p) => p.id == 'acc_1'),
            quantity: 1,
            selectedColor: 'Navy Blue',
          ),
          CartItemModel(
            product: MockDatabase.products.firstWhere((p) => p.id == 'acc_4'),
            quantity: 2,
            selectedColor: 'Black',
          ),
        ],
        subtotal: 28878.0,
        deliveryFee: 120.0,
        totalAmount: 28998.0,
        status: OrderStatus.processing,
        address: addr,
        orderDate: DateTime(2024, 3, 15),
        paymentMethod: 'Cash on Delivery',
      ),
      OrderModel(
        orderId: 'FG-20240311',
        items: [
          CartItemModel(
            product: MockDatabase.products.firstWhere((p) => p.id == 'acc_4'),
            quantity: 1,
            selectedColor: 'Black',
          ),
        ],
        subtotal: 3080.0,
        deliveryFee: 120.0,
        totalAmount: 3200.0,
        status: OrderStatus.shipped,
        address: addr,
        orderDate: DateTime(2024, 3, 11),
        paymentMethod: 'Cash on Delivery',
      ),
      OrderModel(
        orderId: 'FG-20240305',
        items: [
          CartItemModel(
            product: MockDatabase.products.firstWhere((p) => p.id == 'acc_4'),
            quantity: 2,
            selectedColor: 'Black',
          ),
        ],
        subtotal: 1879.0,
        deliveryFee: 120.0,
        totalAmount: 1999.0,
        status: OrderStatus.delivered,
        address: addr,
        orderDate: DateTime(2024, 3, 5),
        paymentMethod: 'Cash on Delivery',
      ),
      OrderModel(
        orderId: 'FG-20240228',
        items: [
          CartItemModel(
            product: MockDatabase.products.firstWhere((p) => p.id == 'acc_4'),
            quantity: 1,
            selectedColor: 'Black',
          ),
        ],
        subtotal: 4380.0,
        deliveryFee: 120.0,
        totalAmount: 4500.0,
        status: OrderStatus.cancelled,
        address: addr,
        orderDate: DateTime(2024, 2, 28),
        paymentMethod: 'Cash on Delivery',
      ),
    ]);
  }

  void deleteAddress(String id) {
    addresses.removeWhere((a) => a.id == id);
    if (selectedAddress.value?.id == id && addresses.isNotEmpty) {
      selectedAddress.value = addresses.first;
    }
  }

  void setDefaultAddress(String id) {
    final updated = addresses.map((a) {
      return AddressModel(
        id: a.id,
        name: a.name,
        label: a.label,
        phone: a.phone,
        street: a.street,
        city: a.city,
        district: a.district,
        isDefault: a.id == id,
      );
    }).toList();
    addresses.assignAll(updated);
    selectedAddress.value = addresses.firstWhere((a) => a.id == id);
  }

  void selectAddress(AddressModel address) {
    selectedAddress.value = address;
  }

  void addAddress({
    required String name,
    required String phone,
    required String street,
    required String city,
    required String district,
    String label = 'Home',
  }) {
    final newAddress = AddressModel(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      label: label,
      phone: phone,
      street: street,
      city: city,
      district: district,
      isDefault: false,
    );

    addresses.add(newAddress);
    selectedAddress.value = newAddress;
  }

  void placeOrder(CartController cart) {
    if (selectedAddress.value == null) {
      Get.snackbar('Missing Address', 'Please select or add a delivery address.');
      return;
    }

    final newOrder = OrderModel(
      orderId: 'FG-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      items: List.from(cart.items),
      subtotal: cart.subtotal,
      deliveryFee: cart.deliveryFee.value,
      totalAmount: cart.total,
      status: OrderStatus.processing,
      address: selectedAddress.value!,
      orderDate: DateTime.now(),
      paymentMethod: 'Cash on Delivery',
    );

    orders.insert(0, newOrder);
    latestOrder.value = newOrder;
    currentStep.value = 2; // Step 3: Done
    cart.clearCart();
  }

  void resetSteps() {
    currentStep.value = 0;
  }
}
