// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_explosion/main.dart';
import 'package:m3e_explosion/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('M3E demo renders main sections', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await setupServiceLocator();

    await tester.pumpWidget(const M3EDemoApp(enableIntro: false));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Material 3 Expressive'), findsAtLeastNWidgets(1));
    expect(find.text('Personalizacion Viva'), findsOneWidget);
    expect(find.text('Buttons'), findsOneWidget);
  });
}
