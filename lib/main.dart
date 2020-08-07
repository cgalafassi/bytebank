import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widget/app_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  BytebankApp({
    @required this.contactDao,
    @required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        home: Dashboard(),
        theme: buildThemeData(),
      ),
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.greenAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.greenAccent[700],
          textTheme: ButtonTextTheme.primary,
        ));
  }
}
