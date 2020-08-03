import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
//teste
class TransactionWebClient extends WebClient {
  Future<List<Transaction>> findAllTransactions() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic transactionJson) => Transaction.fromJson(transactionJson))
        .toList();
  }

  Future<Transaction> saveTransaction(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
