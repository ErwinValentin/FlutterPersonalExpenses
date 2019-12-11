import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = new TextEditingController();
  final _amountController = new TextEditingController();
  DateTime _selectedDate;

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
              controller: _titleController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) => _submitTransaction(),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitTransaction(),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : DateFormat('yyyy/MM/dd').format(_selectedDate),
                  ),
                ),
                FlatButton(
                  child: Text('Select a Date'),
                  onPressed: () {
                    _presentDatePicker();
                  },
                ),
              ],
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitTransaction,
            ),
            Center( child:Container(
              padding: EdgeInsets.all(10),
              child: Text('Swipe down to dismiss!'),
              
            ))
          ],
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  void _submitTransaction() {
    log('${_titleController.text} ${_amountController.text}');
    final enteredText = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    log('$enteredText, $enteredAmount $_selectedDate');
    if (enteredText.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      enteredText,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }
}
