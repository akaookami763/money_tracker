import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

import '../services/database_helper.dart';


class TransactionRepositoryImpl extends TransactionRepository {
  /// Create a transaction in the database
  /// Returns: The unique key hash of the transaction if a success, or -1 if there is a failure
  @override
  Future<int> createTransaction(int category, DateTime date, double cost, String extraNotes) async {
        Database database = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      'category': category,
      'cost': cost,
      'date': date.millisecondsSinceEpoch,
      'extraNotes': extraNotes
    };
    return await database.insert('transactions', row);
  }


  @override
  Future<List<Transaction>> getAllTransactions() async {
        Database database = await DatabaseHelper.instance.database;
    final allRows = await database.rawQuery('''
     SELECT * FROM transactions
     INNER JOIN categories
     ON transactions.category = categories.tag''');

    return allRows.map((transaction) {
      return Transaction.fromMap(transaction);
    }).toList();
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) {
    // TODO: implement getAllTransactionsFor
    throw UnimplementedError();
  }

  @override
  Future<Transaction> getTransactionByTag(int tag) async {
    Database database = await DatabaseHelper.instance.database;

    List<String> columns = ['tag', 'category', 'cost', 'date', 'extraNotes'];
    String whereString = 'tag = ?';
    final Map<String, dynamic> transaction = (await database.query('transactions', columns: columns, where: whereString, whereArgs: [tag])) as Map<String, dynamic>;

    return Transaction.fromMap(transaction);
  }

  @override
  Future<int> removeTransaction(Transaction transaction) {
    // TODO: implement removeTransaction
    throw UnimplementedError();
  }


}
