import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {
  final Function addTransaction;

  UserInput(this.addTransaction);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  void _showDatePicker() {
    showDatePicker(
            // This gives a future object which will trigger when the user picks a date.
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        selectedDate = date;
      });
    }); // This will inform when a user picks a date.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              maxLength: 15,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: <Widget>[
              Expanded(
                child: Text(
                  selectedDate == null
                      ? "No date chosen!"
                      : DateFormat.yMMMMd().format(selectedDate!),
                  style: TextStyle(fontSize: 17),
                ),
              ),
              TextButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  child: Text(
                    "Choose Date",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
            ]),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  widget.addTransaction(titleController.text,
                      int.parse(amountController.text), selectedDate);
                },
                child: Text(
                  "Add Transaction!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
