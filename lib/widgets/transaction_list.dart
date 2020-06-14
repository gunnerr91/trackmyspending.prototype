import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackyourspending/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: userTransactions.length < 1
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions available',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).primaryColorDark,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          '£${userTransactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).accentColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userTransactions[index].title,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            DateFormat('E d, MMM yyyy')
                                .format(userTransactions[index].date),
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
