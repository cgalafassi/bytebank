import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers.dart';

Future<void> tapOnTheFeatureItem(
    WidgetTester tester, String labelText, IconData iconData) async {
  final transferFeatureItem = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget, labelText, iconData));
  expect(transferFeatureItem, findsOneWidget);
  return tester.tap(transferFeatureItem);
}

Future<void> tapOnTheRaisedButton(WidgetTester tester, String label) async {
  final createButton = find.widgetWithText(RaisedButton, label);
  expect(createButton, findsOneWidget);
  return tester.tap(createButton);
}

Future tapOnTheFloatingActionButton(
    WidgetTester tester, IconData iconData) async {
  final fabNewContact = find.widgetWithIcon(FloatingActionButton, iconData);
  expect(fabNewContact, findsOneWidget);
  await tester.tap(fabNewContact);
}

Future<void> insertValueTextField(
    WidgetTester tester, String labelText, String valueField) async {
  final nameTextField =
      find.byWidgetPredicate((widget) => textFieldMatcher(widget, labelText));
  expect(nameTextField, findsOneWidget);
  return tester.enterText(nameTextField, valueField);
}
