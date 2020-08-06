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

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    Key key,
    @required IconData iconData,
    @required this.textTitle,
    @required this.onTap,
  })  : iconData = iconData,
        super(key: key);

  final IconData iconData;
  final String textTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: Container(
            height: 100,
            width: 150,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Text(
                    textTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
