import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp(contactDao: ContactDao()));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;

  BytebankApp({@required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(contactDao: contactDao),
      theme: buildThemeData(),
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
