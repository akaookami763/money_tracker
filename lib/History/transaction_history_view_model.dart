import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

import '../services/transaction_service_abstract.dart';

abstract class TransactionHistoryViewModel {
  late List<Transaction> allTransactions;
  Future initialAction();
  int editTransaction(Transaction transaction);
  Future deleteTransaction(Transaction transaction);
}

class TransactionHistoryViewModelImpl extends TransactionHistoryViewModel {
  List<Transaction> _transactions = [];

  List<Transaction> get allTransactions => _transactions;

  final TransactionService _tWorker;

  TransactionHistoryViewModelImpl(this._tWorker);

  @override
  Future initialAction() async {
    _transactions = await _tWorker.getAllTransactions();
  }

  @override
  Future deleteTransaction(Transaction transaction) async {
    try {
     final Transaction removedTransaction = await _tWorker.deleteTransaction(transaction);
      _transactions.remove(removedTransaction);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  int editTransaction(Transaction transaction) {
    // TODO: implement editTransaction
    throw UnimplementedError();
  }
}
