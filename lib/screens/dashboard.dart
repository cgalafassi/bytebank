import 'package:bytebank/components/feature_item.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

import 'contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FeatureItem(
                        iconData: Icons.monetization_on,
                        textTitle: 'Transfer',
                        onTap: () {
                          _showContactsList(context, 'Transfer');
                        },
                      ),
                      FeatureItem(
                        iconData: Icons.description,
                        textTitle: 'Transaction Feed',
                        onTap: () {
                          _showTransactionList(context, 'Transactions');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContactsList(BuildContext context, String textTitle) {
    {
      Navigator.of(context).push(
        (MaterialPageRoute(
          builder: (context) => ContactsList(textTitle),
        )),
      );
    }
  }

  void _showTransactionList(BuildContext context, String textTitle) {
    {
      Navigator.of(context).push(
        (MaterialPageRoute(
          builder: (context) => TransactionsList(textTitle),
        )),
      );
    }
  }
}
