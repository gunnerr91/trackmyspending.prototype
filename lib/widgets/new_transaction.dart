import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewItem;

  NewTransaction(this.addNewItem);

  void onSubmit() {
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0) {
      return;
    }

    addNewItem(titleController.text, double.parse(amountController.text));
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
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmit(),
            ),
            FlatButton(
              child: Text('Add transaction'),
              onPressed: () => onSubmit(),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
