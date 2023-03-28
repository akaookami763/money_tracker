import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'dart:ffi';
import '../repositories/transaction_repository_abstract.dart';
import '../repositories/transaction_repository_mock.dart';
import 'database_helper.dart';

class TransactionWorker extends TransactionService {
  @override
  Future<List<Transaction>> addTransaction(Transaction transaction) async {
    Database database = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
            'tag': transaction.getTag(),

      'category': transaction.getCategory(),
      'cost': transaction.getCost(),
      'date': transaction.getDate(),
      'extraNotes': transaction.getNotes()
    };
    database.insert('transactions', row);

    return getAllTransactions();
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    Database database = await DatabaseHelper.instance.database;
    final allRows = await database.query('transactions');

    return allRows.map((transaction) {
      return Transaction.fromMap(transaction);
    }).toList();
  }

  @override
  Future<List<Transaction>> updateTransaction(
      Transaction transaction) async {
    Database database = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      'tag': transaction.getTag(),
      'category': transaction.getCategory(),
      'cost': transaction.getCost(),
      'date': transaction.getDate(),
      'extraNotes': transaction.getNotes()
    };
    database.update('transactions', row);
    return getAllTransactions();
  }
}

class TransactionServiceMock extends TransactionService {

      TransactionRepository repo = TransactionRepositoryMock();

  @override
  Transaction createTransaction(FinancialCategory category, Double cost,
      DateTime date, String extraNotes) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return Future(() => repo.getAllTransactions());
  }

  @override
  Future<List<Transaction>> addTransaction(
      Transaction transaction) async {
      int result = await repo.createTransaction(transaction);
    if(result == 1) {
      return repo.getAllTransactions();
    }
    return Future(() => []);
  }

  @override
  Future<List<Transaction>> updateTransaction(
       Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
