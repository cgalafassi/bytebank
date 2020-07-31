import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/models/contact.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'httpinterceptor.dart';

Future<List<Transaction>> findAllTransactions() async {
  Client client = HttpClientWithInterceptor.build(interceptors: [
    LoggingInterceptor(),
  ]);
  final Response response = await client
      .get('http://192.168.0.105:8080/transactions')
      .timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }

  return transactions;
}
