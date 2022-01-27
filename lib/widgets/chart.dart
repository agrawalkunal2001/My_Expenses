import 'package:flutter/material.dart';
import 'package:my_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/widgets/chart_bar.dart';
// The idea of the chart is to show 7 bars representing 7 days of the week. Each bar will be filled in relation to the amount spent on that day relative to the amount spent during the entire week.

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7 /* For week days*/, (index) {
      final weekDay = DateTime.now().subtract(Duration(
          days:
              index)); // DateTime.now() gives the current day. For the entire past week, we subtract (days=index) from current day. For example, for today, DateTime.now() gives current day and index=0 means (current day - 0 day) which is today. Similarly, for yesterday, DateTime.now() gives current day and index=1 means (current day - 1 day) which is yesterday.
      int totalAmount = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date?.day == weekDay.day &&
            recentTransactions[i].date?.month == weekDay.month &&
            recentTransactions[i].date?.year ==
                weekDay
                    .year /* These conditions check if the transaction we are looking at is of the same day as weekDay*/) {
          totalAmount += recentTransactions[i].amount!;
        }
      }
      return {
        "day": DateFormat.E().format(
            weekDay) /* This retrieves the initials of the input weekday. For example, M for monday etc.*/,
        "amount": totalAmount
      };
    });
  }

  int get totalAmountSpent {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + (item["amount"] as int);
    }); // Fold allows us to change a list into another data type based on the function defined in it.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // So that all bars are spaced evenly in the card
          children: groupedTransactionValues.reversed.map((data) {
            return Flexible(
              fit: FlexFit
                  .tight, // It ensures that the bar takes only the space alloted to it and no extra space.
              child: ChartBar(
                  data["day"] as String,
                  data["amount"] as int,
                  totalAmountSpent == 0
                      ? 0
                      : (data["amount"] as int) / totalAmountSpent),
            );
          }).toList(),
        ),
      ),
    );
  }
}
