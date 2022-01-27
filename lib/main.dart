import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/chart.dart';
import 'package:my_expenses/widgets/transaction_list.dart';
import 'package:my_expenses/widgets/user_input.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Expenses",
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.deepOrange,
        fontFamily: "Quicksand",
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(id: "t1", title: "Veggies", amount: 200, date: DateTime.now()),
    // Transaction(id: "t2", title: "Clothes", amount: 1000, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      /* This "where" runs a function over all the elements of the list and whichever elements returns true, it is added to a newly returned list*/
      return tx.date!.isAfter(DateTime.now().subtract(Duration(
          days:
              7))); // This return true if the transaction happened within the last week
    }).toList();
  }

  void _addTransactions(String txTitle, int txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _userTransaction.add(newTx);
    });
    Navigator.of(context)
        .pop(); // Closes the modal sheet when button is clicked
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          // builderCtx is the context which the builder gives. _ can also be used, indicating that we know context is being given but we dont care about it.
          return UserInput(_addTransactions);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _startAddNewTransaction(context);
              },
              icon: Icon(
                Icons.add,
                size: 40,
              ))
        ],
        title: const Text(
          "My Expenses",
          style: TextStyle(fontFamily: "OpenSans-Bold", fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
