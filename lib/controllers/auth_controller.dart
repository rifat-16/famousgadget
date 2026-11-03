import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final RxBool isLoggedIn = true.obs;
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxList<ProductModel> wishlist = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Default user from Figma Account Logged In screen
    user.value = const UserModel(
      id: 'usr_1',
      name: 'Arif Rahman',
      email: 'arif@gmail.com',
      phone: '+880 1712 345678',
      city: 'Dhaka',
      country: 'BD',
    );
  }

  void toggleWishlist(ProductModel product) {
    final index = wishlist.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      wishlist.removeAt(index);
      Get.snackbar(
        'Removed from Wishlist',
        '${product.title} removed from your wishlist',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      wishlist.add(product);
      Get.snackbar(
        'Saved to Wishlist',
        '${product.title} added to your wishlist',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  bool isInWishlist(String productId) {
    return wishlist.any((item) => item.id == productId);
  }

  void login(String email, String password) {
    isLoggedIn.value = true;
    user.value = UserModel(
      id: 'usr_1',
      name: email.split('@').first.capitalizeFirst ?? 'User',
      email: email,
      phone: '+880 1712 345678',
    );
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
