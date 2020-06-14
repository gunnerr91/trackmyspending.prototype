import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewItem;

  NewTransaction(this.addNewItem);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmit() {
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0) {
      return;
    }

    widget.addNewItem(
        titleController.text, double.parse(amountController.text));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => onSubmit(),
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline2.color),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmit(),
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline2.color),
            ),
            FlatButton(
              child: Text(
                'Add transaction',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () => onSubmit(),
              color: Theme.of(context).primaryColorDark,
            )
          ],
        ),
      ),
    );
  }
}
