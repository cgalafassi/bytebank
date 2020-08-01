import 'dart:convert';

import 'package:bytebank/dao/transaction_dao.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'httpinterceptor.dart';
const String baseUrl = 'http://192.168.0.105:8080/transactions';

Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor(),
]);

Future<List<Transaction>> findAllTransactions() async {
  final Response response = await client
      .get(baseUrl)
      .timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  return TransactionDao().toListFromJson(decodedJson);
}


Future<Transaction> saveTransaction(Transaction transaction) async {
  final TransactionDao _transactionDao = TransactionDao();
  final Map<String, dynamic> transactionMap = _transactionDao.toMap(transaction);

  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(baseUrl, headers: {
    'Content-type': 'application/json',
    'password': '1000',
  }, body: transactionJson);

  return _transactionDao.fromJson(jsonDecode(response.body));
}
