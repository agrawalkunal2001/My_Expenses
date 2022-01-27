import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int amountSpent;
  final double amountPercentage;

  ChartBar(this.label, this.amountSpent, this.amountPercentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            // It ensures that if the text is big enough that it moves to next line, the text shrinks.
            child: Text(
              "\u{20B9}${amountSpent}",
              style: TextStyle(
                  fontFamily: "Quicksand", fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 100,
          width: 15,
          child: Stack(
            // Elements are from bottom to top
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: amountPercentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
