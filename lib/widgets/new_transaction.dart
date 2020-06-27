import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewItem;

  NewTransaction(this.addNewItem);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void onSubmit() {
    final enteredAmount =
        amountController.text.isEmpty ? 0 : double.parse(amountController.text);
    if (titleController.text.isEmpty ||
        enteredAmount <= 0 ||
        selectedDate == null) {
      return;
    }

    widget.addNewItem(titleController.text, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((chosenDate) {
      if (chosenDate == null) {
        return;
      }
      setState(() {
        selectedDate = chosenDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (_) => onSubmit(),
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2.color),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => onSubmit(),
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2.color),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No date chosen'
                            : DateFormat('E d, MMM yyyy').format(selectedDate),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    AdaptiveFlatButton(
                      label: "Choose date",
                      handler: presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
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
      ),
    );
  }
}
