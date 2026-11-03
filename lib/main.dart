import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/checkout_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/nav_controller.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Global MVC Controllers via GetX
  Get.put(AuthController(), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(NavController(), permanent: true);
  Get.put(CheckoutController(), permanent: true);

  runApp(const FamousGadgetApp());
}

class FamousGadgetApp extends StatelessWidget {
  const FamousGadgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Famous Gadget BD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}
