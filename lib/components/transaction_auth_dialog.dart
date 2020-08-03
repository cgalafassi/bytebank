import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 68,
          letterSpacing: 16,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {},
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
