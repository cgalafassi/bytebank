import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widget/app_dependencies.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  TransactionsList(this.textTitle);

  final String textTitle;

  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    final dependecies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(textTitle),
      ),
      body: FutureBuilder<List<Transaction>>(
          future: dependecies.transactionWebClient.findAllTransactions(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Progress(),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data;
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${transaction.contact.name.toString()} - Conta: ${transaction.contact.accountNumber.toString()}',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                  return CenteredMessage(
                    'No transactions found',
                    icon: Icons.warning,
                  );
                }
                return CenteredMessage(
                  'No data found',
                  icon: Icons.warning,
                );
                break;
            }
            return CenteredMessage('Unknown error');
          }),
    );
  }
}
