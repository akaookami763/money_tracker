import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

import '../services/database_helper.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  /// Create a transaction in the database
  /// Returns: The unique key hash of the transaction if a success, or 0 if there is a failure
  @override
  Future<int> createTransaction(
      int category, DateTime date, double cost, String extraNotes) async {
    Database database = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      'category': category,
      'cost': cost,
      'date': date.millisecondsSinceEpoch,
      'extraNotes': extraNotes
    };
    return await database.insert('transactions', row);
  }
  /// Gets all transaction objects in the database
  /// Returns: A list of transaction objects
  @override
  Future<List<Transaction>> getAllTransactions() async {
    Database database = await DatabaseHelper.instance.database;
    final allRows = await database.rawQuery('''
     SELECT transactions.tag, transactions.category, transactions.cost, transactions.extraNotes, transactions.date, categories.name
     FROM transactions
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
    final Map<String, dynamic> transaction = (await database.query(
        'transactions',
        columns: columns,
        where: whereString,
        whereArgs: [tag])) as Map<String, dynamic>;

    return Transaction.fromMap(transaction);
  }
  /// Updates a transaction that exists in the database
  /// Returns: The number of rows changed.  Should always be 1.  If 0 or less, there was an error.  If higher than 1, something went wrong
  @override
  Future<int> updateTransaction(Transaction transaction) async {
    Database database = await DatabaseHelper.instance.database;
    String whereString = 'tag = ?';
    Map<String, dynamic> row = {
      'category': transaction.getCategory().tag,
      'cost': transaction.getCost(),
      'date': transaction.getDate().millisecondsSinceEpoch,
      'extraNotes': transaction.getNotes()
    };
    // database.rawUpdate('''UPDATE transactions
    //  SET category = ?, cost = ?, date = ?, extraNotes = ?
    //  WHERE tag = ?
    //  ''', [transaction.getCategory().tag.hashCode, transaction.getCost(), transaction.getDate(), transaction.getTag()]);
    return database.update('transactions', row, where: whereString, whereArgs: [transaction.getTag()]);
  }
  /// Removes a transaction object from the database
  /// Returns: The number of rows affected by the change.  Should always be 1.  If 0 or less, it failed.  If higher than 1, something went wrong
  @override
  Future<int> removeTransaction(Transaction transaction) async {
    Database database = await DatabaseHelper.instance.database;

    return (await database.delete('transactions',
        where: 'tag = ?', whereArgs: [transaction.getTag()]));
  }
}
