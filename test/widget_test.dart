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
}
