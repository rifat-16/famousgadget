import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxString promoCode = ''.obs;
  final RxDouble discount = 0.0.obs;
  final RxDouble deliveryFee = 120.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialCart();
  }

  void _loadInitialCart() {
    // Initial items as shown in Figma cart design
    items.assignAll([
      CartItemModel(
        product: const ProductModel(
          id: 'p7',
          title: 'Anker Soundcore R50i',
          description: 'True wireless earbuds with 10mm drivers.',
          imageUrl:
              'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500&auto=format&fit=crop&q=80',
          price: 1999.0,
          category: 'Accessories',
          colors: ['Black'],
        ),
        quantity: 1,
        selectedColor: 'Black',
      ),
      CartItemModel(
        product: const ProductModel(
          id: 'p8',
          title: 'OnePlus Nord CE 3 Lite',
          description: '108MP camera, 67W fast charging.',
          imageUrl:
              'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&auto=format&fit=crop&q=80',
          price: 24499.0,
          category: 'Smartphones',
          colors: ['Pastel Lime'],
        ),
        quantity: 1,
        selectedColor: 'Pastel Lime',
      ),
    ]);
  }

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get total => (subtotal + deliveryFee.value - discount.value).clamp(0.0, double.infinity);

  void addItem(ProductModel product, {String color = 'Default', int quantity = 1}) {
    if (!product.inStock) {
      Get.snackbar(
        'Out of Stock',
        'Sorry, ${product.title} is currently out of stock.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final index = items.indexWhere(
      (element) => element.product.id == product.id && element.selectedColor == color,
    );

    if (index >= 0) {
      items[index].quantity += quantity;
      items.refresh();
    } else {
      items.add(
        CartItemModel(
          product: product,
          quantity: quantity,
          selectedColor: color,
        ),
      );
    }

    Get.snackbar(
      'Added to Cart',
      '${product.title} has been added to your cart',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < items.length) {
      items[index].quantity++;
      items.refresh();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < items.length) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
        items.refresh();
      } else {
        items.removeAt(index);
      }
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  bool applyPromoCode(String code) {
    if (code.trim().toUpperCase() == 'DEVNIQ' ||
        code.trim().toUpperCase() == 'FAMOUS') {
      promoCode.value = code.trim().toUpperCase();
      discount.value = 500.0;
      Get.snackbar(
        'Promo Applied!',
        '৳500 discount added to your order',
        snackPosition: SnackPosition.TOP,
      );
      return true;
    } else {
      Get.snackbar(
        'Invalid Promo',
        'Please enter a valid promo code (e.g., DEVNIQ)',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  void clearCart() {
    items.clear();
    discount.value = 0.0;
    promoCode.value = '';
  }
}
