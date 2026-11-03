import 'package:get/get.dart';
import '../views/account/account_view.dart';
import '../views/account/addresses_view.dart';
import '../views/account/orders_view.dart';
import '../views/account/wishlist_view.dart';
import '../views/auth/login_view.dart';
import '../views/cart/cart_view.dart';
import '../views/categories/categories_view.dart';
import '../views/checkout/checkout_confirm_view.dart';
import '../views/checkout/checkout_delivery_view.dart';
import '../views/checkout/order_success_view.dart';
import '../views/home/home_view.dart';
import '../views/nav/main_nav_view.dart';
import '../views/product/product_detail_view.dart';
import '../views/product/product_list_view.dart';
import '../views/search/search_view.dart';
import '../views/splash/splash_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.mainNav,
      page: () => const MainNavigationView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesView(),
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => const ProductListView(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailView(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchView(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
    ),
    GetPage(
      name: AppRoutes.checkoutDelivery,
      page: () => const CheckoutDeliveryView(),
    ),
    GetPage(
      name: AppRoutes.checkoutConfirm,
      page: () => const CheckoutConfirmView(),
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => const OrderSuccessView(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountView(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersView(),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
    ),
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddressesView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
    ),
  ];
}
