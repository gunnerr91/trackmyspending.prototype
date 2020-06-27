import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackyourspending/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.userTransaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
                child: Text('£${userTransaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          userTransaction.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          DateFormat('E d, MMM yyyy').format(userTransaction.date),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                onPressed: () => deleteTransaction(userTransaction.id),
                icon: Icon(Icons.delete),
                label: Text("Remove"),
                textColor: Colors.red,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTransaction(userTransaction.id),
              ),
      ),
    );
  }
}
