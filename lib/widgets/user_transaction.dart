import 'package:flutter/material.dart';
import 'package:my_expenses/widgets/transaction_list.dart';
import 'package:my_expenses/widgets/user_input.dart';
import 'package:my_expenses/models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(id: "t1", title: "Veggies", amount: 200, date: DateTime.now()),
    Transaction(id: "t2", title: "Clothes", amount: 1000, date: DateTime.now()),
  ];

  void _addTransactions(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserInput(_addTransactions),
        TransactionList(_userTransaction),
      ],
    );
  }
}
