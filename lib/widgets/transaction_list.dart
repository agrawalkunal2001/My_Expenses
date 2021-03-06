import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;
  TransactionList(this.userTransaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userTransaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {
              // We can use constraints to set the height and width of elements of widgets inside dynamically based on the size of widget applied outside.
              return Column(
                children: <Widget>[
                  Container(
                    height: constraint.maxHeight * 0.55,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No transactions yet!",
                    style:
                        TextStyle(fontFamily: "Quicksand-Bold", fontSize: 20),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 5.0),
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 130,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
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
                                fontFamily: "OpenSans",
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                DateFormat.yMMMMd().format(
                                    userTransaction[index].date as DateTime),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      MediaQuery.of(context).size.width > 450
                          ? TextButton.icon(
                              onPressed: () {
                                deleteTransaction(userTransaction[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).accentColor,
                              ),
                              label: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ))
                          : IconButton(
                              onPressed: () {
                                deleteTransaction(userTransaction[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).accentColor,
                              )),
                    ],
                  ),
                );
              },
              itemCount: userTransaction.length,
            ),
    );
  }
}
