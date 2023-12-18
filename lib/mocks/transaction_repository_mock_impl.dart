import 'package:flutter/material.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';

import '../DataCentral/financial_category_model.dart';
import '../DataCentral/transaction_model.dart';

class TransactionRepositoryMockImpl extends TransactionRepository {
  var _transactions = <Transaction>[];
  var operationWillError = false;

  List<Transaction> sampleTransactions() => [
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category1"),
            date: DateTime.now(),
            cost: 42.35,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category1"),
            date: DateTime.now(),
            cost: 3.45,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category1"),
            date: DateTime.now(),
            cost: 100.34,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category1"),
            date: DateTime.now(),
            cost: 24.11,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category2"),
            date: DateTime.now(),
            cost: 48372.32,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category2"),
            date: DateTime.now(),
            cost: 48.835,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category3"),
            date: DateTime.now(),
            cost: 102.48,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: FinancialCategory(UniqueKey().hashCode, "Category4"),
            date: DateTime.now(),
            cost: 0.54,
            extraNotes: ""),
      ];

  @override
  Future<int> createTransaction(
      int category, DateTime date, double cost, String extraNotes) {
    return Future(() => operationWillError ? -1 : 1);
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return Future(() => sampleTransactions());
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) {
    // TODO: implement getAllTransactionsFor
    throw UnimplementedError();
  }

  @override
  Future<int> updateTransaction(Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }

  @override
  Future<int> removeTransaction(Transaction transaction) {
    // TODO: implement removeTransaction
    throw UnimplementedError();
  }

  @override
  Future<Transaction> getTransactionByTag(int tag) {
    // TODO: implement getTransactionByTag
    throw UnimplementedError();
  }
}
