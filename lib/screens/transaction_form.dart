import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widget/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String _transactionID = Uuid().v4();
  bool _sending = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dependecies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: _sending,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Progress(
                      message: 'Sending...',
                    ),
                  ),
                ),
                Text(
                  widget.contact.name,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    widget.contact.accountNumber.toString(),
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some value';
                      }
                      return null;
                    },
                    controller: _valueController,
                    style: TextStyle(fontSize: 24.0),
                    decoration: InputDecoration(labelText: 'Value'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: RaisedButton(
                      child: Text('Transfer'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formValid(dependecies.transactionWebClient, context);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _formValid(TransactionWebClient webClient, BuildContext context) {
    final double value = double.tryParse(_valueController.text);
    final transactionCreated =
        Transaction(_transactionID, value, widget.contact);
    showDialog(
        context: context,
        builder: (contextDialog) {
          return TransactionAuthDialog(
            onConfirm: (String password) {
              _save(webClient, transactionCreated, password, context);
            },
          );
        });
  }

  void _save(
    TransactionWebClient webClient,
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction = await _sendTransaction(
        webClient, transactionCreated, password, context);

    _showSuccessDialog(transaction, context);
  }

  Future<Transaction> _sendTransaction(
      TransactionWebClient webClient,
      Transaction transactionCreated,
      String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final Transaction transaction = await webClient
        .saveTransaction(transactionCreated, password)
        .catchError((e) => _showFailureDialog(context, message: e.message),
            test: (e) => e is HttpException)
        .catchError(
            (e) => _showFailureDialog(context,
                message: 'timeout submitting the transaction'),
            test: (e) => e is TimeoutException)
        .catchError((e) => _showFailureDialog(context))
        .whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    return transaction;
  }

  Future _showSuccessDialog(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('successful transaction');
          });
      Navigator.pop(context);
    }
  }

  Future _showFailureDialog(BuildContext context,
      {String message = 'Unkown error'}) {
    return showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
