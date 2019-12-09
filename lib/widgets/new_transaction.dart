import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

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
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              controller: amountController  ,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitTransaction(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitTransaction
              ,
            )
          ],
        ),
      ),
    );
  }

  void submitTransaction() {
    final enteredText = titleController.text;
    final enterdAmount = double.parse(amountController.text);

    if(enteredText.isEmpty || enterdAmount <= 0){
      return;
      }

    widget.addNewTransaction(
      enteredText,
      enterdAmount
    );

    Navigator.of(context).pop();
  }
}