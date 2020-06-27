import 'package:flutter/material.dart';
import 'package:trackyourspending/models/transaction.dart';
import 'package:trackyourspending/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactions.length < 1
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions available',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  userTransaction: userTransactions[index],
                  deleteTransaction: deleteTransaction);
            },
            itemCount: userTransactions.length,
          );
  }
}
