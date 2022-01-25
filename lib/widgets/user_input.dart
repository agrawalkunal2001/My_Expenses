import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {
  final Function addTransaction;

  UserInput(this.addTransaction);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

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
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  widget.addTransaction(
                      titleController.text, int.parse(amountController.text));
                },
                child: Text(
                  "Add Transaction!",
                  style: TextStyle(fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }
}
