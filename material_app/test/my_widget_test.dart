import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../lib/screens/screens.dart';

void main() {
  testWidgets('There should be a Widget with the name provided in TextField',
      (WidgetTester tester) async {
    //* renders our Widget
    await tester.pumpWidget(TestScreen());

    //* find our TextField
    Finder textField = find.byType(TextField);

    //* and check if the widget was found
    expect(textField, findsOneWidget);

    //* entering data into the TextField
    await tester.enterText(textField, 'ab');

    //* You can also find by key, if there are multiple widgets
    Finder textWidget = find.byKey(Key('TextWidget'));

    //* for checking if the Text Widget was built
    expect(textWidget, findsNothing);
    //* it should return nothing as We've entered an Invalid name
  });
}
