import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
    Transaction(
        id: "1",
        title: "decaff coffee",
        amount: 6.98,
        date: DateTime(2020, 05, 25)),
    Transaction(
        id: "2",
        title: "bird eye chilli",
        amount: 0.90,
        date: DateTime(2020, 05, 25)),
  ];

  void addNewTransaction(String title, double amount) {
    final newTransaction = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter app'),
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
              child: Card(
                color: Colors.black,
                child: Text(
                  'Chart!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                elevation: 10,
              ),
            ),
            TransactionList(userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
