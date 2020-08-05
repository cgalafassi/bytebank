import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

import 'contacts_form.dart';

class ContactsList extends StatefulWidget {
  ContactsList(this.textTitle);

  final String textTitle;

  @override
  _ContactsListState createState() => _ContactsListState(this.textTitle);
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _contactDao = ContactDao();

  _ContactsListState(this.textTitle);

  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textTitle),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _contactDao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return  Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact, onClick: () {
                    Navigator.of(context).push(
                      (MaterialPageRoute(
                        builder: (context) => TransactionForm(contact),
                      )),
                    );
                  });
                },
                itemCount: contacts.length,
              );
              break;
          }
          return CenteredMessage('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactsForm(),
                ),
              )
              .then((id) => setState(() => widget.createState()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact _contact;
  final Function onClick;

  const _ContactItem(this._contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          _contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
