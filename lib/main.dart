import 'package:flutter/material.dart';
import 'package:trackyourspending/widgets/chart.dart';
import 'package:trackyourspending/widgets/new_transaction.dart';
import 'package:trackyourspending/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.dark().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                color: Colors.white,
              ),
              headline2: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                color: Colors.black,
              ),
              bodyText1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15,
                color: Colors.black,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [
    // Transaction(
    //     id: "1",
    //     title: "decaff coffee",
    //     amount: 6.98,
    //     date: DateTime(2020, 05, 25)),
    // Transaction(
    //     id: "2",
    //     title: "bird eye chilli",
    //     amount: 0.90,
    //     date: DateTime(2020, 05, 25)),
  ];

  void addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      userTransactions.add(newTransaction);
    });
  }

  void popUpNewTransactionForm(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: NewTransaction(addNewTransaction),
      ),
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Transaction> get recentTransactions {
    return userTransactions
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter app',
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => popUpNewTransactionForm(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(recentTransactions),
            ),
            TransactionList(userTransactions, deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => popUpNewTransactionForm(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
