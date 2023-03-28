import 'package:flutter/foundation.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service.dart';

import '../DataCentral/transaction_model.dart';
import '../services/category_service.dart';
import '../services/transaction_service_abstract.dart';

class CategoryViewViewModel extends ChangeNotifier {
  List<Transaction> _transactions = [];
  final FinancialCategory _category;

CategoryViewViewModel(this._category);
  //TODO: Change to real data once everything is implemented
  CategoryService worker = CategoryServiceMock();
  TransactionService tWorker = TransactionServiceMock();

  List<Transaction> get transactions => _transactions;
  FinancialCategory get category => _category;

  Future<void> initialActions() async {
    _transactions = await tWorker.getAllTransactions();
  }

  void costIncrease(String cost, DateTime date,
      String extraNotes) async {
    double doubleCost = double.parse(cost);
    if (doubleCost <= 0) {
      return;
    }

    final transaction = Transaction(category: _category, date: date, cost: doubleCost, extraNotes: extraNotes);

    _transactions = await tWorker.addTransaction(
        transaction);

    updateSum();
    monthlySum();

    notifyListeners();
  }

  void costDecrease(String category, String cost, DateTime date,
      String extraNotes) async {
    double doubleCost = double.parse(cost);
    if (doubleCost <= 0) {
      return;
    }
    final transaction = Transaction(category: _category, date: date, cost: doubleCost * -1, extraNotes: extraNotes);

    _transactions = await tWorker.addTransaction(
        transaction);

    updateSum();
    monthlySum();

    notifyListeners();
  }

  double updateSum() {
    return _transactions
        .map((e) => e.getCost())
        .reduce((value, element) => value + element);
  }

  double monthlySum() {
    int currentMonth = DateTime.now().month;
    List<Transaction> monthlyTransactions = transactions
        .where((transaction) => transaction.getDate().month == currentMonth)
        .toList();

    return monthlyTransactions
        .map((e) => e.getCost())
        .reduce((value, element) => value + element);
  }
}
