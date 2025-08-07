// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:deeplink_poc/main.dart';

void main() {
  testWidgets('Deep Link POC app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app starts with the expected title.
    expect(find.text('Deep Link POC'), findsOneWidget);
    
    // Verify that device information section is present
    expect(find.text('Device Information'), findsOneWidget);
    
    // Verify that latest deep link section is present
    expect(find.text('Latest Deep Link'), findsOneWidget);
    
    // Verify that the simulate deep link button is present
    expect(find.text('Simulate Deep Link'), findsOneWidget);
    
    // Verify that the web fallback button is present
    expect(find.text('Open Web Fallback'), findsOneWidget);
  });
}
