import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackyourspending/widgets/chart.dart';
import 'package:trackyourspending/widgets/new_transaction.dart';
import 'package:trackyourspending/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

  var _showChart = false;

  List<Transaction> get recentTransactions {
    return userTransactions
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Flutter app',
            ),
            backgroundColor: Theme.of(context).primaryColorDark,
            trailing: Row(
              mainAxisSize: MainAxisSize
                  .min, //this property ensures that the row uses only the requried width
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    popUpNewTransactionForm(context);
                  },
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
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
          );
    var topPartHeight = appBar.preferredSize.height + mediaQuery.padding.top;

    final transactionList = Container(
      height: (mediaQuery.size.height - topPartHeight) * .7,
      child: TransactionList(userTransactions, deleteTransaction),
    );
    final mainBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height - topPartHeight) * .3,
                child: Chart(recentTransactions),
              ),
            if (!isLandscape) transactionList,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height - topPartHeight) * .7,
                      child: Chart(recentTransactions),
                    )
                  : transactionList,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: mainBody,
          )
        : Scaffold(
            appBar: appBar,
            body: mainBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
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
