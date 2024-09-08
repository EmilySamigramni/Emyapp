import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emstheapp/main.dart';

void main() {
  testWidgets('Password dialog navigates to MyProfilePage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the home screen shows the title 'Emily' and the button.
    expect(find.text('Emily'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the 'Open' button to show the password dialog.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Trigger a frame to display the dialog.

    // Verify that the password dialog appears.
    expect(find.byType(AlertDialog), findsOneWidget);

    // Enter the password and tap 'OK'.
    await tester.enterText(find.byType(TextField), '250304');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); // Wait for navigation to complete.

    // Verify that the MyProfilePage is displayed.
    expect(find.text('My Profile'), findsOneWidget);
  });
}
