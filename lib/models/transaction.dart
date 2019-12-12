import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String()
    };
  }

  Transaction
.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.title = map['title'];
    this.amount = map['amount'];
    this.date = DateTime.parse(map['date']);
  }
}
