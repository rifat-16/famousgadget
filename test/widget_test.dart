import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:famousgadget/main.dart';
import 'package:famousgadget/data/mock_database.dart';
import 'package:famousgadget/controllers/cart_controller.dart';
import 'package:famousgadget/routes/app_routes.dart';

void main() {
  testWidgets('FamousGadgetApp basic load test', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    expect(find.byType(FamousGadgetApp), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  });

  testWidgets('Out of stock product detail page displays disabled Out of Stock button', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    final oosProduct = MockDatabase.products.firstWhere((p) => p.id == 'acc_oos_1');
    Get.toNamed(AppRoutes.productDetail, arguments: oosProduct);
    await tester.pumpAndSettle();

    expect(find.text('OUT OF STOCK'), findsOneWidget);
    expect(find.text('Out of Stock'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('৳28,500'), findsOneWidget);
    expect(find.text('৳34,000'), findsOneWidget);
  });

  testWidgets('Login and Register views render per Figma design', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.login);
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.textContaining('Register'), findsWidgets);

    Get.toNamed(AppRoutes.register);
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);

    Get.toNamed(AppRoutes.otpVerify, arguments: {'phone': '+880 1712345678'});
    await tester.pumpAndSettle();

    expect(find.text('Verify Phone Number'), findsOneWidget);
    expect(find.text('Verify'), findsOneWidget);
    expect(find.text('Change Phone Number'), findsOneWidget);
  });

  testWidgets('Empty Cart view renders per Figma design', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    final cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    cartController.items.clear();

    Get.toNamed(AppRoutes.cart);
    await tester.pumpAndSettle();

    expect(find.text('My Cart (0 Items)'), findsOneWidget);
    expect(find.text('Your Cart is Empty'), findsOneWidget);
    expect(find.textContaining('Explore our latest collection now!'), findsOneWidget);
    expect(find.text('Start Shopping'), findsOneWidget);
  });

  testWidgets('Checkout flow renders per Figma design', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    // 1. Delivery View
    Get.toNamed(AppRoutes.checkoutDelivery);
    await tester.pumpAndSettle();

    expect(find.text('Checkout'), findsOneWidget);
    expect(find.text('DELIVER TO'), findsOneWidget);
    expect(find.textContaining('Arif Rahman'), findsWidgets);
    expect(find.text('DEFAULT'), findsOneWidget);
    expect(find.text('Add New Address'), findsOneWidget);
    expect(find.text('NEW ADDRESS FORM'), findsOneWidget);
    expect(find.text('Continue to Confirmation'), findsOneWidget);

    // 2. Confirm View
    Get.toNamed(AppRoutes.checkoutConfirm);
    await tester.pumpAndSettle();

    expect(find.text('Order Confirmation'), findsOneWidget);
    expect(find.text('PAYMENT METHOD'), findsOneWidget);
    expect(find.text('Cash on Delivery (COD)'), findsOneWidget);
    expect(find.text('SHIPPING METHOD'), findsOneWidget);
    expect(find.text('Express Delivery (Dhaka Only)'), findsOneWidget);
    expect(find.text('Order Notes (Optional)'), findsOneWidget);
    expect(find.text('ORDER ITEMS'), findsOneWidget);
    expect(find.text('Place Order'), findsOneWidget);

    // 3. Success View
    Get.toNamed(AppRoutes.orderSuccess);
    await tester.pumpAndSettle();

    expect(find.text('Order Placed Successfully!'), findsOneWidget);
    expect(find.text('Order Number'), findsOneWidget);
    expect(find.text('Processing'), findsOneWidget);
    expect(find.text('Continue Shopping'), findsOneWidget);
    expect(find.text('View My Orders'), findsOneWidget);
  });

  testWidgets('CategoriesView renders 4-column grid per Figma categories-grid design', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.categories);
    await tester.pumpAndSettle();

    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Smart Watch'), findsWidgets);
    expect(find.text('Camera'), findsWidgets);
    expect(find.text('Gimbal'), findsWidgets);
    expect(find.text('Accessories'), findsWidgets);
  });

  testWidgets('SearchView renders Figma screen-search header and animates smoothly', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.search);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text('Search products...'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
    expect(find.byIcon(Icons.search_rounded), findsWidgets);

    // Search query
    await tester.enterText(find.byType(TextField), 'Watch');
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
    expect(find.textContaining('Watch'), findsWidgets);

    // Tap Cancel
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  });

  testWidgets('Account, Edit Profile, and Change Password render per Figma design', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    // 1. Account Logged In
    Get.toNamed(AppRoutes.account);
    await tester.pumpAndSettle();

    expect(find.text('My Account'), findsOneWidget);
    expect(find.text('Arif Rahman'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('App Settings'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    // Scroll to & Tap Logout to test custom theme dialog
    await tester.ensureVisible(find.text('Logout'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Are you sure you want to log out of your account?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    // Dismiss dialog
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Are you sure you want to log out of your account?'), findsNothing);

    // 2. Edit Profile
    Get.toNamed(AppRoutes.editProfile);
    await tester.pumpAndSettle();

    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Verified Account'), findsOneWidget);
    expect(find.text('Save Changes'), findsOneWidget);

    // 3. Change Password
    Get.toNamed(AppRoutes.changePassword);
    await tester.pumpAndSettle();

    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('Current Password'), findsOneWidget);
    expect(find.text('New Password'), findsOneWidget);
    expect(find.text('Password Requirements'), findsOneWidget);
    expect(find.text('Update Password'), findsOneWidget);
  });

  testWidgets('Orders, Order Details, Wishlist, Addresses, and Add Address render per Figma design', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    await tester.pumpAndSettle();

    // 1. Orders View
    Get.toNamed(AppRoutes.orders);
    await tester.pumpAndSettle();

    expect(find.text('My Orders'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Processing'), findsWidgets);
    expect(find.text('#FG-20240315'), findsOneWidget);

    // 2. Order Detail View
    Get.toNamed(AppRoutes.orderDetail);
    await tester.pumpAndSettle();

    expect(find.textContaining('Order #'), findsOneWidget);
    expect(find.text('Delivery Tracking'), findsOneWidget);
    expect(find.text('Shipping Address'), findsOneWidget);
    expect(find.text('Items Ordered'), findsOneWidget);

    // 3. Wishlist View
    Get.toNamed(AppRoutes.wishlist);
    await tester.pumpAndSettle();

    expect(find.textContaining('My Wishlist'), findsOneWidget);
    expect(find.text('Add to Cart'), findsWidgets);

    // 4. Addresses View
    Get.toNamed(AppRoutes.addresses);
    await tester.pumpAndSettle();

    expect(find.text('My Addresses'), findsOneWidget);
    expect(find.text('DEFAULT'), findsOneWidget);
    expect(find.text('Add New Address'), findsOneWidget);

    // 5. Add Address View
    Get.toNamed(AppRoutes.addAddress);
    await tester.pumpAndSettle();

    expect(find.text('Add New Address'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Street Address'), findsOneWidget);
    expect(find.text('District / Zone'), findsOneWidget);
    expect(find.text('Save Address'), findsOneWidget);
  });
}
