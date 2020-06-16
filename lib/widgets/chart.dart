import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackyourspending/models/transaction.dart';
import 'package:trackyourspending/widgets/chart_bar.dart';

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

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['Amount'];
    });
  }

  double getSpendingPctOfTotalForDay(double amount) {
    if (totalSpending < 1) {
      return 0.0;
    } else {
      return amount / totalSpending;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(this.groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(25),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(e['Day'], e['Amount'],
                      getSpendingPctOfTotalForDay(e['Amount'] as double)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
