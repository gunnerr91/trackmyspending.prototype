import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackyourspending/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final dayOfTheWeek = DateTime.now().subtract(Duration(days: index));
      double amountForTheDay = 0;
      for (var transaction in transactions) {
        if (dayOfTheWeek.day == transaction.date.day &&
            dayOfTheWeek.month == transaction.date.month &&
            dayOfTheWeek.year == transaction.date.year) {
          amountForTheDay += transaction.amount;
        }
      }
      print(DateFormat.E().format(dayOfTheWeek));
      print(amountForTheDay);
      return {
        "Day": DateFormat.E().format(dayOfTheWeek),
        "Amount": amountForTheDay
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.groupedTransactionValues);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
