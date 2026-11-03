import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductDetailController extends GetxController {
  final RxString selectedColor = ''.obs;
  final RxInt quantity = 1.obs;

  void init(ProductModel product) {
    quantity.value = 1;
    if (product.colors.isNotEmpty) {
      selectedColor.value = product.colors.first;
    } else {
      selectedColor.value = 'Default';
    }
  }

  void setColor(String color) {
    selectedColor.value = color;
  }

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
