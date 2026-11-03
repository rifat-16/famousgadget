import 'package:flutter_test/flutter_test.dart';
import 'package:famousgadget/main.dart';

void main() {
  testWidgets('FamousGadgetApp basic load test', (WidgetTester tester) async {
    await tester.pumpWidget(const FamousGadgetApp());
    expect(find.byType(FamousGadgetApp), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  });
}
