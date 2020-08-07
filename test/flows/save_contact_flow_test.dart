import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockers.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await tapOnTheFeatureItem(tester, 'Transfer', Icons.monetization_on);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    await tapOnTheFloatingActionButton(tester, Icons.add);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactsForm);
    expect(contactForm, findsOneWidget);

    await insertValueTextField(tester, 'Full Name', 'Joaquim');

    await insertValueTextField(tester, 'Account number', '5000');

    await tapOnTheRaisedButton(tester, 'Create');
    await tester.pumpAndSettle();

    verify(mockContactDao.saveContact(Contact(null, 'Joaquim', 5000)));

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll());
  });
}
