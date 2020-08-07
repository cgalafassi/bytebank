import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers.dart';
import '../mockers.dart';

void main() {
  final mockContactDao = MockContactDao();
  testWidgets(
    'Should display the main image when the Dashboard is opened',
    (WidgetTester tester) async {
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
      'Should display the transfer feature when the Dashboard is opened',
      (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed feature when the Dashboard is opened',
      (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
    final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));
    expect(transactionFeedFeatureItem, findsOneWidget);
  });
}
