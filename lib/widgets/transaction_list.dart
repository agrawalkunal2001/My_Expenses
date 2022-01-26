import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  TransactionList(this.userTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "\u{20B9}${userTransaction[index].amount}", // \u{20B9} is used to get rupee symbol and ${tx.amount} is equivalent to tx.amount.toString()
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userTransaction[index].title.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      DateFormat.yMMMMd()
                          .format(userTransaction[index].date as DateTime),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: userTransaction.length,
      ),
    );
  }
}
