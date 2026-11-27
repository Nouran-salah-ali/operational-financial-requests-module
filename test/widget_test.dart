import 'package:financial_requests_module/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders initial Step 2 placeholder screen', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const FinancialRequestsApp());
    expect(find.text('Step 2 Architecture Ready'), findsOneWidget);
  });
}