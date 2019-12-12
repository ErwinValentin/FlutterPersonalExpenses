import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/transaction.dart' as myTransaction;
import 'package:sqflite/sqflite.dart';

import '../models/transaction.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = join(document.path, "PersonalExpenses.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE expenses(id TEXT PRIMARY KEY, title TEXT, amount REAL, date TEXT)",
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getTransactionsMapList() async {
    Database db = await this.database;
    return db.query('expenses');
  }

  Future<int> insertTransaction(myTransaction.Transaction tx) async {
    var db = await this.database;
    return await db.insert('expenses', tx.toMap());
  }

  Future<int> deleteTransaction(String id) async {
    var db = await this.database;
    return await db.rawDelete('DELETE FROM expenses WHERE id=?',[id]);
  }
  Future<List<myTransaction.Transaction>> getTransactions() async{
    var transactionsMap = await getTransactionsMapList();
    int count = transactionsMap.length;

    List<myTransaction.Transaction> transactionList = List<myTransaction.Transaction>();

    for(int i = 0; i< count; i++){
      transactionList.add(myTransaction.Transaction.fromMap(transactionsMap[i]));
    }
  return transactionList;
  } 

}
