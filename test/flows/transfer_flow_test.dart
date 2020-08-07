import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mockers.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();

    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final contactForTest = Contact(0, 'Joaquim', 5000);
    when(mockContactDao.findAll())
        .thenAnswer((invocation) async => [contactForTest]);

    await tapOnTheFeatureItem(tester, 'Transfer', Icons.monetization_on);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);
    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == contactForTest.name &&
            widget.contact.accountNumber == contactForTest.accountNumber;
      }
      return false;
    });

    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text(contactForTest.name);
    expect(contactName, findsOneWidget);
    final contactAccountNumber =
        find.text(contactForTest.accountNumber.toString());
    expect(contactAccountNumber, findsOneWidget);

    await insertValueTextField(tester, 'Value', '200');

    await tapOnTheRaisedButton(tester, 'Transfer');
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword =
        find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);

    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(FlatButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(FlatButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.saveTransaction(
            Transaction(null, 200, contactForTest), '1000'))
        .thenAnswer((_) async => Transaction(null, 200, contactForTest));
    await tester.tap(confirmButton);

    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(FlatButton, 'Ok');
    expect(okButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}
