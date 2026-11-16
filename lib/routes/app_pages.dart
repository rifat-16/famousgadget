import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../views/account/account_view.dart';
import '../views/account/add_address_view.dart';
import '../views/account/addresses_view.dart';
import '../views/account/change_password_view.dart';
import '../views/account/edit_profile_view.dart';
import '../views/account/order_detail_view.dart';
import '../views/account/orders_view.dart';
import '../views/account/wishlist_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/otp_view.dart';
import '../views/auth/register_view.dart';
import '../views/cart/cart_view.dart';
import '../views/categories/categories_view.dart';
import '../views/checkout/checkout_confirm_view.dart';
import '../views/checkout/checkout_delivery_view.dart';
import '../views/checkout/order_success_view.dart';
import '../views/home/home_view.dart';
import '../views/nav/main_nav_view.dart';
import '../views/product/all_reviews_view.dart';
import '../views/product/product_detail_view.dart';
import '../views/product/product_list_view.dart';
import '../views/search/search_view.dart';
import '../views/splash/splash_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.splash;

  static const _pageDuration = Duration(milliseconds: 280);
  static const _pageCurve = Curves.easeOutCubic;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.mainNav,
      page: () => const MainNavigationView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => const ProductListView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.checkoutDelivery,
      page: () => const CheckoutDeliveryView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.checkoutConfirm,
      page: () => const CheckoutConfirmView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.orderSuccess,
      page: () => const OrderSuccessView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddressesView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.otpVerify,
      page: () => const OtpView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.allReviews,
      page: () => const AllReviewsView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => const AddAddressView(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: _pageDuration,
      curve: _pageCurve,
    ),
  ];
}
