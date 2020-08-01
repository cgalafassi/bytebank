import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/transaction.dart';

class TransactionDao {

  static const String _value = 'value';
  static const String _contact= 'contact';

  Map<String, dynamic> toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = Map();
    transactionMap[_value ] = transaction.value;
    transactionMap[_contact] = ContactDao().toMap(transaction.contact);
    return transactionMap;
  }

  Transaction fromJson(Map<String, dynamic> json) {
    return Transaction(
      json[_value ],
      ContactDao().fromJson(json[_contact])
    );
  }

  List<Transaction> toListFromJson(List decodedJson) {
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(fromJson(transactionJson));
    }
    return transactions;
  }
}
