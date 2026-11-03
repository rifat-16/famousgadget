import 'package:get/get.dart';
import '../models/address_model.dart';
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
        street: 'Level 4, Plot 12, Banani C/A',
        city: 'Dhaka',
        district: 'Banani',
        isDefault: false,
      ),
    ]);

    selectedAddress.value = defaultAddr;
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
      deliveryFee: cart.deliveryFee,
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
